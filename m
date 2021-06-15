Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671303A8600
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhFOQFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhFOQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:05:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BD2C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:03:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t7so6646582edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BpKRpK+HoAUCiaDcLiAbBtzYQDtuiOylAa/SZp8zz+0=;
        b=U+qIRbQNfE9dmavZIIOaXY41zpxYzmT7mf0aBXzNS6nfeql6Vr+AzjHmDeMLy3rbRv
         iKCLabMS7iQMajIePtDG261UU1mtcZzNj/521YKcCjP0dao+Tn/yDig1KiE+rYODc+08
         TgkRhURxDajr/3ACIS3Q/9izSdFt2AG8ea7IxevpR7Dd4P+E8JuMnu3Cr3eCFbhLm8WS
         lNZFg5x/VxW+W+lMLUu7zD34pdSgV8LJCOApwDwQ2ergOOaojhxr89QiZ5ri+EmH3uHC
         TkJsxS5fh7vNFnuGEb0h6evh7pJM7vMqs11Sws7ImfQ9lfdxg1oLGGx20Zg8IVd7kUTf
         qsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BpKRpK+HoAUCiaDcLiAbBtzYQDtuiOylAa/SZp8zz+0=;
        b=t9WRMEbo6WCjcb5LWDSVw9Ps7mdQiCP3dDbjMg/wDgvAquoPNtyE2YPAm4CKkhzVuI
         HiERLhuomQAE/ipHtrH+/ayaA9ikiQaaUPstge46mh0pysszr2AichEcuYChRRaUsCFp
         8eGb3zkYi3ZbqjnQDzrqT6yOvO50hqL2zPOG2ih713rAitgyh+Nk6WZBrMT1YGrkEdMg
         HX9OiQICw1vmDiBi8+1ZavoQ32NwGYPML/5JdJ6fZyYr6ppRWEgmKzQ8n7P+FrNMRTDc
         nXelIa3wcPNKStg8F706Y74tB9AbCxKK//eE5gctVzsuysyN/Ahz5t5JfwRQxhTBpksv
         uclQ==
X-Gm-Message-State: AOAM532IeXUYcKWaRHZS7jOVINgwG5hXTCYdngzsJOf5DfNKfmMQu5ru
        eGG6vec/KcxO6w8wUxp0OUU=
X-Google-Smtp-Source: ABdhPJwwERTwHuJXh56tKu323zEBILEhMvA/wOLZ0L7u4iTTk6sZmwVTJTfVHCaqzQqIT/kffy+fBw==
X-Received: by 2002:aa7:c3ce:: with SMTP id l14mr156560edr.99.1623773022379;
        Tue, 15 Jun 2021 09:03:42 -0700 (PDT)
Received: from yoga-910.localhost ([188.26.224.68])
        by smtp.gmail.com with ESMTPSA id b1sm1640061ejz.54.2021.06.15.09.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:03:42 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/3] arm64: dts: lx2160ardb: update PHY nodes with IRQ information
Date:   Tue, 15 Jun 2021 19:03:35 +0300
Message-Id: <20210615160337.1320644-2-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615160337.1320644-1-ciorneiioana@gmail.com>
References: <20210615160337.1320644-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Update the DTS nodes for both the AR8035 and the AQR107 PHYs in order to
describe their IRQ lines.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 5dbf27493e8b..028ff8074b9d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -65,6 +65,7 @@ &emdio1 {
 	rgmii_phy1: ethernet-phy@1 {
 		/* AR8035 PHY */
 		compatible = "ethernet-phy-id004d.d072";
+		interrupts-extended = <&extirq 4 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x1>;
 		eee-broken-1000t;
 	};
@@ -72,6 +73,7 @@ rgmii_phy1: ethernet-phy@1 {
 	rgmii_phy2: ethernet-phy@2 {
 		/* AR8035 PHY */
 		compatible = "ethernet-phy-id004d.d072";
+		interrupts-extended = <&extirq 5 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x2>;
 		eee-broken-1000t;
 	};
@@ -79,12 +81,14 @@ rgmii_phy2: ethernet-phy@2 {
 	aquantia_phy1: ethernet-phy@4 {
 		/* AQR107 PHY */
 		compatible = "ethernet-phy-ieee802.3-c45";
+		interrupts-extended = <&extirq 2 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x4>;
 	};
 
 	aquantia_phy2: ethernet-phy@5 {
 		/* AQR107 PHY */
 		compatible = "ethernet-phy-ieee802.3-c45";
+		interrupts-extended = <&extirq 3 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x5>;
 	};
 };
-- 
2.31.1

