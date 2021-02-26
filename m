Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF92C3263B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhBZOEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:04:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:53378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhBZOD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:03:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6620AF63;
        Fri, 26 Feb 2021 14:03:15 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        ardb@kernel.org, hch@infradead.org, narmstrong@baylibre.com,
        dwmw2@infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 00/13] Generic way of dealing with broken 64-bit buses
Date:   Fri, 26 Feb 2021 15:02:52 +0100
Message-Id: <20210226140305.26356-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM2711, Raspberry Pi 4's arm64 system on chip, contains a PCIe bus that can't
handle 64-bit accesses to its MMIO address space. The issue has already been
discussed here[1], and it turns out BCM2711 isn't the only broken device in the
wild.

In most cases, the solution to this issue is to convert writeq/readq() to into
their lo_hi/hi_lo variants and the eventual introduction of some amount of
locking. But that's not good enough for every device. For example, on some
arm's SMMU configurations atomic 64-bit accesses are mandatory. This series
tries to introduce a mechanism for drivers to be able to ascertain whether or
not they are allowed to perform 64-bit accesses.

The big question is the amount of granularity needed to deal with this
(think here of distro images):

- Build-time: if a broken platform included in the image, disallow any 64-bit
  access. Drivers that need 64-bit accesses could simply bypass the check and
  hope for the best. Imposes a performance penalty on otherwise well behaving
  platforms, and features that depend on 64bit access might be disabled
  unnecessarily. It's simple to implement, yet not very generic/future proof.

- Run-time: allow/disallow 64-bit accesses based on boot time checks (i.e.
  check which platform the kernel is running on). Gets rid of all the negative
  aspects imposed to well-behaving platforms. Well-behaving buses can't coexist
  with broken ones while using all features.

- Per-device: each device has its MMIO access properties and can take decisions
  based on its local bus. That said, I'm not aware of a system that absolutely
  needs this ATM.

This series implements the third option mainly as a proof of concept.
It's my personal preference on how to deal with this. That said, my main
aim ATM is to settle on a general approach.

Regards,
Nicolas

[1] https://lore.kernel.org/linux-arm-kernel/c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de/

---

Nicolas Saenz Julienne (13):
  dt-bindings: Introduce 64bit-mmio-broken
  driver core: Introduce MMIO configuration
  of: device: Introduce of_mmio_configure()
  driver core: plafrom: Introduce platform_mmio_configure()
  pci: Introduce pci_mmio_configure()
  device core: Introduce dev_64bit_mmio_supported()
  arm64: Mark ARCH_MVEBU as needing broken 64bit MMIO support
  arm64: dts: marvell: armada-ap80x: Mark config-space bus as
    64bit-mmio-broken
  iommu/arm-smmu: Make use of dev_64bit_mmio_supported()
  iommu/arm-smmu-impl: Get rid of Marvell's implementation details
  arm64: Mark ARCH_BCM2835 as needing broken 64bit MMIO support
  ARM: dts: bcm2711: Mark PCIe bus as 64bit-mmio-broken
  scsi: megaraid: Make use of dev_64bit_mmio_supported()

 .../devicetree/bindings/common-properties.txt | 15 +++++++++++
 arch/Kconfig                                  |  8 ++++++
 arch/arm/boot/dts/bcm2711.dtsi                |  1 +
 arch/arm64/Kconfig.platforms                  |  2 ++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |  1 +
 drivers/base/dd.c                             |  6 +++++
 drivers/base/platform.c                       |  9 +++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    | 21 ---------------
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  9 +++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |  9 +++++--
 drivers/of/device.c                           | 19 ++++++++++++++
 drivers/pci/pci-driver.c                      | 26 +++++++++++++++++++
 drivers/scsi/megaraid/megaraid_sas_fusion.c   | 23 ++++++++--------
 include/linux/device.h                        | 20 ++++++++++++++
 include/linux/device/bus.h                    |  3 +++
 include/linux/of_device.h                     |  8 ++++++
 16 files changed, 145 insertions(+), 35 deletions(-)

-- 
2.30.1

