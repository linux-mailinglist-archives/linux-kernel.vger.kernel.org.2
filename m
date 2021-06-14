Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C6A3A6A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhFNPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:30:18 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:40557 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhFNP3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:09 -0400
Received: by mail-ej1-f50.google.com with SMTP id my49so17363819ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYGZF49MjT7i5w3fmNxO/ET73BwTfzszWq89gXPfkBM=;
        b=eDLXVfeQkTItrHFS4Okof14N9bQ3B/cc02jrI0kM1e3aswVv4g27Jso5sm09xCI1mA
         sMAA2j9F+fwLeqbDylpTw/A5JpgItM0JopXe9HYyr6pEkj2yRh+T+w/QsMmWPy4/aWod
         3KyEa2Y1C+dnon3LBFCkKKDCrQixJHecpLxzQkrJTuIQH/bWAGm+yBsXeD1hXhRckq2G
         9eLLKPzqfPBHZBID2mItFL+omUM6jCVg8vR3j4d+hd1fFCvZZPOtj/j0gx5BwWBjGnw9
         p5rQZb2QAPgMY0n+CekKC6ALyei6UvkKRetRjOfWjW3Gs1/Y2/uQgMMN35RZ28590aYh
         BhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cYGZF49MjT7i5w3fmNxO/ET73BwTfzszWq89gXPfkBM=;
        b=O7mJAwUxlXYU/pJzOIhTuPUfoit86Jw/xX8efoqmD98tDmWcR0fqHOigncaDMNvNRH
         86s9x0uMNhfYU7A1us5jfcPyxJH8JgXUbi9gG2Jh3dPUe0hsfcV4S5QRfFe42eZa88EB
         IKkcpFC6noQZ+Nma3VuucZDTTc3DBFO/m2TwT3gvIk+951W24hyV24g3dOwdgPARafRy
         61WKiMWYyg6fxfYGLJDDK3rbvIbE8Cl44va7ZuMXpBf+wJl+cOftuY/dzNWjJvmAf5BZ
         kGRKQFsn6iXypa4msx7HSc+gTo8CTMcqnA75dZ6ELVUE1f3LJTb4Uc1EJ3DUxsxQsiAG
         DcaA==
X-Gm-Message-State: AOAM533k+dnfruTvjyptTg4nxb2uzgj/Az1NpNMdLknq58pRI/kyk+HZ
        x6TUtYglerX8V+vE374aC+YZo7sIMNINdqSj
X-Google-Smtp-Source: ABdhPJy43Hvb0Adag6JF7T0ntmFj7LGXOHrVyNUjsYyGUmlFXvvsB2UCGFNcs8ubPd7jKQ0SREYd7A==
X-Received: by 2002:a17:906:7f0e:: with SMTP id d14mr15444756ejr.103.1623684355086;
        Mon, 14 Jun 2021 08:25:55 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id e22sm9402460edu.35.2021.06.14.08.25.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:25:54 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/33] arm64: zynqmp: Correct psgtr description for zcu100-revC
Date:   Mon, 14 Jun 2021 17:25:16 +0200
Message-Id: <bd35fdaac08208578b2bb5059ba2c59bb4e66dac.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable psgtr node and also fix clock names to be aligned with other zynqmp
boards.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 9c40c6552c32..4622e173d262 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -111,13 +111,13 @@ ina226 {
 		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
 	};
 
-	si5335a_0: clk26 {
+	si5335_0: si5335_0 { /* clk0_usb - u23 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
 
-	si5335a_1: clk27 {
+	si5335_1: si5335_1 { /* clk1_dp - u23 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
@@ -459,8 +459,9 @@ conf-tx {
 };
 
 &psgtr {
-	/* usb3, dps */
-	clocks = <&si5335a_0>, <&si5335a_1>;
+	status = "okay";
+	/* usb3, dp */
+	clocks = <&si5335_0>, <&si5335_1>;
 	clock-names = "ref0", "ref1";
 };
 
-- 
2.32.0

