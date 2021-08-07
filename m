Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41CE3E34EF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhHGKkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:40:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:32951 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232194AbhHGKkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:43 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 988645C00F3;
        Sat,  7 Aug 2021 06:40:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 07 Aug 2021 06:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Vy2JXd+xDZiD5
        L7+tWVvVGFaD+OJoxcOJYpYwczbUeE=; b=Aihi0esMeWrCMYTNbOH/Kj35WYYAW
        qmxri44EV4O7GXWVTkPHWWtI/Jx9nUl6tYY6thuQR6qvkrhTUHFP5KQMag4o7bSv
        1gC7fG7Fjeg3BmwFngwxWfYCA2Uqi0ctbCWgdmA+hM1lR2yt1OAk00NiiabGELou
        Es/e1ZpZLT3jcMvXKwB34vu7aWTOdSVf/q7zK8SaEwGpp72+PRpu97hdB4VhZZ/f
        /UU1Pz1HIB0oYRH56sFx4RQ10RAlc7FukWOFi4DoRn2dsTPqjrW4NW5zaKDJkmwL
        /OTeX5l/c9c/Sh5E8kmfB1sBNJFV3GY7OtAJvDEt6GQOw97wO98/r52bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Vy2JXd+xDZiD5L7+tWVvVGFaD+OJoxcOJYpYwczbUeE=; b=R5n5brG4
        6itbHImP2MzW4Q9dRJU4BsFz/LkM5xBCV2asry8am3QgRq7NBKehOj78YxHolZHD
        N7AO6LNnP/Jqt1xspJ3H2kGDCls5Q1C7nbL9C9VHJ233IqMI/t+fw9PnkMJ9GDMr
        L/pfFKltUimM2glo2pEX5pgyJXKCADFIDFlbxd5m88PS2PN7L/RxO2G4d50Gm0UR
        muDRdwmRupihZSuIR8DzW9N2eiWN6K4VGm9AFiJKCIYzLHdtn2gZHIHN7RB3V8Gf
        W/POwusweS4SrQukrRZ54oIpZOF8tdAih5FC8XPThNQ7sqaEGJnXD9J/bGFvxxl6
        CsowHs/H4Mz85g==
X-ME-Sender: <xms:GmMOYS1vWiavRIvdBquMY9luezLpY-0OM0yPi592pBnmYHF7NrE3cg>
    <xme:GmMOYVHg1V-04p9sAqsfaAV0xuAnGWQX_CABVox6cDKpqXZptNa_RV62XmKDlxzKZ
    IRuXf42gbT2-B3bZXE>
X-ME-Received: <xmr:GmMOYa6gpfXpUNEpUEy_077HmmCCaFbCZDvGNNOqLHOpF7d-T8E-ynCrZCL6y4-Tmv-N9JSc4Rn0S1wR2PuCZkI3VwY1XH03Doc-If8XHXCkfJX5yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:GmMOYT0qLa-_OTrThOLjKVttrWtg75K9eO4677FXMTc2ppdPHGntKA>
    <xmx:GmMOYVGOrTwncAr0MwA2yEcI-MnwAPQavhe5Vr9g_fZiMddqqMbnkg>
    <xmx:GmMOYc_6VLX_R1BXZcQ_u9HhWX5BrLOKS-IBOudMHXPPUYK8pKq9fw>
    <xmx:GmMOYc0gLPg6LNZXGOzYjAO35Ml3iRuBteyALXIOcmfEBl8Vbf3_aw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:40:23 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 08/11] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Sat,  7 Aug 2021 20:39:37 +1000
Message-Id: <20210807103940.152-9-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807103940.152-1-alistair@alistair23.me>
References: <20210807103940.152-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator for the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index ef8c6dca1277..0ac7c61c6f3d 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -234,6 +234,7 @@ CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
+CONFIG_SY7636A_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_DA9062_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=m
@@ -249,6 +250,7 @@ CONFIG_MFD_RN5T618=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_MFD_SIMPLE_MFD_I2C=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
 CONFIG_REGULATOR_DA9062=y
@@ -258,6 +260,7 @@ CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
-- 
2.31.1

