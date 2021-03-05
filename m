Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7344B32E3AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhCEIaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhCEI34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:29:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68A8D65011;
        Fri,  5 Mar 2021 08:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614932996;
        bh=9Roq1+ktzTZSK6gD+rBHK9mji+a80aPRur08v7e2wvY=;
        h=Date:From:To:Cc:Subject:From;
        b=o/KIh+GXKNRmP5lEF2qV1cyPu6qDmzDaCPJtTJzinhE5IJdfcIvK5SFVF9W6p6fev
         IRLsoPGPVVdovZu4e4mLsB4kIo1tNMo5hzduk8GfeLQgySFmOaTQyA0yCo+K7x1NF2
         yokgvx7yPhok1MS3EDomQ9YGP/xnE3bxEAa2qc5mrWO+V/zcmAijAjQ7/NCoEruE8J
         gB64g9qhY9FLOL+O5z2tOYBjhRBTykJU4huS5PIuKAqrB30j+katjW7yy1OyXhxCR2
         Zk1YtT8NtcwRVM2UrQVHy2B73gfdF61Zmirqa6hFYht+jZcLv52AfhSgSKggyOqzCI
         wdhnk+SfdHxCw==
Date:   Fri, 5 Mar 2021 02:29:53 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] mtd: rawnand: stm32_fmc2: Fix fall-through warnings
 for Clang
Message-ID: <20210305082953.GA137771@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
of warnings by explicitly adding a couple of break statements instead
of letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 Update the changelog text according to the actual code change.

Changes in v2:
 Make use of a break statement instead of fallthrough for consistency.
 Link: https://lore.kernel.org/lkml/20201123093347.719a77cf@xps13/

 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 550bda4d1415..1c277fbb91f2 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -531,6 +531,7 @@ static int stm32_fmc2_nfc_ham_correct(struct nand_chip *chip, u8 *dat,
 		switch (b % 4) {
 		case 2:
 			bit_position += shifting;
+			break;
 		case 1:
 			break;
 		default:
@@ -546,6 +547,7 @@ static int stm32_fmc2_nfc_ham_correct(struct nand_chip *chip, u8 *dat,
 		switch (b % 4) {
 		case 2:
 			byte_addr += shifting;
+			break;
 		case 1:
 			break;
 		default:
-- 
2.27.0

