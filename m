Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7232E364
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhCEIJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhCEIJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:09:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7755964F4A;
        Fri,  5 Mar 2021 08:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614931749;
        bh=ByaE4K+EFQRpe4LB98+PQO4TPOClgjHWV54KDajmUqQ=;
        h=Date:From:To:Cc:Subject:From;
        b=J1PrYsHrRDMc6jpbXsjeXIRHSf4HRwUXPm3uezAzYs4tOx3kDH6pQqgYXHO19zo6I
         jAqXQUAXl44TYNMJnRmeKDhYpoaH3Cfr9s9YUTYZgDGEFbtJzJpr9PdZOTC8GUfL2f
         D94gF8Iyf1kQch+uYbhwEdh31KEbEKZQfelZKeE/2g+P8KL93UyDxrv5CovC6FnK7g
         nKH7ZKtJysqp1f9o2gpmX9MVHDePeXgD6HBVMT1xRrCGXYquylyOX+OcUErxsFnrll
         Jw0EeVVL80EzIeu4Vef/Vi9dhjVJtLzQj0oet4o2HieeeGRd1Gz4+fFH8GEhg1D5aR
         n+V0xwaGG74hg==
Date:   Fri, 5 Mar 2021 02:09:05 -0600
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
Subject: [PATCH v2][next] mtd: rawnand: stm32_fmc2: Fix fall-through warnings
 for Clang
Message-ID: <20210305080905.GA135306@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
of warnings by explicitly adding a couple of fallthrough pseudo-keywords
instead of letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
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

