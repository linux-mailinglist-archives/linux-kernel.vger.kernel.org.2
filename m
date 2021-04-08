Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5534D357FEF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhDHJvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:51:44 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59022 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhDHJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:51:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UUsn2It_1617875480;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UUsn2It_1617875480)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Apr 2021 17:51:30 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] staging: ks7010: remove useless variable
Date:   Thu,  8 Apr 2021 17:51:19 +0800
Message-Id: <1617875479-58849-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/staging/ks7010/ks_hostif.c:929:19: warning: variable ‘noise’ set
but not used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/staging/ks7010/ks_hostif.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 8bc3b7d..499161d 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -926,14 +926,13 @@ void hostif_bss_scan_confirm(struct ks_wlan_private *priv)
 void hostif_phy_information_confirm(struct ks_wlan_private *priv)
 {
 	struct iw_statistics *wstats = &priv->wstats;
-	u8 rssi, signal, noise;
+	u8 rssi, signal;
 	u8 link_speed;
 	u32 transmitted_frame_count, received_fragment_count;
 	u32 failed_count, fcs_error_count;
 
 	rssi = get_byte(priv);
 	signal = get_byte(priv);
-	noise = get_byte(priv);
 	link_speed = get_byte(priv);
 	transmitted_frame_count = get_dword(priv);
 	received_fragment_count = get_dword(priv);
-- 
1.8.3.1

