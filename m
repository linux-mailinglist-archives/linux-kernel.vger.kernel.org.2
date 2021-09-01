Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998A13FD31E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbhIAFlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:41:17 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:45991 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242066AbhIAFkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:40:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 99C7F58057C;
        Wed,  1 Sep 2021 01:39:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 01 Sep 2021 01:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=W8MNz8Wllp4iR
        U2Ej37s5iy4UZZCQpDauVNv3IqBNDM=; b=h5FpEQoFPYPGpMrAWuh5JY9Pn/fJR
        PQ2vrvFR4E3HKWdsvMazeiq7QadJGwXn4LBUy4aFbyfamh/QS5KBpOdEquRXAVgQ
        ZC7pX+DtO8KFDpDDkidF7yCkm9Krp0CXNCDKboQvvDOGdrPsqBabfqMePRu3I2bP
        NmB1OKf631fNp12RMx+reKL+zQGGl4zTve1Q463NMAbvbOvO1OKCDEj2F9YrEnzG
        ugbUPrWkdXSXUdzk0Njam4K8Eiyd3d04q8LXYG+CyAzLCiX76iP4dwgkl7DZPspt
        QspPzUrQnU9K1MKr1BG+BjxSG0kUUqh0tSnvLPBB/lMT0VuoAMFzrGFsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=W8MNz8Wllp4iRU2Ej37s5iy4UZZCQpDauVNv3IqBNDM=; b=cFWHbCdp
        wkvWgxAEkjIVOwiZz2e2CvtF3O6cdl9ig2KkKmunlIyzYkCPPOp+MKHvSLHjr7yG
        H0YMMQfuzSB0s5HI9WIGisKU1VAa4AiyGHKwwXUYKMiUf6GqtgEg/IgHRb3YfPpi
        vIgcId6UI6XX7uldSV7zl+6oLTbR0GBSXkRjX3BHT84CyHqm+diiLlsFFzLEjBiM
        hzLTlYWLxZOu9JVaprpPmAd7e7HIkSr/Ou7icSolBukrew0xGF0Un5JL0LzCDZi3
        wpWPdocrQyhvhvIFMoWI8fNe+FdZegoKze/Vyn8JZra1AncRvKsoAFE1RxksSFhO
        ExUYTeJt0ghFog==
X-ME-Sender: <xms:LhIvYZwMHbn0KY_80SvB7xrnYyGPu6uppfAi70H5IdX0BnGbMR-_PA>
    <xme:LhIvYZSieBqt8QqpXlZNPHQ4_vsJrom3KCwKpzvXBPD0PoK6NgUqS42vKZtR6NQIE
    Te2rXdnnYlKifLeBw>
X-ME-Received: <xmr:LhIvYTWJPtcGyP8CuBpHZkUVyGwDPu4pVePGakUFkss2Hltr8rVAlZysVCmL2pUK9F2hOB95HAiNSkwLmYoM8ka1YqGDzR5y-lYv8kLGOzk6PvR9IPAO7cfm9acR2q_NOuW6Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:LhIvYbh1pYwNqg53bzAPuzQXjHxY5A8aWuuSaQAmP6dnRVGRCh7qfA>
    <xmx:LhIvYbAzGtyZ04Sr5e0ESUheNrAeSEXx9Futof4ZdURQziDNeAC1tw>
    <xmx:LhIvYUK-vghP_HcaVfQJW4_PB4OKE3kxcWot1SxY-mYKAXxz1_hipQ>
    <xmx:LhIvYf4RNROpDtqyR9XNnL0_OvpZFFVv6d0KZNQNXOojLc-0nGUXoQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:39:58 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 4/7] clk: sunxi-ng: mux: Allow muxes to have keys
Date:   Wed,  1 Sep 2021 00:39:48 -0500
Message-Id: <20210901053951.60952-5-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901053951.60952-1-samuel@sholland.org>
References: <20210901053951.60952-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The muxes in the RTC can only be updated when setting a key field to a
specific value. Add a feature flag to denote muxes with this property.
Since so far the key value is always the same, it does not need to be
provided separately for each mux.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu_common.h |  1 +
 drivers/clk/sunxi-ng/ccu_mux.c    |  7 +++++++
 drivers/clk/sunxi-ng/ccu_mux.h    | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index 98a1834b58bb..fbf16c6b896d 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -17,6 +17,7 @@
 #define CCU_FEATURE_LOCK_REG		BIT(5)
 #define CCU_FEATURE_MMC_TIMING_SWITCH	BIT(6)
 #define CCU_FEATURE_SIGMA_DELTA_MOD	BIT(7)
+#define CCU_FEATURE_KEY_FIELD		BIT(8)
 
 /* MMC timing mode switch bit */
 #define CCU_MMC_NEW_TIMING_MODE		BIT(30)
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 785803cd7e51..fb93cea3a502 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -12,6 +12,8 @@
 #include "ccu_gate.h"
 #include "ccu_mux.h"
 
+#define CCU_MUX_KEY_VALUE		0x16aa0000
+
 static u16 ccu_mux_get_prediv(struct ccu_common *common,
 			      struct ccu_mux_internal *cm,
 			      int parent_index)
@@ -188,6 +190,11 @@ int ccu_mux_helper_set_parent(struct ccu_common *common,
 	spin_lock_irqsave(common->lock, flags);
 
 	reg = readl(common->base + common->reg);
+
+	/* The key field always reads as zero. */
+	if (common->features & CCU_FEATURE_KEY_FIELD)
+		reg |= CCU_MUX_KEY_VALUE;
+
 	reg &= ~GENMASK(cm->width + cm->shift - 1, cm->shift);
 	writel(reg | (index << cm->shift), common->base + common->reg);
 
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index 5aa5a6f49bd8..6ca15e43f9c8 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -87,6 +87,20 @@ struct ccu_mux {
 		}							\
 	}
 
+#define SUNXI_CCU_MUX_HW_WITH_KEY(_struct, _name, _parents, _reg,	\
+				  _shift, _width, _flags)		\
+	struct ccu_mux _struct = {					\
+		.mux	= _SUNXI_CCU_MUX(_shift, _width),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_KEY_FIELD,	\
+			.hw.init	= CLK_HW_INIT_PARENTS_HW(_name,	\
+								 _parents, \
+								 &ccu_mux_ops, \
+								 _flags), \
+		}							\
+	}
+
 static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
 {
 	struct ccu_common *common = hw_to_ccu_common(hw);
-- 
2.31.1

