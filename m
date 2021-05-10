Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF49377BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 07:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEJFo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 01:44:29 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37859 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230133AbhEJFo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 01:44:27 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0522D5804C8;
        Mon, 10 May 2021 01:43:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 10 May 2021 01:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2oYWU/9OjPkLQ
        kQfeH4LDKNvXAEFhmY5/iusfzNu4d8=; b=lsYMSosfFphbDwbgqJJP2ppfXRwFY
        1238abm2R1wp5Inp0sU7TetlW1RIGoxamPJysn39+m9nj0uM0RekhIBwpJdfuaGP
        fGFrSHMX4ndINANMz5y1uIido+3LfgvLwQEeXiWaRPwwUdyouFxb7rnwtkvLfAU3
        g7YKdmQeBYawDA+iqvafNSX3B+lx8oTo+NNWXMTklgrRMX4RjBsojJzVPAkL6KC7
        q1iM1mqmtb4nJFF+iCCeMzO94WWz8LkLf6Nzbf1SUlmFqOFTDrZBQDZt/H/FcUDL
        iuiOctHk0sL9LiNq6m1Hc4DCzCNSEHiPdz49Y5zofSpnABW06pSCQ70mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=2oYWU/9OjPkLQkQfeH4LDKNvXAEFhmY5/iusfzNu4d8=; b=dIANDsRT
        KVlRdtLfnQP8Gj2uMHIrM9TRbEbmL/I0M+YBXpkOk+kZwX7q/Qk+eUceffr+UDLd
        sEkrZTDKLM7BjZouJUj3eDEjTjo0DAaX0y2yS21CUPvNZoP7ZD96tNoS16gITETA
        KgQydTF9q2czYLVbLKjRB0vNHvxYaIvXi1Jcf3sMUAX/q70yiprdbKkuoDj+pM2X
        5aje9Y+k03IDFqqXw9ZAqtf19lbrCkJ9VlEDgrA7OkfZa4SKKE0anPXAqT+dKXdX
        U+YtOPmrPReln3f6jFa9HEerOqGoWgBLuN6gB3L4W9XEaCt/mQl7JRAJYStc+zJ2
        lbNmWkmgqqRmqA==
X-ME-Sender: <xms:-seYYHpO8vhvFlSmedDsioxEnZRW5j6PNiYdZZJw5vkbjLIB33JVyw>
    <xme:-seYYBoiGx5m9TX92MUuwUbxgIs2skYDuPoCb5dQJcsmzvA8i8TtWinh4qGNCF0TQ
    MK4N6jisN3yqSm2zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegjedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvdduhedrkeen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:-seYYEM5iSVpThWEVBHlNrEkQVSiKgBB9niHXTbd0-n_S2mTnYoDow>
    <xmx:-seYYK7_hm0UyR15vqLx_1FWcsUJZd79DHjaHH4l2ZJKOMKcS943Sg>
    <xmx:-seYYG713MAOkhkiczCOyCKGmLux_ahwmoRCaoEGVcxK6R7qcgqD8g>
    <xmx:-8eYYJILPj-ChkBRm1OFFf6eYMapEYxpfDq_w165BO-WmlLnjQH10Q>
Received: from localhost.localdomain (unknown [203.57.215.8])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 10 May 2021 01:43:16 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net, openbmc@lists.ozlabs.org,
        minyard@acm.org
Cc:     devicetree@vger.kernel.org, tmaimon77@gmail.com,
        linux-aspeed@lists.ozlabs.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        tali.perry1@gmail.com, robh+dt@kernel.org,
        chiawei_wang@aspeedtech.com, linux-arm-kernel@lists.infradead.org,
        benjaminfair@google.com, arnd@arndb.de, zweiss@equinix.com
Subject: [PATCH v3 02/16] ipmi: kcs_bmc: Make status update atomic
Date:   Mon, 10 May 2021 15:11:59 +0930
Message-Id: <20210510054213.1610760-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210510054213.1610760-1-andrew@aj.id.au>
References: <20210510054213.1610760-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable more efficient implementation of read-modify-write sequences.
Both device drivers for the KCS BMC stack use regmaps. The new callback
allows us to exploit regmap_update_bits().

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Zev Weiss <zweiss@equinix.com>
---
 drivers/char/ipmi/kcs_bmc.c         |  7 +------
 drivers/char/ipmi/kcs_bmc.h         |  1 +
 drivers/char/ipmi/kcs_bmc_aspeed.c  |  9 +++++++++
 drivers/char/ipmi/kcs_bmc_npcm7xx.c | 10 ++++++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index f292e74bd4a5..58fb1a7bd50d 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -67,12 +67,7 @@ static inline void write_status(struct kcs_bmc *kcs_bmc, u8 data)
 
 static void update_status_bits(struct kcs_bmc *kcs_bmc, u8 mask, u8 val)
 {
-	u8 tmp = read_status(kcs_bmc);
-
-	tmp &= ~mask;
-	tmp |= val & mask;
-
-	write_status(kcs_bmc, tmp);
+	kcs_bmc->io_updateb(kcs_bmc, kcs_bmc->ioreg.str, mask, val);
 }
 
 static inline void set_state(struct kcs_bmc *kcs_bmc, u8 state)
diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
index eb9ea4ce78b8..970f53892f2d 100644
--- a/drivers/char/ipmi/kcs_bmc.h
+++ b/drivers/char/ipmi/kcs_bmc.h
@@ -76,6 +76,7 @@ struct kcs_bmc {
 	struct kcs_ioreg ioreg;
 	u8 (*io_inputb)(struct kcs_bmc *kcs_bmc, u32 reg);
 	void (*io_outputb)(struct kcs_bmc *kcs_bmc, u32 reg, u8 b);
+	void (*io_updateb)(struct kcs_bmc *kcs_bmc, u32 reg, u8 mask, u8 val);
 
 	enum kcs_phases phase;
 	enum kcs_errors error;
diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index c94d36e195be..06628ca69750 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -90,6 +90,14 @@ static void aspeed_kcs_outb(struct kcs_bmc *kcs_bmc, u32 reg, u8 data)
 	WARN(rc != 0, "regmap_write() failed: %d\n", rc);
 }
 
+static void aspeed_kcs_updateb(struct kcs_bmc *kcs_bmc, u32 reg, u8 mask, u8 val)
+{
+	struct aspeed_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
+	int rc;
+
+	rc = regmap_update_bits(priv->map, reg, mask, val);
+	WARN(rc != 0, "regmap_update_bits() failed: %d\n", rc);
+}
 
 /*
  * AST_usrGuide_KCS.pdf
@@ -343,6 +351,7 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	kcs_bmc->ioreg = ast_kcs_bmc_ioregs[channel - 1];
 	kcs_bmc->io_inputb = aspeed_kcs_inb;
 	kcs_bmc->io_outputb = aspeed_kcs_outb;
+	kcs_bmc->io_updateb = aspeed_kcs_updateb;
 
 	addr = ops->get_io_address(pdev);
 	if (addr < 0)
diff --git a/drivers/char/ipmi/kcs_bmc_npcm7xx.c b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
index 722f7391fe1f..1f44aadec9e8 100644
--- a/drivers/char/ipmi/kcs_bmc_npcm7xx.c
+++ b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
@@ -97,6 +97,15 @@ static void npcm7xx_kcs_outb(struct kcs_bmc *kcs_bmc, u32 reg, u8 data)
 	WARN(rc != 0, "regmap_write() failed: %d\n", rc);
 }
 
+static void npcm7xx_kcs_updateb(struct kcs_bmc *kcs_bmc, u32 reg, u8 mask, u8 data)
+{
+	struct npcm7xx_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
+	int rc;
+
+	rc = regmap_update_bits(priv->map, reg, mask, data);
+	WARN(rc != 0, "regmap_update_bits() failed: %d\n", rc);
+}
+
 static void npcm7xx_kcs_enable_channel(struct kcs_bmc *kcs_bmc, bool enable)
 {
 	struct npcm7xx_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
@@ -163,6 +172,7 @@ static int npcm7xx_kcs_probe(struct platform_device *pdev)
 	kcs_bmc->ioreg.str = priv->reg->sts;
 	kcs_bmc->io_inputb = npcm7xx_kcs_inb;
 	kcs_bmc->io_outputb = npcm7xx_kcs_outb;
+	kcs_bmc->io_updateb = npcm7xx_kcs_updateb;
 
 	dev_set_drvdata(dev, kcs_bmc);
 
-- 
2.27.0

