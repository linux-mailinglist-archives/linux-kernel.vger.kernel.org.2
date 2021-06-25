Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783A43B425D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhFYLUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhFYLUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:20:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F99C061767;
        Fri, 25 Jun 2021 04:17:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hz1so14566325ejc.1;
        Fri, 25 Jun 2021 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d9gqCuD5ni2TccavYyFi00E72Ezd2BXqhx0V/7CsfXI=;
        b=ZuoLR+kDpc2zFZhmRsg7yjvBGr1kLyyOziNqIsOpl0ezUUainQkPsqU/8YYV6xcU4V
         6eZf0ZkBxFT0DcoSebPjfdkVc6/t3lprKXH2coTgHGLH+cuBpVR98qgTyf71aiY1++mY
         +b2+7sA4F27CgrDQqon9wV5uSiir/OKfmODwCWqvbYEelrNkr4oPYjr6xf/19VM7H1tD
         66mZuu3zZA79dAEFNhpOzn0VGukA2K8j6XznSSJi2hjvkgWTkqd98BtSm7oF+GgMLM6O
         CFckcUBHUFVW0QJ9UPD1M4GELptfPma+83BYGeVi26pSw8vSmqTeVYCkVxlbPytGyZru
         ymnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d9gqCuD5ni2TccavYyFi00E72Ezd2BXqhx0V/7CsfXI=;
        b=qtejFnQnMdYjsnZxF5vYyadVh0pDFQV5WbuOU4gKUGLJJOI94f8VBTXMSAyn/gQV5B
         6I/GPiBJo68sTWFQPUedY3QOnAUXp6Zoyckv6bBYz2Bak5jKeWl6x5lPR6FedtAH85le
         5wGca/mVO+dyAiNtHi7S9opftLZRaIFXvqoEAj3FCdeh2CAJ0jKh82aa3hxkP4AJHkD2
         ZdtvFq/nHHeJQxDzAhhhi1ZVL07cyg7WvFSz309cpLRJEb49TXNoK4gbv5HSg38k541m
         tMOU9IcChmN81Syx/CnTd7ore9AVYDTNw7e9w0wVm8lNnkekl9aGK6tf90zs29DGJAEa
         pugg==
X-Gm-Message-State: AOAM531lRuATAiPhHoIy27iyH0W0eGzLqdW0b6otFLXJJGL9wem4Omfe
        HCzreS2Od3eDxOzKwZkqjzk=
X-Google-Smtp-Source: ABdhPJzsgCRL7Fbs5dKX9EYg+2SnbuaIj4UNtkZ+q0sot3YKBNicaztiVNVY5WviVml+2RLn5GptHA==
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr10129786ejb.542.1624619875126;
        Fri, 25 Jun 2021 04:17:55 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b10sm3731238edx.4.2021.06.25.04.17.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jun 2021 04:17:54 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: dts: rockchip: add io-domains nodes to rv1108.dtsi
Date:   Fri, 25 Jun 2021 13:17:46 +0200
Message-Id: <20210625111746.6269-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210625111746.6269-1-jbx6244@gmail.com>
References: <20210625111746.6269-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible strings below were added to
rockchip-io-domain.txt, but never added to the device tree,
so add io-domains nodes to rv1108.dtsi

"rockchip,rv1108-io-voltage-domain"
"rockchip,rv1108-pmu-io-voltage-domain"

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 9bd0acf3b..1a61a6a68 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -265,6 +265,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		io_domains: io-domains {
+			compatible = "rockchip,rv1108-io-voltage-domain";
+			status = "disabled";
+		};
+
 		u2phy: usb2phy@100 {
 			compatible = "rockchip,rv1108-usb2phy";
 			reg = <0x100 0x0c>;
@@ -434,8 +439,13 @@
 	};
 
 	pmugrf: syscon@20060000 {
-		compatible = "rockchip,rv1108-pmugrf", "syscon";
+		compatible = "rockchip,rv1108-pmugrf", "syscon", "simple-mfd";
 		reg = <0x20060000 0x1000>;
+
+		pmu_io_domains: io-domains {
+			compatible = "rockchip,rv1108-pmu-io-voltage-domain";
+			status = "disabled";
+		};
 	};
 
 	usbgrf: syscon@202a0000 {
-- 
2.11.0

