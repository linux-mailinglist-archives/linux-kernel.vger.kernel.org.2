Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCC43A6A33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhFNP3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhFNP2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7258C0613A4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ce15so17314270ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sMVNJ/LPbRvn48KGy/785ZDuHz9PafjtcmN48BZV1GQ=;
        b=mM1yRhikbHOL3TLiAHpFyBj6QWF1+TtzCsYz0AjHtLnmTyIij6X/49oInPUboRknNr
         5zMlzCwR7BOYCCAx3Idgu8tthTrxOsW3v+D+Xio2mdIKnTYnjxplu4oSKKUmuf/J6gYG
         wSuftX3UHn9t1EJbboA7cpy9uhw1z3O7vvDFpoRzfDb+82JKuMNemARewvYDWgmOu7gg
         nVMgGukao362IJ6jHJxh4Bpl4KAkif+d3vGKQInve/3SPGYAgZxf/X+JWjso60IUgFX1
         MYDH2W7kFY1IxDcY2pvpUIxuJlVwj3M6SkAwY6CdONFVBAJQpfVfxT5TspXvV/3GLVLw
         yy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sMVNJ/LPbRvn48KGy/785ZDuHz9PafjtcmN48BZV1GQ=;
        b=ioMGYNdkdJitA9Erpwabw/Ze2MF0sJQayyKydsSy3j+9lvPMgk8p+aFZ4CxffRVwCl
         n2AeCh1es0zjkbWZjqGispH3JcsiYoC/k3mRmptCh+kdSGpFQmqjBtjxaSi7tNEUYUhb
         kEoHwhbh8PDOql0C4zxwQAPe7EJnSnsYIb10YuVjQWBSmF+9jeUTpqgTspVASR4ftPqy
         syBYZGnsMLJ0kTuz9fkNAp/MdeefGQzbF7Enp//tiT9qC4e6YtH65vYSVQ2qzj4a1PmP
         Qpq6jBE/uOmPeR8lw9ihvEHqebVCucYiOVWXmA6omr38s07KTkkjN6+/rB8Flnan7ng0
         wqIw==
X-Gm-Message-State: AOAM530a6I5+nYEZaas4iNedIvIV8KDrcSSDp1kw201vLuN/R0kuXTvz
        ARKhlUn0box14o3NTA6WRuBDPEBHpb20ruKJ
X-Google-Smtp-Source: ABdhPJw5nHPMaw17x6xIGLUWcrzK5xMwTMS8SeIrlnqdsD4/5XabEfPGOZwKsWg6dttfKzTHTcCOoQ==
X-Received: by 2002:a17:906:260e:: with SMTP id h14mr15829603ejc.356.1623684377377;
        Mon, 14 Jun 2021 08:26:17 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id s2sm5275071edt.53.2021.06.14.08.26.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:17 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 23/33] arm64: zynqmp: Update rtc calibration value
Date:   Mon, 14 Jun 2021 17:25:31 +0200
Message-Id: <0d36d9fe999ff82f10d42ab5fc0d1e907c26ac34.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Neeli <srinivas.neeli@xilinx.com>

As per the design specification
"The 16-bit Seconds Calibration Value represents the number of
 Oscillator Ticks that are required to measure the largest time
 period that is less than or equal to 1 second.
 For an oscillator that is 32.768 KHz, this value will be 0x7FFF."

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 80332e3b4d6a..da54a2d35552 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -663,7 +663,7 @@ rtc: rtc@ffa60000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 26 4>, <0 27 4>;
 			interrupt-names = "alarm", "sec";
-			calibration = <0x8000>;
+			calibration = <0x7FFF>;
 		};
 
 		sata: ahci@fd0c0000 {
-- 
2.32.0

