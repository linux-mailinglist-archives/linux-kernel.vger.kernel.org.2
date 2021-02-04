Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807A330EE31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhBDIQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:16:43 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36773 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234842AbhBDIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:16:35 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2EB99580273;
        Thu,  4 Feb 2021 03:15:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 04 Feb 2021 03:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=HrmXQQqeqXCC3
        OhqkeMC8DjT3eJi2jBIa1F0dcFrb3g=; b=T9Vb+e19D1IbopQhz4VVcnLKvwTqa
        kRDSV0poUCP0pmCCO6CkxdsylZq9BU6Z6DDE2mvaUIM7DezbrSQYOTy1ihqnlwR/
        4HPP2Dt7/EtLBCsWMo2vg30ug1x/WP8xhvMQTaAE8kABgIE7zCAP26+Frxvi+LO4
        Sm4CRj6Ilz78khTxZOygSJ0VF+LG8s1GXnl91EtfX0ivucZkiUUUlTGFAGHjjFwF
        /syEAeuOTtxuBX2AHkioomCeQe01Ma/OZqQ7CHCkeYiOQdb9cMFZ9cr/9hInUXTE
        6aLf3VlQSqUhKFgf4Hr7tYn8o8VYHbNx9MOUZXYSZLKJ5lQlEgJdCZqcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=HrmXQQqeqXCC3OhqkeMC8DjT3eJi2jBIa1F0dcFrb3g=; b=FJyBgcfu
        8xoL+P5Ft2AhcqpelgbKK6a4drG/9ZCA+rgzrWCupycdPYMFQX4Hd4vg+/PbrzUq
        nr0UsemGLNUrLiQxdFmhy45k0+bLGEDkOCb6Pzbpmqu5lsNRa2GFDOAhXTzTpexr
        mnL0eNqKv6kmZWkEjD/8i5mEp1gNi/VgchCtLyrnhSU+aEl/Q6ZvU2v3poaLBp9x
        nkxvGIdhsduQB4JYdbIlvfeWjpGwU1MLS2AUjB8WsfGqsQJc/0AU5no8zjjIh4xd
        TvZU4RrIaWOnD941i/GMW+Jk75LQDfvYBre5EzZr4GPbGWSUcrhZX6cE3RcXBl4A
        LNNhnSv3I3ZcCw==
X-ME-Sender: <xms:Lq0bYDrqu-u2SHFsKb8rD8aAqYqzQlMKTaugnUTw07u_WkMKYeGnkw>
    <xme:Lq0bYNry4LSVC6gbouNBaZh-qdmFiVcoZU8GNbpbk1Y7OyQByF_OTaSvQLdM-dIk6
    4FUzAf-KockPogf9sM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeefgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucfkphepjeefrdel
    fedrkeegrddvtdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:Lq0bYAObTwIH_1OwyYDJq1zvc3aQqC7NAEwGrY0LwvVvjWBw240L8g>
    <xmx:Lq0bYG4e0UZIe37yksWEtU4Sv8jVUGwCueH_PE83bXrtuCU-PET6OQ>
    <xmx:Lq0bYC6NDLZJFcbeVocdkeli-EKl9o93tCt_TgbnZG2izWEE1IF2Vw>
    <xmx:Lq0bYLG2QsRfqw5RrXEFtntckKgYljLNCbxbsaCX7c_fTOhq_cRn1Q>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id A3A571080063;
        Thu,  4 Feb 2021 03:15:40 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 2/3] ARM: dts: imx7d: remarkable2: Enable the power button
Date:   Wed,  3 Feb 2021 19:03:15 -0800
Message-Id: <20210204030316.489-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210204030316.489-1-alistair@alistair23.me>
References: <20210204030316.489-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 0aae13f5eed6..0978e26f5db5 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -62,6 +62,10 @@ &sdma {
 	status = "okay";
 };
 
+&snvs_pwrkey {
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
2.30.0

