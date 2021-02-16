Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838C631CE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhBPQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBPQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:29:00 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E1C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:28:19 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BCCC522248;
        Tue, 16 Feb 2021 17:28:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1613492894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GagM9WdMfz33aie7QH1eVG9LgSqmihow7mI6uFthL5Y=;
        b=uv2mt67W+kK8JKh7djZuT7Wp0mBYuTmI/2bX8+l37Z6swenzZY5mx1k7xbACS5H8qQIhpL
        Kso05zfPo9hHJvsD0fYM++qaOMiorg5AVizlzBKDV8BD5X/wN+K4Hr43KgUjHsgKZHyFJl
        /P8rHUmO4EP3G4+cVVd0ZRnaEl5zy1o=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 0/2] mtd: spi-nor: OTP support
Date:   Tue, 16 Feb 2021 17:28:05 +0100
Message-Id: <20210216162807.13509-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first version of this patchset was posted over a year ago and since
then, there was not a single comment. I have to admit, this is rather
frustrating. I've now stripped down the patchset to only two patches and
moved the code into an own module otp.c. If you like, I can also add myself
to a reviewer for the OTP code.

This patchset implements the MTD OTP functions to allow access to the SPI
OTP data. Specific support is added for Winbond flash chips.

In the past there was already an attempt by Rahul Bedarkar to add this, but
there was no response. These patches are slightly based on his work.

https://lore.kernel.org/linux-mtd/1489754636-21461-1-git-send-email-rahul.bedarkar@imgtec.com/

Changes since v2:
 - improved commit messages
 - add buffer size check in spi_nor_mtd_otp_info(). just to be sure, the
   buffer is hardcoded to 4k by the mtd subsys
 - moved all code to otp.c
 - dropped the patches introduced in v2

Changes since v1:
 - added methods for Macronix and similar flashes
 - added patch to cleanup/consolidate code in core.c

Michael Walle (2):
  mtd: spi-nor: add OTP support
  mtd: spi-nor: implement OTP support for Winbond and similar flashes

 drivers/mtd/spi-nor/Makefile  |   1 +
 drivers/mtd/spi-nor/core.c    |  10 +-
 drivers/mtd/spi-nor/core.h    |  56 ++++++
 drivers/mtd/spi-nor/otp.c     | 313 ++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/winbond.c |  17 +-
 include/linux/mtd/spi-nor.h   |   9 +
 6 files changed, 403 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/otp.c

-- 
2.20.1

