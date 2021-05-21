Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0057738CE4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbhEUTmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbhEUTmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:42:06 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:40:42 -0700 (PDT)
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 16EEA22173;
        Fri, 21 May 2021 21:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1621626039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ch0oeM7u6L9lGRpSIbUwFd8++Tm676K1qFj/hRHd8Zw=;
        b=GdHyknkAzN+F6JjT5oN/3C4A0H85WBXUV8F9YpDJUjhU2mgAKEUrp2KUrBVcywbZbNTHO7
        WGsqmgmxrfgCZl9XP8piX9pkaT8C9Ou8JcH6mBZeceAyeoAv28uFcvR0q7oOY1V1KvlAdR
        7VzeuS+8e5Isq6r0GQ2bCX/0pT28hwg=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v4 0/4] mtd: spi-nor: otp: 4 byte mode fix and erase support
Date:   Fri, 21 May 2021 21:40:30 +0200
Message-Id: <20210521194034.15249-1-michael@walle.cc>
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
 drivers/mtd/spi-nor/otp.c     | 147 +++++++++++++++++++++++++++++++---
 drivers/mtd/spi-nor/winbond.c |   1 +
 4 files changed, 143 insertions(+), 11 deletions(-)

-- 
2.20.1

