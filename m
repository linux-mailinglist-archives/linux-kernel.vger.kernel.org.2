Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21E73F758D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbhHYNG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:06:27 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34328
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241024AbhHYNGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:06:22 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0BDB5407A1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 13:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629896736;
        bh=UfizrBJBT6h793qifWAMSREo4JNWpi+qoZht6aRmJGE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZM4WRgEKiFu4emREJsvcpdegETCZbnTLHsMvMgsj4DUKF4e+E8tXzsBYqs8a4bpYj
         gBZZyIbV9Z0Nt8G9TzuiWRNMIna3E442zJRjcpuMr4oZ6+N7fJ3JD6CP0xt6OGCLgF
         uoh5UCwvR067+lUeBzVTNQ8kbC8BEfGMoM1cOCu+KwxiqoaHocsD5wYVcUZEIXM1kJ
         Bow4mbyrC2l1CYUU2WAcmG1fWBZ+T+yU1L6/1Elsrxl2YorXojo4QtkJynsl1HrDs+
         pEr+Ej7N/IUERoAangvQO10m/0is/wQk3iyW0TL7DRbqJVC64iUKCVEYnArWoMyCTT
         PazJpyJWlwAsA==
Received: by mail-wr1-f69.google.com with SMTP id p10-20020adfce0a000000b001572d05c970so4448431wrn.21
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfizrBJBT6h793qifWAMSREo4JNWpi+qoZht6aRmJGE=;
        b=LngHbAAZ9UK/Lq0IUOVwqVoFKmPQemkVNKGRdbNmaJ1Ux7HHL9ATBZLWcPrCYVRJae
         p6CQ2caVTvsEzBupa788eqfqE5+biH9dr87vevkw2YRWPw6sKGo3ToimKPeD9mI5nsZ2
         0jEGTkzjHnuR2CSGVfm7HjYcAGq+WtoL4k+Gg1xWlLLCkq+aGREiwNU0eygL85lebEOi
         pn1SSg+quUO/UPWRhQqqsHNtU6gA8TFl/G9MD9Hq6dOHsUCEdAWDJuzbY79MxPbkIbPi
         v1al380qbBHcTpULdL40xlDXi7rbwghrLWuYfQV006CixIAUTRgH/IQO7ad5wzC2KMp+
         hPBQ==
X-Gm-Message-State: AOAM530f3KzavVk64cUIZ03FUFoRRWbwUt1/PPqZIE6nczuCsatJTKNR
        2KfNtDbmpInpdjLJm3jJcSB2ped43VEtxuaiPH9btrFR1AkxD8J58GCg6tBZKyrL9V9+mVDy6cg
        KY7T2IwtoAt6nB8o6h2lYUAVB6CwyF67iJCcUs1jRQA==
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr18711696wrx.293.1629896734660;
        Wed, 25 Aug 2021 06:05:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLGSV31y+kVM+3CidhWNxCQ29UIuSq21ADvfXfOGHO2Gp5VvBVX5SwObpLHLgExu1hCrgJxw==
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr18711663wrx.293.1629896734471;
        Wed, 25 Aug 2021 06:05:34 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id 11sm5338828wmi.15.2021.08.25.06.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 06:05:34 -0700 (PDT)
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
Date:   Wed, 25 Aug 2021 15:04:50 +0200
Message-Id: <20210825130452.203407-3-krzysztof.kozlowski@canonical.com>
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

