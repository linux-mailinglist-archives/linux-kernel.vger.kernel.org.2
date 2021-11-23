Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5F845A04E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhKWKjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:39:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235321AbhKWKjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:39:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE18C60F41;
        Tue, 23 Nov 2021 10:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637663775;
        bh=Q0qoBg6VUv5HTkBCmx18bC2s0i4LoP2nemDb3MvC+LA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZIi543eIIWLnrSxnVVFUAQ7PUVi8zCOq0hl/MUchGAD1kJN06u3Td9u9jlg/BFBZk
         xJqof1RWuYIPD8AMb+93mkhRxgi6O/urULiViMpHJkBjpwtTaobytATwaxwilbE5Xx
         fInJfX3Ae7dTRFSmUx4Yy9MUwDWfiVpdeA7q3DEtORi7vre/HkRWVqnS90dmBdNa8j
         7VQLiqt8jZLDJTtLojp4A6pB0wuhrwImkIGiiPAyk3b/WN8az3js9BJeJgBdBiOY+b
         IhCx968aLbEIf/QQ/7/bQAG5JGYWrATHnMdLoBqOOyCQzM6/ZJTddHXSVSNs27BUA8
         QF3S4xzGdkV4w==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/4] mtd: nand: omap2: Switch to exec_ops, support AM64 SoC
Date:   Tue, 23 Nov 2021 12:36:05 +0200
Message-Id: <20211123103609.14063-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series gets rid of the Legacy ops and switches to exec_ops framework.

Also add driver support for TI's AM64 SoC which contains a GPMC NAND controller.

cheers,
-roger

Roger Quadros (4):
  dt-bindings: mtd: ti,gpmc-nand: Add compatible for AM64 NAND
  mtd: nand: omap2: Allow build on K3 platforms
  mtd: nand: omap2: move to exec_op interface
  mtd: nand: omap2: Add support for NAND Controller on AM64 SoC

 .../devicetree/bindings/mtd/ti,gpmc-nand.yaml |   5 +-
 drivers/mtd/nand/raw/Kconfig                  |   2 +-
 drivers/mtd/nand/raw/omap2.c                  | 525 ++++++++----------
 3 files changed, 251 insertions(+), 281 deletions(-)

-- 
2.17.1

