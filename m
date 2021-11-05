Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0008B445D22
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhKEBCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhKEBCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:02:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F6FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:00:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g190-20020a25dbc7000000b005c21574c704so10973410ybf.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BWRsLXSuRuX7m2v7ufxzsJ2Lj2A75oZX9+jsZ2D7yIw=;
        b=rOB7r6/fbY4l8mLPY8G3uBq2wReZq1FkHA0EBN59GTT5x8sq0UR3tghTOvqg93YHAp
         ka1dLR4hOsSUL+pyNB7Uqgw5s0H60ScBMNGlizFjPJ+LUQBEF+vfLk1e4OjZMgQc9Byd
         e2stSuja4pjQw7iO+8De8x2Vs6eNmKC3mG+rYm/fZwxHBe2DCuHQLIxmVTBTspSuerjB
         ajM8wiAa9HlwhqKJMh5nN/8j++sUnE3NjPtiq2nmk5TntUHB7+GvIh6497yJcl2VN2oV
         huoKII/Ozk5GvReIIeTaWv+F5FEfr5ssOgz+Qr4pJnTMeMZKYjN7+4OUyVi5IR9PMXaa
         zUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BWRsLXSuRuX7m2v7ufxzsJ2Lj2A75oZX9+jsZ2D7yIw=;
        b=maDexcYTRtpveLF0YVf1JkdkH+Vr9dLtkUN4XiNhm0e+dFpMaH9/GntXLQ3ARmYcha
         601qrZCCCKX/RWe8JePQM3JSd6xaekva3byOBXADhRwDInqMZkqtvsoE902M95Pw+6iv
         MGJ9eVxZpdtEM2sI0TWwpYpr59C3FHqH+5x8EDgBitKveMDnWSv6OwzU3ioREpQ8LY9B
         gmuAd5ekrtbVrA/uM1BtIl3EIKBd6kw9VtkAxuFmF0Y3XiLwDBMQWu0TIXk7ozMD83Tj
         QfLYtVoC3Y5ysvmowZE8vRmT+O6Gya0d0Gb1qX+nODEGb4mZlZHSGJ7QEfqS10t4lVG3
         W++g==
X-Gm-Message-State: AOAM531JsZ9phwhlmNzZtzdfwxZOXLJh4VWKlqiepEyt5pqs8wa9VXD1
        CzKxcEPLHhAftYELrebFR4wLymc=
X-Google-Smtp-Source: ABdhPJxGKt0KTPJnJkQP+F1fXbU5ufjr9qUcOu3vXpvZaG/Sj3DoJSO3btei4j4hApi6sqDQHbLE7aM=
X-Received: from osk.cam.corp.google.com ([2620:15c:93:a:24f7:55ac:2f28:525])
 (user=osk job=sendgmr) by 2002:a25:50ca:: with SMTP id e193mr48233941ybb.324.1636074002883;
 Thu, 04 Nov 2021 18:00:02 -0700 (PDT)
Date:   Thu,  4 Nov 2021 20:59:55 -0400
Message-Id: <20211105005955.107419-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
From:   Oskar Senft <osk@google.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Oskar Senft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change updates the configuration for the nct7802 hardware
monitor to correctly configure its temperature sensors.

Signed-off-by: Oskar Senft <osk@google.com>
---
Changes from PATCH v1:
- Removed superfluous "status" from channels.
---
 arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
index 68f332ee1886..66734e4e2ea1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
@@ -213,6 +213,25 @@ &i2c0 {
 	nct7802@28 {
 		compatible = "nuvoton,nct7802";
 		reg = <0x28>;
+		channel@0 { /* LTD */
+			reg = <0>;
+		};
+		channel@1 { /* RTD1 */
+			reg = <1>;
+			sensor-type = "temperature";
+			temperature-mode = "thermistor";
+		};
+
+		channel@2 { /* RTD2 */
+			reg = <2>;
+			sensor-type = "temperature";
+			temperature-mode = "thermistor";
+		};
+
+		channel@3 { /* RTD3 */
+			reg = <3>;
+			sensor-type = "temperature";
+		};
 	};
 
 	/* Also connected to:
-- 
2.34.0.rc0.344.g81b53c2807-goog

