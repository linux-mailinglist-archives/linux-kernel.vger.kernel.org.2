Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB4338F2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbhEXS33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:29:29 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:47003 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232516AbhEXS31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:29:27 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B0D1D581E71;
        Mon, 24 May 2021 14:27:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 May 2021 14:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=TEx4O6ipWrArrkHEgj4N9wKNBP
        467wEwYrYzP9bsXl4=; b=JGpKssTkczo2LEipwnIpKsb9b00UPb8fx4nR/pDIob
        TefJxALlW0AWRbJF8gntLMZ+wASO1d/a23xW/HGZxJ9qGMo/UaXATyFuJNugAHm8
        6h0gLc+9NaBoJGFUMWBLEhC3aVlHLWADuS+AG6HOX9efDb8AqgF4eOScC1flp2Se
        J+SudZ8REsuESSJWD5OKtupUke0ys1/vg6tW8FGanYxQ/oz1IsW5fihyL1M349vL
        Ec8fHmN16b6KLedkJEyOr4Z8fCKybUsImSumEqo0VZqxPHKiFPf+Mtf8HN65Ab/a
        mSMNGqA1z4QODvh8f86Rz8tQdNJ8jVyPwOOKgc50L+ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=TEx4O6ipWrArrkHEg
        j4N9wKNBP467wEwYrYzP9bsXl4=; b=WTD7xNyH66Yh9X1b9Cil1pRWGo81M4aWV
        Weqg+LRz8rHA+5LEt1NVvuI7wYf9wUbCS++RgjjQGwTqmFQOkzDe6BaBWgUiNTwE
        M4BPjKMazaWjDFkfPwr91upisHFy6afeklh+ijU7Qz/xS705dj89EW58IO85mh++
        g6TVmzyi4ROWJY9Tqq+QyP9Z7Dw+dqNpMoWWvT25/My4xrFCQ/nx3ECnraPL6Pmb
        b+P9+HVuv5bb1HCCmyN8JaReRz2iVolrbgGi1v1eWtKEQQvs+QdRK8patKKST5vv
        U0Lo3l/v2KccFuQ0E3MG9ONBbGXwV1+6Jp5GtYH9JFnoUY0nUyN3A==
X-ME-Sender: <xms:LfCrYAFK4WeeTLy7mY23INcFpwE4MLHOjNaiEe_Zavt3Io7oYlth3Q>
    <xme:LfCrYJWESwLW8mfIRukzZJ4PYcLflplKGemElamOZhWgGYNmNjPYBC41Jhils3tjh
    Pon37VdNec-Rq_zkOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeeugfelkedvtdejffefjeehveelfeevkefgudduhfeghfefgedtheevjeefffffgfen
    ucfkphepudejiedrudelledrvdduuddruddvgeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:LfCrYKKpATqYV7Tul45AUl7Mx2Ii5M5O1GTvqvrPyRms2H-fFCULgA>
    <xmx:LfCrYCEyWFMath51u7OA4q5IrQ_fYyrOt2yvK_Ym9rk5sgfMvZl23A>
    <xmx:LfCrYGXCRsoCoRyMsnPceca2MBpxk0jVSAFvIQDH4KCBeh56J47bDQ>
    <xmx:LvCrYKo-1pJTXCEjpYa405FXPDMWnYzHOhNH34GJ8qnnjpt2SyQmfA>
Received: from photon.s7r42.com (ip-176-199-211-124.hsi06.unitymediagroup.de [176.199.211.124])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 14:27:54 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Sven Peter <sven@svenpeter.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 0/3] Apple M1 clock gate driver
Date:   Mon, 24 May 2021 20:27:42 +0200
Message-Id: <20210524182745.22923-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This series adds support for the clock gates present in Apple's SoCs such as
the M1.

These SoCs have various clock gates for their peripherals usually located in
one or two MMIO regions. Each clock gate is a single 32 bit register which
contains bits for the requested and the actual mode. The mode is represented by
four bits. We however only care about "everything enabled" (0b1111) and
"everything disabled" (0b000) for now. The other modes are probably different
low-power states which don't even seem to be used by MacOS. The actual power
management is located in a different region (and probably handled by a separate
processor on the M1).

Additionally, these clocks have a topology that is usually specified in Apple's
Device Tree. As far as I can tell most Linux drivers seem to encode this topology
directly in the source code though. Despite this, we would still like to encode
the topology in the device tree itself:

Apple seems to only change HW blocks when they have a very good reason and even
then they seem to keep the changes minimal. This specific clock gate MMIO block
has already been used in the Apple A7 released in 2013. The only differences
since then are the available clocks (which can be identified by a simple offset)
and their topology.

It's likely that Apple will still use this block in future SoCs as well. By
encoding the clock gate topology inside the device tree as well we can use a
single driver and only need updates to the device tree once they are released.
This might allow end users to already run their favorite distribution by just
updating the bootloader with a new device tree instead of having to wait until
the new topology is integrated into their distro kernel.

Additionally, the driver itself can be kept very simple and not much code needs
to be duplicated and then updated for each new SoC between various consumers of
these device tree nodes (Linux, u-boot, and OpenBSD for now).


This series therefore creates a single device tree node for each clock gate.
This unfortunately maps a whole page out of which only a single register will
be used for each node.

The other alternative I considered was to create a syscon/simple-mfd node
and have the clock nodes as children. The gates would then use a regmap which
would only require a single entry in the pagetable for all clocks. I decided
against this option since the clock gate MMIO region actually isn't a
multi-function device.

I'll also gladly implement other solutions - especially if there is a way to
keep the clock toplogy inside the device tree without having to create a
pagetable entry for every single clock node.

Best,


Sven

Sven Peter (3):
  dt-bindings: clock: add DT bindings for apple,gate-clock
  clk: add support for gate clocks on Apple SoCs
  arm64: apple: add uart gate clocks

 .../bindings/clock/apple,gate-clock.yaml      |  60 +++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |  36 ++++-
 drivers/clk/Kconfig                           |  12 ++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-apple-gate.c                  | 152 ++++++++++++++++++
 6 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/apple,gate-clock.yaml
 create mode 100644 drivers/clk/clk-apple-gate.c

-- 
2.25.1

