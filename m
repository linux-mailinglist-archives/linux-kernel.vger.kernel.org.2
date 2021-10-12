Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C43429D15
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhJLF1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhJLF1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:27:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0490EC061570;
        Mon, 11 Oct 2021 22:25:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d3so48746610edp.3;
        Mon, 11 Oct 2021 22:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EfIYXeJXZGZiW3ivY4Dr4sfAITBJZpqWFEr5+h+uazk=;
        b=FkikaIAGibnBtXf1YruYelSe1VDn/+a1ZfsU3doIs3YNmJjGp9NfgsO9Vn4BmmYS2V
         oVuYl2v74k/nniglK23j/gW4g4cFPFDkNjLkk/3+0WnYQDl1rHLQuWjjq2dkRDrb2X8+
         ZR0nWtctwLMLMsn1k49NY5TCee292gs2s29SR8qJbNoc+dw7Osu8ya7EZT5iav1wHAe/
         hhQQkohtsL9zAqJB8dVL5aCmkHWLC8pDs9eeA5fSxFjT8Af0UzeGO9Ol5fzPh4oBjj6I
         P4OP1oC7ovRaj+PHlrKRli7sJxbdRy5CwDktfU6DIUjAOgGZyy0YXfghNiDuSPJYfz+I
         812Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EfIYXeJXZGZiW3ivY4Dr4sfAITBJZpqWFEr5+h+uazk=;
        b=3m03ESHNZB8nLBYD5IHsJeKSS2LAvYlC9tvddwIIlbKI5YLoSaf7oU2L5fJxt1L6uo
         POKBSMvQh01qNVcHaWkBz1H6rgAzr3RawBIm/ipxDicNjSQQ4RTauR1fJX5KghuGRJ6t
         X36jOg5rO6bNToDRoYs0ARGrG6dKOUV//4KUvESSWg/0z/4V58f8bxASTb2hjw9xqYrW
         8wXWtx2Dxz1jujd+5gY51JmtrI83+fzDlwOj/yKKgrbFhWuQWPLXr4Js2AqlkcShllOP
         6gaJT0r2WuW01ucamCsKWUlsb+FwWK/LG6x0fZedmd+s+T4Rv5IhqRRO9OaR+XLiAodh
         bxPg==
X-Gm-Message-State: AOAM531OqXb75OApmyPBVzKSIbwivjNcKmiFlhskw1jhEGrCNzSqDd4r
        bIM+yQ15aSk0+csq59N/GhI=
X-Google-Smtp-Source: ABdhPJw7dW7J940dM5tG5LwCQcRqT8cLbGuZ0nKVV+ekHhAM+MlAlpHtoMFkVZi9fJtQNSAxgq7rSA==
X-Received: by 2002:a05:6402:274b:: with SMTP id z11mr48321199edd.151.1634016328734;
        Mon, 11 Oct 2021 22:25:28 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r22sm4323321ejd.109.2021.10.11.22.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 22:25:28 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/3] arm64: dts: meson-gxbb-wetek: fix HDMI in early boot
Date:   Tue, 12 Oct 2021 05:25:20 +0000
Message-Id: <20211012052522.30873-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012052522.30873-1-christianshewitt@gmail.com>
References: <20211012052522.30873-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the VDDIO_AO18 regulator always-on and set hdmi-supply for the hdmi_tx
node to ensure HDMI is powered in the early stages of boot.

Fixes: fb72c03e0e32 ("ARM64: dts: meson-gxbb-wetek: add a wetek specific dtsi to cleanup hub and play2")

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index a350fee1264d..8e2af986ceba 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -64,6 +64,7 @@
 		regulator-name = "VDDIO_AO18";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
 	};
 
 	vcc_3v3: regulator-vcc_3v3 {
@@ -161,6 +162,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	hdmi-supply = <&vddio_ao18>;
 };
 
 &hdmi_tx_tmds_port {
-- 
2.17.1

