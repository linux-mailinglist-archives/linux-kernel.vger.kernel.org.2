Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64593A0E40
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbhFIID0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:03:26 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:38249 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbhFIIDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:03:13 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7FADB200013;
        Wed,  9 Jun 2021 08:01:12 +0000 (UTC)
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
Subject: [PATCH v22 00/18] ARM Primecell PL35x support
Date:   Wed,  9 Jun 2021 10:00:54 +0200
Message-Id: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
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

 .../memory-controllers/arm,pl353-smc.yaml     |  133 ++
 .../bindings/memory-controllers/pl353-smc.txt |   47 -
 .../bindings/mtd/arm,pl353-nand-r2p1.yaml     |   57 +
 MAINTAINERS                                   |   16 +
 drivers/memory/pl353-smc.c                    |  314 +----
 drivers/mtd/nand/raw/Kconfig                  |    8 +
 drivers/mtd/nand/raw/Makefile                 |    1 +
 drivers/mtd/nand/raw/pl35x-nand-controller.c  | 1194 +++++++++++++++++
 include/linux/pl353-smc.h                     |   30 -
 9 files changed, 1419 insertions(+), 381 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
 create mode 100644 drivers/mtd/nand/raw/pl35x-nand-controller.c
 delete mode 100644 include/linux/pl353-smc.h

-- 
2.27.0

