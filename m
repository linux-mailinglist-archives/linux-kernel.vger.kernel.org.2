Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080E73FD311
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbhIAFk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:40:58 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:37083 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242060AbhIAFky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:40:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 55FA2580564;
        Wed,  1 Sep 2021 01:39:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 01 Sep 2021 01:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=TDgB71QmYRgxe
        D84v0Lxvqv7BLWaUck6sYKS4bFnXgA=; b=fuQCYQU5kEyxyXW1hW6jcmWPstqT7
        98zrM205IOA797qtAjInGJLrmNKWjdRzJtnyJ3K2itHXFVxHRSTENYYogXpcJVmP
        JP+3zZwVR4nnoFhIV1cfCffO8IhVsyxNo0ui7vlQvZwpc/aoVR/ab8wvJWC3zVus
        nCXQyAOFpj95bohEApJhn18+lwNHb6D/lv0Y2/xz43hpBo6wrkF1wemCdeftS8ZN
        YlP9juuLunlvDbNqPK6ZuhyXB3rZLtUj6JW5zGSHWaQZeodLPM/7dmj9z01GSBNU
        JYDV+Gc312FIpdZFqp6+AGyawGKD5RdOyYS6TTAQvbhFNkwtFs//PcrZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=TDgB71QmYRgxeD84v0Lxvqv7BLWaUck6sYKS4bFnXgA=; b=iZPxwsN6
        yVdvTG4gq4GlTzsx4Ds0uRvz+ZEW4zMYZsyEKeAG7qhf8CXPGZ1Ji0xWp4JAXGbV
        VF6stSwW4BLcvDy7bTeksB1uRu2qDIeY4ARzq9x5KhWdZMqvObS+xU+4ufJp0lS/
        f6UuBW8aiBrJXL/rgd2uRujsstf4Z+7lcmus/cSGfaJNC4K85kqqSKCbjmGvfCWK
        0l7H9fqf1e7pYn4azbrGbZwB312ZWWdYkW6J7+7MaZxJ6FUiji7M9Pe6Kw3ROeAH
        XANuO79/XRgSvCsfVcqmyXzRU/AApuqfah96Gl5jIHIpG8526nD7i4yxySbNg6SU
        RlSHzC7rt3fsqg==
X-ME-Sender: <xms:LBIvYU5yfAHE1I2djg6AFpsu6DiSSi_Iimfdw7zkdx4OktjuxPWVdg>
    <xme:LBIvYV7bjLwG4wWzBad71IgKcezgf9CIHadwt3VdGJ70-QxM_FYiL-d193bBfDn9o
    CDKvMoWXzgSNAB30w>
X-ME-Received: <xmr:LBIvYTczGItmxMnzoZolTfmSi34RTetAhbGRS2JYlF3bbMMGmCGLt13wmTBaiSsndGJEozmccJo06UFJ5q0JDtm18quo6tt5oqglAxu432nnbAtCmcAL0s22E0cMy53zhB-uvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:LBIvYZKk6CSKN7Xstje1gRpZKXYk2tLTgSArwkaAH7Wwos3K01TWPQ>
    <xmx:LBIvYYICxUk1u7Pouo1JSy7y1dkMEbbgFe0qWYBDwPQ0iE26YkSYFA>
    <xmx:LBIvYax54fW74JN9lTefuE36JejrS0b1oZCBiLiZv9B6xTSvCZMRSw>
    <xmx:LRIvYVA5Wbjwg0VbUis8gGx4bZPHqTf-Z6ViTJK57fXRt24E24ho4Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:39:56 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 2/7] clk: sunxi-ng: div: Add macro using CLK_HW_INIT_FW_NAME
Date:   Wed,  1 Sep 2021 00:39:46 -0500
Message-Id: <20210901053951.60952-3-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901053951.60952-1-samuel@sholland.org>
References: <20210901053951.60952-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use the external clock references from the device tree, instead of
hardcoded global names, parents should be referenced with .fw_name. Add
a variant of the SUNXI_CCU_M_WITH_GATE initializer which does this.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu_div.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
index 6682fde6043c..4f8c78a4665b 100644
--- a/drivers/clk/sunxi-ng/ccu_div.h
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -166,6 +166,20 @@ struct ccu_div {
 	SUNXI_CCU_M_WITH_GATE(_struct, _name, _parent, _reg,		\
 			      _mshift, _mwidth, 0, _flags)
 
+#define SUNXI_CCU_M_FW_WITH_GATE(_struct, _name, _parent, _reg,		\
+				 _mshift, _mwidth, _gate, _flags)	\
+	struct ccu_div _struct = {					\
+		.enable	= _gate,					\
+		.div	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_FW_NAME(_name,	\
+							      _parent,	\
+							      &ccu_div_ops, \
+							      _flags),	\
+		},							\
+	}
+
 static inline struct ccu_div *hw_to_ccu_div(struct clk_hw *hw)
 {
 	struct ccu_common *common = hw_to_ccu_common(hw);
-- 
2.31.1

