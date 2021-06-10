Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B183A2675
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhFJIWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:22:42 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49173 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:22:41 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C976720008;
        Thu, 10 Jun 2021 08:20:40 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, helmut.grohne@intenta.de,
        Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v23 00/18] ARM Primecell PL35x support
Date:   Thu, 10 Jun 2021 10:20:22 +0200
Message-Id: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am taking over Naga's series, here are the major changes:
* Cleaning of the SMC bus binding file (and yaml conversion)
* Superficial cleaning and great simplification of the SMC bus driver
* Addition of a yaml file describing the NAND controller
* Full rework of the NAND controller driver. JFFS2 and UBIFS not tested
  yet, only bare test tools have been used to proove basic correctness
  of the helpers.
* Addition of a couple of MAINTAINERS entries.

A Github branch named pl353 is available on my repository:
https://github.com/miquelraynal/linux/

Thanks,
Miquèl

Changes in v23:
- Collected Naga Acked-by's.
- Used const instead of single enum entries in the bindings.
- Dropped the address-cells/size-cells superfluous definitions out of
  the NAND controller binding.
- Enhanced the SMC reg property description to mention that the various
  CS are described in the ranges property.
- Fixed the SMC child nodes regex to match Rob's requirements.

Changes in v22:
- Misc typo fixes.
- Light rewording of a few commit titles.
- Not forgetting to Cc: Rob and Krzysztof this time...

Changes in v21:
- Added Rob's Acked-by/Reviewed-by tags.
- Addressed all comments from Rob and Michael about the bindings.
- Tested both JFFS2 and UBIFS with simple file I/O.

Miquel Raynal (18):
  dt-binding: memory: pl353-smc: Rephrase the binding
  dt-binding: memory: pl353-smc: Document the range property
  dt-binding: memory: pl353-smc: Drop the partitioning section
  dt-binding: memory: pl353-smc: Describe the child reg property
  dt-binding: memory: pl353-smc: Fix the example syntax and style
  dt-binding: memory: pl353-smc: Drop unsupported nodes from the example
  dt-binding: memory: pl353-smc: Fix the NAND controller node in the
    example
  dt-binding: memory: pl353-smc: Enhance the description of the reg
    property
  dt-binding: memory: pl353-smc: Convert to yaml
  memory: pl353-smc: Fix style
  memory: pl353-smc: Rename goto labels
  memory: pl353-smc: Let lower level controller drivers handle inits
  memory: pl353-smc: Avoid useless acronyms in descriptions
  memory: pl353-smc: Declare variables following a reverse christmas
    tree order
  MAINTAINERS: Add PL353 SMC entry
  MAINTAINERS: Add PL353 NAND controller entry
  dt-bindings: mtd: pl353-nand: Describe this hardware controller
  mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller

 .../memory-controllers/arm,pl353-smc.yaml     |  131 ++
 .../bindings/memory-controllers/pl353-smc.txt |   47 -
 .../bindings/mtd/arm,pl353-nand-r2p1.yaml     |   53 +
 MAINTAINERS                                   |   16 +
 drivers/memory/pl353-smc.c                    |  314 +----
 drivers/mtd/nand/raw/Kconfig                  |    8 +
 drivers/mtd/nand/raw/Makefile                 |    1 +
 drivers/mtd/nand/raw/pl35x-nand-controller.c  | 1194 +++++++++++++++++
 include/linux/pl353-smc.h                     |   30 -
 9 files changed, 1413 insertions(+), 381 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
 create mode 100644 drivers/mtd/nand/raw/pl35x-nand-controller.c
 delete mode 100644 include/linux/pl353-smc.h

-- 
2.27.0

