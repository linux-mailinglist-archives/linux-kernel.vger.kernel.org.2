Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580F2456942
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhKSEjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:39:03 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:48587 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233731AbhKSEjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:39:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id AD4702B0116A;
        Thu, 18 Nov 2021 23:35:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 18 Nov 2021 23:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=BMpnUeRyh0/dK
        tU3aOduYGSgk1k3D8qrcKn/13C1j/4=; b=lA9Ytq+iQKfAdpvjOX5m4oA4aZEVE
        QZxV27szXbgssG8GloFsCF754bGGsuR3LupVbjkyHfJ71xJ+52omcFg0mmd+AueV
        fuBF+cc7S1/d880jrFc9/7SSafBu1rkVM5TiQqzRjjdX2b/y4OCgY0kuv/GX+HCs
        SRywiSzaGwJYS4eSKdq+H+Tb+R56H/2hD4tPPZ5Px7Xxsl4rn/ZZIZTvZBi9dsbg
        t7IV0RsBDuiRo+OkRJtG3jTwhBYjsF7JFYGkVyhuuAey6oG2nVkEX2u6cndFEvU2
        8Afn3JmIk9w87rKdJMy/36im5z2Dws8TF21TspvoYMEvvLfa5trM0ZB/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=BMpnUeRyh0/dKtU3aOduYGSgk1k3D8qrcKn/13C1j/4=; b=KKiHSMNh
        6UT/cleWbA05MZPLgkGnyMn6S0wzRLBfDX1NLyD8E0dK8Kw+UdEqvFcwKDyTd7GA
        aBWPgxjR4NFlEQdFxM82PNdFmc1AwvddlEq/+TYgZk5dOZCWUh40vLY2EBrTdkTL
        QimJlxOl8FXB6O3aPTvkQEFH8lrmOomPpzYwAdt75zLzFMS7WWfNvhDQcjsVFQn6
        5ZZvhA3fdNEJ+2Hmd1160HLmcX4OERY0XSmL5qgBTfRnmxoiyQWZntz1cUbPdAZU
        ocP3LThNq3jps8H95mxaYK8zsOatfQWUCrfan4D93nB4f0dMqvdPCfs4owbZF12X
        9AmSPWfJ0D/SKw==
X-ME-Sender: <xms:rimXYW80yCe7bLk74HOPrhA_McFOqTVSvqm2LmjeNpIWNq-c-jCvwQ>
    <xme:rimXYWsppK-GjdAh5jdcBj7t9GQWLBJTYhk3eWzWH1u7TPblmUBk1Q60BdS_H6jkO
    8ca2hQ0-uTK6IyHRQ>
X-ME-Received: <xmr:rimXYcAcIDaMY9D3piWl1OHKY5eF7MVP119XVsE6eX-KhDk7tZxWgz4l_xHYJVQqFwEh6Trsy1ZKGco-FLCnGiNGMjjjMuGn9LMmJbDRoAMnG8ckcBOVd0fY9HNo64b12o6iiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:rimXYecpZCtO2crybUa6EP1x5Rws8KB7yjm2FlAH6mn78xaG8uXObg>
    <xmx:rimXYbMlg6YExZRQ0xSfeEfzlOiA9A-gpcrmd6gZfFn7QEG0KF8NHw>
    <xmx:rimXYYl7oDXBXLuSVs3SnTHjbipPrh9rPuJL-cp1CqCSXZJiH7KbgA>
    <xmx:rimXYcGKGhOEplzmx5AxJZwYhKSLO0hhZDuH68bxr2up1o8XxggxsIf3s0M>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 23:35:57 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v1 4/6] clk: sunxi-ng: mux: Add macros using clk_parent_data and clk_hw
Date:   Thu, 18 Nov 2021 22:35:42 -0600
Message-Id: <20211119043545.4010-5-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119043545.4010-1-samuel@sholland.org>
References: <20211119043545.4010-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Referencing parents with clk_hw pointers is more efficient and removes
the dependency on global clock names. clk_parent_data is needed when
some parent clocks are provided from another driver. Add macros for
declaring muxes that take advantage of these.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi-ng/ccu_mux.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index e31efc509b3d..2c1811a445b0 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -72,6 +72,39 @@ struct ccu_mux {
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
+#define SUNXI_CCU_MUX_DATA(_struct, _name, _parents, _reg,		\
+		      _shift, _width, _flags)				\
+	SUNXI_CCU_MUX_DATA_WITH_GATE(_struct, _name, _parents, _reg,	\
+				     _shift, _width, 0, _flags)
+
+#define SUNXI_CCU_MUX_HW_WITH_GATE(_struct, _name, _parents, _reg,	\
+				   _shift, _width, _gate, _flags)	\
+	struct ccu_mux _struct = {					\
+		.enable	= _gate,					\
+		.mux	= _SUNXI_CCU_MUX(_shift, _width),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS_HW(_name, \
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
2.32.0

