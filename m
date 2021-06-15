Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC5B3A7C10
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhFOKgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:36:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42581 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231768AbhFOKgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:36:40 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C6C25C0116;
        Tue, 15 Jun 2021 06:34:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 15 Jun 2021 06:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=d8z0gS8HZr/N5
        ++6diSc7wdo4fZw0ZGyLBL09kv+EHg=; b=lqQ89Le6W7MKQV4LA02NuDeC6O7dm
        FljBsn72tjQWFFzxPxQYyXTQ+7nyxhr1b4+X8mnwia7lohtlDU8cwCbdDvuwlE4S
        z2DhkNWP2c6UZFG5VcwNjuHEs/B4tPqEG3Aj/KLTzMJrPYVwLGHmt4V4vkaUzmyt
        KSNUaPI+b45/zFXsJxOGbzitl2Z7JGy2yXYviprRxns73zoOyPHwfBE+qNsCms0y
        3aQ5ZTbwe9x+14MhW/vaNJRGhXa/MFUpS0k8GJeWr/xy41xIX8OeqKid0f7TD6NL
        FG4Kub1Mxv9WM7oaW7b0+zVcW131AoC/nxF8AzmehKA+ytkvy/WYqq+ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=d8z0gS8HZr/N5++6diSc7wdo4fZw0ZGyLBL09kv+EHg=; b=FV3zGPnM
        ZaLt5ZQFyqDUklwCu77VoH7hPI0fnnB0m403b60YUpXt0EiHx2Ks8+6NG06i6Pig
        Ybg7icqo77OgEGcSDh7ETXSnx9EwnyyZ1OKY9VinYXrKC3feLhOnRzywWGzhCv5w
        7mS5GX16j2nsqt0SiYep2MZKGDcgDavoaHM0ZHhUHsGechipBufev14j/GUUkB9A
        Is6O9GLLET+Dl9d6XO16ctsrnuAcvCG5rc3QeMzElGT6jeFsdb8RwmkAAA00VLX7
        99LdpqFWpDlqo2MiGU9FKFNFO86aj2zPmrQCnsvv2t2vx2eV9OSvMYkvPchQZltC
        HqxeMowgxqb4mw==
X-ME-Sender: <xms:O4LIYMFfZD05e3uGESG1cCY2w6gfTXxV0dwekZfP87JAMTAfehG-mA>
    <xme:O4LIYFVHpj2FnYQsU4GaGtL_k_7YBre4dh056d8rQ_z-N2Ig-azmwXxtT9aaxUEX3
    nWnGLBu1jRaBvtuBUE>
X-ME-Received: <xmr:O4LIYGIVnxPtzw9qWIQ5_85GQEnN11w7t5DzgTm682qCBgMGJwohuuAL6XGMyoyFdkCMYciTJlxw2kS3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:O4LIYOGSLT906tdJtZQ0czuzz4eY92dRJkwyVFnuACkvdiFyBKLBQQ>
    <xmx:O4LIYCV0DZqBIX2_Tmjfnmw6jJUQGA6u5nmCnksQVUVD6Za5zzLNjA>
    <xmx:O4LIYBNOFlfBAiiNy6oRu3DyumE0iX29q-vIKfNcUQbnYTihSQJx8w>
    <xmx:O4LIYNFQtBitxpbj4DPcx_YTuDUUe_tVlIthIqGI6zVSPt1Z21TQwg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jun 2021 06:34:31 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v6 4/5] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Tue, 15 Jun 2021 20:33:59 +1000
Message-Id: <20210615103400.946-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615103400.946-1-alistair@alistair23.me>
References: <20210615103400.946-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator for the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index cd80e85d37cf..bafd1d7b4ad5 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -245,6 +245,7 @@ CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_RN5T618=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
+CONFIG_MFD_SY7636A=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
@@ -255,6 +256,7 @@ CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
-- 
2.31.1

