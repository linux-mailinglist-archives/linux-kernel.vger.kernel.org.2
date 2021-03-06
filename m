Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA5A32F71A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCFAGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhCFAFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:05:50 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6973EC061761
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:05:50 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 144DB22205;
        Sat,  6 Mar 2021 01:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614989146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Uoux/O1JWx+NLbrxspPKrHa/J//QkiAqvm8Eira3vg=;
        b=GwWx8WXP9kh/IPmsql821t23VrYqfX66wYLwdOyrg+qz7DB2NKGotL2loKOe1wXbDE7xf5
        D+GGfapUc3JHlFAvPOQnC92T2T+nkqREhTkYq0DT5Aeps5yizTHtv0hpx9RGCBTHlMu3v/
        UYYd5V3cisV7bjHsicgXjaWiGVa6z6k=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 0/4] mtd: spi-nor: OTP support
Date:   Sat,  6 Mar 2021 01:05:31 +0100
Message-Id: <20210306000535.9890-1-michael@walle.cc>
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

Michael Walle (4):
  mtd: spi-nor: add OTP support
  mtd: spi-nor: implement OTP support for Winbond and similar flashes
  mtd: spi-nor: winbond: add OTP support to w25q32fw/jw
  mtd: spi-nor: implement OTP erase for Winbond and similar flashes

 drivers/mtd/spi-nor/Makefile  |   1 +
 drivers/mtd/spi-nor/core.c    |  11 +-
 drivers/mtd/spi-nor/core.h    |  64 +++++
 drivers/mtd/spi-nor/otp.c     | 453 ++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/winbond.c |  18 +-
 include/linux/mtd/spi-nor.h   |   9 +
 6 files changed, 551 insertions(+), 5 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/otp.c

-- 
2.20.1

