Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC87E453DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhKQBl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhKQBl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:41:58 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC1AC061570;
        Tue, 16 Nov 2021 17:39:00 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 28so741415pgq.8;
        Tue, 16 Nov 2021 17:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hH6qmXqvZSnOoRAcPtZVa0OkhWnUxqJaW0v8rMecUno=;
        b=VRb+wdNjdNbBwnY/Y9pQl1NMpTKE53gMeoES6xIMGhGx+1uyUzSnnisRSvAvzS0j8O
         BKqlkO+SMp9XpfgjBLY4IO8Y3HQ37c26qe5lLSewdEqkA/IFCxeAJfSXoaIOrXVr6J0f
         pDL/wr537Au+t/OqZdEfMIoqjvyz8JKsxJhn5SLs/u/y7+h9vS0OQ2m1i3/362rXYwEG
         nXZXj9FZ1i+4oMPD8yj/q5W+be/TudJtulBxiKYLicZG2W+cJncl/4px0SMzvQUtT5dO
         80sY1nrekZUwH84rYJy2TdnR6nvzXAFqRNGie3RjGTH8EFCCjyNMfR0PgP4KEK9pogqu
         3njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hH6qmXqvZSnOoRAcPtZVa0OkhWnUxqJaW0v8rMecUno=;
        b=6/MQ9tslKkE7JNLtitofT9/d1SfMR8DqaAUBRDeYsBszXx4+2nqucLkdD9LtegvV99
         UN6EYMKjulGRvZQ17N/Zi0kmaHqUKP/E9Fj3mDScu3mwt5G6SJVPZanw8N6iJZKBcoJs
         XPpJExJm14ENDViGj3x0nT+BiojQ8JJ7nDTs4qApVrUnbmZ0OhZPMOhAhIr6My2T/qhR
         ujPxTMjItY4Y0pNjtZJsVEarZrBk6yCwY7agwfPsITBirbUrfxNrKG8kCiw7EHsB5ciG
         mBark+kSNbWVmyhZ91WhYbrDt/aLTiuzgUhI4liUpV+5D955dmVmyomMsQ7rJf/q35na
         7o2w==
X-Gm-Message-State: AOAM531gbbSqesQWbS2WkZFOWXM9KnpE7YoVUn+Dpyb+Ad58BzMsU0fR
        E9D3aPd8i4aCIVphaYPRLCk=
X-Google-Smtp-Source: ABdhPJwjVHmxqjoD6z4EZGQfTMhn1JDO9TlmrTmVG8EayB5rEd9VN17xefIzJT8miEhx1duZtlP1/Q==
X-Received: by 2002:aa7:9a4e:0:b0:4a2:71f9:21e0 with SMTP id x14-20020aa79a4e000000b004a271f921e0mr3617499pfj.77.1637113140023;
        Tue, 16 Nov 2021 17:39:00 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s7sm3053123pfm.188.2021.11.16.17.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:38:59 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     abel.vesa@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] clk: imx: Use div64_ul instead of do_div
Date:   Wed, 17 Nov 2021 01:38:53 +0000
Message-Id: <20211117013853.158777-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

do_div() does a 64-by-32 division. If the divisor is unsigned long, using
div64_ul can avoid truncation to 32-bit.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/clk/imx/clk-pllv3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 20ee9611ba6e..55497e0585a6 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -247,7 +247,7 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
 	div = rate / parent_rate;
 	temp64 = (u64) (rate - div * parent_rate);
 	temp64 *= mfd;
-	do_div(temp64, parent_rate);
+	div64_ul(temp64, parent_rate);
 	mfn = temp64;
 
 	temp64 = (u64)parent_rate;
@@ -277,7 +277,7 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	div = rate / parent_rate;
 	temp64 = (u64) (rate - div * parent_rate);
 	temp64 *= mfd;
-	do_div(temp64, parent_rate);
+	div64_ul(temp64, parent_rate);
 	mfn = temp64;
 
 	val = readl_relaxed(pll->base);
@@ -334,7 +334,7 @@ static struct clk_pllv3_vf610_mf clk_pllv3_vf610_rate_to_mf(
 		/* rate = parent_rate * (mfi + mfn/mfd) */
 		temp64 = rate - parent_rate * mf.mfi;
 		temp64 *= mf.mfd;
-		do_div(temp64, parent_rate);
+		div64_ul(temp64, parent_rate);
 		mf.mfn = temp64;
 	}
 
-- 
2.25.1

