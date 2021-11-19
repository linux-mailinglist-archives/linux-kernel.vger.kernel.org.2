Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C63B456945
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhKSEjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:39:07 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:57693 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233992AbhKSEjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:39:03 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 705212B01172;
        Thu, 18 Nov 2021 23:36:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Nov 2021 23:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=h1cm6yaBLa7fG
        WfDuCwXWejyAuGuYV6rO7Vr/mcP4I4=; b=OO5CL/II6VsNr6DEPDXosUiPS59RJ
        8xKrzdOQLKz9NfyXVbBlKA6SBb4zvkNMsswwsGA4gH0W8CLd96E3N6fcO6pqnqR0
        zdzC1sCesWymiMbfHtoSY+il7Mvsjf5L7bi+o8k3E7Qo0pcRGDgWNvrRVivKzrws
        QwrRhfnQCwhSrCv4pFNHbDVTkk3/+AYpKzU2oiaSSnWlssc9CkPDWzlw8KoeZWme
        bCyRn2D62tKYxmRH6rYaikAVNj9c0ovrZtakBp8oRNqwoYYi5UeExKl2QvNP6pjv
        Umc6jcO9l6zTQervgHQgk+45RW2BuQ2OMzwTXlILfHl8ZsAa7ZEVbuzjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=h1cm6yaBLa7fGWfDuCwXWejyAuGuYV6rO7Vr/mcP4I4=; b=eSW+ITFp
        zKyopsc2Tq0V2o2DBfp5FAKAu2Aohon6U04gw/U5PI2T7Ksk3TwnKKxxPLulPaym
        qv5YKfKjKwpS+lJQt4N6Nns4ed4fNCgYeurvahsvg4/Gxy2Rh7Ah2Vc5JkqYgrIt
        k8E+Zd5KeTCNaxQjSuuObR33Vm2XZmn4aC0TtzkAhF9M+Bd549xBhrz+Zjszw8H+
        aw39VPa/f351exJQzyM0nLh0jp/BrtLmC+3wChemRt3Lz1ntGQjToRjdigk4UUl8
        MePQbVKcB9uEa6TyaZEV+P0ivXA288NsUh4eUzYjuD4frUdvnSYViOLY1uhtt+yl
        VedoAXXFv4IeXg==
X-ME-Sender: <xms:sCmXYcByCL2cpSRy499Prab3ZmmXEXz-Br7SNIIyhs4vEDNvCgh3jA>
    <xme:sCmXYeh3p6TyaDbCnVS9yGyTmORcYulEInp6TTscbnAn4H3R79yLlvyaWCbEq-R1y
    zUUKOQT1cgzkDwRiQ>
X-ME-Received: <xmr:sCmXYfnVSEKBEhM30QyPsq2gtQCfsqnVaXVmPJYqPMmvWDPNB7eSz3HfwyWc3LEM3htPAK1fWMrWPr0DQXgTEu1zcUk9miylwQKx4BaZIt3_yZfAO3CDjaDW022nDs5RCJPv_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:sSmXYSw9sB0ZVsm8Bdgz2bau5TEtXoGBOmp9qgfqJQyfFUFGxqK1ZQ>
    <xmx:sSmXYRRY08OPggUATvF1GeJY4PHES5ACeC3pdY6jr3FIWslC9DiQsw>
    <xmx:sSmXYdYUdU09_c6f_5wVGBXZmGJi_hVVgZFMMOt_i93uXB1XJ1_g4A>
    <xmx:sSmXYWIX0FgzEe2UXxHw0RQkW9zGdueLbOG10-U2Zl1fWF0sr4SB1p4H0JU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 23:36:00 -0500 (EST)
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
Subject: [PATCH v1 5/6] clk: sunxi-ng: gate: Add macros for gates with fixed dividers
Date:   Thu, 18 Nov 2021 22:35:43 -0600
Message-Id: <20211119043545.4010-6-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119043545.4010-1-samuel@sholland.org>
References: <20211119043545.4010-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to declare a gate with a fixed divider, by using the
CCU_FEATURE_ALL_PREDIV flag. Since this is not obvious, add a macro
for declaring this type of clock.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi-ng/ccu_gate.h | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_gate.h b/drivers/clk/sunxi-ng/ccu_gate.h
index c386689a952b..dc05ce06737a 100644
--- a/drivers/clk/sunxi-ng/ccu_gate.h
+++ b/drivers/clk/sunxi-ng/ccu_gate.h
@@ -53,7 +53,7 @@ struct ccu_gate {
 	}
 
 /*
- * The following two macros allow the re-use of the data structure
+ * The following macros allow the re-use of the data structure
  * holding the parent info.
  */
 #define SUNXI_CCU_GATE_HWS(_struct, _name, _parent, _reg, _gate, _flags) \
@@ -68,6 +68,21 @@ struct ccu_gate {
 		}							\
 	}
 
+#define SUNXI_CCU_GATE_HWS_WITH_PREDIV(_struct, _name, _parent, _reg,	\
+				       _gate, _prediv, _flags)		\
+	struct ccu_gate _struct = {					\
+		.enable	= _gate,					\
+		.common	= {						\
+			.reg		= _reg,				\
+			.prediv		= _prediv,			\
+			.features	= CCU_FEATURE_ALL_PREDIV,	\
+			.hw.init	= CLK_HW_INIT_HWS(_name,	\
+							  _parent,	\
+							  &ccu_gate_ops, \
+							  _flags),	\
+		}							\
+	}
+
 #define SUNXI_CCU_GATE_DATA(_struct, _name, _data, _reg, _gate, _flags)	\
 	struct ccu_gate _struct = {					\
 		.enable	= _gate,					\
@@ -81,6 +96,21 @@ struct ccu_gate {
 		}							\
 	}
 
+#define SUNXI_CCU_GATE_DATA_WITH_PREDIV(_struct, _name, _parent, _reg,	\
+					_gate, _prediv, _flags)		\
+	struct ccu_gate _struct = {					\
+		.enable	= _gate,					\
+		.common	= {						\
+			.reg		= _reg,				\
+			.prediv		= _prediv,			\
+			.features	= CCU_FEATURE_ALL_PREDIV,	\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(_name, \
+								   _parent, \
+								   &ccu_gate_ops, \
+								   _flags), \
+		}							\
+	}
+
 static inline struct ccu_gate *hw_to_ccu_gate(struct clk_hw *hw)
 {
 	struct ccu_common *common = hw_to_ccu_common(hw);
-- 
2.32.0

