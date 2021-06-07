Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9429139DB41
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhFGL3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFGL3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:29:41 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B90C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 04:27:50 -0700 (PDT)
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7FC4F22173;
        Mon,  7 Jun 2021 13:27:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623065268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rTTnPr3fbvvQSNNNubDTYCs5dbtwiY5bKpv1GTbh7/g=;
        b=J/RhPK7ufBxJc64d0sTZ4yDIIUE5ohUBfbyq1PHnz+Opsn/8s1GMqEpZaRzt1CqDBShzhX
        VU7SZ5FOfjrpQV7OaQS5FOBR1l68cPRifQdxtrVslf9Wlu+O1dBVyudnl+QmLeyLsKukNE
        sFWFAcbKKexhYWrO9rQ4PmIztrCybwQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v6 0/4] mtd: spi-nor: otp: 4 byte mode fix and erase support
Date:   Mon,  7 Jun 2021 13:27:40 +0200
Message-Id: <20210607112744.21587-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is the follow up on the single patch
mtd: spi-nor: implement OTP erase for Winbond and similar flashes

Pratyush Yadav discovered a likely problem with bigger flashes, the address
to access the security registers is either 3 or 4 byte (at least for
winbond flashes).

Changes since v5:
 - squash new patch into "Fixes:" patch

Changes since v4:
 - add new patch to get rid taking the spi lock if length is zero. Please
   note, that I didn't squash this into the "Fixes:" patch because it is
   unrelated to the actual bug.
 - add comment which explains that we could also branch on an error in
   spi_nor_mtd_otp_range_is_locked()
 - check zero length in spi_nor_mtd_otp_erase() and return early before
   taking the lock

Changes since v3:
 - new patch to check for read-only OTP regions before writing
 - clarify term "security register"
 - don't combine lock and erase functions anymore. there are now
   more difference than similarities.

Changes since v2:
 - fix 3/4 byte mode access
 - use spi_nor_erase_sector() by swapping the nor->erase_opcode
 - use more consistent wording regarding the security registers

Changes since v1:
- fixed kernel doc

Michael Walle (4):
  mtd: spi-nor: otp: fix access to security registers in 4 byte mode
  mtd: spi-nor: otp: use more consistent wording
  mtd: spi-nor: otp: return -EROFS if region is read-only
  mtd: spi-nor: otp: implement erase for Winbond and similar flashes

 drivers/mtd/spi-nor/core.c    |   2 +-
 drivers/mtd/spi-nor/core.h    |   4 +
 drivers/mtd/spi-nor/otp.c     | 156 +++++++++++++++++++++++++++++++---
 drivers/mtd/spi-nor/winbond.c |   1 +
 4 files changed, 149 insertions(+), 14 deletions(-)

-- 
2.20.1

