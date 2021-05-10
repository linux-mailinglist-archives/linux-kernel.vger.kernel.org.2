Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000343780CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhEJKDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:03:40 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50059 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhEJKDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:03:40 -0400
Received: from xps13.home (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 68B8024000D;
        Mon, 10 May 2021 10:02:33 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: silence static checker warning in nand_setup_interface()
Date:   Mon, 10 May 2021 12:02:32 +0200
Message-Id: <20210510100233.6865-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <YH6Ugwz3gcga+q8X@mwanda>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4d888eceb725216305eee595ff5d068112cf7c15'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-04-20 at 08:44:51 UTC, Dan Carpenter wrote:
> Smatch complains that the error code is not set on this error path:
> 
>     drivers/mtd/nand/raw/nand_base.c:842 nand_setup_interface()
>     warn: missing error code 'ret'
> 
> But actually returning success is intentional because the NAND chip will
> still work in mode 0.  This patch adds a "ret = 0;" assignment to make
> the intent more clear and to silence the static checker warning.  It
> doesn't affect the compiled code because GCC optimises the assignment
> away.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
