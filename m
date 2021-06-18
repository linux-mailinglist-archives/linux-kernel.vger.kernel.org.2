Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175533AC30C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhFRGFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:05:30 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41697 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232250AbhFRGF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:05:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F2BB5C0138;
        Fri, 18 Jun 2021 02:03:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 18 Jun 2021 02:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=rFN1Isa+gtwR+R9fDmDDjGykid
        10VpuGsivirIWLYTc=; b=gHnChd0AppeS/zLSfPThfZJ8XJ3JOHpVGyw76G9LgZ
        zX7DQiFiFVR+iRxruvwLMNIu7BcaBai1LwdSz2v9JD5GQAIJ2iK+dPGKcdo+sb/D
        7cNRZPRIRFuKFsTwtk8bLNvL+9/2EvprhyTS81vQL2CwRV9PfkOu6Q8Whd/tH4A3
        ivf70XYcK+QD2EryLoeHIqnaPhzxCKeJBsEYCtqK5Jy59ubt4SfBSmtVV/aiWrZV
        qF9806UiM1yINbvT5xTJ6x6ZJR1uD9Lsf0ZQcUhTb9FnGvyxERA3CrBmhnLsDxLw
        FH4IDBBjcgvMPVqGNNz5r7Y1eM5YYb5s2L2kLfcjfxCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rFN1Isa+gtwR+R9fD
        mDDjGykid10VpuGsivirIWLYTc=; b=JtppSal1I0GnycNhJdo/PhzOn8h6ZFFBD
        nLhZjKw1UqWNdhA5idN4L/11bOsJ0+2PiU0NQ74XISYwoSC0cJblfxK85O+C7xSc
        ABryj8L28vRjI7Ytx2dKqdtUzikxn9/nJ1+Pg4L377oKx7Pr8wE1FVG+a7G0VaST
        JdqIK6y3eJsWCcKxSlh+52aem+MPDcQ1wlExAQQHs9yQrGPetLjv/4zW4InATC4W
        AfzBpAWuuUBoRatFo6EHf7JSgXSoYxZu6/EP3aUV5kC5SWvvAIDW0hqTSt2TLCus
        hTzmpljlXHMjTNPwN4Wp/NMC+iEIaKmJe9z6tFGWYSgKhuWXOo5BQ==
X-ME-Sender: <xms:JjfMYIp4o58s19lHc2EQRVdNN2OdW6XKqdJZUQkjjlcP8Ca89bekPg>
    <xme:JjfMYOpqFOo8AvIwK9pTSZEQbE9ZN8aN1ki8r4zA5H0Spoc3IvT9k4dcQKfdXvHIx
    yU9ibDyAZ6b9nk1SA>
X-ME-Received: <xmr:JjfMYNMZ2HUbGkVUb5lYmyKKGbUxWBkxLYBlRahSMkkLElo-UiTXhR6wu4rxxMgMIKvCZpVEFJMJS_UHqLibAeOB9_CE1hYbPDXrtsnMtKvtwgaTw5h_3_CR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuggftrfgrthhtvghrnhepkefhieffjeevfeevhedtieeihfefvdejle
    dvvddthefftedujeethfeuueelfedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:JjfMYP78nWFeeCR1CwsUxcE5UeRLRdVpgaUP-Yof5kYo5mTZQOaB2g>
    <xmx:JjfMYH6w_DtttQp7toWUqC4FzzbN323B46-uCLPDMu792YREYNy9Lg>
    <xmx:JjfMYPj1NgpwO5wx15u8FZv4DbpUxAPZe4iR7oEifJ6WLbY3kAQrvg>
    <xmx:JzfMYK3Qgsnsdc5-eSNAQo24c5QBg4DOZnDzq_Zk__c_ywESKiybuw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jun 2021 02:03:15 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     joel@jms.id.au
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rainier: Enable KCS channels 2 and 3
Date:   Fri, 18 Jun 2021 15:33:05 +0930
Message-Id: <20210618060305.4031224-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCS 2 and 3 are used as out-of-band signalling channels between the host
and the BMC on the Rainier platform.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 941c0489479a..38aad878d482 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -1780,3 +1780,14 @@ &xdma {
 	status = "okay";
 	memory-region = <&vga_memory>;
 };
+
+&kcs2 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca8 0xcac>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
-- 
2.30.2

