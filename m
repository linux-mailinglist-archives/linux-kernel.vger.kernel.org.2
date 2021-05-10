Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D77377F18
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhEJJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:11:36 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:8875 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhEJJLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:11:13 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13.home (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AA974240018;
        Mon, 10 May 2021 09:10:06 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yu Kuai <yukuai3@huawei.com>, joern@lazybastard.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        matthias.bgg@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yi.zhang@huawei.com
Subject: Re: [PATCH 2/3] mtd: plat-ram: remove redundant dev_err call in platram_probe()
Date:   Mon, 10 May 2021 11:10:05 +0200
Message-Id: <20210510091005.4100-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210408111514.1011020-3-yukuai3@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c054de10ae5d6d8b3f417cb8d29e67a7cd686f36'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-04-08 at 11:15:13 UTC, Yu Kuai wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
