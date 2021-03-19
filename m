Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1F3428FE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 00:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhCSXB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 19:01:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9606 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCSXBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 19:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616194890; x=1647730890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Qf9TjLEkAqG4lRDNO3udtS6r3hubcbTqxRFi+Zi17s=;
  b=NACbrIjIU8KEKvF9OQzywLjnG9iUahb2cC0tQtp7B70OF1yyxu6+UXEz
   to51wCoViBHGx7j8cMEpbijXtrbU5DUI8ziVKmCREKQqd13NdIj7En2rA
   xljGBDhPFQ5P51dBcdYOBZlK9XBAqXyYORjW0IyYUtDvnbdDS0f80oDY1
   tGejuBx8Fx1NOdMwRdw5KUdlDVhiXvuVGPisu+UxWkcX+IAH+WMXZXBNI
   hPXMxxh9rmIGT/isfGpNGEebtrS5vAqrPr3S2WUTCEU7jRgN0JqxuJtNC
   KQnCy1IhEpC4qDaXykYCQuLSDrd9oJKvQB/IzPEVaDxUNXjllKYNZwvBk
   g==;
IronPort-SDR: FGmmBp/cNX3Msdhnibsf1j25xY1rTDAecLNBih5y7OKo8kJ5SeuRiK2CsRIEIzHELblZ5tCXTu
 il5/nZsz780c9+y0lKsPkCo5uBRJXXspJJNhwMeBPsAXjharCK+0OMPu+XYO6B/E8lagKfa6Pu
 3ejO9ZQQiYOHtD4qp2P9aPKVNJ7m5sTro3WpJwyH4sNeM+UKZl1ZpeT9Ey7xJN3AnahJlDlRLb
 nrbi6lU3R0np7syq9ZMXgFidISuzUNDRYS6SKonGkZmVVx8+i53PTTVgsz0Ng11TQyuIe7itE7
 Bic=
X-IronPort-AV: E=Sophos;i="5.81,263,1610380800"; 
   d="scan'208";a="162584053"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2021 07:01:30 +0800
IronPort-SDR: nFo00SuFaCLLERylqeZfcCaUv0qZm/tfgvKExoC6wFR9iB/TjTW4KCVIUltNxdz3CYJhIsFUWW
 VcmAAtBOCfSNU+bUJ/J18rOuKJTUurx9yymrqmCSjnlQZkC+IV2hoidnYSp4nejdzecsL9624x
 65D8Fz1y3csnzApEDfuxhKkMcT7ZRWWEFq7+kxRadzNRFd9U8/Fcmf12gsa/3LRIspf2xWD3sE
 +D7UJFEHGsDCas9N/b9knPDJXz5SHoQupATdrl8NV2m9Sh42CimRK9AjyPz5P5jYoKaIRF0r0M
 267IEdVBnM4Rw+hCDmaPaeGg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 15:43:42 -0700
IronPort-SDR: WtbzaVxxfmKWmKaOXP5pznJullm99yE0eUrF+pcc3X67ZA2teNqDg/5mqnH/pqLQ8p5bDiZJ7Y
 BKlWPB4SQvzjLVYenj3iT1eQSp0NJicFWRa7O3+kedm05yHtuGFl1jtrHJIoX2XyOHR/zDP3/l
 YLl7zXgwedkr5FFawG/emmG5xrR92bfhr6KKCOgLIEcUMuEEX5hLKCyazVIlqoAunaiPwYvmro
 2ugrHrYOV3phGH2iUpRBfBcdB+ENC8X2zA0PC64n+TgiG7O1/VQfn9kgQYeDpSl/6j93PX4itp
 gm0=
WDCIronportException: Internal
Received: from ind002560.ad.shared (HELO jedi-01.hgst.com) ([10.86.48.105])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2021 16:01:30 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 0/6] Improve RISC-V Perf support using SBI PMU extension
Date:   Fri, 19 Mar 2021 16:01:00 -0700
Message-Id: <20210319230106.2186694-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds improved perf support for RISC-V based system using
SBI PMU extension[1]. It is based on a platform driver instead of a existing
arch specific implementation. The core platform driver is implemented in
such a way that most of the generic event handling is done in the core driver
while individual PMUs need to only implement necessary features specific to
the PMU. This is easily extensible and any future RISC-V PMU implementation
can leverage this. Currently, SBI PMU driver & legacy PMU driver are implemented
as a part of this series.

The SBI based driver provides more advanced features such as event configure
start/stop. This version does not implement counter overflow
& filtering yet. That will implemented in the future on top of this series
using "Sscof" extension. The RISC-V perf documentation will also be updated
at that time with all the bits.

The legacy driver tries to reimplement the existing minimal perf under a new
config to maintain backward compatibility. This implementation only allows
monitoring of always running cycle/instruction counters. Moreover, they can
not be started or stopped. In general, this is very limited and not very useful.
That's why, I am not very keen to carry the support into the new driver.
However, I don't want to break perf for any existing hardware platforms.
If nobody really uses perf currently, I will be happy to drop PATCH 4.

This series has been tested in Qemu on RV64 only. Qemu[2] & OpenSBI [3] patches
are required to test it. Qemu changes are not backward compatible. That means,
you can not use perf anymore on older Qemu versions with latest OpenSBI
and/or Kernel. However, newer kernel will just use legacy pmu driver if
old OpenSBI is detected or hardware doesn't implement mcountinhibit.

Here is an output of perf stat while running hackbench.

[root@fedora-riscv riscv]# perf stat -e r8000000000000007 -e r8000000000000006 \
-e r0000000000000002 -e r0000000000000004 -e branch-misses -e cache-misses \
-e cycles -e instructions ./hackbench -pipe 15 process 15

Running with 15*40 (== 600) tasks.
Time: 1.548

 Performance counter stats for './hackbench -pipe 15 process 15':

             7,103      r8000000000000007     (62.56%) --> SBI_PMU_FW_IPI_RECVD
             7,767      r8000000000000006     (12.19%) --> SBI_PMU_FW_IPI_SENT
                 0      r0000000000000002     (24.79%) --> a custom raw event described in DT
     <not counted>      r0000000000000004     (0.00%)  --> non-supported raw event described in DT
                 0      branch-misses         (12.65%) 
                 0      cache-misses          (25.36%)
    27,978,868,702      cycles                (38.12%)
    27,849,527,556      instructions          # 1.00  insn per cycle  (50.46%)

       2.431195184 seconds time elapsed

       1.553153000 seconds user
      13.615924000 seconds sys

The patches can also be found in the github[4].

[1] https://lists.riscv.org/g/tech-unixplatformspec/message/598
[2] https://github.com/atishp04/qemu/tree/riscv_pmu_v1
[3] https://github.com/atishp04/opensbi/tree/riscv_pmu_v1
[4] https://github.com/atishp04/linux/tree/riscv_pmu_v1

Atish Patra (6):
RISC-V: Remove the current perf implementation
RISC-V: Add CSR encodings for all HPMCOUNTERS
RISC-V: Add a perf core platform driver
RISC-V: Add a simple platform driver for RISC-V legacy perf
RISC-V: Add RISC-V SBI PMU extension definitions
RISC-V: Add perf platform driver based on SBI PMU extension

arch/riscv/Kconfig                  |  13 -
arch/riscv/include/asm/csr.h        |  58 ++++
arch/riscv/include/asm/perf_event.h |  72 -----
arch/riscv/include/asm/sbi.h        |  80 +++++
arch/riscv/kernel/Makefile          |   1 -
arch/riscv/kernel/perf_event.c      | 485 ----------------------------
drivers/perf/Kconfig                |  25 ++
drivers/perf/Makefile               |   5 +
drivers/perf/riscv_pmu.c            | 397 +++++++++++++++++++++++
drivers/perf/riscv_pmu_legacy.c     |  88 +++++
drivers/perf/riscv_pmu_sbi.c        | 464 ++++++++++++++++++++++++++
include/linux/cpuhotplug.h          |   1 +
include/linux/perf/riscv_pmu.h      |  61 ++++
13 files changed, 1179 insertions(+), 571 deletions(-)
delete mode 100644 arch/riscv/kernel/perf_event.c
create mode 100644 drivers/perf/riscv_pmu.c
create mode 100644 drivers/perf/riscv_pmu_legacy.c
create mode 100644 drivers/perf/riscv_pmu_sbi.c
create mode 100644 include/linux/perf/riscv_pmu.h

--
2.25.1

