Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261FD3479BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhCXNhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235284AbhCXNhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:37:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C94061A01;
        Wed, 24 Mar 2021 13:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616593029;
        bh=PslWGV1zAHiCp3MqLppdgDKQmZVZu+7LJijobMo672I=;
        h=From:To:Cc:Subject:Date:From;
        b=YjucVhlv4T4O6vQl3V2slzxT7hy6Co+DyTCphMDBxW5NMFNt8DjqAQgZqd9UF9b5W
         OXFRcGTiWArcvxPvg83co4bR3fHa8DEiq2E6H4xez//ePlhqww/9AU2sauVUBOCA00
         d1F+oi/qwjxBdhkZVtGnU85ewEhX2a4xjJQxSPmTW5bVGsFUTHvrouVIun8RwEPjIg
         VO5dYbrHGWt+O6cE+C+pb9DS0BLkko1UT62XusklGh7hoQzCGFEY4xlEeuzIyWWb9d
         yuJxJbeGWlTdtWreyotXLRL3rkNZpIvarkU8u0JD5emchlX8KUC1mllSw9jdz4I1wV
         eOarLf2DivS1g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jinzhou Su <Jinzhou.Su@amd.com>, Huang Rui <ray.huang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] amdgpu: securedisplay: simplify i2c hexdump output
Date:   Wed, 24 Mar 2021 14:36:52 +0100
Message-Id: <20210324133705.2664873-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A previous fix I did left a rather complicated loop in
amdgpu_securedisplay_debugfs_write() for what could be expressed in a
simple sprintf, as Rasmus pointed out.

This drops the leading 0x for each byte, but is otherwise
much nicer.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 69d7f6bff5d4..fc3ddd7aa6f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -92,9 +92,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 	struct drm_device *dev = adev_to_drm(adev);
 	uint32_t phy_id;
 	uint32_t op;
-	int i;
 	char str[64];
-	char i2c_output[256];
 	int ret;
 
 	if (*pos || size > sizeof(str) - 1)
@@ -136,12 +134,9 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
 		if (!ret) {
 			if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
-				int pos = 0;
-				memset(i2c_output,  0, sizeof(i2c_output));
-				for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
-					pos += sprintf(i2c_output + pos, " 0x%X",
-						securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
-				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
+				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is: %*ph\n",
+					 TA_SECUREDISPLAY_I2C_BUFFER_SIZE,
+					 securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf);
 			} else {
 				psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
 			}
-- 
2.29.2

