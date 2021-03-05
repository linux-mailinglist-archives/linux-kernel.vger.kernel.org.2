Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6592D32E397
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhCEIX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:23:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhCEIX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:23:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3099E65017;
        Fri,  5 Mar 2021 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614932639;
        bh=5dWhuUO/oHpV2V7fo9QOdb69sHzl2L5kSFQKxqFnL80=;
        h=Date:From:To:Cc:Subject:From;
        b=VqlbfHag5aW6BbFYB9RTCZs0dAhUAafKuWXqSI4KMph4sX5i63ZkTaigItdgXCoPX
         J97beKjQpQ1XMQze9mn0j5B2z74LWrAs81P1qQYwcZeErq2zO+bm16iRNLXNW9biO8
         uc7i4uGT0hugxan5BHs4gQzNW33wLXO/z2HsfSFa5bqPmZOkWBZFN44CxqkRi1mf81
         JFyX3YCqPcr3wNESLLQeV/SxaGRFelO5dQuTG28xNzFZbb70fGLF6VX+nlobI02BJ6
         xjfbfeaukzTaZf2Acs7vZVaMkOJ9T3V+PZ/Ts2Z/B5LfYf0fENzlZ4guLnyFrqebl7
         Kx3U9U7FRkEXA==
Date:   Fri, 5 Mar 2021 02:23:56 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] mtd: onenand: Fix fall-through warnings for
 Clang
Message-ID: <20210305082356.GA137489@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/mtd/nand/onenand/onenand_samsung.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index 87b28e397d67..b64895573515 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -396,6 +396,7 @@ static int s3c_onenand_command(struct mtd_info *mtd, int cmd, loff_t addr,
 	case ONENAND_CMD_READOOB:
 	case ONENAND_CMD_BUFFERRAM:
 		ONENAND_SET_NEXT_BUFFERRAM(this);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

