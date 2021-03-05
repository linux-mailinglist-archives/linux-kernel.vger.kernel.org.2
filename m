Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C116E32E384
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCEITi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:19:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhCEITg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:19:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B37C65014;
        Fri,  5 Mar 2021 08:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614932376;
        bh=4tcQynLBYFF8R4IvD4h1vdRVG+jt6uczJrx4L0hagCI=;
        h=Date:From:To:Cc:Subject:From;
        b=UL1XdNh8CUWSnSJzvCohlPYrnTV2wTDEEz5riKz7vCZcMZhoHhPrasqPxFyDjg3cU
         VK3X8zdKPp+d6Zk/nELeHn3TdaXZvTdkcbbsIVD+MmI3vzKv//uEq+eVtS2hdpZdNN
         xZ5xjHI8v6xqaOQZEQsouGP7wWjwNscQRO5TwulHRw0Bc0sS7HokMjDTdjYqhzl/Zz
         s0cXYpl4dk9JRtuX9zkAcJvruvjzGIDAaaweqIRuQM9PBbkElCBsFm9IDgye534BsA
         chc/GrUygzOBW79bv/OyG62NhhnpMGkcRf2zgnsdtAKGkLjM0oe7+UBr0sMDkpYkyq
         JNtCkBJU8gq0g==
Date:   Fri, 5 Mar 2021 02:19:33 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] mtd: cfi: Fix fall-through warnings for Clang
Message-ID: <20210305081933.GA137147@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements and a return
instead of letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/mtd/chips/cfi_cmdset_0001.c | 1 +
 drivers/mtd/chips/cfi_cmdset_0002.c | 2 ++
 drivers/mtd/chips/cfi_cmdset_0020.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 42001c49833b..b7f5e7977dcd 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -2549,6 +2549,7 @@ static int cfi_intelext_suspend(struct mtd_info *mtd)
 			   anyway? The latter for now. */
 			printk(KERN_NOTICE "Flash device refused suspend due to active operation (state %d)\n", chip->state);
 			ret = -EAGAIN;
+			break;
 		case FL_PM_SUSPENDED:
 			break;
 		}
diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index a1f3e1031c3d..6f6b0265c22d 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -902,6 +902,7 @@ static int get_chip(struct map_info *map, struct flchip *chip, unsigned long adr
 			/* Someone else might have been playing with it. */
 			goto retry;
 		}
+		return 0;
 
 	case FL_READY:
 	case FL_CFI_QUERY:
@@ -2994,6 +2995,7 @@ static int cfi_amdstd_suspend(struct mtd_info *mtd)
 			 * as the whole point is that nobody can do anything
 			 * with the chip now anyway.
 			 */
+			break;
 		case FL_PM_SUSPENDED:
 			break;
 
diff --git a/drivers/mtd/chips/cfi_cmdset_0020.c b/drivers/mtd/chips/cfi_cmdset_0020.c
index 270322bca221..d35df526e0a6 100644
--- a/drivers/mtd/chips/cfi_cmdset_0020.c
+++ b/drivers/mtd/chips/cfi_cmdset_0020.c
@@ -1332,6 +1332,8 @@ static int cfi_staa_suspend(struct mtd_info *mtd)
 			 * as the whole point is that nobody can do anything
 			 * with the chip now anyway.
 			 */
+			break;
+
 		case FL_PM_SUSPENDED:
 			break;
 
-- 
2.27.0

