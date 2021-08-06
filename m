Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA9A3E26E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244270AbhHFJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:12:16 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37005 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244197AbhHFJMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:12:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EE8005C00D5;
        Fri,  6 Aug 2021 05:11:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 06 Aug 2021 05:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Vy2JXd+xDZiD5
        L7+tWVvVGFaD+OJoxcOJYpYwczbUeE=; b=i3v0ODp6vHtWQFoNuIRNXd9S2VsxU
        M8rRDo5WfsdZZOWXbP/qR2EPvS3qlBZaS6JVAjjmXm1jDH/Bqp5wwASXCpoHQOCw
        pzw2g1DANzPxbi2eWH4SUmcTUq7V5+olwQSGjBsUj05XnF9Z6ypThkRHIqBYPFv7
        BfX2L5ovv3aCsftDqhhVd0K36y8LvjpX2J3lU7H9BO3f7Jhqgpob9X1HGOMACCX7
        +CNVPKFILE8fAoG9gWmd6W9ziDTWVo2VZdo33BXR/EkYOzwyMzRJ28/ACkJ1KZNX
        oq8pVpIdiOrZPQZDAZ4DQWmdy0l6ECgmSa1OBebDZzKdHALVAmiZEMgww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Vy2JXd+xDZiD5L7+tWVvVGFaD+OJoxcOJYpYwczbUeE=; b=ULJQRPVs
        hZsh9TV4Gz4mCb69tt4yhD7O5vHKdc1NZ+F3JQMjcBA09e1mZKZzWTcaifdliP+C
        u4C1sPtHkF8rvmcQc1IgQhmn5L/4aj2uvvjvUZqUn5owTNgsLt2vNMGljeZ3uHdw
        pdHTr9wZoZksOAkv22K0JAHK5x3tKzS9pBoe5x2u11MesXTolY9M5Gh8XTWvgvwp
        rrNkEr5d2uyiWhhSavemFMlhqL8lgt6fYA3QnIsbu2bKo8erGWepHRWFzTUbtRaU
        pdtqZQ3T7VSFjVbhLe9gGFu5XuDYnB2rAtcRuxnzGdor9jhL9Y9YzkJpFsz8hSyD
        MOdXthO32uhevQ==
X-ME-Sender: <xms:1vwMYQTkAvW_7KxKqnotStM1W5gmLVjS875kYOGQ0WFFXM4dnk82fw>
    <xme:1vwMYdzJvN6kl23_di1owm9yKx2juJaCmnASpngfPE4chand0urAJt6b5fbsUdXHo
    6ISCmpR0nlf-dCmsYk>
X-ME-Received: <xmr:1vwMYd3y7Uk5lObRLOz3UJVKtcUTvE_DU7UE8zlGqnZe_3F6_7gDhIx4kk3vkI1HoefiHQyyj9Oq_skQxwtfmLmI_SyDTfgDp9x1TDOJ6QJbNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:1vwMYUBiIhE6t5s4-LBlK-S6LTPATS9IoNVcnkmcL4ThemHu9TyHVA>
    <xmx:1vwMYZgZLX9jRakj0eEKhC4N2uxdifcyVYRlOEUy03mtr6393oKEAg>
    <xmx:1vwMYQoSOZT8DEASnG03jFkYPABWgWZKzsZNHVxYDh9LzblNNaoXdw>
    <xmx:1vwMYRiDnPEw9jS8blFS2neytl_PG6bAxH4-uo6Vu5U7AFMaH9Trhw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:46 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 09/12] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Fri,  6 Aug 2021 19:10:55 +1000
Message-Id: <20210806091058.141-10-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806091058.141-1-alistair@alistair23.me>
References: <20210806091058.141-1-alistair@alistair23.me>
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

