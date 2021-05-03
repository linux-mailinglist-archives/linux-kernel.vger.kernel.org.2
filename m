Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96737175C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhECPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhECPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:01:12 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EFAC06174A;
        Mon,  3 May 2021 08:00:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t22so3843583pgu.0;
        Mon, 03 May 2021 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8Jx10fBRRAyAXqe89r614y4Nn3d7ekioAosLYfsorI=;
        b=b7hYVY9EtToaTOGKclQPTp+d9zBrF4cdxYNSxyO1kcgFjclhVrmEwUwSmOS3Zx8Bia
         UdA1pqZRGbBoz3v6Lp7KHnK0a9+SCEj/LujSJ2A7p6Y3Rkc4PQqkz8GbMupYTw+z0/Ks
         tu1u5Y24juPE3o8wc/7FAvTqTPKj2VwFO2AGM36lw3en7rwtZKymjZa7APjjwyqtHVYH
         oaD12RLad2AbRYXjU7Dn4fSYDa1oVHTcVwd8IQV9rjquP+Nm/FATub4HqT17YzUz/1Er
         pSIG94uPM5avTvBq/0N/hAUX/WWiH/GZIunka2RP8A3TgkfaWwMYIMEemDesWBfBF1Vx
         9V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8Jx10fBRRAyAXqe89r614y4Nn3d7ekioAosLYfsorI=;
        b=ZoYbfhOgujkSm7Juf5MovfrirEGYN5P7oM+xs++sulJUM9a7XMEycWlL4r/uz1adDa
         rYgqdCTNaMrQaFzhqok1tinmDaPGztOgwFyEzRsyoqxWBbaxZWcPynQZcyduvQFesIkU
         SfZ31d78cnx7Z9M7/qKKuVH9LSnzRaYcnywqcPikzub2iAD6eY/qDy2tO34KsueCiofK
         159pYBnzfMP0vnt6MjMr134rLRSHon7u1BErwZvgKnTuR1KfGIqkNn8Q58shG/Rr0seH
         lmwCFxaer4PWwnbz97wVYyD6jNQ57RT6ujoWgpPg9OxLdp4SK0dGEpJPTM06UyGCSVKC
         4nlw==
X-Gm-Message-State: AOAM532K5R1RkRRDpvEYjjZHNqf+QHktIua5eckIEVls/nyPd8S/2ePc
        SKvI5ajgk1d2H+nee7jToNDnT/YfIKk=
X-Google-Smtp-Source: ABdhPJx3q9BKW8sqHNuANBAOlnyBhQXNL8PyteBe5Hx29D5qoeiRpfob5mXAYIDoxwcbOFXEx0/Zcg==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr18671591pgp.338.1620054018554;
        Mon, 03 May 2021 08:00:18 -0700 (PDT)
Received: from archl-on2.. ([103.51.75.154])
        by smtp.gmail.com with ESMTPSA id k38sm3593983pgi.73.2021.05.03.08.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:00:17 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCHv1 7/9] arm64: dts: amlogic: Add hdmi power domain for sm1 sbc
Date:   Mon,  3 May 2021 14:54:40 +0000
Message-Id: <20210503145503.1477-8-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503145503.1477-1-linux.amoon@gmail.com>
References: <20210503145503.1477-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hdmi power domain id for hdmi on sm1 sbc
to enable hdmi power domain via "pwrc" controller.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index b16a9a2b6cc4..fd8544d0150f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -347,6 +347,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_SM1_HDMI_ID>;
 	hdmi-supply = <&vcc_5v>;
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 0ca72b000105..c9fc51d81fca 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -413,6 +413,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_SM1_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
-- 
2.31.1

