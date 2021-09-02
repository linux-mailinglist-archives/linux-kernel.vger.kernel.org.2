Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172753FF78E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbhIBXDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:03:10 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:39251 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232013AbhIBXDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:03:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BB964320094B;
        Thu,  2 Sep 2021 19:02:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 02 Sep 2021 19:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=dMOJsy0kcae44XC/LGRiBL+H+K
        kmGvDivPUnj3WmBgw=; b=dvPutcBJY4eJd8M7UK+vpFfytx5TbRf1kpv3ThMjf6
        xoOsmnpUc3kFC2zMKU1g+i2hg5Qp1yl391esO5/sMl4H44Gl29MgyiyOL3/8t0BN
        vabFn7u1YjZOpa4P6+0xAkNVON4hiYAdnq/VhH3cUcG0XSzxzCR1HvqZlaY/g34q
        MKVof879q1XCO3dOO3mh19y7noDvDN7Sl0FgV4P0OCltQbyWLUEuzHsaTN3uh7aL
        Me8ZE8IFh9vqjmzwqv+u20SwdSBmzBov6YNr4pMwJmFW/5iQo9goxR70rOhqAXsk
        E3dlDKoysZZonZF6T96I3lF3mmlSUtTk/8brxIxpxHSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dMOJsy0kcae44XC/L
        GRiBL+H+KkmGvDivPUnj3WmBgw=; b=vgK59s62AuIfb0qx6Gwm/dhLmOprhmhyP
        YK9Dwmeq/g/LAUn+55AK5JieQyY8feGffRareN7YvBz/pC8/KNDWBlmWW9nbqugL
        g2f/DdIjWlfDXR7e6CB8iLlcx8gQiFq0PwNTBxVusldY8bZsPdg3eVq86mPqh8J5
        C4U3+EaKy/r+z4VoOwAv3Wqx/RkIq39zP+RIbBa04fBmcnj/XjsbMa8MB21pR6MM
        j2dOdJGNbU5kUhJGCg5NAr1OL4iniEVF6o51lLNwF4owkLYQo+PRfvp5VNadck0M
        3dAidDImdzGtNtMxD4cEYab3MjOvVvCyBnbfJMrhb435dmRtwresw==
X-ME-Sender: <xms:6VcxYblyDtqaj5ANTOsBaXh3fNxpIb-EtqVRR8xv3AkakgX3Lrb2JA>
    <xme:6VcxYe0qu0uf7Q6gxaYt33eNMDx-61CZJLxrQOQvbE7MOYwJlri5DugykBXF8Xs6-
    B4DG3Kphsb0SQkUdA>
X-ME-Received: <xmr:6VcxYRqNHne3-sRjrAFXzvN9h35uWJZN6y2hvFQNgjKzEsEWU9gXL2HXr7WYhfOAojTttC4eevHsZOMIkbY-6LAmeCT3Wx4UvdUnqpM4BZgNj4JTxU1C0D3sXTv8sSe2CLcPrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddviedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6VcxYTncog_H_QsHoc2nziLWQLL0Ob0mcDIlr4rqlAXL25kRpXnJPw>
    <xmx:6VcxYZ2-Aqns-46q8DEvu3GUIaqbl0Af-xKmMFk-e7JqKfFg0Pc_ig>
    <xmx:6VcxYSvTDs2EL3OtU6a01iHGytsDA1M5i7u7xiRk8UzeacypjW44sA>
    <xmx:6lcxYSLwUmNNfU8H-FuRMgQU_JzjNbxtt6yFHgIJ_O8VPSvihdSrgQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Sep 2021 19:02:01 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH] clk: sunxi-ng: Add machine dependency to A83T CCU
Date:   Thu,  2 Sep 2021 18:02:00 -0500
Message-Id: <20210902230200.29574-1-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CCUs for all other 32-bit SoCs have a dependency on a specific
MACH_SUNxI symbol. This effectively hides these drivers when building
an ARCH=arm64 kernel. However, the A83T CCU still shows up because it
is missing this dependency. Let's add it for consistency.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index cd46d8853876..e76e1676f0f0 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -71,6 +71,7 @@ config SUN8I_A33_CCU
 config SUN8I_A83T_CCU
 	bool "Support for the Allwinner A83T CCU"
 	default MACH_SUN8I
+	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_H3_CCU
 	bool "Support for the Allwinner H3 CCU"
-- 
2.31.1

