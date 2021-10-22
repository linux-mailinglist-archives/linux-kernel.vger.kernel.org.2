Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9754378D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 16:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhJVOOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:14:18 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:43953 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhJVOOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:14:15 -0400
Received: by mail-oi1-f176.google.com with SMTP id o4so5140882oia.10;
        Fri, 22 Oct 2021 07:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fntq8tUMlB+L0yN28C+/8oiQ/tqnhvbVaVy+XCHM97M=;
        b=VwQQJkjyzJxf2ac2q1SbmbQ9GS6gkSIFP+OU/E8Q615+2ksSYUj1RLg13b0YEWgCkL
         ADJNi7HB52iKbsRUGUxgqLQe63+SDIKJbfGB15k+Xv8pMM2mGDyRK1gN4PA6ZT14o0+P
         icsP19ho1jNd8i+Ac6m8/XYJwXueCfGX5rzlWUWOm35d/qnyUgEaajxRbhQ7nu5qVa/p
         p4Sb5uXZRztpNVTJk2q5XYAcNUsc3/yZjtTsksiayjifIzN0C+gHBMLS9W8PLvWk3eur
         nOEH+Vf9mK5k7IdBDYkkvtJcJpKudDFGdQBxnMplFpk3A9VIuRC+vVDTIV+/BTZ/7nBq
         9Xlg==
X-Gm-Message-State: AOAM530NW74CQi0sphcaVnEAkaDHNe2aRa1GUV73MnJfXxTk65LPT76p
        jo4bfc4mB0B9ulXQ6HmMfA==
X-Google-Smtp-Source: ABdhPJwQ2dCgcSgOjl+llkhisJut4OFc60/Z9ZVdZK9ftiZjWbJd0kP0dC9thm618B3k/7CcA122Eg==
X-Received: by 2002:a05:6808:1287:: with SMTP id a7mr10108534oiw.45.1634911917877;
        Fri, 22 Oct 2021 07:11:57 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id a15sm2037958oiw.53.2021.10.22.07.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:11:57 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2] ARM: dts: spear13xx: Drop malformed 'interrupt-map' on PCI nodes
Date:   Fri, 22 Oct 2021 09:11:56 -0500
Message-Id: <20211022141156.2592221-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spear13xx PCI 'interrupt-map' property is not parse-able.
'#interrupt-cells' is missing and there are 3 #address-cells. Based on the
driver, the only supported interrupt is for MSI. Therefore, 'interrupt-map'
is not needed.

Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---

Arnd, Olof, Please apply.

 arch/arm/boot/dts/spear1310.dtsi | 6 ------
 arch/arm/boot/dts/spear1340.dtsi | 2 --
 2 files changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index c4b49baf9804..2f746a9428a7 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -82,8 +82,6 @@ pcie0: pcie@b1000000 {
 			reg = <0xb1000000 0x4000>, <0x80000000 0x20000>;
 			reg-names = "dbi", "config";
 			interrupts = <0 68 0x4>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0x0 0 &gic 0 68 0x4>;
 			num-lanes = <1>;
 			phys = <&miphy0 1>;
 			phy-names = "pcie-phy";
@@ -101,8 +99,6 @@ pcie1: pcie@b1800000 {
 			reg = <0xb1800000 0x4000>, <0x90000000 0x20000>;
 			reg-names = "dbi", "config";
 			interrupts = <0 69 0x4>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0x0 0 &gic 0 69 0x4>;
 			num-lanes = <1>;
 			phys = <&miphy1 1>;
 			phy-names = "pcie-phy";
@@ -120,8 +116,6 @@ pcie2: pcie@b4000000 {
 			reg = <0xb4000000 0x4000>, <0xc0000000 0x20000>;
 			reg-names = "dbi", "config";
 			interrupts = <0 70 0x4>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0x0 0 &gic 0 70 0x4>;
 			num-lanes = <1>;
 			phys = <&miphy2 1>;
 			phy-names = "pcie-phy";
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 1a8f5e8b10e3..827e887afbda 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -47,8 +47,6 @@ pcie0: pcie@b1000000 {
 			reg = <0xb1000000 0x4000>, <0x80000000 0x20000>;
 			reg-names = "dbi", "config";
 			interrupts = <0 68 0x4>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0x0 0 &gic 0 68 0x4>;
 			num-lanes = <1>;
 			phys = <&miphy0 1>;
 			phy-names = "pcie-phy";
-- 
2.32.0

