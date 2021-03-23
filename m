Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48450345EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhCWNEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhCWNEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:04:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D79BB619B6;
        Tue, 23 Mar 2021 13:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616504674;
        bh=q6NHsIW3BnA5mhThORhjcdH3DG7oZJ3fYXk3ohPq4IE=;
        h=From:To:Cc:Subject:Date:From;
        b=NSVZHMS2Sa44doHHUf+7S7yQgC3c7fmn8mqentdeLVYtyu9W1ptJa2pLE79Fdw4T1
         x25sJWLjI8q72sGiXXjws1uxQ+Stxy21a1AGhFnFNQ71UmNVqiq17cLSooefF8iLZh
         DpQ8dPBai9dvRSoVgcW/hM+fEuLE6l21P9PUtsIJ+zZb08BftvHsYvXj1DXNCLCGxD
         DdFhaiPPrSeskOliAZMdENIJIVbTLGsDMajQLPthjqfTbvw0LACdqTKMhCKer76HYR
         Mjcz7piID8kj8USw42m8caU00xxjmYn/DiRMbafuxX6EVK/6pitlIivY+HIxUUY0qm
         mLIpyBIPjsJ3Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huang Rui <ray.huang@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] amdgpu: fix gcc -Wrestrict warning
Date:   Tue, 23 Mar 2021 14:04:20 +0100
Message-Id: <20210323130430.2250052-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about an sprintf() that uses the same buffer as source
and destination, which is undefined behavior in C99:

drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c: In function 'amdgpu_securedisplay_debugfs_write':
drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:141:6: error: 'sprintf' argument 3 overlaps destination object 'i2c_output' [-Werror=restrict]
  141 |      sprintf(i2c_output, "%s 0x%X", i2c_output,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  142 |       securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:97:7: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
   97 |  char i2c_output[256];
      |       ^~~~~~~~~~

Rewrite it to remember the current offset into the buffer instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 834440ab9ff7..69d7f6bff5d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -136,9 +136,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
 		if (!ret) {
 			if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
+				int pos = 0;
 				memset(i2c_output,  0, sizeof(i2c_output));
 				for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
-					sprintf(i2c_output, "%s 0x%X", i2c_output,
+					pos += sprintf(i2c_output + pos, " 0x%X",
 						securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
 				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
 			} else {
-- 
2.29.2

