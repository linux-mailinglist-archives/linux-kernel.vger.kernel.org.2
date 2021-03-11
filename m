Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29765337189
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhCKLjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:39:22 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35205 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbhCKLjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:39:10 -0500
X-Originating-IP: 90.89.138.59
Received: from xps13.home (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1770760005;
        Thu, 11 Mar 2021 11:39:05 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, chris.packham@alliedtelesis.co.nz,
        Sergey.Semin@baikalelectronics.ru
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: maps: fix error return code of physmap_flash_remove()
Date:   Thu, 11 Mar 2021 12:39:05 +0100
Message-Id: <20210311113905.305884-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210308034446.3052-1-baijiaju1990@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'620b90d30c08684dc6ebee07c72755d997f9d1f6'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-08 at 03:44:46 UTC, Jia-Ju Bai wrote:
> When platform_get_drvdata() returns NULL to info, no error return code
> of physmap_flash_remove() is assigned.
> To fix this bug, err is assigned with -EINVAL in this case
> 
> Fixes: 73566edf9b91 ("[MTD] Convert physmap to platform driver")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
