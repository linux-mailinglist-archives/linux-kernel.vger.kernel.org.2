Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0C3F17D9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhHSLQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:16:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58375 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238682AbhHSLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:16:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AC29A5C00C9;
        Thu, 19 Aug 2021 07:16:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 19 Aug 2021 07:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Vy2JXd+xDZiD5
        L7+tWVvVGFaD+OJoxcOJYpYwczbUeE=; b=MaDsLR0Ci3uKSAmXJWh3K8391O73B
        lfedFZm0vvlwhHCm1y0egq2Cota/MBOzOjjXCofq67avC0XoZN3NtbD9CRlpOHEZ
        V735Csxt5srKbu/AgATsNuJUeeScN25ZWuVc+kPAGpzXYotEsQjlxQgSxRxYl0wS
        ggNT/lsuyYQLox7nVKa4/idB0joh6oCq37X1RX7LKbEYgXd30IowI1N//ulpI26w
        1WCklQTLyhYOX1wpeiHo6Q7q/6NpTSlsxu6n+A9AIxSaR0T8vbi9Qcm1zhIiqkzu
        H7xKlpOkTZyFKLiw/qfAscGv+8uySWlbOkCdnk9XPnaspZ8fR7JFR8EDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Vy2JXd+xDZiD5L7+tWVvVGFaD+OJoxcOJYpYwczbUeE=; b=fwsajerR
        vgoCIOh42lsMNP/SWWXezKwFnbH7+PdhtW1kA5u9GlyK9yaC1KoyvlEPziukKHbG
        Bk8yCewKfNMXz2a/SbfB0D69OUBd5vFRVER757RgP45M7ozhcfjdV8xW3DcPRNZZ
        1Ycpa8+5sjCyJmMYmlN7bcJLXjPfHGRSLueBQyFM56PnMPyTiRoyGThq5BsDa0JL
        hjflz3ZZubakvTf0HeVbMuXk0xywi1eucN9QwWZTKt0oOD+y1zwyog+BhjS+zAFh
        o4+xEtqWzhcmfyeHotY4fS8o3qrrEFoLdfk2IpIVf34ZbLpHwHi063NAsvyCKo28
        41sEx3MzLNdH6g==
X-ME-Sender: <xms:gD0eYUsv5KlbL8qva1ZiaFbHmD6hES4M0_z54HOcAYtPHkjLjkfc0w>
    <xme:gD0eYRehv0Myys11xen1iL98SEeW10HCmSe06uoAtTnqx914OjZX8QOU3yL_pKePu
    EQRXK7-krGM2VcwW0Q>
X-ME-Received: <xmr:gD0eYfyY5m3rErG82kdH46pOkCaINXXT0UnGyRu0o52eX7WBXvAHPIxQ09-13D3BaGWvOuNNgPN23EIYVFNUleqMsTsTZhNxdtCBSVvp33KODlxJFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:gD0eYXP31M35icrCUlEw3soSAkhXtgvEVUmtXZANg8KLJ-KY_HfH6Q>
    <xmx:gD0eYU9yRg5Zlp9JSAUWfWwajyEkeE515YWWtxZ1NiPAgie149D4Gg>
    <xmx:gD0eYfVBbMKvlmP7V8zle6LnkAcgK10hexx0Mua7tANYkOAOOfDZFw>
    <xmx:gD0eYROfv0N16D1nmAM1pwGMCx1tHhnqUz4e3mYMT349d_ilkNpb7w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 07:16:12 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v11 07/10] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Thu, 19 Aug 2021 01:44:46 +1000
Message-Id: <20210818154449.1037-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818154449.1037-1-alistair@alistair23.me>
References: <20210818154449.1037-1-alistair@alistair23.me>
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

