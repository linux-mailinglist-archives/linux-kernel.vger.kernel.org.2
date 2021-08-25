Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E753F7591
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbhHYNHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:07:39 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34412
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229547AbhHYNHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:07:38 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C992B40658
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629896811;
        bh=UfizrBJBT6h793qifWAMSREo4JNWpi+qoZht6aRmJGE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=A2W4AryX4NTH0WVxK6QsedWktL33EOVUmb8UfSxS1efmWnuG6aWHzZR6jB/4Ud1fQ
         Q16yGLR7j8bNtFIxO3KcqbjOhlC4b75poK7s+Z76i9JV75i7mDmvUbGZzxIK+2EOJE
         IvBo0mjd8pEgoYBE1io5lQVKE1uL4ojgdry8Yq80+CgdzcXn0zKcgkAvKHkHMEKIwx
         ayBSGVynKHVe1DfmOB+y0IM0fap/d7V3yL398PwqIpGAZyewpY73lr0KvktfTpfjjD
         1b9nTNNwKyQMY+E0DqGPvbTMKOi0LYC0PjMkRn2B5GUu8xNr8xjbiya90BtQFKf4sp
         sBdaPTGQu9OLg==
Received: by mail-wr1-f69.google.com with SMTP id d12-20020a056000186cb02901548bff164dso6608280wri.18
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfizrBJBT6h793qifWAMSREo4JNWpi+qoZht6aRmJGE=;
        b=sLXNmzgKYiBkl+tSKpDQ6uhVeIhIjFDhYCcO4k7o0cbPJVRhatk3JvTDKDsasw3VEO
         +LxVxO3JtA1KPkQYdRt6DflGTDvJLBJwRpAJ+Y6Y3Mp41g/11xYMs+vhXb4ecNmSCS98
         5l3ZRD8LpRrByDYFW78JfIvZjNqJXdoLcj7bmcrgavMNoOyKLPLSHTiKKCWrpeaCKtNE
         LkurNdY+F+8AsLY6k1GIlRpDN7+IL5hJbbJLppNiggRKFKbShjUSN4yn0UZRO8TBLOS3
         5rpaEcbRYiSAuhnYlvEOX1cgAWlb+ZmoghJZfrFDV/s6wrX/V/DcyxJ1WtFKwmqs3+eO
         TiKA==
X-Gm-Message-State: AOAM530SDSLvv9PX/I9unVV1xqxmB1sPJ3VAPny4dmD4En834xWxoJqP
        HcfBkiGkrW1qRieJ8x8dYKvLqj676/TOikByUtYR12XpSfFGvKG/rIveU502vtlOvSYvAJlX8MH
        uaq7dRn2wQc8OCwi7PBd3nIcUnKpJV763mPbmMUU8Vg==
X-Received: by 2002:a1c:40c:: with SMTP id 12mr9149928wme.158.1629896811090;
        Wed, 25 Aug 2021 06:06:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzixd6QysPlsvWL7nertMLrUP2YTQueOD1OTVHyup8rVWyTa/PXx9YKm+yhpgfRrSNjfxxakQ==
X-Received: by 2002:a1c:40c:: with SMTP id 12mr9149906wme.158.1629896810959;
        Wed, 25 Aug 2021 06:06:50 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.15])
        by smtp.gmail.com with ESMTPSA id r20sm13300842wrr.47.2021.08.25.06.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 06:06:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Atish Patra <atish.patra@wdc.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] riscv: dts: sifive: drop duplicated nodes and properties in sifive
Date:   Wed, 25 Aug 2021 15:06:04 +0200
Message-Id: <20210825130604.203601-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825130452.203407-1-krzysztof.kozlowski@canonical.com>
References: <20210825130452.203407-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTSI file defines soc node and address/size cells, so there is no
point in duplicating it in DTS file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. None
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 5 -----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 2b4af7b4cc2f..ba304d4c455c 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -8,8 +8,6 @@
 #define RTCCLK_FREQ		1000000
 
 / {
-	#address-cells = <2>;
-	#size-cells = <2>;
 	model = "SiFive HiFive Unleashed A00";
 	compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000",
 		     "sifive,fu540";
@@ -27,9 +25,6 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x2 0x00000000>;
 	};
 
-	soc {
-	};
-
 	hfclk: hfclk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 9b0b9b85040e..4f66919215f6 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -8,8 +8,6 @@
 #define RTCCLK_FREQ		1000000
 
 / {
-	#address-cells = <2>;
-	#size-cells = <2>;
 	model = "SiFive HiFive Unmatched A00";
 	compatible = "sifive,hifive-unmatched-a00", "sifive,fu740-c000",
 		     "sifive,fu740";
@@ -27,9 +25,6 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x4 0x00000000>;
 	};
 
-	soc {
-	};
-
 	hfclk: hfclk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-- 
2.30.2

