Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC42402D11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbhIGQr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344886AbhIGQrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:47:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BC8C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:46:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so1931911pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zxeKOcsz9PYV/EBnoSP2OdS5qZkC/DOANNRm4GawZs=;
        b=EQY9LK0nlvbjdUDnGXYe/WMeXa86iXkGcxnQ5KO02Msq3CWuYqZAizkmwMyuJ2efAI
         DCEZDEoJCZMjfKabsFLEeoSYk8j18WhslDWHa8IMJaSLQ6iLe+mJFpAdtRrb1WfeQY9+
         ziEmjymz4N5LUDD7tEzIEkfCzmCGkDYFWxtn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zxeKOcsz9PYV/EBnoSP2OdS5qZkC/DOANNRm4GawZs=;
        b=OlY3PAbkuzVEBdvug5MNb12TSukg1cge0N9AZ7RIyWtfyOVhKxkCbHAgPQFdeHdgmz
         EO0P/vB8UlUymkolwrx2420ys2dYoXt8lJHJOT3IlvN5jQ+evT9L5rb//s38n6DemEru
         oPonMiiYcDDC2uNkyewXVYc1CvUyrbXrjWM6WpoRbTNGLgee67rqfHCnoXZFr8zSO2N8
         ly45r0yacdgAQ1ahcGushOQaCoLOb2OjwqajgdzmGFIvLjgF+EoHKiwlWibD953+p3YM
         bd1tCAuKklHKkyTBhMjUEn4eWZvpg2HOL39bXqtSCy2JSDfvCYrw+KY7hwXbo7/HcxHS
         F8dA==
X-Gm-Message-State: AOAM532ymwd7M3UF/sw/BYVcTYjMQ+AUDSzsuCR2JberiFsDjnT7HR0O
        o2jA5MIUHuQjI6RFPhUzP3mdIahlPp7KwQ==
X-Google-Smtp-Source: ABdhPJzAMHxXX/5MzVpqqGR29iBTi/HayR0Rhqwnp/SejsqPflp4g9rejxSjXlgRIy9kau67KDbCZg==
X-Received: by 2002:a17:90b:1bcc:: with SMTP id oa12mr5465114pjb.241.1631033208783;
        Tue, 07 Sep 2021 09:46:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7662:6d8e:510:db67])
        by smtp.gmail.com with UTF8SMTPSA id ml10sm3253767pjb.9.2021.09.07.09.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 09:46:48 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [RESEND PATCH 2/2] arm64: dts: rockchip: add Coresight debug range for RK3399
Date:   Tue,  7 Sep 2021 09:46:37 -0700
Message-Id: <20210907094628.RESEND.2.Ibc87b4785709543c998cc852c1edaeb7a08edf5c@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210907094628.RESEND.1.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid>
References: <20210907094628.RESEND.1.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt.

This IP block can be used for sampling the PC of any given CPU, which is
useful in certain panic scenarios where you can't get the CPU to stop
cleanly (e.g., hard lockup).

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 48 ++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 3871c7fd83b0..c8c62637b600 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -433,6 +433,54 @@ usbdrd_dwc3_1: usb@fe900000 {
 		};
 	};
 
+	debug@fe430000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe430000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l0>;
+	};
+
+	debug@fe432000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe432000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l1>;
+	};
+
+	debug@fe434000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe434000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l2>;
+	};
+
+	debug@fe436000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe436000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l3>;
+	};
+
+	debug@fe610000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe610000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_B>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_b0>;
+	};
+
+	debug@fe710000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe710000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_B>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_b1>;
+	};
+
 	cdn_dp: dp@fec00000 {
 		compatible = "rockchip,rk3399-cdn-dp";
 		reg = <0x0 0xfec00000 0x0 0x100000>;
-- 
2.33.0.153.gba50c8fa24-goog

