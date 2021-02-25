Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5721324CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbhBYJWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:22:05 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:60709 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233797AbhBYJT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:19:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UPXAKmu_1614244743;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UPXAKmu_1614244743)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Feb 2021 17:19:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: remove unnecessary conversion to bool
Date:   Thu, 25 Feb 2021 17:19:02 +0800
Message-Id: <1614244742-67869-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c:243:67-72:
WARNING: conversion to bool not needed here.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
index 3398540..102f6a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
@@ -240,7 +240,7 @@ bool dpp3_program_gamcor_lut(
 		next_mode = LUT_RAM_A;
 
 	dpp3_power_on_gamcor_lut(dpp_base, true);
-	dpp3_configure_gamcor_lut(dpp_base, next_mode == LUT_RAM_A ? true:false);
+	dpp3_configure_gamcor_lut(dpp_base, next_mode == LUT_RAM_A);
 
 	if (next_mode == LUT_RAM_B) {
 		gam_regs.start_cntl_b = REG(CM_GAMCOR_RAMB_START_CNTL_B);
-- 
1.8.3.1

