Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167C9359561
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhDIGYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:24:06 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:41465 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233408AbhDIGYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:24:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UUyWTPy_1617949426;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UUyWTPy_1617949426)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 09 Apr 2021 14:23:51 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] staging: comedi: cb_pcidas64: remove useless function
Date:   Fri,  9 Apr 2021 14:23:45 +0800
Message-Id: <1617949425-105420-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/staging/comedi/drivers/cb_pcidas64.c:232:19: warning: unused
function 'analog_trig_low_threshold_bits' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/staging/comedi/drivers/cb_pcidas64.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
index 6d3ba39..41a8fea 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas64.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
@@ -229,11 +229,6 @@ enum daq_atrig_low_4020_contents {
 	EXT_START_TRIG_BNC_BIT = 0x2000,
 };
 
-static inline u16 analog_trig_low_threshold_bits(u16 threshold)
-{
-	return threshold & 0xfff;
-}
-
 enum adc_control0_contents {
 	ADC_GATE_SRC_MASK = 0x3,	/* bits that select gate */
 	ADC_SOFT_GATE_BITS = 0x1,	/* software gate */
-- 
1.8.3.1

