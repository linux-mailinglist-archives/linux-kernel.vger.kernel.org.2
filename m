Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CD331445
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhCHRKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:10:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33324 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhCHRKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:10:07 -0500
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJJOP-0003T3-PF
        for linux-kernel@vger.kernel.org; Mon, 08 Mar 2021 17:10:05 +0000
Received: by mail-wm1-f72.google.com with SMTP id c9so2281401wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PW2gwp+ApGkfA4Yw2lCHp6cW3AKSzP0k9Br5Vr8VeB8=;
        b=A47Ld+vcUnIheinB7iWGjGOubSp9JE2jofyVLZEBjerQCnwAjK+t0+Je+xywXTpTeE
         TEoKsZZngCWlhifO+9z5XQVq8QeNfH0IfKFu7J42DG4yCFJGQISzm7S/v33bbNe/gieI
         WxodC0roFqWKwu4jP+QPromcCDPeAlkFHpub2lLYJZLprTmrvm8fqVbzgXwQ/smCe4hr
         jkyeOR3jMeo3ByWzfqEUi/Cz8VtUp2un+fvDX/XU8+sB178ERqcxwNt4EIpYY5YrQcH4
         /DBhd0NoXov31kVi+jPWvt02+yMWdhfDi+aBEcqxwqYs0vpPW3dtXergwehTPROHp2lS
         fH5A==
X-Gm-Message-State: AOAM532CtzHf3eCsuGwl/qVdy8idDlxhp8SdRFQd6VK0rZTOHaf0umOW
        Vo5kL1psIk3E4rCuKKbZfh3XohHhyWEJouXQ+10mMp1BX/QhVnV+3Wmq/D8GjRzVNRn7TkOUXFt
        5Mdw6VbJ8NPuJn1P/K5fSkrQ3/8ke6ZEGJJ3owUnGmA==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr23783103wrq.39.1615223405493;
        Mon, 08 Mar 2021 09:10:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyngFHucjuFwjLrIfUgXmRE9UU0tfjT6g7o8cF8UxJ/wVkfhO8iMRULHVDy+UA6+IGoMpCOwQ==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr23783090wrq.39.1615223405390;
        Mon, 08 Mar 2021 09:10:05 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id c11sm19568762wrs.28.2021.03.08.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:10:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND 2nd PATCH 10/10] arm64: dts: intel: socfpga_agilex_socdk_nand: align LED node names with dtschema
Date:   Mon,  8 Mar 2021 18:09:45 +0100
Message-Id: <20210308170945.161468-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
References: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Align the LED node names with dtschema to silence dtbs_check warnings
like:

    leds: 'hps0', 'hps1', 'hps2' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
index 58a827a5e83f..cc2dcabf34e3 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
@@ -20,17 +20,17 @@ chosen {
 
 	leds {
 		compatible = "gpio-leds";
-		hps0 {
+		led0 {
 			label = "hps_led0";
 			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
 		};
 
-		hps1 {
+		led1 {
 			label = "hps_led1";
 			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
 		};
 
-		hps2 {
+		led2 {
 			label = "hps_led2";
 			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
 		};
-- 
2.25.1

