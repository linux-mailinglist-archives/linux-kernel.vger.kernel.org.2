Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441763435D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 00:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCUXwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 19:52:07 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:60965 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhCUXvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 19:51:49 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C831622172;
        Mon, 22 Mar 2021 00:51:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616370707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bRI73FnBBYgYB1kw6tkuk7W1q2a0kQd5Ln970HaJOPc=;
        b=VoCbSpQebezGTTgzOcvVGeXw/QDLm5MaA0Yc9h6+/594PnEwSwoKA9WTgvXYohwkt8FPxd
        mfD10HfaJBWJUdNw4jHatg/8cfS2MuIEVhacgJM4pWQElSzLtAqDWI6KiEQWQ2lqazSIhd
        CM3x92dqeR36hOILYP4GTeopg4zkL3M=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v5 0/3] mtd: spi-nor: OTP support
Date:   Mon, 22 Mar 2021 00:51:37 +0100
Message-Id: <20210321235140.8308-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements the MTD OTP functions to allow access to the SPI
OTP data. Specific support is added for Winbond flash chips.

In the past there was already an attempt by Rahul Bedarkar to add this, but
there was no response. These patches are slightly based on his work.

https://lore.kernel.org/linux-mtd/1489754636-21461-1-git-send-email-rahul.bedarkar@imgtec.com/

Changes since v4:
 - s/u_char/u8/
 - dropped extra whitespace
 - moved nor->params->otp.org assignment
 - moved spi_nor_otp_init() after spi_nor_init()
 - keep fixups as last property in struct spi_nor_flash_parameter
 - dropped spi_nor_otp_ops()
 - use i instead of region
 - move otp.o to the list of core objects

Changes since v3:
 - remapped the OTP regions to a contiguous area starting at 0. The
   chips/cfi_cmdset_000[12].c remap the regions, too.
 - with that in place, read/write/lock/erase spanning multiple OTP
   regions are possible
 - picked up Tudors review remarks
 - added new erase support as RFC because MTD API/ABI is still missing.
   Feel free to review, but don't apply it.

Changes since v2:
 - improved commit messages
 - add buffer size check in spi_nor_mtd_otp_info(). just to be sure, the
   buffer is hardcoded to 4k by the mtd subsys
 - moved all code to otp.c
 - dropped the patches introduced in v2

Changes since v1:
 - added methods for Macronix and similar flashes
 - added patch to cleanup/consolidate code in core.c

Michael Walle (3):
  mtd: spi-nor: add OTP support
  mtd: spi-nor: implement OTP support for Winbond and similar flashes
  mtd: spi-nor: winbond: add OTP support to w25q32fw/jw

 drivers/mtd/spi-nor/Makefile  |   2 +-
 drivers/mtd/spi-nor/core.c    |   7 +-
 drivers/mtd/spi-nor/core.h    |  60 ++++++
 drivers/mtd/spi-nor/otp.c     | 384 ++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/winbond.c |  17 +-
 include/linux/mtd/spi-nor.h   |   8 +
 6 files changed, 474 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/otp.c

-- 
2.20.1

