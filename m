Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEFE324D19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhBYJld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:41:33 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35450 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233755AbhBYJkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:40:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UPXi4Du_1614245992;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UPXi4Du_1614245992)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Feb 2021 17:39:57 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     stanimir.varbanov@linaro.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] media: venus: helpers: remove unnecessary conversion to bool
Date:   Thu, 25 Feb 2021 17:39:51 +0800
Message-Id: <1614245991-82986-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/media/platform/qcom/venus/helpers.c:585:11-16: WARNING:
conversion to bool not needed here.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/media/platform/qcom/venus/helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 76ece2f..35091c6 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -581,8 +581,7 @@ static int platform_get_bufreq(struct venus_inst *inst, u32 buftype,
 		params.dec.is_secondary_output =
 			inst->opb_buftype == HFI_BUFFER_OUTPUT2;
 		params.dec.is_interlaced =
-			inst->pic_struct != HFI_INTERLACE_FRAME_PROGRESSIVE ?
-				true : false;
+			inst->pic_struct != HFI_INTERLACE_FRAME_PROGRESSIVE;
 	} else {
 		params.width = inst->out_width;
 		params.height = inst->out_height;
-- 
1.8.3.1

