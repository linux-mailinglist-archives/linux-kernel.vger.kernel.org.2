Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B43332A53F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446780AbhCBMNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:13:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350181AbhCBLzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:55:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E06764EE8;
        Tue,  2 Mar 2021 11:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614686045;
        bh=59Aeg6OTLh229SBR1rNKkTBiOuHLf36ku/68ZypnqAk=;
        h=From:To:Cc:Subject:Date:From;
        b=UDyGdT4syejp/m8NVdGmv/+iaVXkOZ1ks/joz3+euk3cSNgAXYo0DTYTsqdAvJLsG
         VlMNEq5T1aVvVpkvJHvunkOv1+X217N2WuBogoeIdtIPBXlaw4Y30Nd6MwRJa95LBT
         VX6LtlWRI631Q9vAk81v6PDA6pwqkhxS1XjsGHKlWhn/i5JmGtxPaHW2V7mNO2HpBd
         9kNZCBQ/Hl3+kt50epQQMIta1DNuDEINuBxyZ49UekO7EV331UgDmgI56FjWGy7/0P
         bipa+CnH2K8jLKpMWMC2cHYStlxv2MGMv0QDMD5+LhYIoJkOl9efbnr4Ujeu789Jnu
         prBph6x9/ncUQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, tglx@linutronix.de, p.zabel@pengutronix.de,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] clocksource: dw_apb_timer_of: add handling for potential memory leak
Date:   Tue,  2 Mar 2021 05:53:58 -0600
Message-Id: <20210302115358.1259268-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add calls to disable the clock and unmap the timer base address in case
of any failures.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/clocksource/dw_apb_timer_of.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 42e7e43b8fcd..b1e2b697b21b 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -52,18 +52,34 @@ static int __init timer_get_base_and_rate(struct device_node *np,
 		return 0;
 
 	timer_clk = of_clk_get_by_name(np, "timer");
-	if (IS_ERR(timer_clk))
-		return PTR_ERR(timer_clk);
+	if (IS_ERR(timer_clk)) {
+		ret = PTR_ERR(timer_clk);
+		goto out_pclk_disable;
+	}
 
 	ret = clk_prepare_enable(timer_clk);
 	if (ret)
-		return ret;
+		goto out_timer_clk_put;
 
 	*rate = clk_get_rate(timer_clk);
-	if (!(*rate))
-		return -EINVAL;
+	if (!(*rate)) {
+		ret = -EINVAL;
+		goto out_timer_clk_disable;
+	}
 
 	return 0;
+
+out_timer_clk_disable:
+	clk_disable_unprepare(timer_clk);
+out_timer_clk_put:
+	clk_put(timer_clk);
+out_pclk_disable:
+	if (!IS_ERR(pclk)) {
+		clk_disable_unprepare(pclk);
+		clk_put(pclk);
+	}
+	iounmap(*base);
+	return ret;
 }
 
 static int __init add_clockevent(struct device_node *event_timer)
-- 
2.30.0

