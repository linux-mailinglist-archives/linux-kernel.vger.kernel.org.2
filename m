Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698C642860A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 06:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhJKEtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 00:49:33 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130]:13399 "EHLO
        esa5.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230102AbhJKEtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 00:49:31 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 00:49:31 EDT
IronPort-SDR: DOEnyVVHj8EcA9rouyjnVrPcXkDj8DRY+/viJeR2tU79Ha/ELXmljnPclORShn9T3QkLkfxKqG
 fDQeMqcGLzOxKwi9YxSQcU88urfO49OkfSgpuIT86k9rpLbxRDKhqSQQs7Dic5stl5Upz7uA6K
 /UZ4r+oXstmYV1yi+rnM231Q7+mwmEryFZVGjY/pHGYNs60cdE86BuhRXwYYVYjQkH8tOfEyEP
 qrJehGJJpqna5Wj8O9RwhDzwXNQ3D/tUikXFmhXOI4wEd+nUjDj6qYFbnFWaqNBPmFedUmsycd
 CaO5noUpRZnIgIN6iI5cryBu
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="48057871"
X-IronPort-AV: E=Sophos;i="5.85,363,1624287600"; 
   d="scan'208";a="48057871"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Oct 2021 13:40:23 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 78EAFEB346
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:40:21 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id B5EA156F77
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:40:20 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 85F624005E9CA;
        Mon, 11 Oct 2021 13:40:20 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [RFC PATCH 0/4] Add hardware prefetch core driver and A64FX support
Date:   Mon, 11 Oct 2021 13:39:48 +0900
Message-Id: <20211011043952.995856-1-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series add hardware prefetch driver register/unregister
function, and support for A64FX processor. The purpose of this driver is
to provide an interface to control the hardware prefetch mechanism
depending on the application characteristics.

An earlier RFC[1] suggested creating a hardware prefetch directory under
/sys/devices/system/cpu/[CPUNUM]/cache.
Surely, hardware prefetch is a cache-related feature, but it does not
require cache sysfs feature, so we decided to isolate the code.
Specifically, we create a hardware prefetch directory under cpu/[CPUNUM].

[1]https://lore.kernel.org/lkml/OSBPR01MB2037D114B11153F00F233F8780389@OSBPR01MB2037.jpnprd01.prod.outlook.com/

Patch organizations are as follows:

- patch1: Add hardware prefetch core driver
  This adds register/unregister function to create the sysfs interface
  with attribute "enable", "dist", and "strong".  Detailed description
  of these are in Documentation/ABI/testing/sysfs-devices-system-cpu.

- patch2: Add support for A64FX
  This adds module init/exit code for A64FX. If someone would like to
  add new support for another environment, refer to this.

- patch3: Add Kconfig/Makefile to build module

- patch4: Add documentation for the new sysfs interface

[Merit]
For reference, here is the result of STREAM Triad when tuning with the
dist file in L1 and L2 cache on A64FX.
In pattern A, we set the size of the array to 174720, which is about
half the size of the L1d cache.
In pattern B, we set the size of the array to 10485120, which is about
twice the size of the L2 cache.

| dist combination  | Pattern A   | Pattern B   |
|-------------------|-------------|-------------|
| L1:256,  L2:1024  | 234505.2144 | 114600.0801 |
| L1:1536, L2:1024  | 279172.8742 | 118979.4542 |
| L1:256,  L2:10240 | 247716.7757 | 127364.1533 |
| L1:1536, L2:10240 | 283675.6625 | 125950.6847 |

In pattern A, a change of dist at L1 has a larger effect. On the other
hand, in pattern B, the change of dist at L2 has a larger effect.
As described above, the optimal dist combination depends on the
characteristics of the application.
Therefore, such a sysfs interface is useful for performance tuning.

[RFC & Future plan]
Please comment on how to handle the enable attribute file in this
chapter.

We plan to support some Intel processors that have MSR 0x1A4[2] in the
same way. The register supports enabling two types of hardware
prefetches for each cache.

[2]https://software.intel.com/content/www/us/en/develop/articles/disclosure-of-hw-prefetcher-control-on-some-intel-processors.html

We would like to assign these features to an enable attribute file,
and consider the two proposals:

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
allow the detailed tuning.

Proposal B allows the same tuning as direct register access. However,
user needs to know the hardware specifications (e.g. Number of features
that can be enabled via register) to use interface.

We think proposal A is better for providing a standard interface, but it
is a concern that it cannot provide all the features of the register.
Do you have any comments on these proposals?

Best regards,
Kohei Tarumizu

Kohei Tarumizu (4):
  driver: hwpf: Add hardware prefetch core driver register/unregister
    functions
  driver: hwpf: Add support for A64FX to hardware prefetch driver
  driver: hwpf: Add Kconfig/Makefile to build hardware prefetch driver
  docs: ABI: Add sysfs documentation interface of hardware prefetch
    driver

 .../ABI/testing/sysfs-devices-system-cpu      |  58 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/Kconfig.platforms                  |   6 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/hwpf/Kconfig                          |  24 +
 drivers/hwpf/Makefile                         |   6 +
 drivers/hwpf/fujitsu_hwpf.c                   | 460 ++++++++++++++++++
 drivers/hwpf/hwpf.c                           | 452 +++++++++++++++++
 include/linux/hwpf.h                          |  38 ++
 10 files changed, 1054 insertions(+)
 create mode 100644 drivers/hwpf/Kconfig
 create mode 100644 drivers/hwpf/Makefile
 create mode 100644 drivers/hwpf/fujitsu_hwpf.c
 create mode 100644 drivers/hwpf/hwpf.c
 create mode 100644 include/linux/hwpf.h

-- 
2.27.0

