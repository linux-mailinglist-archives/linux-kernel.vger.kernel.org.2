Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D89A3E9257
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhHKNP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:15:28 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7984 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhHKNPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:15:25 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56113cd4900d-65121; Wed, 11 Aug 2021 21:14:49 +0800 (CST)
X-RM-TRANSID: 2ee56113cd4900d-65121
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66113cd44cdd-41e64;
        Wed, 11 Aug 2021 21:14:49 +0800 (CST)
X-RM-TRANSID: 2ee66113cd44cdd-41e64
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ARM/smp_twd: Cleanup the unnecessary cast
Date:   Wed, 11 Aug 2021 21:15:12 +0800
Message-Id: <20210811131512.940-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not necessary to specify 'int' castingfor 'PTR_ERR(twd_clk)'.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 arch/arm/kernel/smp_twd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 9a14f721a..423e9079d 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -199,7 +199,7 @@ static void twd_get_clock(struct device_node *np)
 		twd_clk = clk_get_sys("smp_twd", NULL);
 
 	if (IS_ERR(twd_clk)) {
-		pr_err("smp_twd: clock not found %d\n", (int) PTR_ERR(twd_clk));
+		pr_err("smp_twd: clock not found %d\n", PTR_ERR(twd_clk));
 		return;
 	}
 
-- 
2.20.1.windows.1



