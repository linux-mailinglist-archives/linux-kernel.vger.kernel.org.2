Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F67444E5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 06:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhKDFb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 01:31:57 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:40325 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229824AbhKDFb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:31:56 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 01:31:55 EDT
IronPort-SDR: dwCowayHn00Q9dsxjLj2NaE95xC6IJmPIPztZ3ZqxngxmfzwYnRWi5VepRx/N0nlTIVhd7KIBK
 E/jUkf9ZVQQBe/eAvWUH8XHPIEic0cwFwimhjuFgU2V4GNYh/3BaK6eLxQLAmB3uDvurCDRWX6
 ua+MFcmEGsHAJfv6L0us6QkRv/N5wUjOHanrqwS1ybpf90+/gAPowDRstR+DOhzOIFw9HaOE+W
 5DyKxnaXkN6NaKaZqHGUv3esXWeBOhwGFOo2rMziBNbGylILgJKqxDTeWtJ9GbDxA370gFHgwJ
 /GBC3dUKaz1w/NwsnFLT6vc+
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="51357878"
X-IronPort-AV: E=Sophos;i="5.87,207,1631545200"; 
   d="scan'208";a="51357878"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Nov 2021 14:22:06 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2B7EF6EBA84
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:06 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 46584D9747
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:05 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id EFB99400C07D4;
        Thu,  4 Nov 2021 14:22:04 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and Intel processors
Date:   Thu,  4 Nov 2021 14:21:17 +0900
Message-Id: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add hardware prefetch driver register/unregister
function. The purpose of this driver is to provide an interface to
control the hardware prefetch mechanism depending on the application
characteristics.

An earlier RFC[1], we were suggested that we create a hardware
prefetch directory under /sys/devices/system/cpu/[CPUNUM]/cache.
Hardware prefetch is a cache-related feature, but it does not require
cache sysfs feature. Therefore, we decided to isolate the code.
Specifically, create a directory under cpu/[CPUNUM].

[1]https://lore.kernel.org/lkml/OSBPR01MB2037D114B11153F00F233F8780389@OSBPR01MB2037.jpnprd01.prod.outlook.com/

Changes since v1:
- Add Intel hardware prefetch support
- Fix typo

This version adds Intel Hardware Prefetch support by Proposal A that
proposed in v1 RFC PATCH[2], and the proposal is also described in the
[RFC & Future plan] section of this letter.
This is the first step to supporting Intel processors, so we add
support only for INTEL_FAM6_BROADWELL_X.

[2]https://lore.kernel.org/lkml/20211011043952.995856-1-tarumizu.kohei@fujitsu.com/

Patch organizations are as follows:

- patch1: Add hardware prefetch core driver
  This adds register/unregister function to create the sysfs interface
  with attribute "enable", "dist", and "strong".  Detailed description
  of these are in Documentation/ABI/testing/sysfs-devices-system-cpu.

- patch2: Add support for A64FX
  This adds module init/exit code for A64FX.

- patch3: Add support for Intel

- patch4: Add Kconfig/Makefile to build module

- patch5: Add documentation for the new sysfs interface

We tested this driver and measured its performance by STREAM benchmark
on our x86 machine. The results are as follows:

| Hardware Prefetch status | Triad      |
|--------------------------|------------|
| Enabled                  | 40300.4600 |
| Disabled                 | 31694.6333 |

The performance is better with Enabled, which is an expected result.
We also measured the performance on our A64FX machine and showed the
results in v1 RFC PATCH.

[RFC & Future plan]
We plan to support Intel processors that have MSR 0x1A4(1A4H)[3].
We would appreciate it if you could give us a comment on how we should
handle multiple hardware prefetch types in enable attribute file for
Intel processor. Detailed description will be described later.

[3]https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
    Volume 4

There are some cases where MSR 0x1A4 has different specifications
depending on the model. One of the specification of MSR 0x1A4 for each
bits is as follows:

[0]    L2 Hardware Prefetcher Disable (R/W)
[1]    L2 Adjacent Cache Line Prefetcher Disable (R/W)
[2]    DCU Hardware Prefetcher Disable (R/W)
[3]    DCU IP Prefetcher Disable (R/W)
[63:4] Reserved

If it supports enabling two types of hardware prefetches for each
cache, as in the specification above, we should consider how to
handle them.

We would like to assign these features to an enable attribute file
(i.e. Map l1/enable to bit[2:3] and l2/enable to bit[0:1]), and
consider the two proposals:

A) The enable file handles only one bit, and changes affect the multiple
   hardware prefetch types at a certain cache level.

B) The enable file handles one or more bit, and changes to a single bit
   affect a corresponding single hardware prefetch type.

For each proposal, an example of the result of writing to the enable
file when all bits of the MSR 0x1A4 are 0 is shown below.

| Value to write          | bit[0] | bit[1] | bit[2] | bit[3] |
|-------------------------|--------|--------|--------|--------|
| A) write 1 to l1/enable | 0      | 0      | 1      | 1      |
| A) write 1 to l2/enable | 1      | 1      | 0      | 0      |
| B) write 1 to l1/enable | 0      | 0      | 1      | 0      |
| B) write 2 to l1/enable | 0      | 0      | 0      | 1      |
| B) write 3 to l2/enable | 1      | 1      | 0      | 0      |

Proposal A is simple, it uniformly controls the enablement of the
hardware prefetch type at a certain cache level. In this case, it is
easy to provide the same interface as the A64FX. However, it cannot
allow the detailed tuning(e.g. Write 1 to only bit[1]).

Proposal B allows the same tuning as direct register access. However,
user needs to know the hardware specifications (e.g. Number of features
that can be enabled via register) to use interface.

We think proposal A is better for providing a standard interface, but it
is a concern that it cannot provide all the features of the register.
Do you have any comments on these proposals?

Best regards,
Kohei Tarumizu

Kohei Tarumizu (5):
  driver: hwpf: Add hardware prefetch core driver register/unregister
    functions
  driver: hwpf: Add support for A64FX to hardware prefetch driver
  driver: hwpf: Add support for Intel to hardware prefetch driver
  driver: hwpf: Add Kconfig/Makefile to build hardware prefetch driver
  docs: ABI: Add sysfs documentation interface of hardware prefetch
    driver

 .../ABI/testing/sysfs-devices-system-cpu      |  58 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/x86/Kconfig                              |  12 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/hwpf/Kconfig                          |  24 +
 drivers/hwpf/Makefile                         |   9 +
 drivers/hwpf/fujitsu_hwpf.c                   | 460 ++++++++++++++++++
 drivers/hwpf/hwpf.c                           | 452 +++++++++++++++++
 drivers/hwpf/intel_hwpf.c                     | 219 +++++++++
 include/linux/hwpf.h                          |  38 ++
 12 files changed, 1288 insertions(+)
 create mode 100644 drivers/hwpf/Kconfig
 create mode 100644 drivers/hwpf/Makefile
 create mode 100644 drivers/hwpf/fujitsu_hwpf.c
 create mode 100644 drivers/hwpf/hwpf.c
 create mode 100644 drivers/hwpf/intel_hwpf.c
 create mode 100644 include/linux/hwpf.h

-- 
2.27.0

