Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C31339719
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhCLTGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhCLTGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:06:05 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7995C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:06:05 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 62A1E22238;
        Fri, 12 Mar 2021 20:06:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615575963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=r1NUXsd8CcCDGSgN9MbS4BQVVK/eEe8OH8TuK2TBWdU=;
        b=ftGn2reIyDNiSRy7+ia+andf8S1ds8SvJzrxvkFwFQSaXCjjKQI/9IRiqmBCfT/p/yj6Br
        xdSYqzcSgqh3b5ka6GRW8WUxf7rbHiza67ONaWq8I79FWV+3uWhqHLe8Ch4maVhkdF06is
        8g+F4nnA7ZmP25uO28N/KfTQYkXhnEs=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 1/3] mtd: spi-nor: support dumping sfdp tables
Date:   Fri, 12 Mar 2021 20:05:45 +0100
Message-Id: <20210312190548.6954-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There are two ways to provide access to the SFDP data:
 (1) We just read the SFDP data once and cache it
 (2) Any userspace access will always read the SFDP data

I choose (2) because it isn't as invasive as (1). The current SFDP code
reads the SFDP data only partially and only the part which are actually
used. Using (1) would mean to change that behavior.

Michael Walle (3):
  mtd: spi-nor: sfdp: remember sfdp_size
  mtd: spi-nor: sfdp: fix spi_nor_read_sfdp()
  mtd: spi-nor: add sysfs and SFDP support

 drivers/mtd/spi-nor/Makefile |  2 +-
 drivers/mtd/spi-nor/core.c   |  5 +++
 drivers/mtd/spi-nor/core.h   |  3 ++
 drivers/mtd/spi-nor/sfdp.c   | 24 +++++++++++-
 drivers/mtd/spi-nor/sfdp.h   |  2 +
 drivers/mtd/spi-nor/sysfs.c  | 73 ++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h  |  1 +
 7 files changed, 107 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/sysfs.c

-- 
2.20.1

