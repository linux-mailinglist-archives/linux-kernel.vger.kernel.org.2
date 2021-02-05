Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCEF3105BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhBEHTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhBEHT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:19:26 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCACC06178C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 23:18:44 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r38so3892415pgk.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 23:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cThBBHhfisbdUPR0BkCKaJgx6RZfF0oevqoz0x7YcXQ=;
        b=gs7kBuH9Kl2Esc4hMGZparVZwOgugR9fMHaIj/vMqeARwLiB+DD6trkrhEWDltv91m
         LngB76WnruOTsnwJd6m8W6cZkeVEfhUjzNei/e4OA42Ap1JhPN4i3rnIx9sPrzENRo3a
         4bu9FswKSpiKzu6PoZ5Gj1wjQWMe9ruXQ99jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cThBBHhfisbdUPR0BkCKaJgx6RZfF0oevqoz0x7YcXQ=;
        b=brqGsNlPq6ZdHnM9Cn2JqJgaxs8J0bs47B0DR7YVJm8SzCY2sh+ivK8J28bUpaUuwS
         JxN0ONYCXAHEvcRZrL45HdLig+U4YPCODtQ6C+dzZfcSCRE8UlSynAJpVd3ZwCDP2f0D
         lU//Qs1Vn+3BeC+wtKem3PbdGd3kwmkcnXsGnAye/LaHE/NAJaSxJjGOPm5HO3AcxYaq
         xVruQFK2QVAOS4SP54D7ehWiZUnNDFDIRiIsOU6/3b016BUkfoLSnGDYhhgXuiQpTOqd
         3NB0DL/2/2vr/yYNQTGwZfyp2NRIO4HAk5NvoHhlu5TwkpXd/MzzTQXPQ8ePk20/gw6n
         v99g==
X-Gm-Message-State: AOAM532j4KV2hRQahuDOqZsIPDt2QUf6iFOnKMKwRgIheq142QiX2vTG
        nZcrKEjAK1jx0KLh0lx6kG5sdQ==
X-Google-Smtp-Source: ABdhPJxVTkGhbC4mb8o4v/jbnmCm1Zn/84EZDxDHwP99CjSL5G3+3Z+E4oZSCPRdCA7E7eTYRJE58A==
X-Received: by 2002:a63:5d59:: with SMTP id o25mr2963041pgm.322.1612509524491;
        Thu, 04 Feb 2021 23:18:44 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ed70:6d43:9c6a:2e22])
        by smtp.gmail.com with ESMTPSA id oa10sm6292028pjb.45.2021.02.04.23.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 23:18:44 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] arm64: dts: mt8192: add gce node
Date:   Fri,  5 Feb 2021 15:18:32 +0800
Message-Id: <20210205071833.2707243-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210205071833.2707243-1-hsinyi@chromium.org>
References: <20210205071833.2707243-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

add gce node for mt8192

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 9757138a8bbd8..1afa6ad06b2b8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -5,6 +5,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gce/mt8192-gce.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
@@ -291,6 +292,15 @@ systimer: timer@10017000 {
 			clock-names = "clk13m";
 		};
 
+		gce: mailbox@10228000 {
+			compatible = "mediatek,mt8192-gce";
+			reg = <0 0x10228000 0 0x4000>;
+			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <3>;
+			clocks = <&infracfg CLK_INFRA_GCE>;
+			clock-names = "gce";
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt8192-uart",
 				     "mediatek,mt6577-uart";
-- 
2.30.0.365.g02bc693789-goog

