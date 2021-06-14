Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB3C3A6A51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhFNPad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:30:33 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:46767 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbhFNP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:13 -0400
Received: by mail-ej1-f49.google.com with SMTP id he7so17152426ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1by+ic5kCnkZmbZYv5aysS3H21LtClorSioqqWHafw=;
        b=IqtJkfzKCBwjHdoK6vpmKpeEReUBWVeyUMEII6oTIAkqgaYGDchYjNep1VE3LM+rIA
         VtFqs6KtF1QgXnWZLvynv47pSQ83jzAYR6AKlHBcj/b83w+owKwe/bhm71GIgep1gL3b
         s5iHrZ/2zHOI6YyjmI7At/yOz/btH7D+kfVF4SJxNnJuSW/48leXeWhLX7qpUQP59zyS
         m36v/MqXiEmhkHrxaGgI1HttTxeoc3a3ljXT5usttsdedtRIO4LcP17XIEI3paB5D2++
         q9WajWHUQ4PBv8kPy9bPvHh8cLU0pta14Gyh75KnQo2pzqO3wqjMtu5TLi5ty+OogtzB
         AC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=H1by+ic5kCnkZmbZYv5aysS3H21LtClorSioqqWHafw=;
        b=npeDa3Yv/kkw0GR46ch5mVP2rG7qu/wB5BPKTMlhuQMv2rpoDoHG05UHVyTmoizoCg
         R3BVyyB6gnc5rLXyKsg5iUt0ZYW0cTmtxDkym1II+b2bKzOwW+2qkKcy3hPa47chjkVZ
         KTGBKBbkJCK1hMuL4sRoz9SlvcnxzuzjYCLBkvihKxcX9jSNEL1V6YpqPWvWkhQQRxUf
         QL+OouroMGTPPuKRjw1wUKAlT0IgEFqOAZLlQS5HtmeKnm0Nt5rmO6Kt2AzkCn4SWUTt
         k8+mIfJRX77yD2XnYSyYHKxOajnb+3ZsiZ8E8L7Z4JUX4qoiphAcNHdinSH8n/kYghzE
         WJCA==
X-Gm-Message-State: AOAM532kIt6dVLp4LyKs0BWl1IxQwqIMzbvdjARFqTIpMmtcXGn/lAl5
        unZhSjHi95IVvj20UMnYDmyDjz/aYwNs0VzM
X-Google-Smtp-Source: ABdhPJzVO+UgZYb8aPkMsR8xsBqbPViqBvy52IbZFOUjxN2aDJ8jtcclViCcGIlTVQWGMFtQBrN9wQ==
X-Received: by 2002:a17:906:b7d7:: with SMTP id fy23mr16221416ejb.49.1623684359512;
        Mon, 14 Jun 2021 08:25:59 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id y10sm8911757edc.66.2021.06.14.08.25.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:25:59 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 11/33] arm64: zynqmp: Add missing SMID for pcie to zynqmp.dtsi
Date:   Mon, 14 Jun 2021 17:25:19 +0200
Message-Id: <43f21f5033f7806fba049474bced6131c8cb98ba.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

The SMMU is disabled in device tree so this change has no impact.
The benefit is that this way it is in sync with xen.dtsi. Xen enables
the SMMU and makes use of it.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index f860e90ea2a6..3fa0517cfd98 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -636,6 +636,8 @@ pcie: pcie@fd0e0000 {
 					<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
 					<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
 					<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 0x4d0>;
 			power-domains = <&zynqmp_firmware PD_PCIE>;
 			pcie_intc: legacy-interrupt-controller {
 				interrupt-controller;
-- 
2.32.0

