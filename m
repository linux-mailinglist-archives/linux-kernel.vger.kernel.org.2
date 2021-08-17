Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE43EF064
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhHQQtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:49:55 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59239 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhHQQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:49:50 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A4EEF40005;
        Tue, 17 Aug 2021 16:49:13 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, bbrezillon@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 2/2] mtd: mtdconcat: Check _read, _write callbacks existence before assignment
Date:   Tue, 17 Aug 2021 18:49:12 +0200
Message-Id: <20210817164912.108616-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210817114857.2784825-3-chengzhihao1@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a89d69a44e282be95ae76125dddc79515541efeb'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-17 at 11:48:57 UTC, Zhihao Cheng wrote:
> Since 2431c4f5b46c3 ("mtd: Implement mtd_{read,write}() as wrappers
> around mtd_{read,write}_oob()") don't allow _write|_read and
> _write_oob|_read_oob existing at the same time, we should check the
> existence of callbacks "_read and _write" from subdev's master device
> (We can trust master device since it has been registered) before
> assigning, otherwise following warning occurs while making
> concatenated device:
> 
>   WARNING: CPU: 2 PID: 6728 at drivers/mtd/mtdcore.c:595
>   add_mtd_device+0x7f/0x7b0
> 
> Fixes: 2431c4f5b46c3 ("mtd: Implement mtd_{read,write}() around ...")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
