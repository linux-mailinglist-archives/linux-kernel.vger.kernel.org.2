Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BB23BF975
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhGHMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:01:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55689 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231643AbhGHMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:01:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 03B4F5C0151;
        Thu,  8 Jul 2021 07:58:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Jul 2021 07:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=FeYnB8+oBtTka
        GPF8xMqWbEUGfRQf6hvPi98R+6Qq1g=; b=ehbG/GeUggaFzzDE1HMDaWLZ5BliU
        kFhLqL0uEChrfcDfGB2/hb8NcrphIg0G3JcabLmodLFE+7cCemDWCGRvnGCtsffT
        rQ75Gtj+w2VK5zY7oTSUWefucnFDZlNZro1IhQEHnbbaGjgmY2iORCyeEeXcUa6r
        GxlevaYPEETDpmacGny4Is4u3L3eWrCX37aZQLa/QgC2D7oRH5JsJuo/TXcODbwf
        GJ1tUYMxzJD7UKx7hjparIfJbD+jltln9B/F/14cx40OOF7UfktEVpWgUMz4/77y
        Q14c98kQjrxLfewQ4g8s/ewnUnZUm+/EvHrKtv6Od9vFvK8aIJaQ1dSjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=FeYnB8+oBtTkaGPF8xMqWbEUGfRQf6hvPi98R+6Qq1g=; b=iivTKSWI
        sc+DXTTHuv33JXzZHfGjS1ByM32D/frv7xF9QxC8fdqt4RDSiDJ5lH2SuqmJv66H
        qmIGkzwGdCGQjwbkUbwkTNp4IjWhzPUHImDUIHhjL3WJY959rDthvoQObs/VKwR6
        374nr4bcrm/ECjhNpAXWlLiokhpVkXKOGiYzpfFw8Kv6XgSVQkE5RPzxyR1Rz03O
        R6JO8qLsK7zeX5C9lc4ej4pxnRyuOiiYL4gzl3T+t+yuilJGo5wTdzsd6QkbBWyy
        gfiwJY0Xas1NBbekYzlRc9nfsOrSsHWILZW/Ovoe1lJDFsgW0n7g1F6t5zzDNwQK
        ChuphchckYMjgQ==
X-ME-Sender: <xms:ZejmYNkpr4z__cDdrIrW5MzRwyMizdZgMZ4kvo2qqYO6IsQnP2OZNA>
    <xme:ZejmYI3jL1BU13wkFELSzsWDYme0akcz9x-ybAU1eutNw1vlQl93NhCtknPIRPMKc
    rTr_5EvSbkGt_aTHk8>
X-ME-Received: <xmr:ZejmYDrpMC6jR_Z-7Ff5zfRwFC46itHi93pNOcYaTh1uaSjmaZNwZHAHWElvvNTNdMUJlQpTrJJ_2DNZEQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtdeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:ZejmYNnVuC5f3-KUdWqe67Oi-FRSOEUsNCD4IbMwuXCGMHBj_ifj8w>
    <xmx:ZejmYL3HI4O0kaPPVfiFXliAa3Fp66bNIwjHyW3WSJ6EVvRqP-5TyQ>
    <xmx:ZejmYMt10oQFzyAy5rw4B2j5dV5wf9z0Cau4vClYZAe55cprdR-0Sg>
    <xmx:ZujmYAlrParKiIN2l0ic9UnoJnETz1WCgbYl3u3G2qKieCRFJE_JjA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jul 2021 07:58:26 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v7 4/6] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Thu,  8 Jul 2021 21:58:02 +1000
Message-Id: <20210708115804.212-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210708115804.212-1-alistair@alistair23.me>
References: <20210708115804.212-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator for the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e9c0be5629c6..51b04d71777f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -232,6 +232,7 @@ CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
+CONFIG_SY7636A_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_DA9062_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=m
@@ -245,7 +246,7 @@ CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_RN5T618=y
 CONFIG_MFD_STMPE=y
-CONFIG_REGULATOR=y
+CONFIG_MFD_SY7636A=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
@@ -256,6 +257,7 @@ CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
-- 
2.31.1

