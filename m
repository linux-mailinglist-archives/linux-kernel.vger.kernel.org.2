Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E83A6A56
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhFNPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:31:00 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38852 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhFNP3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:41 -0400
Received: by mail-ed1-f52.google.com with SMTP id t7so1836495edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDT5rlW0N7H4VvpBkB/rB2GqsHgubckjDkxPaOtr/xo=;
        b=eSdx8zyzDm9ucytlOww51RgKl5j8xPNdBuP/pNIZGcFWXEyWFGP+oXDdaYOrnRAns5
         tCvBx0oeOsaaHUTxQdrwTGlW6z6uIhzqYhlz3rHiXJcACTp7IsBNiDbjhl/osXSNqIKK
         W2D5kGv1YQESPcMPI90eUooFkDqjB/bpjfHERtgkN/j31SHejexuPCo7a7pk9s+L7C32
         tHxW8qbvfGze3OtqwQGh5SlRiPJOX3mYUfld3q42yC4/EGlyKeqExxdFSEmbgQA5crds
         U9WenDMH3VqOvivbH0PmGOBRYE/a7WPAu1qhcJqNmluqGokalg/MQ2Mq4xNA3nPoExV2
         IwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dDT5rlW0N7H4VvpBkB/rB2GqsHgubckjDkxPaOtr/xo=;
        b=IezMAVaxiZOsyVpl0h0fXrqRdLMhAtOGNNJeLpttH4xe1gvR52M0tnGKBklcm4VkK+
         KM4drINRPzUuzpPGW54pPY2mMUtMdHf5XFRwjhfDMKmUdCaFb9LpWlTNCjylqqL1Ifeq
         cZIMZkuK4HtQFiTWZOLfwNYCQS2ZrEINf9zLy2yCWw+HL+0AZbQ5e1lc6Ni0yTfmHLK7
         j8qUb1tKsQsYM7ZZJiFHXnnYR2chzZTzJ7LofHXPHiQUxI93rEWDlZCQDEIIIaaJMM2Y
         MvPOJJLVB3+5BlP8gF8I2QcrBsJRYaqQgTgxwdgDhRO7HiwpXNb7K/MGqvacTbPfOr2h
         LydQ==
X-Gm-Message-State: AOAM531IqwAnA8u20tLi+nCHoOpjCTphyxd3xpL5PfNiXFvVwyCcvgN1
        5S7ryAsajI/b67OBCjoqpBFupgj0Xkv0EyN8
X-Google-Smtp-Source: ABdhPJzUsfoA0QONluP+sE0c5qOTK68fAZbX/3ipyn6BYTFQ1TPq5xaTcq4t3zQ1mjs0pJuSKsmpUg==
X-Received: by 2002:aa7:d5c9:: with SMTP id d9mr17497072eds.278.1623684382874;
        Mon, 14 Jun 2021 08:26:22 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id s18sm7948219ejh.12.2021.06.14.08.26.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:22 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 27/33] arm64: zynqmp: Add reset description for sata
Date:   Mon, 14 Jun 2021 17:25:35 +0200
Message-Id: <b7f61daa2fe1a2300767af73c46b8082088f741a.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sata needs to get reset before configuration that's why add property for it
there.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index da54a2d35552..6f0fcec28ae2 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -673,6 +673,7 @@ sata: ahci@fd0c0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 133 4>;
 			power-domains = <&zynqmp_firmware PD_SATA>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
 			#stream-id-cells = <4>;
 			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
 				 <&smmu 0x4c2>, <&smmu 0x4c3>;
-- 
2.32.0

