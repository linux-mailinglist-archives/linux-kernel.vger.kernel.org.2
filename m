Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75393DEDB8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhHCMRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:17:24 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34795 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235007AbhHCMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:17:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 59AE9580889;
        Tue,  3 Aug 2021 08:17:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 03 Aug 2021 08:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=7rZfd/qsnUKLmSz/pSyi1ygYlA
        c/GUtTlDvVD6X1U0s=; b=Rhxl65r/LKhG1oEfcoJMMORE347EqyXwUFvtRemlOA
        wD3q0q5RQ+aUt6M5VcSAdPxa1kNmWNuA0w2Lz4AddLF8n0GoDg6s2gB3ocng8AmX
        Pdpy2XmCB0bB4ogn36HLYvbj0Z+Yjgl8al/B7NxlGwKISU5VMll4rQVdYkEEtHJ4
        AKWYMRC2KjI1BnU/CZ+v84vV2AI3PHc2QGL+3pXMp4ZhZbKDTdCc9elAgM14qZRc
        LKCTXd1atSVOl+tKDwS2XLbZ5NYSVFcLt/KcnRZjZapde7gP83aVpzuwvnDJGS6c
        kNuv73G/nHD8J0OGacHBtPo7FWiwL/DPWACMtdZUa80w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7rZfd/qsnUKLmSz/p
        Syi1ygYlAc/GUtTlDvVD6X1U0s=; b=UAb11ZjK/DE5+YvuELxIzRHQLNX8EfRwb
        tE5k+UvkfontHOGM1ix25VPJT5GY9DFnMMJ6SCQSf6PsSKCUDO54ezjuN6vdqkhK
        G+VnGr185+o2KptQe0iSicz4gB1xDlrLjjTURbdexuRZfxDig2h4hE/FvmrWIrB/
        MF3NreEJ4oCBP++UQxl3kUQtDYg+lZqk1dYK1VXiYP7cLSeDUo3ygWshUv/b5j/K
        W2/9Xmca3pXXH/qxQqS7AV+sVhkt4F+qA1wqlRwsqIrD7quUERwwY+3QW8iuUhMW
        cE4ZLa2VnaxqliiU4BCKQ0qjZLehEdTvxw3FCPs6OPSA3QyxcH2FA==
X-ME-Sender: <xms:xTMJYQnGvpxPw6VC9NJtTx5iC6QrkJ2HGsEAVqvcvo6YiF7d3dcrNA>
    <xme:xTMJYf2DaMkCE_NpTIhRUdYJ8aD_31RT80k48jAdOodReT_KDZecbEpra3qt4bIM8
    5CcbNhsYnSgzrnvp-4>
X-ME-Received: <xmr:xTMJYerYsbJB9ZIk-_xu2wTNbRUra-wkNNdS17DBhe1So0aXlE8Y_RamzzXckn9uBr63zzNiBE3MIN4H5A39_Ci28t8tanVDN2s5Nw2C3z6U67KamZx-iS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfrvght
    vghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    dvffeileefkeetuedvjedvudetheefieejfeekveetheeugeevledtheekffejjeenucff
    ohhmrghinheprghsrghhihhlihhnuhigrdhorhhgpdhkvghrnhgvlhdrohhrghdpghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:xTMJYckDNwf156MpuFJSUE5NYtbtTL0kJ6imxw4MST5JxQqLAbr6Ng>
    <xmx:xTMJYe32YofgHt1qTcCEdqQwKvOU6xL0KNJdpQuM25-iZpbMm4BFnw>
    <xmx:xTMJYTutXjhYJlC1USQdcbKEWJJxSZod4STHuz8lfz2sezRWZSD_Tg>
    <xmx:xzMJYXGGckW0o2LvidAqfZzCbfa77MUlzNSNLas6WBUvQmCo_oYgdQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 08:17:06 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@kernel.org>,
        devicetree@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, r.czerwinski@pengutronix.de
Subject: [PATCH v5 0/3] Apple M1 DART IOMMU driver
Date:   Tue,  3 Aug 2021 14:16:48 +0200
Message-Id: <20210803121651.61594-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v5 of my Apple M1 DART IOMMU driver series as a follow up to the previous
versions [1][2][3][7].

Short summary: this series adds support for the iommu found in Apple's new M1
SoC which is required to use DMA on most peripherals like the display controller,
the USB ports or the internal PCIe bus (which is used for WiFi, Ethernet and
more USB ports).
So far this code has been tested by multiple people with dwc3 in host and
device mode (which both only require changes to the device tree after this
patchset) and PCIe (using a yet to be finalized patchset).

Note that this version has to be applied on top of iommu/core or iommu/next since
it now uses the new map_pages/unmap_pages API.


== Testing this patchset with the USB-C controller == 

The two USB-C ports on the M1 machines are exposed as two separate dwc3
controllers which are behind a DART. Now that my USB phy bringup code has been
merged into our bootloader m1n1 you can easily test this patchset yourself:

1) Follow the instructions at [4] to setup our bootloader m1n1 on your M1
   machine which will allow you to boot kernels using a normal USB cable.
   Note that you'll still need a special setup to expose the UART for very
   low-level debugging.

2) Apply this patchset and add the DART and dwc3 nodes as done in e.g. [5].

3) Boot the kernel through our bootloader m1n1. You'll need a version after
   commit [6] which enables the USB PHY and the USB PD chip.

Note that the dwc3 controller has a quirk where each root port can only be used
once right now. The most stable way to test is to already connected the USB
device(s) before booting the kernel.

It's also possible to test the PCIe bus but this requires a more complex setup
for now. I can write a quick howto if anyone is interested though.
(tl;dr: Mark Kettenis has a u-boot fork that includes PCIe bringup code and
Marc Zyngier has a WIP patchset to add a PCIe driver)

== Project Blurb ==

Asahi Linux is an open community project dedicated to developing and
maintaining mainline support for Apple Silicon on Linux. Feel free to
drop by #asahi and #asahi-dev on OFTC to chat with us, or check
our website for more information on the project:

https://asahilinux.org/

== Changes ==

Changes for v5:
 - Added reviewed-by and tested-by tags (thanks!)
 - Rebased on top of iommu/core and replaced map/unmap with map_pages/unmap_pages
 - Removed software bypass hacks: I've tried a few different variants now
   and they all have drawbacks or incompatibilities that I am not comfortable
   with. This means that PCIe devices (for which there is no kernel support yet
   anyway) will not work correctly for now on 4K kernels. I plan to address this
   in a follow-up series where I want to modify the dma-iommu layer to support
   pagesize mismatches.
 - Removed reference to ARM from the constants for the io-pgtable code
 - Addressed the following comments by Robin Murphy, which resulted in some major
   changes to apple-dart.c
   - Correctly assign iommu_groups in apple_dart_device_group
   - Get rid of the fwspec-inspired of_xlate linked lists and replaced them with
     a simple static array with a streamid bitmap covering all known cases
   - Relax locking: Now only a single spinlock around TLB flushes and a mutex
     around domain initialization are required. attach_dev/detach_dev uses
     atomic64_t.
   - Set .suppress_bind_attrs to prevent manual unbinding
   - Get rid of .shutdown since there's no real need to clean anything up
   - Manage interrupts manually instead of using devm_* to prevent situations
     where a shared interrupt could trigger while clocks are disabled
   - apple_dart_irq now prints "unknown" when more than a single error bit
     has been set.
   - Use DL_FLAG_AUTOREMOVE_SUPPLIER so that there's no need to keep track
     of the pointer
   - Ignore any unknown protection flags instead of failing
   - Use dev_err_ratelimited and clk_bulk_disable_unprepare instead of
     open-coding them
   - Correctly set and clear iommu_bus_ops
   - Removed unhelpful WARN_ONs and duplicate sanity checks
   - Removed unnecessary identity stream map reset code 
   - Renamed apple-dart-iommu.c to apple-dart.c
   - Fixed commit style to use the correct subsystem style
 - Possibly some smaller fixes I forgot about

Changes for v4:
 - Addressed Rob Herring's remark about the incorrect phandles in the device
   tree binding example and added his reviewed-by tag
 - Take the software linear mapping range from the bus instead of hardcoding
   it in the driver
 - Use def_domain_type to force bypass mode if there's a pagesize mismatch
   between the DART (hardwired to 16KB) and the kernel (may use 4K)
 - Added lockdep_assert_held instead of comments as suggested by Rouven Czerwinski
 - rebased on 5.13-rc7

Changes for v3:
 - fixed name of the iommu node in the device tree binding example
   pointed out by Arnd Bergmann
 - remove hardware specific checks from io-pgtable.c  as pointed out by
   Will Deacon
 - introduced a fake bypass mode by programming static linear pagetables
   if the DART does not support regular bypass mode as proposed by Alex
   Graf
 - added checks to enforce bypass mode if there is a pagesize mismatch
   between the DART HW and the CPU.
 - fixed usage of GFP_KERNEL during a held spinlock found by Julia Lawall
 - rebased on v5.13-rc3

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


[1] https://lore.kernel.org/linux-iommu/20210320151903.60759-1-sven@svenpeter.dev/
[2] https://lore.kernel.org/linux-iommu/20210328074009.95932-1-sven@svenpeter.dev/
[3] https://lore.kernel.org/linux-iommu/20210603085003.50465-1-sven@svenpeter.dev/
[4] https://github.com/AsahiLinux/docs/wiki/Developer-Quickstart
[5] https://github.com/AsahiLinux/linux/commit/7d4ebb0b22e9bfec849e2af86ddeb46ec29d7feb
[6] https://github.com/AsahiLinux/m1n1/commit/9529ec2b4fd6550f9cfd66d9f2448b90804699a1
[7] https://lore.kernel.org/linux-iommu/20210627143405.77298-1-sven@svenpeter.dev/

Sven Peter (3):
  iommu/io-pgtable: Add DART pagetable format
  dt-bindings: iommu: add DART iommu bindings
  iommu/dart: Add DART iommu driver

 .../devicetree/bindings/iommu/apple,dart.yaml |  81 ++
 MAINTAINERS                                   |   7 +
 drivers/iommu/Kconfig                         |  14 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/apple-dart.c                    | 923 ++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c                |  63 ++
 drivers/iommu/io-pgtable.c                    |   1 +
 include/linux/io-pgtable.h                    |   7 +
 8 files changed, 1097 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml
 create mode 100644 drivers/iommu/apple-dart.c

-- 
2.25.1

