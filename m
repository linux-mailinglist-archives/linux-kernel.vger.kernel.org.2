Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6626F36048C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhDOIle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:41:34 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41392 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231398AbhDOIld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:41:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVdSLBq_1618476064;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVdSLBq_1618476064)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Apr 2021 16:41:09 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     anitha.chrisanthus@intel.com
Cc:     edmund.j.dea@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drm/kmb: remove unused function
Date:   Thu, 15 Apr 2021 16:41:03 +0800
Message-Id: <1618476063-108624-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following clang warning:

drivers/gpu/drm/kmb/kmb_dsi.c:824:2: warning: unused function
'set_test_mode_src_osc_freq_target_hi_bits' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/kmb/kmb_dsi.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index 4b5d82a..448cc1b 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -820,22 +820,6 @@ static void test_mode_send(struct kmb_dsi *kmb_dsi, u32 dphy_no,
 		       (freq & 0x7f));
 }
 
-static inline void
-	set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi *kmb_dsi,
-						  u32 dphy_no,
-						  u32 freq)
-{
-	u32 data;
-
-	/* Flag this as high nibble */
-	data = ((freq >> 6) & 0x1f) | (1 << 7);
-
-	/* Typical rise/fall time=166, refer Table 1207 databook,
-	 * sr_osc_freq_target[11:7]
-	 */
-	test_mode_send(kmb_dsi, dphy_no, TEST_CODE_SLEW_RATE_DDL_CYCLES, data);
-}
-
 static void mipi_tx_get_vco_params(struct vco_params *vco)
 {
 	int i;
-- 
1.8.3.1

