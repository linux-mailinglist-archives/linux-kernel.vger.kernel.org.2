Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35D30A75D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhBAMPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhBAMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:15:03 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF7C0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 04:14:21 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c12so16322961wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 04:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z39meYOIrJcvImu0d9+1ppKubLWmfZB/Damj7pz9ugQ=;
        b=mhJAPRDLeJG+CgRohjkj6GBCavV1RE6bdoiAB6gS9zPxzQG7EPMD2p2IBAjxPjn0Ra
         1w0y7tZcbqnf/WaqO0KETh63P8UV5MRDh6d7h9x7115MeFgpO2zf89z+8AcFYI5mHT7u
         K12vZ6HDnCGG7NsHA5/J+cVZzNI+z5T1Dt0HpSIqkcpeqYZK2mWh2BcA6dh2rhElR1Y+
         YkDegngOsnRoas0Ia81UWu7w/203bEU17qnS/3ATkjiJ++TUgtu++hXS0XAmpDVjs49R
         UwsGXV+TlNkFF1Ze5uZHcXcXMvd3KNVFc9j6INJQdQXkDnrvR/zD9G8kMks7TRHzSBsI
         DMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z39meYOIrJcvImu0d9+1ppKubLWmfZB/Damj7pz9ugQ=;
        b=jJ2OCV1rHr07eQtLpC3vFrLo7AanMUfYao/ghOXc3ofYP7RPooF7/+LdWCXIX6gIu9
         bsJJjzTc0AcaRa2me8BYwGGORd8DBxQ4VddOBpiscKqbz0IMFWFPwQ2MTLQEl6PahN5u
         pYOoSTI/RBZFGYbgRu27NHYJYceSbnD1azAAxfmtSidgYqlkNnseH/aDyefSMUhtZk3f
         MzJzxWNs3+tZ1Dv7fEeiNKG6vJDn4XKjQ1tOyjB4liKTlm1bVsiglJOih7QFY6qNGhfn
         ikx+1mkLCo7jSMw4oTFdeEG3LNDHDO896LnYQ3t54DaeTQEhS/uqLpxvEC341uf36kYk
         NpHA==
X-Gm-Message-State: AOAM532a/vEUj/QZ6o5+sj4lbomW4CTKmDNhVZViHqPPknRHpOJvo1nf
        NBmD9dZdiSe4gIzaV68xX3A=
X-Google-Smtp-Source: ABdhPJyTShgh28D3j3BlprnPfBjmaF3wX8z7N3nvExat8Z2nhpnh2vnac+tmdL/eDznwmI78wXtcVw==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr18001392wrt.388.1612181660522;
        Mon, 01 Feb 2021 04:14:20 -0800 (PST)
Received: from localhost.localdomain (cpc141888-watf13-2-0-cust663.15-2.cable.virginm.net. [86.14.42.152])
        by smtp.googlemail.com with ESMTPSA id j13sm20698332wmi.24.2021.02.01.04.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:14:20 -0800 (PST)
From:   Bilal Wasim <bilalwasim676@gmail.com>
X-Google-Original-From: Bilal Wasim <Bilal.Wasim@imgtec.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, enric.balletbo@collabora.com,
        hsinyi@chromium.org, weiyi.lu@mediatek.com
Subject: [PATCH v2 3/3] arm64: dts: mediatek: mt8173: Add domain supply for mfg_async
Date:   Mon,  1 Feb 2021 17:14:16 +0500
Message-Id: <20210201121416.1488439-4-Bilal.Wasim@imgtec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201121416.1488439-1-Bilal.Wasim@imgtec.com>
References: <20210201121416.1488439-1-Bilal.Wasim@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

da9211 regulator needs to be enabled before enabling the mfg_async power
domain. Otherwise the subdomain is not enabled and causes failure in
imgtec gpu driver boot.

Add the "domain-supply" property to the "mfg_async" node in DT.

Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts  | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi     | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 21452c51a20a..a8efff2071bf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -157,6 +157,10 @@ hdmi_connector_in: endpoint {
 	};
 };
 
+&mfg_async {
+	domain-supply = <&da9211_vgpu_reg>;
+};
+
 &cec {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 6dffada2e66b..c8eece8f5beb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -62,6 +62,10 @@ usb_p0_vbus: regulator@1 {
 	};
 };
 
+&mfg_async {
+	domain-supply = <&da9211_vgpu_reg>;
+};
+
 &cec {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 7fa870e4386a..31d23099df90 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -504,7 +504,7 @@ power-domain@MT8173_POWER_DOMAIN_USB {
 					reg = <MT8173_POWER_DOMAIN_USB>;
 					#power-domain-cells = <0>;
 				};
-				power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
+				mfg_async: power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
 					reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
 					clocks = <&clk26m>;
 					clock-names = "mfg";
-- 
2.25.1

