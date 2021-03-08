Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AEF33143B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhCHRKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:10:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33148 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhCHRJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:09:58 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJJOH-0003Is-M2
        for linux-kernel@vger.kernel.org; Mon, 08 Mar 2021 17:09:57 +0000
Received: by mail-wr1-f71.google.com with SMTP id y5so5106935wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9i/YWiyyb5PdwLe3ZFYzqCtKS3WIBfWL6NqlaTWQyU=;
        b=mD3XZMJmU7t/u+PHtiitaoP3SZgeeMcAEFBQ2O9ecIoEctGw+aMumFQdP9DLC3E9fj
         W0E4v7liF17MCMcjoPaYyL3L7xSOyqnhoTgZ5/cfiR+7CzprLPfXyXyhrlc760Kf/b48
         taYv6+MVdQ/kGHAl38vVxRpwupPYi0B7vEuoX74NWwQK1KanmbBYGfjODlbb+ze74V6F
         C3EL8RPQ3Xtk+TPB7GAdmIkJ5D0ucU+j8YlD+AHtru4ix3VUnPJIIDFYfu0j4YjYIZQE
         FPs32A0gTXB/z3nMUP1eNL3sRus7Hp+HFLkHfsqu1/vhnEbey66Jy4ccJLgGQ3/frWkt
         x9rw==
X-Gm-Message-State: AOAM5307Mv4zY4sSt+LH0u8GdJrjZFlXcqp/AuLZ0xrvklNiOqIRZ3Z4
        NQMdA6jPeASGRIjUnRgDVNrytsGrgKFwtl93rryAJxX/kr+2bZxmHUCOBpOUI55xd8snZ0r7WEy
        +ja+sJdexyKvVK0G9n6vDYt3TFwDU8fKg4G3qe8BcMQ==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr22923214wmg.97.1615223396993;
        Mon, 08 Mar 2021 09:09:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWzaztVdULD9g4Zbto/QrUTn46X9bgseHYTyzXeTjQCkYwdkvR7xsi1fOdNe3rkKa5+Za85A==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr22923197wmg.97.1615223396876;
        Mon, 08 Mar 2021 09:09:56 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id c11sm19568762wrs.28.2021.03.08.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:09:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND 2nd PATCH 02/10] arm64: dts: intel: socfpga: override clocks by label
Date:   Mon,  8 Mar 2021 18:09:37 +0100
Message-Id: <20210308170945.161468-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
References: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Using full paths to extend or override a device tree node is error
prone.  If there was a typo error, a new node will be created instead of
extending the existing node.  This will lead to run-time errors that
could be hard to detect.

A mistyped label on the other hand, will cause a dtc compile error
(during build time).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts   | 12 ++++--------
 .../boot/dts/intel/socfpga_agilex_socdk_nand.dts     | 12 ++++--------
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts      | 12 ++++--------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index a7a83f29f00b..f14a89ca8784 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -41,14 +41,6 @@ memory {
 		/* We expect the bootloader to fill in the reg */
 		reg = <0 0 0 0>;
 	};
-
-	soc {
-		clocks {
-			osc1 {
-				clock-frequency = <25000000>;
-			};
-		};
-	};
 };
 
 &gpio1 {
@@ -92,6 +84,10 @@ &mmc {
 	bus-width = <4>;
 };
 
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
index 979aa59a6bd0..58a827a5e83f 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
@@ -41,14 +41,6 @@ memory {
 		/* We expect the bootloader to fill in the reg */
 		reg = <0 0 0 0>;
 	};
-
-	soc {
-		clocks {
-			osc1 {
-				clock-frequency = <25000000>;
-			};
-		};
-	};
 };
 
 &gpio1 {
@@ -121,6 +113,10 @@ partition@4280000 {
 	};
 };
 
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
index 5f56e2697fee..01f1307ce4ac 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -23,14 +23,6 @@ memory {
 		/* We expect the bootloader to fill in the reg */
 		reg = <0 0 0 0>;
 	};
-
-	soc {
-		clocks {
-			osc1 {
-				clock-frequency = <25000000>;
-			};
-		};
-	};
 };
 
 &clkmgr {
@@ -44,6 +36,10 @@ &mmc {
 	bus-width = <4>;
 };
 
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.25.1

