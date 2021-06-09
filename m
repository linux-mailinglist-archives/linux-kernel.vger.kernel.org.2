Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106453A170D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhFIOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237805AbhFIOYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623248543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJmqxzT8uSof7JvXwU0e58Z2K6C1TfI+K5YVC+evFiE=;
        b=WN1DWyB/ZTCexxUmtmo/S7HKz7KGD4gk9lenwQXYvT3OO+f1PD6OPzaS8e3+Dsn+visZjN
        GaqzTdgd5UIKSf89WPqQi6bni7mjkgZniEyv572B2vrK+33X4hWOmIx5eQK/4RWH+l7Azw
        F8Ftuy3P8byb/DiXVW0LjBOvwAlgt3o=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-kDYt2MwbPfKndwBLWh9MmQ-1; Wed, 09 Jun 2021 10:22:22 -0400
X-MC-Unique: kDYt2MwbPfKndwBLWh9MmQ-1
Received: by mail-oi1-f197.google.com with SMTP id g203-20020aca39d40000b02901f57bf48250so1182297oia.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJmqxzT8uSof7JvXwU0e58Z2K6C1TfI+K5YVC+evFiE=;
        b=OkBwJsf88ikcHPT7HoZWL4m0jDL3zYLCEI2wEIz/+SI5eLqpKcoLJYU+JmdPwfs3NR
         sWHxvaCzKABKfObNo2NDFIDitfUMxEguHvbUoCc5Fb7goF0kwxdNsNSPD7Xo53HCKNFa
         7gkIhj2UdlagV5TSBRRc00cpRkdRsK/qmG8bcdevuXGgB54knNY15NifFKYr7o/wnias
         6KDqTxVOo9aG2r3FQynUmh27RnLmevtkV6BOLQj8AFW26oIEYUiy2TdhtZZnC9Epaa3V
         M3UXj78HjEA2PppKVSRmjl2QOpj3slcWIFi7Wf0/fZFQ5H0GouzdsGcMSYL/JAoTzM4D
         p8hg==
X-Gm-Message-State: AOAM531DGagFXghSi/B3nQi5MBwE/H74u1cCLoJLjf84Td8bUhB2QLVq
        YAb3UcFm3w4+JMMMSwDkxaNncC/vwFn2FYapHuzboZlHmVEGeCESP9nSZv+DAO/d5HXM9FqY588
        ctzLgDTdAyzOKTztX9+Ozv54S
X-Received: by 2002:a4a:c190:: with SMTP id w16mr131553oop.92.1623248541583;
        Wed, 09 Jun 2021 07:22:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu1WpD4Vw2H8PHe3Y+K4jIkppLYRuWDkmuN8flEkgAaKSMsHNxNDUIeMWZ0aGs6vcS4v0ofw==
X-Received: by 2002:a4a:c190:: with SMTP id w16mr131529oop.92.1623248541400;
        Wed, 09 Jun 2021 07:22:21 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o4sm3414432oon.15.2021.06.09.07.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 07:22:21 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, nava.manne@xilinx.com,
        dinguyen@kernel.org, krzysztof.kozlowski@canonical.com,
        yilun.xu@intel.com, arnd@arndb.de, fpacheco@redhat.com,
        richard.gong@intel.com, luca@lucaceresoli.net
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/4]  fpga: reorganize to subdirs
Date:   Wed,  9 Jun 2021 07:22:04 -0700
Message-Id: <20210609142208.3085451-2-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210609142208.3085451-1-trix@redhat.com>
References: <20210609142208.3085451-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The incoming xrt patchset has a toplevel subdir xrt/
The current fpga/ uses a single dir with filename prefixes to subdivide owners
For consistency, there should be only one way to organize the fpga/ dir.
Because the subdir model scales better, refactor to use it.
The discussion wrt xrt is here:
https://lore.kernel.org/linux-fpga/68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com/

Follow drivers/net/ethernet/ which has control configs
NET_VENDOR_BLA that map to drivers/net/ethernet/bla
Since fpgas do not have many vendors, drop the 'VENDOR' and use
FPGA_BLA.

There are several new subdirs
altera/
dfl/
lattice/
xilinx/

Each subdir has a Kconfig that has a new/reused

if FPGA_BLA
  ... existing configs ...
endif FPGA_BLA

Which is sourced into the main fpga/Kconfig

Each subdir has a Makefile whose transversal is controlled in the
fpga/Makefile by

obj-$(CONFIG_FPGA_BLA) += bla/

Some cleanup to arrange thing alphabetically and make fpga/Makefile's
whitespace look more like net/'s

Changes from
v1
  Drop renaming files
  Cleanup makefiles

Tom Rix (4):
  fpga: dfl: reorganize to subdir layout
  fpga: xilinx: reorganize to subdir layout
  fpga: altera: reorganize to subdir layout
  fpga: lattice: reorganize to subdir layout

 MAINTAINERS                                   |   2 +-
 drivers/fpga/Kconfig                          | 204 +-----------------
 drivers/fpga/Makefile                         |  47 +---
 drivers/fpga/altera/Kconfig                   |  78 +++++++
 drivers/fpga/altera/Makefile                  |  12 ++
 drivers/fpga/{ => altera}/altera-cvp.c        |   0
 drivers/fpga/{ => altera}/altera-fpga2sdram.c |   0
 .../fpga/{ => altera}/altera-freeze-bridge.c  |   0
 drivers/fpga/{ => altera}/altera-hps2fpga.c   |   0
 .../{ => altera}/altera-pr-ip-core-plat.c     |   0
 drivers/fpga/{ => altera}/altera-pr-ip-core.c |   0
 drivers/fpga/{ => altera}/altera-ps-spi.c     |   0
 drivers/fpga/{ => altera}/socfpga-a10.c       |   0
 drivers/fpga/{ => altera}/socfpga.c           |   0
 drivers/fpga/{ => altera}/stratix10-soc.c     |   0
 drivers/fpga/{ => altera}/ts73xx-fpga.c       |   0
 drivers/fpga/dfl/Kconfig                      |  81 +++++++
 drivers/fpga/dfl/Makefile                     |  16 ++
 drivers/fpga/{ => dfl}/dfl-afu-dma-region.c   |   0
 drivers/fpga/{ => dfl}/dfl-afu-error.c        |   0
 drivers/fpga/{ => dfl}/dfl-afu-main.c         |   0
 drivers/fpga/{ => dfl}/dfl-afu-region.c       |   0
 drivers/fpga/{ => dfl}/dfl-afu.h              |   0
 drivers/fpga/{ => dfl}/dfl-fme-br.c           |   0
 drivers/fpga/{ => dfl}/dfl-fme-error.c        |   0
 drivers/fpga/{ => dfl}/dfl-fme-main.c         |   0
 drivers/fpga/{ => dfl}/dfl-fme-mgr.c          |   0
 drivers/fpga/{ => dfl}/dfl-fme-perf.c         |   0
 drivers/fpga/{ => dfl}/dfl-fme-pr.c           |   0
 drivers/fpga/{ => dfl}/dfl-fme-pr.h           |   0
 drivers/fpga/{ => dfl}/dfl-fme-region.c       |   0
 drivers/fpga/{ => dfl}/dfl-fme.h              |   0
 drivers/fpga/{ => dfl}/dfl-n3000-nios.c       |   0
 drivers/fpga/{ => dfl}/dfl-pci.c              |   0
 drivers/fpga/{ => dfl}/dfl.c                  |   0
 drivers/fpga/{ => dfl}/dfl.h                  |   0
 drivers/fpga/lattice/Kconfig                  |  22 ++
 drivers/fpga/lattice/Makefile                 |   4 +
 drivers/fpga/{ => lattice}/ice40-spi.c        |   0
 drivers/fpga/{ => lattice}/machxo2-spi.c      |   0
 drivers/fpga/xilinx/Kconfig                   |  48 +++++
 drivers/fpga/xilinx/Makefile                  |   6 +
 .../fpga/{ => xilinx}/xilinx-pr-decoupler.c   |   0
 drivers/fpga/{ => xilinx}/xilinx-spi.c        |   0
 drivers/fpga/{ => xilinx}/zynq-fpga.c         |   0
 drivers/fpga/{ => xilinx}/zynqmp-fpga.c       |   0
 46 files changed, 280 insertions(+), 240 deletions(-)
 create mode 100644 drivers/fpga/altera/Kconfig
 create mode 100644 drivers/fpga/altera/Makefile
 rename drivers/fpga/{ => altera}/altera-cvp.c (100%)
 rename drivers/fpga/{ => altera}/altera-fpga2sdram.c (100%)
 rename drivers/fpga/{ => altera}/altera-freeze-bridge.c (100%)
 rename drivers/fpga/{ => altera}/altera-hps2fpga.c (100%)
 rename drivers/fpga/{ => altera}/altera-pr-ip-core-plat.c (100%)
 rename drivers/fpga/{ => altera}/altera-pr-ip-core.c (100%)
 rename drivers/fpga/{ => altera}/altera-ps-spi.c (100%)
 rename drivers/fpga/{ => altera}/socfpga-a10.c (100%)
 rename drivers/fpga/{ => altera}/socfpga.c (100%)
 rename drivers/fpga/{ => altera}/stratix10-soc.c (100%)
 rename drivers/fpga/{ => altera}/ts73xx-fpga.c (100%)
 create mode 100644 drivers/fpga/dfl/Kconfig
 create mode 100644 drivers/fpga/dfl/Makefile
 rename drivers/fpga/{ => dfl}/dfl-afu-dma-region.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu-error.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu-main.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu-region.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu.h (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-br.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-error.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-main.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-mgr.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-perf.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-pr.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-pr.h (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-region.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme.h (100%)
 rename drivers/fpga/{ => dfl}/dfl-n3000-nios.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-pci.c (100%)
 rename drivers/fpga/{ => dfl}/dfl.c (100%)
 rename drivers/fpga/{ => dfl}/dfl.h (100%)
 create mode 100644 drivers/fpga/lattice/Kconfig
 create mode 100644 drivers/fpga/lattice/Makefile
 rename drivers/fpga/{ => lattice}/ice40-spi.c (100%)
 rename drivers/fpga/{ => lattice}/machxo2-spi.c (100%)
 create mode 100644 drivers/fpga/xilinx/Kconfig
 create mode 100644 drivers/fpga/xilinx/Makefile
 rename drivers/fpga/{ => xilinx}/xilinx-pr-decoupler.c (100%)
 rename drivers/fpga/{ => xilinx}/xilinx-spi.c (100%)
 rename drivers/fpga/{ => xilinx}/zynq-fpga.c (100%)
 rename drivers/fpga/{ => xilinx}/zynqmp-fpga.c (100%)

-- 
2.26.3

