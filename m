Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3336EDB8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbhD2P6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhD2P6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:58:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160D0C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:57:31 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 14E4F22173;
        Thu, 29 Apr 2021 17:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619711848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HpaxG8rm84ZVuaYd7aNZxfINyI92WQzUWLGtZtmfac8=;
        b=gJZKOFRG8OKB8slf+vsoR1ECI/6/hpvbWhABptC0NI6f5mYWP5cvSDzBwG2yFRsIsJkjA+
        R+M05qxI2IaYvO3ox4VrS4bKoxuBWh7NrFvHe0mHOqmtYT6w2o4sDk9r8InyaLP254EmS9
        7gUQqsndTdpv3XGzRYBjgPmciTEDEGo=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Williams <awill@google.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 0/2] mtd: spi-nor: support dumping sfdp tables
Date:   Thu, 29 Apr 2021 17:57:11 +0200
Message-Id: <20210429155713.28808-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the possibility to dump the SFDP data of a flash device.

More and more flash devices share the same flash ID and we need per device
fixups. Usually, these fixups differentiate flashes by looking at
differences in the SFDP data. Determining the difference is only possible
if we have the SFDP data for all the flashes which share a flash ID. This
will lay the foundation to dump the whole SFDP data of a flash device.

This is even more important, because some datasheets doesn't even contain
the SFDP data. Fixups for these kind of flashes are nearly impossible to
do.

I envision having a database of all the SFDP data for the flashes we
support and make it a requirement to submit it when a new flash is added.
This might or might not have legal implications. Thus I'd start with having
that database private to the SPI NOR maintainers.

Changes since v2:
 - use .dev_groups of the driver to attach the attributes
 - add manufacturer attribue
 - rename attribute name to partname
 - add ABI documentation

Changes since v1:
 - use sysfs_emit()
 - add comment about the allocation of the sfdp dwords
 - free SFDP memory in the error path
 - use BIN_ATTR_RO(sfdp, 0)
 - use spi_nor_read_sfdp()

Changes since RFC:
 - Don't read SFDP data after probe. The flash might already be switched to
   8D-8D-8D mode. Instead, cache the SFDP data
 - add two sysfs files: jedec-id and name
 - change the file mode of the sfdp file from 0400 to 0444. There is no
   hardware access anymore.

Michael Walle (2):
  mtd: spi-nor: sfdp: save a copy of the SFDP data
  mtd: spi-nor: add initial sysfs support

 .../ABI/testing/sysfs-bus-spi-devices-spi-nor | 31 +++++++
 drivers/mtd/spi-nor/Makefile                  |  2 +-
 drivers/mtd/spi-nor/core.c                    |  1 +
 drivers/mtd/spi-nor/core.h                    | 12 +++
 drivers/mtd/spi-nor/sfdp.c                    | 58 ++++++++++++
 drivers/mtd/spi-nor/sysfs.c                   | 92 +++++++++++++++++++
 include/linux/mtd/spi-nor.h                   |  2 +
 7 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
 create mode 100644 drivers/mtd/spi-nor/sysfs.c

-- 
2.20.1

