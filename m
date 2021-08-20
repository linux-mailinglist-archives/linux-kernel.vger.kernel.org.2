Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DDC3F2857
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhHTI0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:26:17 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46278
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232383AbhHTI0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:26:16 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 99C204076C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629447380;
        bh=rFYV7pHtPVAhRCoujACv0nbWtGdLJ18YOanrxxZY/lQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ENhS/boz7O5nErTumJsWMhmVKGE3En1BTsOfI88J/gLC22zyViUtMgCP3qW0Ggovq
         qlMHzbkXMUNwkQnWJIlULdxvZJTrDsUAK1IUqAEFVDVymbtj8rEzJP7w1xvm+HpemV
         We87/JOq8U4bUweX85eXD6zIj2n8U/0agtjXqkZNSAqbTUWUu+N+RGrVuPnDKm61rG
         GQA4VLZg/VXnhygu+h+JaOI5ieu+9+L6tv9C9Eu0ofOl15TysBonGh5Q9q9ATHRWv1
         pBfawvA6CZy9Y1XLZd5OmcRYoLRiZfKCdW/pFk4Gdhf8Re4dY8n7gMMda3awBXQIJK
         vfAdTtk+Y+MqA==
Received: by mail-ed1-f72.google.com with SMTP id b16-20020a0564022790b02903be6352006cso4147930ede.15
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFYV7pHtPVAhRCoujACv0nbWtGdLJ18YOanrxxZY/lQ=;
        b=tYxPT9OSbGyN+n4uFnG99kPakdtk4KMYPXq/VzyZjULfVBsmm/HjVa6olZOoJNN4+0
         OCizTu7ADGCNp7i46zQ/8yGMat55ReQsk96zRk2KnhU7fl6xvXAGWZAltUplXoa8G5Qy
         VPF2e18dASTjaMrDv+w6ZLek1PUPlWDkxthnpf/K2dWEaxtKo0xXgTE2etIhZSstYzuv
         VPANytIBNMAqOe2KJQIRYYs7GLm8NEzX0ahW8/v45kmVh+nkrOKAyhD5DK6h1wGnQBMt
         3PVF3cAc3QwfoGe7LewnTiAmTUCHevHHgJcok27Ks99ZqYsmdTeGJqsY46+7Qka1ZL2w
         Wpfg==
X-Gm-Message-State: AOAM53125XpQKZC8V5LvpqOcMXMixvWUC8s/VnRtTDDh7CoFRWCJHxq6
        RlpUG1SEi0aahqrkqeZ54PsXvQU6Avf5cwAjDvgBG56tF3BoR87XP9bHe15GQIngk7EsAKq/1CC
        qLMBvM17tzkSWqpKC9/PmofsIyTkHLBW6LjI3k8LNDw==
X-Received: by 2002:a05:6402:13cf:: with SMTP id a15mr21006886edx.117.1629447380409;
        Fri, 20 Aug 2021 01:16:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhFPcjbeXROTX7e6+Upaf75ZvqQGL1rcjdhNt9+IdhuGxzIbim1t5Pp3fsAw4KLjqKWlg5QA==
X-Received: by 2002:a05:6402:13cf:: with SMTP id a15mr21006874edx.117.1629447380301;
        Fri, 20 Aug 2021 01:16:20 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id w13sm351632edx.67.2021.08.20.01.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 01:16:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] arm64: dts: mediatek: align thermal zone node names with dtschema
Date:   Fri, 20 Aug 2021 10:16:16 +0200
Message-Id: <20210820081616.83674-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210820081616.83674-1-krzysztof.kozlowski@canonical.com>
References: <20210820081616.83674-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the name of thermal zone node to dtschema to fix warnings like:

  arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml:
    thermal-zones: 'cpu_thermal' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi  | 2 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index a9cca9c146fd..640d4fdaa611 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -19,7 +19,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	cluster0_opp: opp_table0 {
+	cluster0_opp: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 		opp00 {
@@ -36,7 +36,7 @@ opp02 {
 		};
 	};
 
-	cluster1_opp: opp_table1 {
+	cluster1_opp: opp-table-1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 		opp00 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 49c6b6a5b489..066025d80ca4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -273,7 +273,7 @@ cpum_ck: oscillator2 {
 	};
 
 	thermal-zones {
-		cpu_thermal: cpu_thermal {
+		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <1000>; /* milliseconds */
 			polling-delay = <1000>; /* milliseconds */
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index caab109add28..d836769b87bb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -759,7 +759,7 @@ thermal: thermal@1100b000 {
 		};
 
 		thermal_zones: thermal-zones {
-			cpu_thermal: cpu_thermal {
+			cpu_thermal: cpu-thermal {
 				polling-delay-passive = <100>;
 				polling-delay = <500>;
 				thermal-sensors = <&thermal 0>;
-- 
2.30.2

