Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE943A06E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhFHWcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:32:43 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:42724 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbhFHWcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:32:39 -0400
Received: by mail-qk1-f174.google.com with SMTP id o27so21871032qkj.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cH/M8hML98gLh8w+CTkpmO+RznC7BLW0JshH/2U89MM=;
        b=gaeaJcXtCHi2LjfYTKJF92D0iJmI0eBUZX9Wx31ODbJw9wCkG5tuYU8pN+ru++udBq
         nEjWgm5txPHHjIEyBE3SGNPg+UqL6xIId7dWSYNSAKGTVb64gcmAt5YdnsuUh+22AthW
         4PolUglQk5HDQFTjr4tV4D2j97Bob8977MrxqyEugM57j4nhrkzKtuM+nQYmrFYqOy4n
         fN67xSra70Qzs9ygcL+4pD6+P931wRedwo8j/htyqSSfw+J5Xq3MEHsnPM7pNWerFj8p
         wPmWH/nRzhuXy5y9yusgL9VU7eZPZnlZl24HnJDh9t1dsbnIH/4gLhve23ailyT6sYKe
         aezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cH/M8hML98gLh8w+CTkpmO+RznC7BLW0JshH/2U89MM=;
        b=Yj5c9ou5LK47dGidJ4uP81wb6iQISSLA0FMy1pk67sG4SQ8NJta85BJs2ThWBlFoMq
         fWvpOwI3sQAnAnQ2hgcE+GiLte45EMkUeHUqeQd6FCQnhn1AdQwXs2V4Sf6D3+/QDsne
         B92y2pdz3F7usn1Ti6YmrjMRwii0YO4IhHHY8C0aZzpeek29Yd6GvTrnhj06qp6lwLEa
         obuRVRPYHhO3VMZGw05mo4Flo5LIZLzcjRKKobm3Pm3O5630IXxnKyGlvpvFvR3nXes+
         lastQsJcnbz2V6Eb1vZve+ddjX1pBzmpeMhsKwDoViIbTkMxyKqqOA+nnZwXrM24d3PN
         mQIg==
X-Gm-Message-State: AOAM530R8X4xzvlUB3GzwksCwxs/rglATONPkgCbcwsf2wSUq/9seJYr
        /X4ZgxHPxlv7PiL+x/QC3wP9xg==
X-Google-Smtp-Source: ABdhPJzzPv33n8TyS0JmOTg0ugsTAWEwo3D9m79ayv2QjS8XIcBIWdg90fzWkWpUKMDvYhe0lgAxjQ==
X-Received: by 2002:a05:620a:1454:: with SMTP id i20mr22818025qkl.91.1623191371612;
        Tue, 08 Jun 2021 15:29:31 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h19sm10450736qtq.5.2021.06.08.15.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:29:31 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 4/5] arm64: boot: dts: sdm45: Add support for LMh node
Date:   Tue,  8 Jun 2021 18:29:25 -0400
Message-Id: <20210608222926.2707768-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608222926.2707768-1-thara.gopinath@linaro.org>
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LMh nodes for cpu cluster0 and cpu cluster1. Also add interrupt
support in cpufreq node to capture the LMh interrupt and let the scheduler
know of the max frequency throttling.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0a86fe71a66d..fdd8d816f728 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3646,6 +3646,24 @@ swm: swm@c85 {
 			};
 		};
 
+		lmh_cluster1: lmh@17d70800 {
+			compatible = "qcom,msm-hw-limits";
+			reg = <0 0x17d70800 0 0x401>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,lmh-cpu-id = <0x4>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		lmh_cluster0: lmh@17d78800 {
+			compatible = "qcom,msm-hw-limits";
+			reg = <0 0x17d78800 0 0x401>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,lmh-cpu-id = <0x0>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		sound: sound {
 		};
 
@@ -4911,10 +4929,13 @@ cpufreq_hw: cpufreq@17d43000 {
 			reg = <0 0x17d43000 0 0x1400>, <0 0x17d45800 0 0x1400>;
 			reg-names = "freq-domain0", "freq-domain1";
 
+			interrupts-extended = <&lmh_cluster0 0>, <&lmh_cluster1 0>;
+
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
 			clock-names = "xo", "alternate";
 
 			#freq-domain-cells = <1>;
+			qcom,support-lmh = <1>;
 		};
 
 		wifi: wifi@18800000 {
-- 
2.25.1

