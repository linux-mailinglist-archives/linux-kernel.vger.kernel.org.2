Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA334BDB4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 19:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhC1RfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 13:35:07 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:49743 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhC1RfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 13:35:02 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13.home (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 74AA71BF203;
        Sun, 28 Mar 2021 17:35:00 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stefan Riedmueller <s.riedmueller@phytec.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: nand_bbt: Skip bad blocks when searching for the BBT in NAND
Date:   Sun, 28 Mar 2021 19:35:00 +0200
Message-Id: <20210328173500.10571-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210325102337.481172-1-s.riedmueller@phytec.de>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bd9c9fe2ad04546940f4a9979d679e62cae6aa51'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-03-25 at 10:23:37 UTC, Stefan Riedmueller wrote:
> The blocks containing the bad block table can become bad as well. So
> make sure to skip any blocks that are marked bad when searching for the
> bad block table.
> 
> Otherwise in very rare cases where two BBT blocks wear out it might
> happen that an obsolete BBT is used instead of a newer available
> version.
> 
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
