Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B703A10E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhFIKLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:11:32 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:32103 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238660AbhFIKLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:11:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UbrkGH0_1623233371;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UbrkGH0_1623233371)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Jun 2021 18:09:34 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: use ARRAY_SIZE for base60_refresh_rates
Date:   Wed,  9 Jun 2021 18:09:26 +0800
Message-Id: <1623233366-100202-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE instead of dividing sizeof array with sizeof an
element.

Clean up the following coccicheck warning:

./drivers/gpu/drm/amd/display/dc/core/dc_resource.c:448:47-48: WARNING:
Use ARRAY_SIZE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 57afe71..3f00989 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -445,7 +445,7 @@ bool resource_are_vblanks_synchronizable(
 {
 	uint32_t base60_refresh_rates[] = {10, 20, 5};
 	uint8_t i;
-	uint8_t rr_count = sizeof(base60_refresh_rates)/sizeof(base60_refresh_rates[0]);
+	uint8_t rr_count = ARRAY_SIZE(base60_refresh_rates);
 	uint64_t frame_time_diff;
 
 	if (stream1->ctx->dc->config.vblank_alignment_dto_params &&
-- 
1.8.3.1

