Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7980B3CAF87
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhGOXLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:11:36 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49615 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhGOXLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:11:33 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A7972C0009;
        Thu, 15 Jul 2021 23:08:36 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stefan Riedmueller <s.riedmueller@phytec.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Dan Brown <dan_brown@ieee.org>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: nand_bbt: Skip bad blocks when searching for the BBT in NAND
Date:   Fri, 16 Jul 2021 01:08:36 +0200
Message-Id: <20210715230836.222817-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210625123821.207458-1-s.riedmueller@phytec.de>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'1a57b13e6017d2af575f4f42e848aa0b64d4bcf1'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-06-25 at 12:38:21 UTC, Stefan Riedmueller wrote:
> The blocks containing the bad block table can become bad as well. So
> make sure to skip any blocks that are marked bad when searching for the
> bad block table.
> 
> Otherwise in very rare cases where two BBT blocks wear out it might
> happen that an obsolete BBT is used instead of a newer available
> version.
> 
> This only applies to drivers which make use of a bad block marker in flash.
> Other drivers won't be able to identify bad BBT blocks and thus can't skip
> these.
> 
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
