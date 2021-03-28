Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D19334BB94
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhC1HlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 03:41:13 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:58063 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhC1Hke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 03:40:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id BBA45580830;
        Sun, 28 Mar 2021 03:40:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 28 Mar 2021 03:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=MI94jwmE2zLqhfN/R9l+Jdqfny
        JcLTSsv9uX8W7RVRE=; b=ssuZv+AFrzSuDD41TBt4dn2cF94qJZKbByHwNkWB8U
        0MDHj9gb+fzYfS7q0BEUsRFqeoLm910DZH0xfd7YADc3RhgZjDCG2v2raUxMU/fR
        j04JbluAfqKyQHB0S+PqshL+nZgbYZ6gF/JXAqN1iSKNFnx2pctngaUzizgCnWS/
        hZlNULm3Jsg2CZAfy/TGumBaUcUg+vnhZpnT7qkLjBsx8Q+l5P9jbqt8RuE0WLay
        CthyAiIa6be75L+rQDQqY33LQ2K1tFtc6ejsFNKtrZorU/HnyMaFTmZhAsKUa13K
        j29mv95y2Zs7gDzuqX1hHDAaGsnauNmRapc5fFrfl5Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MI94jwmE2zLqhfN/R
        9l+JdqfnyJcLTSsv9uX8W7RVRE=; b=ENkFBFRf0FHBKM5TXCf9p+OXBY87FTrZU
        IkEXDP7nbhhphIwE5P8tj/yEOldBFtrfx7DBm2Jwbh4XKfK2yGPL1tFR5hJQIiQc
        5m+UIvJr0Jd3cK73W4djH6NpsiMMBHZrvSRm57ZiZwetKJzm8LQGAorc1WVz2oHj
        BdMly1dGvQRSzjrCTtB9puhe80vcx2Qmbg0j/ZtqlId9idkp3OfDMALyQkODerUV
        VwzxOfbWP3hOosl9CgxILNbNPhIdkEMa46jAJ2Ib89yPHnxI4mIgYSp+a8A+FxEg
        wbkRQOycolY4yNOc7gtYqJgFxzmyTpNSP8euXrmJh6rCESLCIUtPQ==
X-ME-Sender: <xms:7zJgYBopPunbEkBwirC9xV2Bf2z3od4HasX21IdEu5yETq1t62RkIg>
    <xme:7zJgYDr4UuDabTsxXddDbYO7JC-19ub7H6rubBO4ieFb_9A2nrK6a_bD1QQpNJblg
    Z10PgtNIKwtywJw0lY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehhedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeeiueeljedutdfgvdegleekjeetveehffdvudefteeklefhgffgkeeljeevheelhfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucfkphepud
    ejiedrudelledrvddutddrudehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:7zJgYOMkMCfK3IjSwdALAHcf6wJQEFX5dtodFra87xzHb4nOKtg2Ew>
    <xmx:7zJgYM4SyxDD5JPuUtAKUpw6E1YqphakgiGBf6DzCRkUKGx8tELcow>
    <xmx:7zJgYA7ah88jsotm5L6JlkoFr7P1WWuZCOliQYinfwx-HwFu5uw8Ug>
    <xmx:8TJgYAwwm-GvqXyk_59nDfwl9upKKhiC9ZsCR4x8Sxl9nM3J-CTK2S4y96M>
Received: from localhost.localdomain (ip-176-199-210-156.hsi06.unitymediagroup.de [176.199.210.156])
        by mail.messagingengine.com (Postfix) with ESMTPA id 41B0624005A;
        Sun, 28 Mar 2021 03:40:29 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@kernel.org>,
        devicetree@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/3] Apple M1 DART IOMMU driver
Date:   Sun, 28 Mar 2021 09:40:06 +0200
Message-Id: <20210328074009.95932-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's v2 of my Apple M1 DART IOMMU driver series as a follow up to the original
version [1].

Short summary: this series adds support for the iommu found in Apple's new M1
SoC which is required to use DMA on most peripherals. So far this code has been
tested with dwc3 in host and device mode on a M1 Mac Mini on top of the latest
version of Hector's bringup series [2,3] together with my m1n1 bootloader
branch to bring up USB [4]. It will also apply (but not be very useful) on
top of iommu/next and v5.12-rc3.

Thanks everyone for the suggestions and discussions so far. I believe they
have already significantly improved the state of this driver and our
understanding of the DART iommu!

The part I'm most unsure about is the way I keep track of the multiple
iommu nodes attached to a device. I would love to especially get some
feedback there.


Changes for v2:
 - fixed devicetree binding linting issues pointed out by Rob Herring and
   reworked that file.
 - made DART-specific code in io-pgtable.c unconditional and removed flag from
   Kconfig as proposed by Robin Murphy.
 - allowed multiple DART nodes in the "iommus" property as proposed by
   Rob Herring and Robin Murphy. this resulted in significant changes
   to apple-iommu-dart.c.
 - the domain aperture is now forced to 32bit if translation is enabled after
   the original suggestion to limit the aperture by Mark Kettenis and the
   follow-up discussion and investigation with Mark Kettenis, Arnd Bergmann,
   Robin Murphy and Rob Herring. This change also simplified the code
   in io-pgtable.c and made some of the improvements suggested during review
   not apply anymore.
 - added support for bypassed and isolated domain modes.
 - reject IOMMU_MMIO and IOMMU_NOEXEC since it's unknown how to set these up
   for now or if the hardware even supports these flags.
 - renamed some registers to be less confusing (mainly s/DOMAIN/STREAM/ to
   prevent confusion with linux's iommu domain concept).

I have also fixed my email provider so this time the series should actually
be a single thread and not contain any HTML by accident anymore...

Best,


Sven


[1] https://lore.kernel.org/linux-iommu/20210320151903.60759-1-sven@svenpeter.dev/
[2] https://lore.kernel.org/linux-arch/20210304213902.83903-1-marcan@marcan.st/
[3] https://github.com/AsahiLinux/linux/tree/upstream-bringup-v4
[4] https://github.com/svenpeter42/m1n1/tree/usb-dwc3-serial-wip

Sven Peter (3):
  iommu: io-pgtable: add DART pagetable format
  dt-bindings: iommu: add DART iommu bindings
  iommu: dart: Add DART iommu driver

 .../devicetree/bindings/iommu/apple,dart.yaml |  81 ++
 MAINTAINERS                                   |   7 +
 drivers/iommu/Kconfig                         |  14 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/apple-dart-iommu.c              | 858 ++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c                |  59 ++
 drivers/iommu/io-pgtable.c                    |   1 +
 include/linux/io-pgtable.h                    |   6 +
 8 files changed, 1027 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml
 create mode 100644 drivers/iommu/apple-dart-iommu.c

-- 
2.25.1

