Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A909D3B0E16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhFVUH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232462AbhFVUHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624392335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+7yL79kXlqJ1cF+wnNe/WiHmKwK4NVGvHq2uE2hHHEM=;
        b=Hn1iUzwaM9PNdWmXpp3Ml8Tet2s/fkcnb+dgGKclCxpEE2c/05IBVKzFWh1Xiwdpu9LxdQ
        aHLZBbwOZibP+lQkE5Y40fTPQnycn6DAWMWhe+4i7jocXX7k8uMq2alAuX1dS1ohvaGcna
        huOc9U09jAzyNU1D7Xl3fAFBvf3EzXs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-Gm1FQB2pP4aAkYSa9nEuAg-1; Tue, 22 Jun 2021 16:05:33 -0400
X-MC-Unique: Gm1FQB2pP4aAkYSa9nEuAg-1
Received: by mail-oo1-f69.google.com with SMTP id e25-20020a4ab9990000b029024aa2670b1cso284268oop.21
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+7yL79kXlqJ1cF+wnNe/WiHmKwK4NVGvHq2uE2hHHEM=;
        b=Sx737Foeb2OzrsBCrO49rVYKZ3FJ0qK0kjf6Kqjyec1yItY7Or5458us7MHKOpE14P
         RWaEomjyxxApAJNJL6z2/s+8vzJJJuhzaDdECraqqXJoCvWUSNdY95fuSNYAzVuZ3nWJ
         45Yb01OMuJ8Qk3O2Lotq/Cf49bc3nPfpQ69UBUV8PzZNBr0kvOT70PWmNhiqSLANevvy
         30jZ//7ThjnZ9qwHx0QsJnRspzeIczAYzWjlhIKYj+gXZASc8+5IMXXItpf2bynbVrt/
         LWj6n5mGPKbhQGsaLlR46hwmc6NI9GKOYlr3CkWECBA/RjCPlavUzV5E+kk3M8AFM8HL
         aoTQ==
X-Gm-Message-State: AOAM5336uCHulGUl63b88uu9m8eFTkKKYvoqDJFzeYxxg9Xf1VQrRG0X
        NF8IKPgRH9d5p40Chn1yYP4u5b9jSdJwh4/OYUTJLyymVniadLmo0RLT1190/fw/VncXUsC/peX
        YjoRdW7/Zp16AWxNhWjVlLwoZ
X-Received: by 2002:a4a:8901:: with SMTP id f1mr2411642ooi.66.1624392333212;
        Tue, 22 Jun 2021 13:05:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3dnFMjbbQ8plJaDFAWlMQYqm2DfJBNA/R99XQY8DnX1W7mOpVij0632BgGrJXlchtHXj6Gg==
X-Received: by 2002:a4a:8901:: with SMTP id f1mr2411622ooi.66.1624392332999;
        Tue, 22 Jun 2021 13:05:32 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 5sm727184oot.29.2021.06.22.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 13:05:32 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        davidgow@google.com, fpacheco@redhat.com,
        russell.h.weight@intel.com, richard.gong@intel.com,
        luca@lucaceresoli.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v5 0/4]  fpga: reorganize to subdirs
Date:   Tue, 22 Jun 2021 13:05:06 -0700
Message-Id: <20210622200511.3739914-1-trix@redhat.com>
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

Some cleanup to arrange thing alphabetically and make fpga/Makefile's
whitespace look more like net/'s

Changes from
v1
  Drop renaming files
  Cleanup makefiles

v2
  Expand commit messages
  Add SPDX to Kconfig
  Expand new Kconfig variable help messages

v3
  Update Documentation/fpga/dfl.rst for fpga/dfl/

v4
  Restore HAS_IOMEM depends in dfl/Kconfig
  Fix vendor names in Kconfig's

Tom Rix (4):
  fpga: dfl: reorganize to subdir layout
  fpga: xilinx: reorganize to subdir layout
  fpga: altera: reorganize to subdir layout
  fpga: lattice: reorganize to subdir layout

 Documentation/fpga/dfl.rst                    |   4 +-
 MAINTAINERS                                   |   2 +-
 drivers/fpga/Kconfig                          | 204 +-----------------
 drivers/fpga/Makefile                         |  47 +---
 drivers/fpga/altera/Kconfig                   |  85 ++++++++
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
 drivers/fpga/dfl/Kconfig                      |  83 +++++++
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
 drivers/fpga/lattice/Kconfig                  |  29 +++
 drivers/fpga/lattice/Makefile                 |   4 +
 drivers/fpga/{ => lattice}/ice40-spi.c        |   0
 drivers/fpga/{ => lattice}/machxo2-spi.c      |   0
 drivers/fpga/xilinx/Kconfig                   |  55 +++++
 drivers/fpga/xilinx/Makefile                  |   6 +
 .../fpga/{ => xilinx}/xilinx-pr-decoupler.c   |   0
 drivers/fpga/{ => xilinx}/xilinx-spi.c        |   0
 drivers/fpga/{ => xilinx}/zynq-fpga.c         |   0
 drivers/fpga/{ => xilinx}/zynqmp-fpga.c       |   0
 47 files changed, 305 insertions(+), 242 deletions(-)
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

