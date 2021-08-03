Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE13DE8B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhHCIqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:46:34 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36061 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234772AbhHCIqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:46:31 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 68B045C0136;
        Tue,  3 Aug 2021 04:46:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 03 Aug 2021 04:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=nnLyJr1jVNjIS
        rRwGMrDdP0YEcBhH9NqAHAPaaeF24w=; b=NbI7o4wQ+Ta5qfOu1ilSJfy7MjzZx
        lWmP1Hm/fIMwIGfOBd9lxxROTwtvggepeW9GVEFyQFBI7HK7bpgfNYoYFz4jpMmz
        JP4gJMgeaWfAOgxZk6bBaWIhoHaEXTX2GUwXm4JP/K0BdcLP4wTwvByEVEsHT89M
        pyoai7MeOm/6f0NxoDJX93SmEDTzy2iDHxg3sAcwvboQX8GfecWc5bTBVpr1t639
        VbHsA7dbsqpuzsxLQ+DwY7/EMC4qQIHwgRhgCsj3YKTqjPbhMjQQVfP1RUKwZ3Qw
        s2Njelnmn0YtLaxoqHarXmp7HS2kQwlfsBHn2sygzHG7ZndRpxaIPaM1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=nnLyJr1jVNjISrRwGMrDdP0YEcBhH9NqAHAPaaeF24w=; b=ktUsVG05
        AglmhfG8TGjDXJgcJ+07weLC031A0IOPd7fVOTutn8U1hkaXrGVVBg3VCRmalCy8
        /CFm8WySya067wQavdnsn3MmbddBlCkHElTjXWtbdOSrzeMiZUw1oQA9nRrFWv63
        /SdXS/D6pJ9ECZUVoY3YU9ttwXHauvSWFACVCVcuarRkgTNvPl3XcsPZAtDlDAd1
        Jbfl+UEzP8N6xJEMPWWYNU/66U5ajpXsEunu6Uy0PxVO1BTVtESYUbafNrjIDCJU
        7OW8I9zwCjur8iIEtdJM3sniz+aoYmw0VdDDv6pSyClSFtpcYyNvGKVK/xlardB+
        NVzFlFkSqAtAYg==
X-ME-Sender: <xms:XAIJYZZtlU1f81_8htiTx-cYLg_zH7JSTHioMreVtw3iB9hpfmFDxw>
    <xme:XAIJYQaJUqsWTXmAup74sktiUGUsfhT0yU7Ss0urxwtUEtFPSoxbfsYLzpU7wTrl5
    JOtpBZsl2mmU2jvcR8>
X-ME-Received: <xmr:XAIJYb8TKJafI_ECd-D3JM_3fpazNK9Ji9WLHJnYlEuHreFxB_1AJ8sXpG51AIJuzo0QvacSrD7hfofIboh9uOivyEogBElti3H7YMd6ZU_5tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:XAIJYXpuxQvRBIpsQAzxHPA2CldvQ-IoIJd0oe4pnxqBEtk3Rz_JYQ>
    <xmx:XAIJYUpqDUV2j5Ois7s3h3-ryv_6fCghXAPIHl5d35a0-I7Zwopy1A>
    <xmx:XAIJYdRZUx0nuVKosmxMNDl0UoZ9tFhYP8vjaaTtdsiTziSMpKWMrg>
    <xmx:XAIJYcJgKG4Uxeot7xY-rEFZou78nhtMWNs9ZlOJ6M4BPW9z7XrxEg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:46:16 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 08/11] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Tue,  3 Aug 2021 18:44:55 +1000
Message-Id: <20210803084456.198-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803084456.198-1-alistair@alistair23.me>
References: <20210803084456.198-1-alistair@alistair23.me>
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
index ef8c6dca1277..ff3eddb62c1d 100644
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
@@ -248,6 +249,7 @@ CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_RN5T618=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
+CONFIG_MFD_SY7636A=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
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

