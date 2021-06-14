Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594ED3A6A12
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhFNP2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhFNP2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC4BC0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:25:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id og14so17361334ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMnnSnHhZ+ZC8YRlb+Ztl4rSXV3VF/rNnZ8I2hpt3YY=;
        b=PsCcEZqJS+CY72hY1D8xYClmdstasqbFlYggtaq7vqqnrfTV7IzIUtDEWSx3cPapeA
         HISQQYLXvqZqTacv9ixo+S36HGtkF4pdwNhTdLEvGFKY4RqsdrDQFuIwjLs0KmgzYk+a
         UVcSU9WMT5BJFoKW8MwFa5q0+wDLRrHprccqXku6IrsgJhNsys7esfnk0Je81EYBB2CJ
         QO4e1Gr2AFyP94dd3F2MyyFJGnYBIsattv0STitJyACfRyNrOEc2EoHH1CCEXqWbqXST
         dlnij0iuapH2ZkPBJvekw3PTOS2opPkN/A+mlTi3XJoPs+D8KP7kZQ5KnS+c2LU/GLUH
         zz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GMnnSnHhZ+ZC8YRlb+Ztl4rSXV3VF/rNnZ8I2hpt3YY=;
        b=Z+5ChbOB+DQA6AawS434O3OuYrlibI23qe91ihZF/otejcLhMpwNSZN2NM0SGbKo94
         pqRnnIMkJJSX50t/f83WLuo1M7j2+KAsUNGOrrC89ad77jjdFzEKpxwqm/eOgzJxb/WN
         ceLrbGcDXykUrWfsja7zvITaoTRpCBcLJPP2KaMa4K/NGWvYdElFXKxC3s0j14zFKYQo
         TG9Zz24djvETt+l0rxWThfno1TxJN1Ne+a81a5+M60MF8HvV5QVwgZpkEcCsqFdiW4qW
         BihPRE8Wl68p1BchfqqdZOuNnkY1FMDpQAlcsVmX47jI5FvC92CyHr9CtWtL42fFYyc/
         uxvA==
X-Gm-Message-State: AOAM532AttdYKc514Uz5mgulK6r0+xccQ6xLSULIvnwlObWIzc4BIviy
        Mz1Lb+ozGyQLzOkKVzmY8n3h9zSIlUgAFuOm
X-Google-Smtp-Source: ABdhPJyxGPARqvHI0C3EcGU55MM5QfBwC4fwK0GGHt/8ICyIwJn2ub8gxrYtpjZaSPIQay+RmnmZNA==
X-Received: by 2002:a17:906:e2d6:: with SMTP id gr22mr16172494ejb.514.1623684352296;
        Mon, 14 Jun 2021 08:25:52 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id f18sm4698356edu.5.2021.06.14.08.25.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:25:51 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 06/33] arm64: zynqmp: Correct zcu111 psgtr description
Date:   Mon, 14 Jun 2021 17:25:14 +0200
Message-Id: <d47cbf374423cb71bb4be5e45e3d834da0c4673a.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DP and SATA psgtrs are swapped.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 2e9fe675a718..b0c2eae1b4b3 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -766,8 +766,8 @@ conf-pull-none {
 
 &psgtr {
 	status = "okay";
-	/* nc, sata, usb3, dp */
-	clocks = <&si5341 0 3>, <&si5341 0 2>, <&si5341 0 0>;
+	/* nc, dp, usb3, sata */
+	clocks = <&si5341 0 0>, <&si5341 0 2>, <&si5341 0 3>;
 	clock-names = "ref1", "ref2", "ref3";
 };
 
@@ -787,7 +787,7 @@ &sata {
 	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
 	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
 	phy-names = "sata-phy";
-	phys = <&psgtr 3 PHY_TYPE_SATA 1 1>;
+	phys = <&psgtr 3 PHY_TYPE_SATA 1 3>;
 };
 
 /* SD1 with level shifter */
-- 
2.32.0

