Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A6E39FC5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhFHQZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhFHQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623169437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aDHyqkHT8tP5woeTV+rBNHR8on5450qVlxL0Zzlav/M=;
        b=WKd15jttWawYyp5gelo4GVniUUXZ9N8d2g/MLalxdCFPfndKel14ZqBUm2a9zou5AGwfAx
        C4JlZgQQKymRRD2F/eq192eFRcS4MitLCXV70vNqYkyGrjNwx9plTpnhxf1hbiQsDD5duH
        w1FbNWn8+FbA07w4lkUMGGOCGtjcWv4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-04pDp7zaMXqykB7xePQJ9g-1; Tue, 08 Jun 2021 12:23:55 -0400
X-MC-Unique: 04pDp7zaMXqykB7xePQJ9g-1
Received: by mail-ot1-f71.google.com with SMTP id 10-20020a9d0f0a0000b02903c030760be3so2027640ott.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDHyqkHT8tP5woeTV+rBNHR8on5450qVlxL0Zzlav/M=;
        b=ViFHPoUoJF5Bs2b1ntFjLD0+yXcrJzLNfx6UYSQ1URFfORJS/1yzryixt55iUUUyaO
         iW+IVa0hGt254yHOxx4UTptT30olr0/2gjQeFZ+n1AqofJI87XySHlm1lK6nuVRt62WG
         n0Dz2PD9eUy0mDuLnudIRAkBeZYyJ6dx+IJl1hlPjvTUtaIsaF7zpnSP3x+toP7sfeij
         U9wA1kazVPhQyomSPQdMkcHuknehdBZNsab6KPIm4urkrYB0aQetx3UG0jsU6qvCKoSB
         njUReiUuJqfL8OJ1awMGXB6J/SzfyZM79cuvNLI6QyOOoQYLNB/M8foh4lGmk9Gf0XtJ
         VIMw==
X-Gm-Message-State: AOAM53082OCfAxvoWKtfw3ovLOf2oh2IcjWeOPPyFOawayayjV2V+PGy
        6sFOyIv2kouKhHCDEhRlRCyGRZuWj77B6IHmxg8L+weNhgKfXnVBfwbcPqWPoYvmcNGAGqFpGFu
        aUfkUKd/7AbraKgk4gxI4E0ig
X-Received: by 2002:a05:6808:488:: with SMTP id z8mr3357381oid.135.1623169434975;
        Tue, 08 Jun 2021 09:23:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL3V0dlSLYkqToSWjx9Po9II62z4yYLpcjOlV4KUq87+yWIQQ0CfaVL3XV3QpauOYsA+4Gjg==
X-Received: by 2002:a05:6808:488:: with SMTP id z8mr3357367oid.135.1623169434800;
        Tue, 08 Jun 2021 09:23:54 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s4sm3225773otr.80.2021.06.08.09.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:23:54 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        dinguyen@kernel.org, krzysztof.kozlowski@canonical.com,
        nava.manne@xilinx.com, yilun.xu@intel.com, davidgow@google.com,
        fpacheco@redhat.com, richard.gong@intel.com, luca@lucaceresoli.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 0/7] fpga: reorganize to subdirs
Date:   Tue,  8 Jun 2021 09:23:32 -0700
Message-Id: <20210608162340.3010204-1-trix@redhat.com>
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

