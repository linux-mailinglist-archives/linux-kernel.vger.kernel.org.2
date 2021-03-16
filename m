Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8033CF51
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhCPIJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:09:20 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35677 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233998AbhCPII6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:08:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0US7bm7Q_1615882130;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0US7bm7Q_1615882130)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Mar 2021 16:08:56 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Remove unnecessary conversion to bool
Date:   Tue, 16 Mar 2021 16:08:49 +0800
Message-Id: <1615882129-14822-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c:721:65-70: WARNING:
conversion to bool not needed here.

./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c:1139:67-72: WARNING:
conversion to bool not needed here.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 6e864b1..434d3c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -718,7 +718,7 @@ bool dpp3_program_blnd_lut(
 		next_mode = LUT_RAM_B;
 
 	dpp3_power_on_blnd_lut(dpp_base, true);
-	dpp3_configure_blnd_lut(dpp_base, next_mode == LUT_RAM_A ? true:false);
+	dpp3_configure_blnd_lut(dpp_base, next_mode == LUT_RAM_A);
 
 	if (next_mode == LUT_RAM_A)
 		dpp3_program_blnd_luta_settings(dpp_base, params);
@@ -1136,7 +1136,7 @@ bool dpp3_program_shaper(
 	else
 		next_mode = LUT_RAM_A;
 
-	dpp3_configure_shaper_lut(dpp_base, next_mode == LUT_RAM_A ? true:false);
+	dpp3_configure_shaper_lut(dpp_base, next_mode == LUT_RAM_A);
 
 	if (next_mode == LUT_RAM_A)
 		dpp3_program_shaper_luta_settings(dpp_base, params);
-- 
1.8.3.1

