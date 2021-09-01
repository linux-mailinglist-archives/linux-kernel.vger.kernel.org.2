Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F93FD2AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbhIAFGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:06:40 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60825 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241867AbhIAFGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:06:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E41A5C01D8;
        Wed,  1 Sep 2021 01:05:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 01 Sep 2021 01:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=++HrPlGZ+qukq
        dajcrSz33+ED++t/T63RI31aUteFu8=; b=iJfcDUPrzdASsyU/bPixM0kQE82Jf
        Yx4xrZkcCN+FqOl6YdkO+TUu6jF9RUCjJZkQFIMAyWXH+vxPMObuiRQG16bGilcI
        JEIOVgDtEoGBnrX835cSlUzBNnnxe9PEavVS5cxN2l0C0RP+oGnZ/VSd9RIgPShW
        HPaPH4D2sVyM0TyGQqxML+XKWYwV8STP2H0sd2rThH2XMBD06XZese5CDh3wjytL
        cF4kB6GsflfY7saDQILjZr5gD2wnuspV5ANQYJQ72UyuRSFtLsr4pKQrzNxZWrb0
        W4K3j16+2PiApWELwJL9LQVsvexp0aWR/z5bjIXQ/CSDx3MzZbwvzfUiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=++HrPlGZ+qukqdajcrSz33+ED++t/T63RI31aUteFu8=; b=s4ulmAgg
        AEWKMaJuI7TreqcAv29aYi6Os4a/9QEgNmEDlcqptVmvRF16Tb/+zLI4V/lcM9FI
        w8mPwqpObiQfU0bbTPUkZZdUyRzh1VCWGkGWrODBH+KhAx98uc57yrjRs+OBZ0E/
        4z1qIHGOLvmI8L9fBzD7Zn3jzi+dOcHzCg+2yQmLZw3ROmdInGENb1XVCUTf6ZEv
        DXpYdzozrK/qlvT3Z/kZdJdYvELCGvm8aOi5ewHxNaHn0VAXfDPPTwtIwaXtbp4t
        VbfJnvJynB9IBKovUbBbtFrs3suufdw9pI+N9yPrJhwl56Iao65QYPbg8YNd22MH
        lbpdZd5DOuM8Jg==
X-ME-Sender: <xms:HQovYVvi6AKdzF4yT31JlbLNhn9D8s4dlSXGRRRDxXcc8en9wvDhwQ>
    <xme:HQovYec-YFaNSsSWVraeVFCDrzBol0vIweEfWRdV-M4xWsoIgtmO1C7QdEV_-s_U3
    P3VK0zfVBo89sPHjQ>
X-ME-Received: <xmr:HQovYYyq0oXRxdbNXqV0gERotsAdjTP-nQBwd2y4xX7neVUmlQQGnKyskQn_Tv0eoIcqucgMBJ9BqBZzegeCeEm0yL0T9CN4GQiGDhwT23Tgo4FzPGfzZVMsky9xFN5wysaLLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:HQovYcPR3yX3BybYFQLo7QVcTQVMtd9GNCRPFsySMFvyPUNAZNP6Cw>
    <xmx:HQovYV9GyeyaGdI1Y7waLfOufZvBUd7f6Uuk1kmWfwBCMBu8tgFqpQ>
    <xmx:HQovYcXsZmnSXaDeOGBMtxRvkV7oQMK2e75tBaZW15Wn1UlRXR33Vg>
    <xmx:HgovYRRO8Z75Yu9y3JfKDAoPetKTWENHwBL2hFsZwHRNJCPe4ly28Q>
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
Subject: [PATCH 3/8] clk: sunxi-ng: Use a separate lock for each CCU instance
Date:   Wed,  1 Sep 2021 00:05:21 -0500
Message-Id: <20210901050526.45673-4-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901050526.45673-1-samuel@sholland.org>
References: <20210901050526.45673-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms have more than one CCU driver loaded: the main CCU, the
PRCM, the display engine, and possibly others. All of these hardware
blocks have separate MMIO spaces, so there is no need to synchronize
between them.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu_common.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index 88cb569e5835..31af8b6b5286 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -17,11 +17,10 @@
 
 struct sunxi_ccu {
 	const struct sunxi_ccu_desc	*desc;
+	spinlock_t			lock;
 	struct ccu_reset		reset;
 };
 
-static DEFINE_SPINLOCK(ccu_lock);
-
 void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock)
 {
 	void __iomem *addr;
@@ -94,6 +93,8 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, struct device *dev,
 
 	ccu->desc = desc;
 
+	spin_lock_init(&ccu->lock);
+
 	for (i = 0; i < desc->num_ccu_clks; i++) {
 		struct ccu_common *cclk = desc->ccu_clks[i];
 
@@ -101,7 +102,7 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, struct device *dev,
 			continue;
 
 		cclk->base = reg;
-		cclk->lock = &ccu_lock;
+		cclk->lock = &ccu->lock;
 	}
 
 	for (i = 0; i < desc->hw_clks->num ; i++) {
@@ -133,7 +134,7 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, struct device *dev,
 	reset->rcdev.owner = dev ? dev->driver->owner : THIS_MODULE;
 	reset->rcdev.nr_resets = desc->num_resets;
 	reset->base = reg;
-	reset->lock = &ccu_lock;
+	reset->lock = &ccu->lock;
 	reset->reset_map = desc->resets;
 
 	ret = reset_controller_register(&reset->rcdev);
-- 
2.31.1

