Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF0F4158A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbhIWG5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbhIWG5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:57:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BBDC061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:56:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id dw14so3808746pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fr7Enq1Md+/iS6o0n8IXfVQosSmEQH+2Mu6++d6naXk=;
        b=XGbJ/bAz1wNwRPORhEQJjL8UXXXNcWj8rIuHxZwAPFBFhQ5vtn3ZdMWQXxHIxQOulP
         e7BiZXQnZLv5/ziNcpQnZexJ1akH+g0yJOuFxb4Z52e7DiN95qA3mCnYkgoSJz9dQaZ0
         TLD6g4leqMUOpCrEfIuNbhKW9bBL3uwMXluc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fr7Enq1Md+/iS6o0n8IXfVQosSmEQH+2Mu6++d6naXk=;
        b=2OK0em59mRSlGUidpfQ+j+OJ6pMX09njBOiQD82MzwKNjr3oXsKJ2sPYRRBQnforxz
         q947Tj2CUurn6bwR8Y5B6rzpMk1ObR2Qgi4mnaVNzRUoE244oGtIuJG5yrcHUoOQvGY0
         VBbtLNnw1M0QuFch5EceMf27FAiY2ViF9x2W2ouyo5yvbQrR6Pkbzt1SAhnoETU8kBSG
         +bj4vC+V2z/YwTLcGzMKKeHnvOdW5QG8mbGYFkcRnAHrkzk8qNSdXB9MsIGBhjrdz1Q6
         2b1b+kaU5TVevh4pa8lKgt34s9JWe5AncqDKIbL8p2jc9DfdNStma/8ORiG3lef+pcsX
         iNPg==
X-Gm-Message-State: AOAM531lsvKAzhae2NRF+YZ3q6ZmyaoiQ0Cxz/fTshPYjbaw8Ydk0t68
        B6uIw9DIOYBqsJ5H8GzPYXnT9Q==
X-Google-Smtp-Source: ABdhPJzW3ODPcfMkj2BqCnn8XcUBbAEEGB28eD/+I/5nulCCkg1ERrU1Rta+GOQv2IRU/1vvA8AAAw==
X-Received: by 2002:a17:90a:cb84:: with SMTP id a4mr3659138pju.137.1632380163447;
        Wed, 22 Sep 2021 23:56:03 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id e12sm1581888pgv.82.2021.09.22.23.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 23:56:03 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, pavel@ucw.cz,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 09/11] ARM: dts: mstar: unitv2: Add io regulator
Date:   Thu, 23 Sep 2021 15:54:58 +0900
Message-Id: <20210923065500.2284347-10-daniel@0x0f.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923065500.2284347-1-daniel@0x0f.com>
References: <20210923065500.2284347-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a fixed regulator for the io voltage.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
index 7fba3a772fb2..19289d5b2a9b 100644
--- a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
@@ -40,6 +40,14 @@ reg_vcc_core: regulator-vcc-core {
 		regulator-max-microvolt = <900000>;
 		regulator-boot-on;
 	};
+
+	reg_vcc_io: regulator-vcc-io {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_io";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
 };
 
 &pm_uart {
-- 
2.33.0

