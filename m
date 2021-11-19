Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FF745693F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhKSEjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:39:01 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:60043 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233909AbhKSEi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:38:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id EAA032B01172;
        Thu, 18 Nov 2021 23:35:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Nov 2021 23:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=fguoVogwmskAh
        lHrC9KOQfT5JQU7tzggdR1YQNV9uik=; b=o5JqvyCAYEVju+Yh4yL6P6ku03S5j
        wH4kwgzFs0RRrIdA0UXoQw9ks756W72259idvfzXdnjOCYNJ84UE4/0RRTYu+8A3
        tnyb0ocht1KOCAh27Nx0TokcJI/yo6Kxp1LTHihqwDmuulaFhhFjShYxZ0Tq3xHJ
        o5VR7fI6HkG2EYb3potPcLr0RxBjy11X9nGmRV+cpU5AdFiyl/KtSW5UFtyyym+d
        g3/wNyRRNyieph9gGgtccmIYtvKwdx4jDfxBKMGkdBP0zoiADt1V9+A8MNvlhlkA
        CnBTwovrSBVrYDRjpV/5tIk1EVAQsrz1JsUU46rCPgX14x17pP0v0TgbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=fguoVogwmskAhlHrC9KOQfT5JQU7tzggdR1YQNV9uik=; b=VRam4kUH
        sdrSfLCHkgyl7XojmkWgNGvuGs3SrmsvFe88C7nc+jXarD4ildE6dIcK/aZFIsq1
        +xRaRsUMO9VeD0b4iBMSE0OU152PY7DVbG15TRd1/tc8gvzsVvoyMTxjilpHWbDw
        a/rdc9wccBDC7ObWJHXsod0GcnUeheLAxW5HpzD/nqt14u+71HF4GiyM7Ox3gWP6
        8/q1T5Geuah9R3g1gDDcNZodB7R27YACYou2tYZo1X56GoFp/v+ouM1NidOr5g6P
        02Dh9ZuP0/CMDUtQAr5XaraVxiJmyDAy37pXS9du80jfcAVtekPkOUp9DDiQN4Ku
        uVyaNWvU2UPdWg==
X-ME-Sender: <xms:qymXYWEP_VwHHcsJjMURSuFiR6PTIGI2prK4Z5nA1hJIr9AwvFbgXg>
    <xme:qymXYXXO8oZJV_dgPYRJNb4zgd8TtLTTNkJBJJmWouonqkXlw2BMCB6LGwloKp5m5
    gNBf-ky6cso9IeP8Q>
X-ME-Received: <xmr:qymXYQJeG1z0NYGJswX1KBzJLRIInvK35PVXDniFfcma3uqXx_gWvnL_mK231LD1zaJLJ0eC2SIJfcWhICOiKhMNVFGS1HX8sBYECiwzECaqN-hTBCQxNVzz6_brgWba1ziUeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:qymXYQE_2Hhvur5puk5HPY5BM7sR-GWJe1CG3-wEpD2P9c0JSlhikw>
    <xmx:qymXYcV93eu5p0mWDqPmmnoxMlX3O0uhUZBI3J9iq25Ujy1vdWwbyg>
    <xmx:qymXYTMn0LRJKUm2xlyyYRI8_XqdYaRUCF6ZRQiVIavwLd3bgIMYwQ>
    <xmx:qymXYVML4wtrmwyuVe6au6XY1Ntkv-jQw3EgLSiUHbOvKJl5YOsxMwcXRDM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 23:35:54 -0500 (EST)
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
Subject: [PATCH v1 3/6] clk: sunxi-ng: mp: Add macros using clk_parent_data and clk_hw
Date:   Thu, 18 Nov 2021 22:35:41 -0600
Message-Id: <20211119043545.4010-4-samuel@sholland.org>
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
declaring dividers that take advantage of these.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi-ng/ccu_mp.h | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.h
index b392e0d575b5..6e50f3728fb5 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.h
+++ b/drivers/clk/sunxi-ng/ccu_mp.h
@@ -82,6 +82,55 @@ struct ccu_mp {
 				   _muxshift, _muxwidth,		\
 				   0, _flags)
 
+#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+					_mshift, _mwidth,		\
+					_pshift, _pwidth,		\
+					_muxshift, _muxwidth,		\
+					_gate, _flags)			\
+	struct ccu_mp _struct = {					\
+		.enable	= _gate,					\
+		.m	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
+		.p	= _SUNXI_CCU_DIV(_pshift, _pwidth),		\
+		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(_name, \
+								   _parents, \
+								   &ccu_mp_ops, \
+								   _flags), \
+		}							\
+	}
+
+#define SUNXI_CCU_MP_DATA_WITH_MUX(_struct, _name, _parents, _reg,	\
+				   _mshift, _mwidth,			\
+				   _pshift, _pwidth,			\
+				   _muxshift, _muxwidth,		\
+				   _flags)				\
+	SUNXI_CCU_MP_DATA_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+					_mshift, _mwidth,		\
+					_pshift, _pwidth,		\
+					_muxshift, _muxwidth,		\
+					0, _flags)
+
+#define SUNXI_CCU_MP_HW_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+				      _mshift, _mwidth,			\
+				      _pshift, _pwidth,			\
+				      _muxshift, _muxwidth,		\
+				      _gate, _flags)			\
+	struct ccu_mp _struct = {					\
+		.enable	= _gate,					\
+		.m	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
+		.p	= _SUNXI_CCU_DIV(_pshift, _pwidth),		\
+		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS_HW(_name, \
+								 _parents, \
+								 &ccu_mp_ops, \
+								 _flags), \
+		}							\
+	}
+
 static inline struct ccu_mp *hw_to_ccu_mp(struct clk_hw *hw)
 {
 	struct ccu_common *common = hw_to_ccu_common(hw);
-- 
2.32.0

