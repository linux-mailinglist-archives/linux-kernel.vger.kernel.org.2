Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35338F75A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhEYBJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhEYBJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:09:17 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C256BC061574;
        Mon, 24 May 2021 18:07:48 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id l15so21500682iln.8;
        Mon, 24 May 2021 18:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RbcKNuYaobOiLATTeiYg9CDVrozl2cCc/yeGD2WrQG8=;
        b=DmbRGydIxk6XlDA+8WBe7eJNL7LmmGvrmBGhUNk1xTpPeYX4AlJTGk70Ld2kJIgdfh
         xfNejTTruOYHQLouRSh0Bw3ehKky49PsG/OzAHaas4W/ZHpy4jIUKgBQWYFDYg8mkJYX
         3s4bSkjwouZAKjoTPo08bSEKFRn9n0bc7CjJfpu6yjNdVuRYyJROtL6lnjWINczBJTm6
         MM3MkbqtZl7iLGjnY7mmIjG1xHU1vZH/mmU/gLOhPsC86lK22vtKp1mU98qvIzewdw4H
         9CTxjQZubXL7jDynyLUervTIswPjIW4Hjj9hXrgD+xkW0KWxzmrzZykvukYt+dgmKkPr
         UBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RbcKNuYaobOiLATTeiYg9CDVrozl2cCc/yeGD2WrQG8=;
        b=ZC3cAWwqdZu+WRXMWC+T3jnY97c6oBzbG/0qtVf/aDK1F87a/pM1Rlg++QpVLH3k3Z
         5LPXthM8shPiDtpb9Fhe34nHJQzJhKQLvifuXieX/zqI9k2kpKB4K8tV1WywB5oOUbR4
         5RulOI63SQZ4Kbt2DJ32F+hKzL9xTEt1+ZOb152yxIJH0TxwXKi7b9hZZQwYsZjFt1jA
         GnDJhp4+ZOYDZi1UHRkzBtk032jw4Ls81foSRw8LQMkZcRB2yqd5UQeX5ZBORoTrowpV
         YNSsBt+Wjbxfv4SIU+/ZsG9qwVTQ4z8sptiXtnQx61z7lQSnj+TaqrjIWP6uJgf439TL
         416A==
X-Gm-Message-State: AOAM530Oj1gzs6Ix2pTScPHyqfzrnu5pej03HV5aKHqkuxAfMKCFttGW
        mdJp0qh0SRFQlUXuoZz/3v0=
X-Google-Smtp-Source: ABdhPJzOfexUgN+sfhuhpkj/1EmOybZqPlNlwlAbhjhhydS68W0tkTW2J/9xTOhGOOb/i7+JbUbN6w==
X-Received: by 2002:a92:ddd1:: with SMTP id d17mr15465349ilr.46.1621904867860;
        Mon, 24 May 2021 18:07:47 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:599b:b8c7:b3a9:9f1d])
        by smtp.gmail.com with ESMTPSA id w20sm12318413ilj.16.2021.05.24.18.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 18:07:47 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: imx8mn: Add power-domain reference in USB controller
Date:   Mon, 24 May 2021 20:07:31 -0500
Message-Id: <20210525010732.115562-5-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525010732.115562-1-aford173@gmail.com>
References: <20210525010732.115562-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB OTG controller cannot be used until the power-domain is enabled
unless it was started in the bootloader.

Adding the power-domain reference to the OTG node allows the OTG
controller to operate.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 0eb64b59c8e3..8b1fb83cb893 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1009,6 +1009,7 @@ usbotg1: usb@32e40000 {
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				fsl,usbphy = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
+				power-domains = <&pgc_otg1>;
 				status = "disabled";
 			};
 
-- 
2.25.1

