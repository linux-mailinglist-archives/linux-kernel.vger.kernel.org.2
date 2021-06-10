Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918993A21E3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 03:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFJBg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 21:36:29 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56084 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhFJBg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:36:27 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id C19EB2A96F; Wed,  9 Jun 2021 21:34:27 -0400 (EDT)
Message-Id: <cover.1623287706.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 0/2] Use libata platform drivers to replace deprecated m68k IDE drivers
Date:   Thu, 10 Jun 2021 11:15:06 +1000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "Joshua Thompson" <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        "Richard Zidlicky" <rz@linux-m68k.org>,
        "Michael Schmitz" <schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series allows m68k platforms to switch from deprecated IDE
drivers to libata drivers.

Changed since v1:
 - Added reviewed-by and tested-by tags.
 - Improved commit log.

Changed since v2:
 - Added #ifdef guards to prevent build failure when CONFIG_ATARI=n.


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
 drivers/ide/falconide.c           |  79 +++++++++-----
 drivers/ide/macide.c              | 161 ----------------------------
 drivers/ide/q40ide.c              | 168 ------------------------------
 13 files changed, 155 insertions(+), 433 deletions(-)
 delete mode 100644 drivers/ide/macide.c
 delete mode 100644 drivers/ide/q40ide.c

-- 
2.26.3

