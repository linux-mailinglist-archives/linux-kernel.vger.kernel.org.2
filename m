Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E272C377BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 07:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhEJFqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 01:46:13 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50445 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230316AbhEJFpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 01:45:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 643455803ED;
        Mon, 10 May 2021 01:44:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 10 May 2021 01:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Cf8vcTHTFHQGR
        l2fPzXB+QwMHUhRpgEuhayhDdGSR0o=; b=O7r5u+Pb8GS2Q1DY2IQJlcY3a6mOh
        dZeDbnqS2KxWPDEfwjx84Eh5A2MB2vJWrVy+5qxJCHYvfQheNJEAYlCzn+O18q7V
        XMREvbWCgMAkbo4RKMAu0UroNFALk2mcXmItY8IFPZVC1bixpfvBUonD36TJv2e+
        fOsw/nibpqiLgt9CZ+jPZ8XmFx8AxXfSczg74i6gXLQDc2Bxp/SyT2oKAOHR1h43
        f88Jzv9ddWZTBt1fhpVwHz0Df7kO7kAru0wc6L/8pU9oMCJzrulZlDldmVedgWkU
        IrU/O6Oe9xkZklJ+w16Okl4GJBDRvtFp2Zz33UnX0JZ1Ph5Bd9omohZQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Cf8vcTHTFHQGRl2fPzXB+QwMHUhRpgEuhayhDdGSR0o=; b=thpxnPm1
        spFbmLH4SZdrghRKsDpRnTdgYoXjaWEnjRwvKmsa0W1//uuqFmlDQk7mOS21qEEz
        jOJ9rc4FLVxdfsQnQOs6sO5her+Ex8DN3gtDRMIIDL4PuVDAtm12xnFZ7sx7zFM4
        5mIpV9wa3K5PJMwkkzGd4FPiwimfdxgvRqfE+rVdCtvisHYZaOV/z+L7UjXZiCJY
        ak8LlgOpinhORA+rSRW0xWnr9FGUo2un/If0SA1AdWQJMaFecIbwcXl2RcVOnzLZ
        +pnc7M+eU5ODgVpYSIT3S7vUdZgbrQiag8Ls4kU78Pz0qRdMMLqrCsNT9BpiafRZ
        F3zS+on2wVHAzA==
X-ME-Sender: <xms:SciYYPSNgS8tBptoJC4wlF6FdvhpztlPyxj2XchmTV-PCOwFgNQPRA>
    <xme:SciYYAzFmFy_afRqkeGV1TJdGjgTBA5NoosrnIDt9s9r2ETTNls5vW4wfKRobkyh1
    H7XAjM1sUw-rJ38fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegjedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvdduhedrkeen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:SciYYE0GhbSA40fRuZhAosj475kjRLVT_gFhzsEbrgolTU8SQSq0gQ>
    <xmx:SciYYPBILDqUjXppjiEqkn49Y9u007jq1xlLKwW0NESoKiTJUucKKA>
    <xmx:SciYYIhy5ifno6GhxWfOZSdBLM-VVqsHbidyp1JpSYVKDpPi4zSq3A>
    <xmx:SciYYHQDNT3v-osM3PKc2RIEC3LTsxGnxINt05of50ltHGZA_o3kyQ>
Received: from localhost.localdomain (unknown [203.57.215.8])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 10 May 2021 01:44:35 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net, openbmc@lists.ozlabs.org,
        minyard@acm.org
Cc:     devicetree@vger.kernel.org, tmaimon77@gmail.com,
        linux-aspeed@lists.ozlabs.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        tali.perry1@gmail.com, robh+dt@kernel.org,
        chiawei_wang@aspeedtech.com, linux-arm-kernel@lists.infradead.org,
        benjaminfair@google.com, arnd@arndb.de, zweiss@equinix.com
Subject: [PATCH v3 15/16] ipmi: kcs_bmc_aspeed: Fix IBFIE typo from datasheet
Date:   Mon, 10 May 2021 15:12:12 +0930
Message-Id: <20210510054213.1610760-16-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210510054213.1610760-1-andrew@aj.id.au>
References: <20210510054213.1610760-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Input Buffer Full Interrupt Enable (IBFIE) is typoed as IBFIF for some
registers in the datasheet. Fix the driver to use the sensible acronym.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Zev Weiss <zweiss@equinix.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 9b81806b4dcb..558132b2b9f7 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -50,9 +50,9 @@
 #define     LPC_HICR0_LPC2E          BIT(6)
 #define     LPC_HICR0_LPC1E          BIT(5)
 #define LPC_HICR2            0x008
-#define     LPC_HICR2_IBFIF3         BIT(3)
-#define     LPC_HICR2_IBFIF2         BIT(2)
-#define     LPC_HICR2_IBFIF1         BIT(1)
+#define     LPC_HICR2_IBFIE3         BIT(3)
+#define     LPC_HICR2_IBFIE2         BIT(2)
+#define     LPC_HICR2_IBFIE1         BIT(1)
 #define LPC_HICR4            0x010
 #define     LPC_HICR4_LADR12AS       BIT(7)
 #define     LPC_HICR4_KCSENBL        BIT(2)
@@ -83,7 +83,7 @@
 #define LPC_STR2             0x040
 #define LPC_STR3             0x044
 #define LPC_HICRB            0x100
-#define     LPC_HICRB_IBFIF4         BIT(1)
+#define     LPC_HICRB_IBFIE4         BIT(1)
 #define     LPC_HICRB_LPC4E          BIT(0)
 #define LPC_HICRC            0x104
 #define     LPC_HICRC_ID4IRQX_MASK   GENMASK(7, 4)
@@ -383,20 +383,20 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
 
 		switch (kcs_bmc->channel) {
 		case 1:
-			regmap_update_bits(priv->map, LPC_HICR2, LPC_HICR2_IBFIF1,
-					   enable * LPC_HICR2_IBFIF1);
+			regmap_update_bits(priv->map, LPC_HICR2, LPC_HICR2_IBFIE1,
+					   enable * LPC_HICR2_IBFIE1);
 			return;
 		case 2:
-			regmap_update_bits(priv->map, LPC_HICR2, LPC_HICR2_IBFIF2,
-					   enable * LPC_HICR2_IBFIF2);
+			regmap_update_bits(priv->map, LPC_HICR2, LPC_HICR2_IBFIE2,
+					   enable * LPC_HICR2_IBFIE2);
 			return;
 		case 3:
-			regmap_update_bits(priv->map, LPC_HICR2, LPC_HICR2_IBFIF3,
-					   enable * LPC_HICR2_IBFIF3);
+			regmap_update_bits(priv->map, LPC_HICR2, LPC_HICR2_IBFIE3,
+					   enable * LPC_HICR2_IBFIE3);
 			return;
 		case 4:
-			regmap_update_bits(priv->map, LPC_HICRB, LPC_HICRB_IBFIF4,
-					   enable * LPC_HICRB_IBFIF4);
+			regmap_update_bits(priv->map, LPC_HICRB, LPC_HICRB_IBFIE4,
+					   enable * LPC_HICRB_IBFIE4);
 			return;
 		default:
 			pr_warn("%s: Unsupported channel: %d", __func__, kcs_bmc->channel);
-- 
2.27.0

