Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055453F285F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhHTI02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:26:28 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52574
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232664AbhHTI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:26:19 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CDE04407A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629447379;
        bh=OmtSKxexi252yLpsd09SnFUuzqXU2/zeUXsYaGlChyE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=pmN7qgHi+EARqniZH47Yo17cxIVOm/IfX3R7dZro17DaQWzlGaAbNEkj8szan4gCb
         lpe0S1v0TW4zc01rnTbF0V3i+D3kznsuWZBHGIzg+k6ldxePImRO3Y8ri5qujO0/d3
         BmvNMwq42rRH8rsQZNVnO49+7HIlLGy7m4nHmH2+a31e/X3McNbRmvXaE8geIzvTip
         XZpGlyI256ouiQvMlCURAVZ9s8fROKILiMn9KPOysSvTLxExGHRjnwa5IPZpFktRGI
         4gUFndtKkcLzT1lKTytUzWeSIZquzo8C/8snlz6MGJYBu1R1dir5GkS7Su6FW23MbV
         LmxrR1gur0EoQ==
Received: by mail-ed1-f70.google.com with SMTP id b25-20020a05640202d9b02903be7281a80cso4170557edx.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OmtSKxexi252yLpsd09SnFUuzqXU2/zeUXsYaGlChyE=;
        b=L/75tAlAndq5WalLnyy0frxZcPvNHzYFLTXZSY13WrZHVMJJhOk1LQNtAaPXgZeBZi
         lcgC6B2CkKQc04BznzggrSu33VS0aG3MJiV8Ep/D3ohJGiIaWGb79O3NFzGEW5rgt+cm
         lL1T1i5Nv9IcDkoqvd8vIGrv73N3F1J2GVmTFrCj1nboMTl7menWDZjb/jhU+qF96Mg8
         +hOR6yyP2WgAnF+hopiYG35UaWztdX4Y36M7vUfZuG3CExjRA5QZL1CwdUh8CEXmmxxb
         QtNbwg4zzlvFNMYvoibg9CxceSJkospEjpN2O01mHIkPsG0ze0jC3NPoeYivmVUyt1WU
         6Qhw==
X-Gm-Message-State: AOAM532kyCmytMAlc2Gk3M2B1peCBaaE/gWU4JySGmmoFApS1uNCNR+Z
        GLGtoljKAJatV90vp6N6nws0OZ47KIsh/ub6p1CNRJ7nUb75Wj676S6kH7WEzJPaWuZKNhOURk+
        UtfgFQyW9+QxTtloUx+jwx8AZ+Sk4zz8m0WF7bJ175g==
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr20736023edu.221.1629447379438;
        Fri, 20 Aug 2021 01:16:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCE7w2Hupb+KqkRVqDnp7hgDcT/qC/auwCzygTdxXxygjTPKNmYAIQZ65smv9XcUCZyL7j5g==
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr20736014edu.221.1629447379330;
        Fri, 20 Aug 2021 01:16:19 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id w13sm351632edx.67.2021.08.20.01.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 01:16:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] arm64: dts: mediatek: align operating-points table name with dtschema
Date:   Fri, 20 Aug 2021 10:16:15 +0200
Message-Id: <20210820081616.83674-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the name of operating-points node to dtschema to fix warnings like:

  arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml:
    opp_table0: $nodename:0: 'opp_table0' does not match '^opp-table(-[a-z0-9]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d9e005ae5bb0..49c6b6a5b489 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -57,7 +57,7 @@ aliases {
 		serial3 = &uart3;
 	};
 
-	cluster0_opp: opp_table0 {
+	cluster0_opp: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 		opp-507000000 {
@@ -94,7 +94,7 @@ opp-1703000000 {
 		};
 	};
 
-	cluster1_opp: opp_table1 {
+	cluster1_opp: opp-table-1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 		opp-507000000 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 409cf827970c..caab109add28 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -197,7 +197,7 @@ CLUSTER_SLEEP1: cluster-sleep-1 {
 		};
 	};
 
-	gpu_opp_table: opp_table0 {
+	gpu_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-- 
2.30.2

