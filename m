Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D295A430BDF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbhJQTxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:53:35 -0400
Received: from vern.gendns.com ([98.142.107.122]:60642 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhJQTxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mBedI+GnmqR8ufViU8AAiK9kL096SIDzwcuuPdOFVIE=; b=t+IfxrQxMP9iitfbQcbu18TXbu
        iX+0ZFwdigNp3eT9USj2KEfN5x3SJejV7FDzA1KbTCFATHdbP6QcFFxRPcBLG113m8XiS31318/oz
        Bddju//bmbMOxLOxg5/EQe3SeIcoz75pvBBX4oo9yToizevTfNCji/QpU0p+b9CKioZloLnyVREnE
        qQz+t56Gv+ubd/4uQzLQVfOC+cjTMfc1slTbqI8NPih35w65+RXhO7ublfKtu7QNmQkxuAyvF+XWm
        le8hrCQ0Lgn82hfrS/Igy0NCYN7jBZRFc1c5idnHt8fxp9jyakUtHX6I4Q1nPZSYJX1l2azCvYUgv
        zKAJcK9g==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:34374 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mcCBi-0007Zh-7c; Sun, 17 Oct 2021 15:51:19 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ARM: dts: da850: add MMD SDIO interrupts
Date:   Sun, 17 Oct 2021 14:51:05 -0500
Message-Id: <20211017195105.3498643-1-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the MMC SDIO interrupts to the MMC nodes in the device tree
for TI DA850/AM18XX/OMAP-L138.

The missing interrupts were causing the following error message to be
printed:

    davinci_mmc 1c40000.mmc: IRQ index 1 not found

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index c3942b4e82ad..bda9a22ba4bc 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -537,7 +537,7 @@ mmc0: mmc@40000 {
 			reg = <0x40000 0x1000>;
 			cap-sd-highspeed;
 			cap-mmc-highspeed;
-			interrupts = <16>;
+			interrupts = <16>, <17>;
 			dmas = <&edma0 16 0>, <&edma0 17 0>;
 			dma-names = "rx", "tx";
 			clocks = <&psc0 5>;
@@ -567,7 +567,7 @@ mmc1: mmc@21b000 {
 			reg = <0x21b000 0x1000>;
 			cap-sd-highspeed;
 			cap-mmc-highspeed;
-			interrupts = <72>;
+			interrupts = <72>, <73>;
 			dmas = <&edma1 28 0>, <&edma1 29 0>;
 			dma-names = "rx", "tx";
 			clocks = <&psc1 18>;
-- 
2.25.1

