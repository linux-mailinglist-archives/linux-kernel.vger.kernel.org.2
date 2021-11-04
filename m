Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD3445B87
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 22:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhKDVML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 17:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhKDVMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 17:12:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4393DC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:09:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso10345950ybs.14
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7eAvWZMUuk83qtD9UGD4CmQ/pWSKrNHVd5Ady12gMfg=;
        b=rZMYILror75Ht0AoBH/ZsvgKjVwaFo18MhCkuaBu13bkWfTbN1VZGREiucrugYQnjk
         3PM0CUGc+QnXp+VyClKs2qeMxLzOz8kHqoO2X3yYWHa7tq2s+P+BnTRhPg8Cyw2zaRJB
         PLh1+RH+WjaKHpXmdyRLZhyHgTW5U+aLTyVJ4sNzlJEIyfBHqqOrt/1LqACMPALQ3SS+
         e3NzjxwdTc2Nwdl1S6gn/zcrMU38LQPuxNEk86vrKBgT+orwFNRN4jU6PvAPVBzXNi3C
         dJ0tpmBiU9j3QsWpaIjLb2YNsob85WX1E67j+q38ZnnDne8zoRdfW9LcYQhbikrokLhu
         fYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7eAvWZMUuk83qtD9UGD4CmQ/pWSKrNHVd5Ady12gMfg=;
        b=q+lgcYvla1kvpM+eaN/5AWOXlQFP7ub4Klvk/7u7a41RCzbHs/O5HcyZre2vtkuvp/
         T6eKXiWPo7/sMjdAelq23YlG6lif9bW7yp14ki85+OaZfoPSplU/YSgx74yC8sGvIwSZ
         bRJ5O9maKpiSf4xvdC7TZrDUfxjclZdjhW3IGilBr9LSMieLJ5HyxeinyRFklcLLc4lB
         Tz6wkotHXlSK6Xcym/sa8ILO9Q+NaYJZl4IahoEcORIa6jEmLInOuguXAamobdr5jl2O
         9EDpPfq/fSbI9CxP4ZscVCg8F0YofRPE1HmPXj2BOMxCnLsDPuloWK2ABgRhmczXjPyS
         FEXQ==
X-Gm-Message-State: AOAM532DvCLEYXL2zx6wboAMVKBQvCiwnSinJDXdcJCZ1yNduHB+hmY9
        /8ZXekWz5CcgZGkfqA9AaMads8s=
X-Google-Smtp-Source: ABdhPJwY4ltXWbOSiMhD5uAht74woKKOsNOUMTZw+v1ATbZtma+JpvQiGfD/6x46fgOGYQGcXioAnH0=
X-Received: from osk.cam.corp.google.com ([2620:15c:93:a:24f7:55ac:2f28:525])
 (user=osk job=sendgmr) by 2002:a25:c907:: with SMTP id z7mr59727605ybf.172.1636060169398;
 Thu, 04 Nov 2021 14:09:29 -0700 (PDT)
Date:   Thu,  4 Nov 2021 17:09:14 -0400
Message-Id: <20211104210914.4160448-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
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
 arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
index 68f332ee1886..fc1585f34a57 100644
--- a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
@@ -213,6 +213,29 @@ &i2c0 {
 	nct7802@28 {
 		compatible = "nuvoton,nct7802";
 		reg = <0x28>;
+		channel@0 { /* LTD */
+			reg = <0>;
+			status = "okay";
+		};
+		channel@1 { /* RTD1 */
+			reg = <1>;
+			status = "okay";
+			sensor-type = "temperature";
+			temperature-mode = "thermistor";
+		};
+
+		channel@2 { /* RTD2 */
+			reg = <2>;
+			status = "okay";
+			sensor-type = "temperature";
+			temperature-mode = "thermistor";
+		};
+
+		channel@3 { /* RTD3 */
+			reg = <3>;
+			status = "okay";
+			sensor-type = "temperature";
+		};
 	};
 
 	/* Also connected to:
-- 
2.34.0.rc0.344.g81b53c2807-goog

