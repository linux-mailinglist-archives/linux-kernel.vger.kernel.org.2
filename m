Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B201E3FD2AC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbhIAFGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:06:38 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58787 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241918AbhIAFG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:06:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E88D5C01D4;
        Wed,  1 Sep 2021 01:05:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Sep 2021 01:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=g/tkXc9ZH7xFT
        64/AUCsHAFuJBmoKdWUnX2oc1IWSEE=; b=lfCJ5gu9uxsGTso75OC8PrFgijee6
        KFOaDk3W13NKcBm3cjZYkbQsi9xsqH/sSPVALuIPLb+5JlHPp6T5vKCdnKC6+LDL
        lgy/kpmJxJahCvO6Mpbc8s0k9kWtFckRDe2ev7T3Q7FXK3Pt1uTUx5kZdSNwIFNL
        82CyCWBPmo4kkyvF7yuBPfHMcKp2o1QUWVBdIi2zu+Ya2HgBmRE7eW5d5eln1q9Y
        LYMfSUUifdyTT3ZsmePoXYboopQGSK/5LB+3WY6znIgP/cBJ3cPTi3gDU7+BiD07
        lzpbhzYtUHa9IU96Q/5d4DnUb7lLbJ6E3JTeaAO8lhXfcFUCqN1wJ/ytA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=g/tkXc9ZH7xFT64/AUCsHAFuJBmoKdWUnX2oc1IWSEE=; b=EX/xpIzE
        rrpwqlv88W+Tmx7zqhj5cWuJaWvqDdLICVFsqFyMebcfNAeKUcdxWQ+kimz8aYC1
        J0PFxgDqRbxBLtTq9EeDa3AxdI+rA+fEJXJCWmgfdJGi2rigvngfqdBg/Jt544H9
        Cj/TSV7Ljare0c0P1RNe+HOkAQsuZhRaf0rR6uNl82HmgY6CZvEc8NTVYOd+a6Gv
        IQz9TdY53wJ8VEEK7/yCyzWcsyt330fxvzGHTI5kAfG6ONGHjLmvwS4VFzDqh6QB
        TEYOLkHnW3z2lDS68d5VAuq9jpoD7DYgIz/56MDENH3zgvs/ZPxldmf2rdZnCQvY
        Rc6mf2GBnV8gxw==
X-ME-Sender: <xms:HAovYW4ZXkZJK4jxCtgkqyEjewKM5EXQy-LAx-K7oE_10F4TQBBfgg>
    <xme:HAovYf7DR57WhMJjcOVOjg6kj0LUU9agyG_TQpNH0KQILGldF9lkgpD_akzIuGtUe
    VYJBEe17OlrKUEUIg>
X-ME-Received: <xmr:HAovYVf_LMhNg3t2gCHaTjc8ErBUZifwWwTGtyLAWeWH4iouigPlSChmM4-k1jlI1AEYmgVU63BU1-47zeqwjjDN6xBypHg7wvKYxzif4QpT-pKaXONzj38LWnLxjVtjL7D4Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:HAovYTJOqMNJe9Zp6qK7TLC_sL1WgeUzHmbv4AVA1ZIDTOOcVkUqYQ>
    <xmx:HAovYaL7RTNzpLlGdOCQLpnvTYZr3Vj4XEPpjDsy6t9CEm_DQl09GA>
    <xmx:HAovYUxMHqt4qp2GSd_Smt_q9DxQPitBCCRRuxKdojfL6ZxJuzb67A>
    <xmx:HAovYZ9rhriJhXZ4lcYYP9E3ez21mQLJgfQFYf9LmKPT44f1iNMynA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:05:32 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/8] clk: sunxi-ng: Prevent unbinding CCUs via sysfs
Date:   Wed,  1 Sep 2021 00:05:20 -0500
Message-Id: <20210901050526.45673-3-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901050526.45673-1-samuel@sholland.org>
References: <20210901050526.45673-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CCU drivers are not really designed to be unbound. Unbinding a SoC's
main CCU is especially pointless, as very few of the peripherals on the
SoC will work without it. Let's avoid any potential problems by removing
the bind/unbind attributes from sysfs for these drivers.

This change is not applied to the "secondary" CCUs (DE, USB) as those
could reasonably be unbound without making the system useless.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c   | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c    | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c    | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c     | 1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c  | 1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c     | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
index 6f2a58970556..804729e0a208 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
@@ -208,6 +208,7 @@ static struct platform_driver sun50i_a100_r_ccu_driver = {
 	.probe	= sun50i_a100_r_ccu_probe,
 	.driver	= {
 		.name	= "sun50i-a100-r-ccu",
+		.suppress_bind_attrs = true,
 		.of_match_table	= sun50i_a100_r_ccu_ids,
 	},
 };
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
index 913bb08e6dee..1d475d5a3d91 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
@@ -1270,6 +1270,7 @@ static struct platform_driver sun50i_a100_ccu_driver = {
 	.probe	= sun50i_a100_ccu_probe,
 	.driver	= {
 		.name	= "sun50i-a100-ccu",
+		.suppress_bind_attrs = true,
 		.of_match_table	= sun50i_a100_ccu_ids,
 	},
 };
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 54f25c624f02..fcbd914e84e0 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -978,6 +978,7 @@ static struct platform_driver sun50i_a64_ccu_driver = {
 	.probe	= sun50i_a64_ccu_probe,
 	.driver	= {
 		.name	= "sun50i-a64-ccu",
+		.suppress_bind_attrs = true,
 		.of_match_table	= sun50i_a64_ccu_ids,
 	},
 };
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index c0800da2fa3d..9a8902f702c5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -1252,6 +1252,7 @@ static struct platform_driver sun50i_h6_ccu_driver = {
 	.probe	= sun50i_h6_ccu_probe,
 	.driver	= {
 		.name	= "sun50i-h6-ccu",
+		.suppress_bind_attrs = true,
 		.of_match_table	= sun50i_h6_ccu_ids,
 	},
 };
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index c2ddcd2ddab4..e663ab0c9935 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -918,6 +918,7 @@ static struct platform_driver sun8i_a83t_ccu_driver = {
 	.probe	= sun8i_a83t_ccu_probe,
 	.driver	= {
 		.name	= "sun8i-a83t-ccu",
+		.suppress_bind_attrs = true,
 		.of_match_table	= sun8i_a83t_ccu_ids,
 	},
 };
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 002e0c3a04db..a2144ee728a0 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -1369,6 +1369,7 @@ static struct platform_driver sun8i_r40_ccu_driver = {
 	.probe	= sun8i_r40_ccu_probe,
 	.driver	= {
 		.name	= "sun8i-r40-ccu",
+		.suppress_bind_attrs = true,
 		.of_match_table	= sun8i_r40_ccu_ids,
 	},
 };
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
index 261e64416f26..d2072972b614 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
@@ -268,6 +268,7 @@ static struct platform_driver sun9i_a80_de_clk_driver = {
 	.probe	= sun9i_a80_de_clk_probe,
 	.driver	= {
 		.name	= "sun9i-a80-de-clks",
+		.suppress_bind_attrs = true,
 		.of_match_table	= sun9i_a80_de_clk_ids,
 	},
 };
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
index 97aaed0e6850..68b30fdc60fd 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -1243,6 +1243,7 @@ static struct platform_driver sun9i_a80_ccu_driver = {
 	.probe	= sun9i_a80_ccu_probe,
 	.driver	= {
 		.name	= "sun9i-a80-ccu",
+		.suppress_bind_attrs = true,
 		.of_match_table	= sun9i_a80_ccu_ids,
 	},
 };
-- 
2.31.1

