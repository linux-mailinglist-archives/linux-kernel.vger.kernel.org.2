Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5748945693C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhKSEi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:38:57 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:58667 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233539AbhKSEiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:38:55 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 2300C2B0116A;
        Thu, 18 Nov 2021 23:35:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Nov 2021 23:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=UHFs+jzXlVQqY
        PwDLYltykecLOO5tGSOdE8iObY7Ef8=; b=APsP4kvPBHBsFMwDDnK51JEMv3Sle
        EHRafzDnkXB8dzvqEjJU/QOwvSkoRqbIcD7ulp9dRz5K5csBaNBCyzfAtxs7VVM0
        +ghGXv2w1JtjkjakMGV8eWDHyMj7rZtTjecIV8/P4KNPyG7k5klSUCef4WNEp9Sp
        HgF/rqmtiM7obO31SWsa1y9LlbqEk0D9UaNbnQs/S0sZSyl5e2piHo3U4FSu3yin
        wS1hkZW7RhUfI4R3fh6Usn2nsJSVxYHeLH72F2f1VM3yl/+LpoOt7L89ylp4eTY2
        3oEJAoKp9znFarQGeEPqv3NhbrwPrHf2y0enFmhakgEZH0Xq6lGeRtTfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=UHFs+jzXlVQqYPwDLYltykecLOO5tGSOdE8iObY7Ef8=; b=Hz+xUhbE
        5ZLGqtyAmZZcWDuT48M1gKGINudt1j4xom+fJKt9tKWw+5tHcESKExXQ9E3//Eqv
        iQoRUYaaPTWPVcG7ZwXFCyqYczt6eiiQZCmP5u5KyBuN+s0CcHAQpI7XnFJt5Yiu
        AEwPdzUM42VmPF0cbiO0qUYDeZmH6NsMxRL6pUV7T/heo8epeBmxoptgBTs2vqPL
        /ybLNs1Wr22DK/Yq0GX7sW83YI+/Hh7sE1XocHYGJPGPI43+5/Y9qvAAf9+OMwvK
        aWBA25WFfdNMpsh5dx/A8AGq3MwrazoAykuEMFoDlzQD6Gl4kcivQlJDJzViMYrX
        16aDeOt9S2KV0g==
X-ME-Sender: <xms:qCmXYdB_D1BZaE7rSW7R0CnmYBueZyrNieiFBFHAk-g1U1BpPGOBlQ>
    <xme:qCmXYbhnJH_Pusz_6tJUqHqtkRlbUZs1MOFuPNXIhaaiemN1Isdwy2-GrQzku1McK
    ta_oqVqSYloVvfHOw>
X-ME-Received: <xmr:qCmXYYnRr_x2Wr74FQOwmFqfE4U-UuUC5QJTG6EqQsytaOAdV8elqX84krM0DciHTtnucftJjFWb6bLSkRlbCR73Or2AwO_xe1Rl2hJbazdNhThdwOEJS4tO5LMIGfP0xlFPRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:qCmXYXy5TMpOEVoOsCURJyAJ4RJM1M_Cd0Ugisvh0shJFD8EKxlttw>
    <xmx:qCmXYSQm5NMaH5-S7DWiDJlyLz7OZcdv_jAoEyiQECpXyJOc5Fxjew>
    <xmx:qCmXYaYxfxQdDkdqUm7ekHoOV4AdPUviw91_-1P5TuDaQUhzLolriA>
    <xmx:qCmXYXKJ8O0LYulPr9YTuR9t-L2wwq1wiurWlDBZk_RS0oH6CQetO8U5F0s>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 23:35:51 -0500 (EST)
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
Subject: [PATCH v1 2/6] clk: sunxi-ng: div: Add macros using clk_parent_data and clk_hw
Date:   Thu, 18 Nov 2021 22:35:40 -0600
Message-Id: <20211119043545.4010-3-samuel@sholland.org>
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

 drivers/clk/sunxi-ng/ccu_div.h | 78 ++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
index 6682fde6043c..948e2b0c0c3b 100644
--- a/drivers/clk/sunxi-ng/ccu_div.h
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -108,6 +108,22 @@ struct ccu_div {
 				      _shift, _width, _table, 0,	\
 				      _flags)
 
+#define SUNXI_CCU_DIV_TABLE_HW(_struct, _name, _parent, _reg,		\
+			       _shift, _width,				\
+			       _table, _flags)				\
+	struct ccu_div _struct = {					\
+		.div		= _SUNXI_CCU_DIV_TABLE(_shift, _width,	\
+						       _table),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_HW(_name,		\
+							 _parent,	\
+							 &ccu_div_ops,	\
+							 _flags),	\
+		}							\
+	}
+
+
 #define SUNXI_CCU_M_WITH_MUX_TABLE_GATE(_struct, _name,			\
 					_parents, _table,		\
 					_reg,				\
@@ -166,6 +182,68 @@ struct ccu_div {
 	SUNXI_CCU_M_WITH_GATE(_struct, _name, _parent, _reg,		\
 			      _mshift, _mwidth, 0, _flags)
 
+#define SUNXI_CCU_M_DATA_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+				       _mshift, _mwidth,		\
+				       _muxshift, _muxwidth,		\
+				       _gate, _flags)			\
+	struct ccu_div _struct = {					\
+		.enable	= _gate,					\
+		.div	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
+		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(_name, \
+								   _parents, \
+								   &ccu_div_ops, \
+								   _flags), \
+		},							\
+	}
+
+#define SUNXI_CCU_M_DATA_WITH_MUX(_struct, _name, _parents, _reg,	\
+				  _mshift, _mwidth,			\
+				  _muxshift, _muxwidth,			\
+				  _flags)				\
+	SUNXI_CCU_M_DATA_WITH_MUX_GATE(_struct, _name, _parents, _reg,  \
+				       _mshift, _mwidth,		\
+				       _muxshift, _muxwidth,		\
+				       0, _flags)
+
+#define SUNXI_CCU_M_HW_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+				     _mshift, _mwidth, _muxshift, _muxwidth, \
+				     _gate, _flags)			\
+	struct ccu_div _struct = {					\
+		.enable	= _gate,					\
+		.div	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
+		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS_HW(_name,	\
+								 _parents, \
+								 &ccu_div_ops, \
+								 _flags), \
+		},							\
+	}
+
+#define SUNXI_CCU_M_HWS_WITH_GATE(_struct, _name, _parent, _reg,	\
+				  _mshift, _mwidth, _gate,		\
+				  _flags)				\
+	struct ccu_div _struct = {					\
+		.enable	= _gate,					\
+		.div	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_HWS(_name,	\
+							  _parent,	\
+							  &ccu_div_ops,	\
+							  _flags),	\
+		},							\
+	}
+
+#define SUNXI_CCU_M_HWS(_struct, _name, _parent, _reg, _mshift,		\
+			_mwidth, _flags)				\
+	SUNXI_CCU_M_HWS_WITH_GATE(_struct, _name, _parent, _reg,	\
+				  _mshift, _mwidth, 0, _flags)
+
 static inline struct ccu_div *hw_to_ccu_div(struct clk_hw *hw)
 {
 	struct ccu_common *common = hw_to_ccu_common(hw);
-- 
2.32.0

