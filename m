Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0402B39EE80
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFHGGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:06:24 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:38422 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhFHGGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:06:21 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 286432AD5E; Tue,  8 Jun 2021 02:04:25 -0400 (EDT)
Message-Id: <cover.1623131194.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 0/2] Use libata platform drivers to replace deprecated m68k IDE drivers
Date:   Tue, 08 Jun 2021 15:46:34 +1000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        "Joshua Thompson" <funaho@jurai.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        "Richard Zidlicky" <rz@linux-m68k.org>,
        "Michael Schmitz" <schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series allows m68k platforms to switch from deprecated IDE
drivers to libata drivers.

Changed since v1:
 - Added reviewed-by and tested-by tags.
 - Improved commit logs.


Finn Thain (2):
  m68k/mac: Replace macide driver with generic platform drivers
  m68k/q40: Replace q40ide driver with pata_falcon and falconide

 arch/m68k/atari/config.c          |  12 +--
 arch/m68k/configs/mac_defconfig   |   1 -
 arch/m68k/configs/multi_defconfig |   2 -
 arch/m68k/configs/q40_defconfig   |   2 +-
 arch/m68k/mac/config.c            |  24 +++--
 arch/m68k/q40/config.c            |  37 +++++--
 drivers/ata/Kconfig               |   6 +-
 drivers/ata/pata_falcon.c         |  62 ++++++++---
 drivers/ide/Kconfig               |  32 +-----
 drivers/ide/Makefile              |   2 -
 drivers/ide/falconide.c           |  75 ++++++++-----
 drivers/ide/macide.c              | 161 ----------------------------
 drivers/ide/q40ide.c              | 168 ------------------------------
 13 files changed, 151 insertions(+), 433 deletions(-)
 delete mode 100644 drivers/ide/macide.c
 delete mode 100644 drivers/ide/q40ide.c

-- 
2.26.3

