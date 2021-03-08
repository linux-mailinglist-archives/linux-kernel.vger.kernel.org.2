Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A127A33144E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCHRMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:12:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33555 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhCHRMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:12:10 -0500
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJJOL-0003Mp-JS
        for linux-kernel@vger.kernel.org; Mon, 08 Mar 2021 17:10:01 +0000
Received: by mail-wm1-f72.google.com with SMTP id a3so2286501wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4L5ptXi6Ff8KPlgqMtzZ9yjH3MQlq6STx7WRAfv4xo=;
        b=aWVqK4JMkorS6XNLrwLT4gtdkAJepm+PJHydRgvm2e7h4vI+bQrOWVNnZY+48SRyBR
         l0Zk/Bg4NVc6GVO35k39P1jW9fmSKdw95eIPbccDlokgeyOkziA7EMqvGWsn791O99jv
         oYehRZi43Hc2Yc6oV91IKPixOsO+rU9Gz6dYbaMOJS/UbUbrTsHXA2MW//4cykm6nWwz
         5GXVpcYa2IPtKJyk0pHX5VNAwF4Fk019epWZ5EXj/5uPCXhKstWMB0jFA4rxFVNkhu3y
         be3VoeEPbLX/tgD8JmUdAECCX6vTPJMTwbSPhjxDHx44NxSQx0u2yIoXENVwmjsPpaaw
         1xTA==
X-Gm-Message-State: AOAM532Mzf9O9A76WDv2w+AuaCKpZ/wwtiEJa6WeA3/0jrHfZYfr+Z4D
        qnxCoE0eVxF4nuEBB2VoYrGQ5tyVZok3wuqOaZpu65sRMyym7yG54zzLD2NW0uS5Oi7WXgGqmOG
        8SjBSCOdebWEXThW2wEDdrsFgVBYISD5Mos9WQnkXlw==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr24158668wrr.104.1615223401334;
        Mon, 08 Mar 2021 09:10:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPagpGsVnOaCHQeGSb/PwYZWcGo1SGrv+aPP1pQ4LRem2ryUxhQF1clMRSwozlnOT1O+X2Xg==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr24158648wrr.104.1615223401185;
        Mon, 08 Mar 2021 09:10:01 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id c11sm19568762wrs.28.2021.03.08.09.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:10:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND 2nd PATCH 06/10] arm64: dts: intel: socfpga_agilex: move usbphy out of soc node
Date:   Mon,  8 Mar 2021 18:09:41 +0100
Message-Id: <20210308170945.161468-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
References: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

The usual usb-nop-xceiv USB phy node should be under root node, to fix
dtc warning:

    arch/arm64/boot/dts/intel/socfpga_agilex.dtsi:472.21-476.5:
        Warning (simple_bus_reg): /soc/usbphy@0: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index f46d678ba775..103de0a91e60 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -124,6 +124,11 @@ timer {
 			     <1 10 0xf08>;
 	};
 
+	usbphy0: usbphy {
+		#phy-cells = <0>;
+		compatible = "usb-nop-xceiv";
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -469,11 +474,6 @@ uart1: serial1@ffc02100 {
 			status = "disabled";
 		};
 
-		usbphy0: usbphy@0 {
-			#phy-cells = <0>;
-			compatible = "usb-nop-xceiv";
-		};
-
 		usb0: usb@ffb00000 {
 			compatible = "snps,dwc2";
 			reg = <0xffb00000 0x40000>;
-- 
2.25.1

