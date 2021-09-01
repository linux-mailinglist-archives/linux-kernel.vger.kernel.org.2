Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085D63FD316
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbhIAFlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:41:01 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48455 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231289AbhIAFky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:40:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id EE038580568;
        Wed,  1 Sep 2021 01:39:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 01 Sep 2021 01:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=xm7Y8fEf134No
        HobrQ9IyVP5eZVPNtG57R+gyfqDAkc=; b=oBUtnAYl2+2Rs7fk7WmqGOp4/X/I3
        yYLn/YDjlsYtXq6TARIViIGiXbDZEwN79+0stclM63Tzz8LMthK/V6W3tOVBQ0c5
        zv+m2jbDVQPcZUIzVacv8LYMN7dPlcG80Qdz3teX1atoaE8hVeyOyxKEJ86aDz8i
        OwKnVlG4kzwyUWPWb1FgoAeCqMgZF9FJ4JNTriJBrnUS3PbTFGXgwAcn14p85vce
        HZ+B3YH9IaTiDNT6zdOEPuRbu8LRPQksz01BU0MmNKIlZq/ooPWpEIiVhzfS8xBT
        fav61RCojVWyClLLgOwutQiP4fRV9lGTLu+HNen6tXWyHJGl6JYkR8M1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=xm7Y8fEf134NoHobrQ9IyVP5eZVPNtG57R+gyfqDAkc=; b=H+BjWZNP
        iApnlLx6xJnVvdHoL3AW2yelZ0jFvHXTB7OnplEa6LZIdUYUt7RIF925BC/OW+45
        0Nu/halsRAEG5q4JGhCgtp33IIL5/yilzgPFe2vdIzwpV/vj408uyOl2lhEQGTLV
        1rIlUO4mdtioMgd1OHeZj3Fbjxj/58+PYS1OcKfvjO6R+F4w8qQ5CWbUTG3SqVC1
        4IRn/RxsAppJx3taZab2jSTd1C08we69lOMt64Tswunu5liauov0U7t/OiCCwgU/
        +XL5rzY6bcZUPMeTK8D3K0GEf9f+lZewynxkTq+XCE6GmpdP4F4bcVzJ54sMZ4VE
        PwnGG+8BR5ISjg==
X-ME-Sender: <xms:LRIvYa0w3QH9tt-JKr4ltouB2wHGfeaT2BnKPQh30Q57QiRCb892YQ>
    <xme:LRIvYdFDW7KPu0aZ_fDtj-C4huU1-GP_pWMNWG7qAvvLyRQ93kNHUnN8aF-DoowCn
    3Vj0_SuffZ2ZPHmWQ>
X-ME-Received: <xmr:LRIvYS7-1akVKJ-_mom6dgbKhvNpVtA8IxUEpbTSeegONVcT8YBSydEVFawUQUue7bNsBo7MebUhjwWHHvxQnJeGDGOuGPVNtRhTGzL-rZIXhNEt-mqHMy8FQIYTgm1fDf72Hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:LRIvYb35xQ3HDpdOW181ah3ngLavwweyFoHehcW9_JFnQ1DXACcVmg>
    <xmx:LRIvYdHnKhjm8Lw8ymZaY3e8ugaHxKwIKvmjjmY2IlW3PfKnSu57ww>
    <xmx:LRIvYU8WHUoHca20IyEeuhdzJqHxTnkm9Iac1vstxH_43eB_mmZ8_g>
    <xmx:LRIvYV8Qz3N_acQYIgPMcvLSebBMAWlAB7d1gtu8C_C9q8gQfLBx7g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:39:57 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 3/7] clk: sunxi-ng: mux: Add macro using CLK_HW_INIT_PARENTS_DATA
Date:   Wed,  1 Sep 2021 00:39:47 -0500
Message-Id: <20210901053951.60952-4-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901053951.60952-1-samuel@sholland.org>
References: <20210901053951.60952-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some muxes need the flexibility to specify a combination of internal
parents (using .hw) and external parents (using .fw_name). Support
this with a version of the SUNXI_CCU_MUX_WITH_GATE macro that uses
CLK_HW_INIT_PARENTS_DATA to provide the parent information.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu_mux.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index f165395effb5..5aa5a6f49bd8 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -73,6 +73,20 @@ struct ccu_mux {
 	SUNXI_CCU_MUX_TABLE_WITH_GATE(_struct, _name, _parents, NULL,	\
 				      _reg, _shift, _width, 0, _flags)
 
+#define SUNXI_CCU_MUX_DATA_WITH_GATE(_struct, _name, _parents, _reg,	\
+				     _shift, _width, _gate, _flags)	\
+	struct ccu_mux _struct = {					\
+		.enable	= _gate,					\
+		.mux	= _SUNXI_CCU_MUX(_shift, _width),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(_name, \
+								   _parents, \
+								   &ccu_mux_ops, \
+								   _flags), \
+		}							\
+	}
+
 static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
 {
 	struct ccu_common *common = hw_to_ccu_common(hw);
-- 
2.31.1

