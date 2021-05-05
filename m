Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226B03735A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 09:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhEEHdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 03:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhEEHdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 03:33:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6B7C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 00:32:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s82so781881wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 00:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAsKBCUtWvT2TBc5FQFA2vVLxfmKKkbA3qujbzupPfM=;
        b=iINUI414yX3eussPTaoAOO/pvWn2l543f33G792rYFl8TrHaiBlx0oOXjW8Zoru1bR
         m5Nwmv53xQzUcZFoN8y3HJgLUZeBCvtziEGuxH4nhY4t8jwW7IHLgSLbGUjGLeFUlMmf
         zNaOCRRBS1ySiIN+sZv4zMYTGUwYSXZylbFkb9wzX6TCSR4NY/bc6Avan0J097BrbgNC
         ILP3MQ0hccqeSDX7z9Lxz6ikB8U8Sw+Cw3QUmmsQnlEYlsF878h4rXO11Gn53LpJiIfi
         89NVprSE8XcYcM4qXI+8k2yfAZoumAtknaaad1Tq4vENs7GKa6/sqalADa+y0rjeKfp1
         fxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAsKBCUtWvT2TBc5FQFA2vVLxfmKKkbA3qujbzupPfM=;
        b=N3QnJ/0pW7zsdlgTF9DyMWwXM10qigSszFs0kKKNGsQEXe0j2HKFbhaTlqtN4yluc9
         deULLiQ1+tgpqVCvMqXPkoudjGNnDl7gs8E9Zdwzy3i3PSIytAj0YqQOC/W8kU7Ksj/a
         MgWWlFROKYBmXmMi/gz2PjtpjCPIHpCzl24u81SBJG0smyQe2yFBog7iHrsIaUBvVb0j
         bfWsEtyWSrshKrNmcJmGLEp6p+P+Q4KGQI/GadRR5Ev95ShwdEtQxVnRICihoRh8JhUw
         6y7mmtFOL7o+TArCjNVVM9fEkFzNpND4hBQgH5CiWx7nwMYDa2mds2dyZylVtLP2rQln
         kPNg==
X-Gm-Message-State: AOAM532Wh9E8JaF8QFgcgkTQANfixexCjujxghbMwXjL5z33SW8gbyUe
        0+nz/Hg1AkVRGM99t6SCcD66CQ==
X-Google-Smtp-Source: ABdhPJzqHOMYla5K+XJkfuTYUrMwN70FjFmu1iVV0CWcNwNdmacC33Gs82x7AwQkSoUY5EDQEJXfYw==
X-Received: by 2002:a1c:540b:: with SMTP id i11mr8478873wmb.40.1620199972006;
        Wed, 05 May 2021 00:32:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:6eb3:66ab:cb1e:ef0])
        by smtp.gmail.com with ESMTPSA id v20sm4965663wmj.15.2021.05.05.00.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 00:32:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/3] arm64: dts: meson-sm1: add toacodec node
Date:   Wed,  5 May 2021 09:32:46 +0200
Message-Id: <20210505073248.3816183-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505073248.3816183-1-narmstrong@baylibre.com>
References: <20210505073248.3816183-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add toacodec node for Amlogic SM1 SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index c309517abae3..3d8b1f4f2001 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -401,6 +401,16 @@ tdmout_c: audio-controller@580 {
 			status = "disabled";
 		};
 
+		toacodec: audio-controller@740 {
+			compatible = "amlogic,sm1-toacodec",
+				     "amlogic,g12a-toacodec";
+			reg = <0x0 0x740 0x0 0x4>;
+			#sound-dai-cells = <1>;
+			sound-name-prefix = "TOACODEC";
+			resets = <&clkc_audio AUD_RESET_TOACODEC>;
+			status = "disabled";
+		};
+
 		tohdmitx: audio-controller@744 {
 			compatible = "amlogic,sm1-tohdmitx",
 				     "amlogic,g12a-tohdmitx";
-- 
2.25.1

