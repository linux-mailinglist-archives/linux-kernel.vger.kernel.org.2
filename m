Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532B53A156A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhFINYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhFINYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623244974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aDHyqkHT8tP5woeTV+rBNHR8on5450qVlxL0Zzlav/M=;
        b=hX5ChmGqKQnwoFrEOjBEqySXpX1r1mWRO/suEvZ+F9zdFyp2kmO09jh7zLLXyddO8cN27v
        iTSSUHxGQMFnoC8yXjKfyy1dAmoy+iIB0OolOBuh61ZEtPQS75G72z4GSPYwPUcVw8trl7
        BxGiCbKUMkf0TWdcBLPG03YkuemniuE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-vfc8UqTCNi-fq4OsLyFwXQ-1; Wed, 09 Jun 2021 09:22:53 -0400
X-MC-Unique: vfc8UqTCNi-fq4OsLyFwXQ-1
Received: by mail-oo1-f71.google.com with SMTP id o2-20020a4ad4820000b0290208a2516d36so15518185oos.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDHyqkHT8tP5woeTV+rBNHR8on5450qVlxL0Zzlav/M=;
        b=a/kqv5vxY4frMmRcBRpL6826EXEvqsoRTUh7d59h1UJczSI/jihxvuR0trQ24LL6xU
         yabqHn7Gj71yWp9QGKPpze6holqLTqfWK0aIIZ1A1p5fade4PCV82UGEhZH+i8SM9oNt
         DXILgfpXPyAZFLzrs1VBPQgFFZ39gHcOJX6Hk0RAjEVSGXumRjWSNdxoi5a8tCwM6bzx
         Ura2cyn+LZ+c5btiStOoepZg3A+x7XgWbP22RnKLlU9ZBh8hbD6G26cYVBrL1vZ4WooH
         oQTkVnodUASUZXdvYwY6cobXhOiENBVu7+ha2rIaAE68PjVqv7JV8sdoqzl0gZuRuAHK
         Doxg==
X-Gm-Message-State: AOAM530H2W8KXElDHpCltxfxDgeMXV4kax+UIjoBMkEkwzmQIs3Je/iX
        aGksEdsX1vy+V0HMQc0SZA/F1PW5B+mR/ABuaAJMLHTLyXGviSz2SxXyhi6lrermbNPoFOovnBq
        KqbahGWi0OhLqTkQYmp93cTRi
X-Received: by 2002:aca:5f8b:: with SMTP id t133mr6219340oib.163.1623244972741;
        Wed, 09 Jun 2021 06:22:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn5lanWywWdbV93OBtRDUPMoGU8oADrAe7cVkY1A5c8p/LtBg0gJ/mQGxaIqK7JjoP2FBKDw==
X-Received: by 2002:aca:5f8b:: with SMTP id t133mr6219330oib.163.1623244972568;
        Wed, 09 Jun 2021 06:22:52 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 21sm3165654otd.21.2021.06.09.06.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:22:52 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 0/7] fpga: reorganize to subdirs
Date:   Wed,  9 Jun 2021 06:21:43 -0700
Message-Id: <20210609132151.3081379-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
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

For many of the moved files, they had a prefix bla-* that matched their
new subdir dir name bla/.  Those filename are overspecified.  So they
were simplified by removing the 'bla-' prefix.  If they were *.h files
their guards were also changed.

Some cleanup to arrange thing alphabetically and make fpga/Makefile's
whitespace look more like net/'s

Tom Rix (7):
  fpga: dfl: reorganize to subdir layout
  fpga: xilinx: reorganize to subdir layout
  fpga: altera: reorganize to subdir layout
  fpga: lattice: reorganize to subdir layout
  fpga: dfl: remove dfl- prefix on files
  fpga: xilinx: remove xilinx- prefix on files
  fpga: altera: remove altera- prefix on files

 Documentation/fpga/dfl.rst                    |   4 +-
 MAINTAINERS                                   |   2 +-
 drivers/fpga/Kconfig                          | 204 +-----------------
 drivers/fpga/Makefile                         |  47 +---
 drivers/fpga/altera/Kconfig                   |  79 +++++++
 drivers/fpga/altera/Makefile                  |  12 ++
 drivers/fpga/{altera-cvp.c => altera/cvp.c}   |   0
 .../fpga2sdram.c}                             |   0
 .../freeze-bridge.c}                          |   0
 .../{altera-hps2fpga.c => altera/hps2fpga.c}  |   0
 .../pr-ip-core-plat.c}                        |   0
 .../pr-ip-core.c}                             |   0
 .../fpga/{altera-ps-spi.c => altera/ps-spi.c} |   0
 drivers/fpga/{ => altera}/socfpga-a10.c       |   0
 drivers/fpga/{ => altera}/socfpga.c           |   0
 drivers/fpga/{ => altera}/stratix10-soc.c     |   0
 drivers/fpga/{ => altera}/ts73xx-fpga.c       |   0
 drivers/fpga/dfl/Kconfig                      |  80 +++++++
 drivers/fpga/dfl/Makefile                     |  17 ++
 .../afu-dma-region.c}                         |   2 +-
 .../fpga/{dfl-afu-error.c => dfl/afu-error.c} |   2 +-
 .../fpga/{dfl-afu-main.c => dfl/afu-main.c}   |   2 +-
 .../{dfl-afu-region.c => dfl/afu-region.c}    |   2 +-
 drivers/fpga/{dfl-afu.h => dfl/afu.h}         |   6 +-
 drivers/fpga/{ => dfl}/dfl.c                  |   0
 drivers/fpga/{ => dfl}/dfl.h                  |   0
 drivers/fpga/{dfl-fme-br.c => dfl/fme-br.c}   |   2 +-
 .../fpga/{dfl-fme-error.c => dfl/fme-error.c} |   2 +-
 .../fpga/{dfl-fme-main.c => dfl/fme-main.c}   |   2 +-
 drivers/fpga/{dfl-fme-mgr.c => dfl/fme-mgr.c} |   2 +-
 .../fpga/{dfl-fme-perf.c => dfl/fme-perf.c}   |   2 +-
 drivers/fpga/{dfl-fme-pr.c => dfl/fme-pr.c}   |   4 +-
 drivers/fpga/{dfl-fme-pr.h => dfl/fme-pr.h}   |   6 +-
 .../{dfl-fme-region.c => dfl/fme-region.c}    |   2 +-
 drivers/fpga/{dfl-fme.h => dfl/fme.h}         |   6 +-
 .../{dfl-n3000-nios.c => dfl/n3000-nios.c}    |   0
 drivers/fpga/{dfl-pci.c => dfl/pci.c}         |   0
 drivers/fpga/lattice/Kconfig                  |  22 ++
 drivers/fpga/lattice/Makefile                 |   4 +
 drivers/fpga/{ => lattice}/ice40-spi.c        |   0
 drivers/fpga/{ => lattice}/machxo2-spi.c      |   0
 drivers/fpga/xilinx/Kconfig                   |  48 +++++
 drivers/fpga/xilinx/Makefile                  |   8 +
 .../pr-decoupler.c}                           |   0
 drivers/fpga/{xilinx-spi.c => xilinx/spi.c}   |   0
 drivers/fpga/{ => xilinx}/zynq-fpga.c         |   0
 drivers/fpga/{ => xilinx}/zynqmp-fpga.c       |   0
 47 files changed, 306 insertions(+), 263 deletions(-)
 create mode 100644 drivers/fpga/altera/Kconfig
 create mode 100644 drivers/fpga/altera/Makefile
 rename drivers/fpga/{altera-cvp.c => altera/cvp.c} (100%)
 rename drivers/fpga/{altera-fpga2sdram.c => altera/fpga2sdram.c} (100%)
 rename drivers/fpga/{altera-freeze-bridge.c => altera/freeze-bridge.c} (100%)
 rename drivers/fpga/{altera-hps2fpga.c => altera/hps2fpga.c} (100%)
 rename drivers/fpga/{altera-pr-ip-core-plat.c => altera/pr-ip-core-plat.c} (100%)
 rename drivers/fpga/{altera-pr-ip-core.c => altera/pr-ip-core.c} (100%)
 rename drivers/fpga/{altera-ps-spi.c => altera/ps-spi.c} (100%)
 rename drivers/fpga/{ => altera}/socfpga-a10.c (100%)
 rename drivers/fpga/{ => altera}/socfpga.c (100%)
 rename drivers/fpga/{ => altera}/stratix10-soc.c (100%)
 rename drivers/fpga/{ => altera}/ts73xx-fpga.c (100%)
 create mode 100644 drivers/fpga/dfl/Kconfig
 create mode 100644 drivers/fpga/dfl/Makefile
 rename drivers/fpga/{dfl-afu-dma-region.c => dfl/afu-dma-region.c} (99%)
 rename drivers/fpga/{dfl-afu-error.c => dfl/afu-error.c} (99%)
 rename drivers/fpga/{dfl-afu-main.c => dfl/afu-main.c} (99%)
 rename drivers/fpga/{dfl-afu-region.c => dfl/afu-region.c} (99%)
 rename drivers/fpga/{dfl-afu.h => dfl/afu.h} (98%)
 rename drivers/fpga/{ => dfl}/dfl.c (100%)
 rename drivers/fpga/{ => dfl}/dfl.h (100%)
 rename drivers/fpga/{dfl-fme-br.c => dfl/fme-br.c} (99%)
 rename drivers/fpga/{dfl-fme-error.c => dfl/fme-error.c} (99%)
 rename drivers/fpga/{dfl-fme-main.c => dfl/fme-main.c} (99%)
 rename drivers/fpga/{dfl-fme-mgr.c => dfl/fme-mgr.c} (99%)
 rename drivers/fpga/{dfl-fme-perf.c => dfl/fme-perf.c} (99%)
 rename drivers/fpga/{dfl-fme-pr.c => dfl/fme-pr.c} (99%)
 rename drivers/fpga/{dfl-fme-pr.h => dfl/fme-pr.h} (96%)
 rename drivers/fpga/{dfl-fme-region.c => dfl/fme-region.c} (98%)
 rename drivers/fpga/{dfl-fme.h => dfl/fme.h} (95%)
 rename drivers/fpga/{dfl-n3000-nios.c => dfl/n3000-nios.c} (100%)
 rename drivers/fpga/{dfl-pci.c => dfl/pci.c} (100%)
 create mode 100644 drivers/fpga/lattice/Kconfig
 create mode 100644 drivers/fpga/lattice/Makefile
 rename drivers/fpga/{ => lattice}/ice40-spi.c (100%)
 rename drivers/fpga/{ => lattice}/machxo2-spi.c (100%)
 create mode 100644 drivers/fpga/xilinx/Kconfig
 create mode 100644 drivers/fpga/xilinx/Makefile
 rename drivers/fpga/{xilinx-pr-decoupler.c => xilinx/pr-decoupler.c} (100%)
 rename drivers/fpga/{xilinx-spi.c => xilinx/spi.c} (100%)
 rename drivers/fpga/{ => xilinx}/zynq-fpga.c (100%)
 rename drivers/fpga/{ => xilinx}/zynqmp-fpga.c (100%)

-- 
2.26.3

