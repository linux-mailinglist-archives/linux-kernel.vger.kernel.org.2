Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0632C3DE8BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhHCIra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:47:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38431 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234453AbhHCIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:47:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D6585C0131;
        Tue,  3 Aug 2021 04:47:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 03 Aug 2021 04:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=jZzL80sAxd8wsrGpE0UUL7K9VD
        qEKpecnpfesSlh82Y=; b=e4dTnfkFxeCv/01PA2xBQj9/6ymh7FTqvuw3HZapfw
        n1sziybWwne8Olawb5xozqYd4U/sDWA7fyvFj7WfQwZIAtMdjpEaddKTyi3Q/GM2
        gMB8if3lSSF+S0HXwVnvDyARll7ap497clzyN26IBz9oJkOwtPfxk8sNvqZag2TM
        dZHpZ1KxNxgwamul/vUQtcmaNoW40rWsXgf2SLNrn7NtcI3+3lToI9rmfVi4tj+W
        qZPSHTj4i4bwbfkr82B3nkunLxHTcKwY1bhZ98TN415nqQRQTk0p15iYhH2FS1Y8
        jjxRFutbPM/z8y62HI0IxNdb/azCc4Vb0DSKTm4FSO9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jZzL80sAxd8wsrGpE
        0UUL7K9VDqEKpecnpfesSlh82Y=; b=J7yQ//653bcONaroniSMgXxbDXCBj+54O
        jEcqt4dmwdHIw6sQiV+5zZA4FTPJy2sUT/qMuj+ZgStYxe5zBL+Fua1Z40hggClB
        0pbIBN70rrfPH4KvYBO/Laq7gb/GGjJjv4rjmPYfC4p7JMXddFGRyStO0b/FrDW8
        tJehama0tRq99K3cnqzcryr5W6Yn440hzALmAu1ZPZTu9RfG4dMuX1Y2cvrfNCcJ
        T1z0Y2Yv4lzztH64k5KwmdvTegOJco2CwRzjrDgul/6UPJ9+COMEVoO8SxbI5VQw
        w5rxY4LB6XUWEYorgjFn1orvz/tvtXfdTIohnvB3d580hGDR6NKlg==
X-ME-Sender: <xms:lgIJYQJvJ_NxIo6jCgi4P_iqGr6eOVvTMD4Z0vhkVk6-9kWD9SEFDg>
    <xme:lgIJYQIsVE_Vwr_umpT4-Dylr_XsbdVNECLcyrgt0WdR9_ZJUKpm55wTtPns2Jstp
    wv4dZCEHC0rhCrmg1s>
X-ME-Received: <xmr:lgIJYQvhmKthpABtB9gjG5smgTQuXIuBLiGout_l1sxR4cyUKe-bLmXnw3YF5Tby2yjY-VrINBQKpCq5fexuTYkj5E7zULKDRFvOPQimAcpKMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepjeeliefhvdetgfdtte
    fhtdegffdtiefffeejiefffeevueeljeehjeevhfffueeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrg
    hirhdvfedrmhgv
X-ME-Proxy: <xmx:lgIJYdYfT6-B46ekH-gl0tk27vA5Ssli5asNdq3u8FPIpJVbO-osRQ>
    <xmx:lgIJYXaW1uSSf-FnyQOk_WyztoVBpkkBSttBjs-pW-6dfDeC2GNQ_g>
    <xmx:lgIJYZCwOsTu-fDMJjoRm7RRFcOhTAta6bfA_kKSZI1gCkD1JAWPog>
    <xmx:lgIJYb66CHBSwt04nV0NBHN2ejcS2yK0AODwmvq7leI-dEQtOjgLgg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:47:14 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 10/11] ARM: imx_v6_v7_defconfig: Enable backlight class devices
Date:   Tue,  3 Aug 2021 18:47:07 +1000
Message-Id: <20210803084708.254-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BACKLIGHT_CLASS_DEVICE config is required for the already enabled
DRM_SIMPLE_PANEL to work so let's enable BACKLIGHT_CLASS_DEVICE.

This allows the mxsfb probe to complete successfully on the reMarkable
2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index ff3eddb62c1d..cc11b062ca38 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -300,6 +300,7 @@ CONFIG_FB_MODE_HELPERS=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_GPIO=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
2.31.1

