Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C09D3440B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCVMTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhCVMSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:18:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 965856198B;
        Mon, 22 Mar 2021 12:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616415529;
        bh=ckuQInXF0VBSNEoF623rjc1y5mTjD/MuacPtmohphhg=;
        h=From:To:Cc:Subject:Date:From;
        b=iNOgt5We2jijGbWd2hnKEH1ciJYxWS9zuVI3TNvWS0uU5lMOqyFOlK/+jAlsNAsEX
         CoTD3zEWTA5pH1u9/U2JjB8K9i/5V/6QCECwzY+e1Y3h3kF3zH+rWeI2cD0OJ8ynXb
         9FM7s5TZV4htqaBhiQvUz4xzJifuOFV0weEfGFqp/oUUauGLRjcIOyatFz58lhNlFz
         1jp8KaS7nxBFs+knmTdJInwirWyUaPZSqwz0QcBfUjIqYi47XyCuBm3KnJTpLxeBWr
         oU3RyReglbDIbOjdSHOCCxDXnqQ6lTtudaw50A/ph5Z+gpLVxWw3wXuHovvj5wFTzk
         4NlYK2sXKrB/A==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     daniel.lezcano@linaro.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, p.zabel@pengutronix.de,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH RESEND] clocksource: dw_apb_timer_of: add handling for potential memory leak
Date:   Mon, 22 Mar 2021 07:18:44 -0500
Message-Id: <20210322121844.2271041-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
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
2.25.1

