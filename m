Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84750343B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCVIQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:16:54 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:55692 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhCVIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=AOj1KLDMOWvHBGXOOf
        nN3WKopE7N9vEYfmfmtmIwbrQ=; b=LIy2BIyA2+Zhlqp5krdHEz4pnj48Czlezb
        HzyExMuPooTogFvLgYr1ZkUy1WLbqd+t1v8dv8Z/GWWjh7agnspnfkPDHT7mw2Ua
        OUKDqIZ8OPzuacJk0eqhnSLAzFLBKSWBES9mGf7QBLW8+rS1ftvDywoQsQiMWgSe
        GJqGgHuoY=
Received: from wengjianfeng.ccdomain.com (unknown [218.17.89.92])
        by smtp5 (Coremail) with SMTP id HdxpCgBHfDk6UlhgLSO1BQ--.5281S2;
        Mon, 22 Mar 2021 16:15:56 +0800 (CST)
From:   samirweng1979 <samirweng1979@163.com>
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        kenneth.feng@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
Subject: [PATCH] drm/amd/pm/powerplay/smumgr/smu7_smumgr: Fix some typo error
Date:   Mon, 22 Mar 2021 16:16:06 +0800
Message-Id: <20210322081606.25116-1-samirweng1979@163.com>
X-Mailer: git-send-email 2.15.0.windows.1
X-CM-TRANSID: HdxpCgBHfDk6UlhgLSO1BQ--.5281S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1UAr4fAFW3tw13Wr1xXwb_yoW8GrW3pF
        s3Cr43Z3yxA3W7Ka1DWa17Xry8C3W8XFyqkFsrC3s0934YgrnYvF98Gayavw4UGa4xCw1x
        t39Fg39rW3WIv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b5JPiUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: pvdpx25zhqwiqzxzqiywtou0bp/1tbiHRxdsVSIp0RWJAAAsg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wengjianfeng <wengjianfeng@yulong.com>

change 'addres' to 'address'

Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
index aae2524..0de9e0e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
@@ -97,7 +97,7 @@ int smu7_copy_bytes_to_smc(struct pp_hwmgr *hwmgr, uint32_t smc_start_address,
 	addr = smc_start_address;
 
 	while (byte_count >= 4) {
-	/* Bytes are written into the SMC addres space with the MSB first. */
+	/* Bytes are written into the SMC address space with the MSB first. */
 		data = src[0] * 0x1000000 + src[1] * 0x10000 + src[2] * 0x100 + src[3];
 
 		result = smu7_set_smc_sram_address(hwmgr, addr, limit);
@@ -127,7 +127,7 @@ int smu7_copy_bytes_to_smc(struct pp_hwmgr *hwmgr, uint32_t smc_start_address,
 		extra_shift = 8 * (4 - byte_count);
 
 		while (byte_count > 0) {
-			/* Bytes are written into the SMC addres space with the MSB first. */
+			/* Bytes are written into the SMC address space with the MSB first. */
 			data = (0x100 * data) + *src++;
 			byte_count--;
 		}
-- 
1.9.1

