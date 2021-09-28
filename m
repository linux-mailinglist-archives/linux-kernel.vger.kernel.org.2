Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9968741B77B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbhI1TX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:23:26 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41488 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbhI1TXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:23:25 -0400
Received: by mail-ot1-f52.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso30266980ota.8;
        Tue, 28 Sep 2021 12:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sChSP4IBzdn+CJKNlGx6rgNLx64zEAAzoPPhQN0lecQ=;
        b=vsMBy+3+o+ST7Y0FV8e0C7FixWFqinqCLYBG02mkFY2+IBQlzvy3Fp8XE595TOnef0
         Nqxe8LSn+/eRvsn8UQWqACGLCP/Q9o4rJ+tlS+kl/xrMfLeEyeNBbKXxHEZFwagMXS25
         4+wmsLP243xgULUcP0zpNDwrqVl6NVXwPFcXYAppfGdF5WewiSpk3FdMVIKenfJkI3fw
         bUQZ8JziIkbsyw8XdBfGKIsTS4gdSZ8T5Myb9DLVo7axttUKKcB/0WIROjmvlLVxc8ti
         BJwX1r4J63aD/+W1ZG7JQBDg8qV6FAu6xsOrKVe9+ijJgtg+Hs999xzyAdURM+cl7HTZ
         wbow==
X-Gm-Message-State: AOAM532ThmUHKdHbWK/97oPFp3HTDIFjRFiKwSzdj5rpuuDHd5J3RVua
        cJKj72Iox/dXyHcBnnl+5e/cqeFuWQ==
X-Google-Smtp-Source: ABdhPJywv+B9hXIlUuYXWoPyeC21s8wtLHG97gM4ya9NVYEt9fFYmMlwI/hcKlD5ZrCJyw7FRxLZKQ==
X-Received: by 2002:a9d:7284:: with SMTP id t4mr6651399otj.285.1632856905487;
        Tue, 28 Sep 2021 12:21:45 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id g21sm3801190ooc.31.2021.09.28.12.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:21:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: spear13xx: Drop malformed 'interrupt-map' on PCI nodes
Date:   Tue, 28 Sep 2021 14:21:43 -0500
Message-Id: <20210928192143.1841497-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spear13xx PCI 'interrupt-map' property is not parse-able.
'#interrupt-cells' is missing and there are 3 #address-cells. Based on the
driver, the only supported interrupt is for MSI. Therefore, 'interrupt-map'
is not needed.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
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
2.30.2

