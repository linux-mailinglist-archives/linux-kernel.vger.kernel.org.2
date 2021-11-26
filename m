Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587E845F5D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbhKZU20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbhKZU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:14 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EC7C061758;
        Fri, 26 Nov 2021 12:22:07 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i5so20990445wrb.2;
        Fri, 26 Nov 2021 12:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a03oi73IUIbALiHeFayx9Bqv0K+rE4kVayfrAJF+ar0=;
        b=qX7uM7p97Jt0FQj6iQEBYdM+mBXQ/ChNeRNfngSQvq/n6N6YwvQjGsylVDLjn/upje
         pZsrSQl9c0R2YsNsgX1hgWZcfypOwDAKEg/1tNUmb0abjZ8VXuwj1blcW1DdNJa36acy
         6YKFLP0VQiBLWgPKoHZgRgIzSsWUfsSbczkuXsFr3qe+G6hLszgm/BDG1u102lixiSaB
         uKpjZTWgtR6NbjOrxoizXOvLra49t5ViOzZEJlEMxoiuUiURormXWN4B9bMr9vKRqIRN
         1m5kfiKm7R74DXQqQgdj/nnXJ1iOOLnQ2PL9UK+fAhJDW16TcKSFc9IEIVsEbzCb66WS
         9gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a03oi73IUIbALiHeFayx9Bqv0K+rE4kVayfrAJF+ar0=;
        b=r+/gdKgrBU3CgiHeTeO63nHD7Ce7SYZWIj4AUP0IcRY1QEGUQkTrWAzhfznWR+UQWl
         Xwn41Tvwc+8orCj9FyGHUo+CNCGOeqyVqkfUWtJEenW3tZPfW8ezy7IcCul7LWtvHlVr
         nb9dFqOF2WJPr6cFDIbcz+Z8Jp4HRehoqURJ6ab1BB9v6mzaFxHlv5deJFZqyYiIeBds
         Q9R9OPjkAtRUPEoOWjvsUkbhQDD7jLEgSAQ8hDo4vq8EW8fSvC8sBE8qMv17/OLftrOO
         tI/eiM8bhidx2ZEamysI8WsUKfV8GCcjwumdxfrrC2KrFN7najHzTyNDsnaOtH0rAEFU
         g8HQ==
X-Gm-Message-State: AOAM531JA6l+mr5cqLKWjv8ktVPAyJzgdoWwzdRh8uEaMF2gfI4o9jRb
        nPCFQ3gPOg91QkON66BW5iKXAyV6z+U=
X-Google-Smtp-Source: ABdhPJz8uSeuZpTMKhNOKdJcRyH0QQPdOuoobO37b+5kX2WUsmVWOFxZnRjPlDVf30LtKuHPirCsJA==
X-Received: by 2002:a5d:6e82:: with SMTP id k2mr16084465wrz.147.1637958125381;
        Fri, 26 Nov 2021 12:22:05 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id m36sm8236955wms.25.2021.11.26.12.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 12:22:05 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: mstar: Add timers device nodes
Date:   Fri, 26 Nov 2021 21:21:43 +0100
Message-Id: <20211126202144.72936-6-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211126202144.72936-1-romain.perier@gmail.com>
References: <20211126202144.72936-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the definition of the timers device node.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 89ebfe4f29da..7ede4cec0af9 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -123,6 +123,26 @@ watchdog@6000 {
 				clocks = <&xtal_div2>;
 			};
 
+			timer@6040 {
+				compatible = "mstar,msc313e-timer";
+				reg = <0x6040 0x40>;
+				clocks = <&xtal_div2>;
+				interrupts-extended = <&intc_fiq GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			timer1: timer@6080 {
+				compatible = "mstar,msc313e-timer";
+				reg = <0x6080 0x40>;
+				clocks = <&xtal_div2>;
+				interrupts-extended = <&intc_fiq GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			timer2: timer@60c0 {
+				compatible = "mstar,msc313e-timer";
+				reg = <0x60c0 0x40>;
+				clocks = <&xtal_div2>;
+				interrupts-extended = <&intc_fiq GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			};
 
 			intc_fiq: interrupt-controller@201310 {
 				compatible = "mstar,mst-intc";
-- 
2.33.0

