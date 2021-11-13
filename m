Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C665744F2E6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 12:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhKML5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 06:57:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232925AbhKML52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 06:57:28 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C454A60F6B;
        Sat, 13 Nov 2021 11:54:36 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mlrcA-005BG2-KW; Sat, 13 Nov 2021 11:54:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/8] drivers/perf: CPU PMU driver for Apple M1
Date:   Sat, 13 Nov 2021 11:54:21 +0000
Message-Id: <20211113115429.4027571-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The M1 SoC embeds a per-CPU PMU that has a very different programming
interface compared to the architected PMUv3 that is normally present
on standard implementations.

This small series adds a driver for this HW by leveraging the arm_pmu
infrastructure, resulting in a rather simple driver.

Of course, we know next to nothing about the actual events this PMU
counts, aside from CPU cycles and instructions. Everything else is
undocumented.

My hope is that this driver will help people to explore the event
space and propose possible interpretations for these events using
reproducible test cases.

Marc Zyngier (8):
  dt-bindings: arm-pmu: Document Apple PMU compatible strings
  dt-bindings: apple,aic: Add CPU PMU per-cpu pseudo-interrupts
  irqchip/apple-aic: Add cpumasks for E and P cores
  irqchip/apple-aic: Wire PMU interrupts
  irqchip/apple-aic: Move PMU-specific registers to their own include
    file
  arm64: apple: t8301: Add PMU nodes
  drivers/perf: arm_pmu: Handle 47 bit counters
  drivers/perf: Add Apple icestorm/firestorm CPU PMU driver

 .../devicetree/bindings/arm/pmu.yaml          |   2 +
 .../interrupt-controller/apple,aic.yaml       |   2 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |  12 +
 arch/arm64/include/asm/apple_m1_pmu.h         |  64 ++
 drivers/irqchip/irq-apple-aic.c               |  59 +-
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/apple_m1_cpu_pmu.c               | 632 ++++++++++++++++++
 drivers/perf/arm_pmu.c                        |   2 +
 .../interrupt-controller/apple-aic.h          |   2 +
 include/linux/perf/arm_pmu.h                  |   2 +
 11 files changed, 763 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm64/include/asm/apple_m1_pmu.h
 create mode 100644 drivers/perf/apple_m1_cpu_pmu.c

-- 
2.30.2

