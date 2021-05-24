Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A8838F2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhEXS3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:29:38 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:55495 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233826AbhEXS3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:29:34 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4765F581E77;
        Mon, 24 May 2021 14:28:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 24 May 2021 14:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=2fewIY8SSeOIN
        MWuX04BZLhEUB7cqd8i9hwPLOWHdeY=; b=r4g5LIrUfm4HTwFGDPybjTlZaIJoC
        u0g4bgplBwxMKrR0W2ts+TzDqCGMiBjPHqGMkcLgkZocztyJfERxVKTJsIusONe3
        LrZoCtN5gEwc3yoLDBelZOjGAeHyAFrstz9k7sn1Hcj6MTKkgM/TRIhTSiD32C3I
        ACDYN/lQCEz3DGEb1rgGrcBoqWSfeR7DHL3QBUnkQ3PJV8brIRL7lmOuQPIaZn9M
        /eVWRWDanRwrms6hKKWIQLfDhXkjVEKxLgy9Nm2IBex3SlV18MRfhOAUPyZVTALK
        W6xQartIELHA+dgGKYf2g8GrJ74JbtvgwtaJjcvJG/Ao0TvS2mBh3BRgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=2fewIY8SSeOINMWuX04BZLhEUB7cqd8i9hwPLOWHdeY=; b=Bdh4cKCJ
        6B/+t4L2ERzwEv/DNZle7PnXB5ogDZA2XAkZQ94VvVJIgni1HmtzXyEEwnWj5t7/
        mO1vuJEmRYnVxx7TW/27y6gG0gkrvAQKxKg1auxUmrEBcT0X/XcREFj7E1g8w+nP
        YpK0ZI+gdwXANayau9Ku4aMw55+94tIw0BD0jQmRLE5//HGWYwypTQ2MQ91vR4+f
        tkb8E9miSwjhtyA02JA8EsuhbhMDS5rt3bLMc+nHlNG76oYTebDOMOYFQFq31/LY
        3v3QlN1KQniM9Ks0fGAzfpItStX0Bt98I2hwv4QoEBdNzHaGRcappmPCDH1O4+Mn
        254fyMc821sEDw==
X-ME-Sender: <xms:M_CrYEB5po9Y8GA7PVllubrjF7cnwpl58g0Sn2sTUimNn8Sl9pd_cA>
    <xme:M_CrYGg8x0lRX8WakeXy9A9yCa-vElASp6Wl-qLwUpNxIdMjRY0AVF-W5JXW5E0Mp
    fL9-2ZJFreI7cuRPew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
    jeenucfkphepudejiedrudelledrvdduuddruddvgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggv
    vh
X-ME-Proxy: <xmx:NPCrYHmAWkEFx1MH7uBCxhgKguI7TlpTHSVr4B--0sJ3RYrNKEO82Q>
    <xmx:NPCrYKzVZMWbZybwaU8TeZ51b7bkm0MkBEiwhu6z71CJN9r6LqkzXg>
    <xmx:NPCrYJRGuwLiJxnTqGyRKEiPbc2FK6hw66eM0sNumIU9OyZcG_Rp8g>
    <xmx:NfCrYEF5fhs2o4U0VMaB3ZkgR4Sq4EV7K-Zjd6lghiMwqAiLoecZUQ>
Received: from photon.s7r42.com (ip-176-199-211-124.hsi06.unitymediagroup.de [176.199.211.124])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 14:28:02 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Sven Peter <sven@svenpeter.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 3/3] arm64: apple: add uart gate clocks
Date:   Mon, 24 May 2021 20:27:45 +0200
Message-Id: <20210524182745.22923-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210524182745.22923-1-sven@svenpeter.dev>
References: <20210524182745.22923-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a driver for gate clocks add the proper topology for the
UART. These are already enabled by the bootloader but are part of the
clock topology used by devices yet to be implemented.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 36 +++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index a1e22a2ea2e5..b7c85b800efd 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -120,7 +120,7 @@ serial0: serial@235200000 {
 			 * TODO: figure out the clocking properly, there may
 			 * be a third selectable clock.
 			 */
-			clocks = <&clk24>, <&clk24>;
+			clocks = <&clock_uart0>, <&clk24>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
 		};
@@ -131,5 +131,39 @@ aic: interrupt-controller@23b100000 {
 			interrupt-controller;
 			reg = <0x2 0x3b100000 0x0 0x8000>;
 		};
+
+		clock_sio_busif: clock-sio-busif@23b7001c0 {
+			compatible = "apple,t8103-gate-clock";
+			#clock-cells = <0>;
+			reg = <0x2 0x3b7001c0 0x0 0x4>;
+			clock-output-names = "clock_sio_busif";
+		};
+
+		clock_sio: clock-sio@23b7001c8 {
+			compatible = "apple,t8103-gate-clock";
+			#clock-cells = <0>;
+			reg = <0x2 0x3b7001c8 0x0 0x4>;
+			clocks = <&clock_sio_busif>;
+			clock-names = "clock_sio_busif";
+			clock-output-names = "clock_sio";
+		};
+
+		clock_uart_p: clock-uart-p@23b700220 {
+			reg = <0x2 0x3b700220 0 4>;
+			compatible = "apple,t8103-gate-clock";
+			#clock-cells = <0>;
+			clock-output-names = "clock_uart_p";
+			clocks = <&clock_sio>;
+			clock-names = "clock_sio";
+		};
+
+		clock_uart0: clock-uart0@23b700270 {
+			reg = <0x2 0x3b700270 0 4>;
+			compatible = "apple,t8103-gate-clock";
+			#clock-cells = <0>;
+			clock-output-names = "clock_uart0";
+			clocks = <&clock_uart_p>;
+			clock-names = "clock_uart_p";
+		};
 	};
 };
-- 
2.25.1

