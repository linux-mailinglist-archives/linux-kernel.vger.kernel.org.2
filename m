Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85EB3CAF72
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhGOWxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:53:46 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42939 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhGOWxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:53:46 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id CBB8E1C0002;
        Thu, 15 Jul 2021 22:50:49 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH v2] mtd: mtd_blkdevs: Initialize rq.limits.discard_granularity
Date:   Fri, 16 Jul 2021 00:50:49 +0200
Message-Id: <20210715225049.66252-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210615093905.3473709-1-chengzhihao1@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2b6d2833cd1d8a43a837a45da65860ef086443dc'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-06-15 at 09:39:05 UTC, Zhihao Cheng wrote:
> Since commit b35fd7422c2f8("block: check queue's limits.discard_granularity
> in __blkdev_issue_discard()") checks rq.limits.discard_granularity in
> __blkdev_issue_discard(), we may get following warnings on formatted ftl:
> 
>   WARNING: CPU: 2 PID: 7313 at block/blk-lib.c:51
>   __blkdev_issue_discard+0x2a7/0x390
> 
> Reproducer:
>   1. ftl_format /dev/mtd0
>   2. modprobe ftl
>   3. mkfs.vfat /dev/ftla
>   4. mount -odiscard /dev/ftla temp
>   5. dd if=/dev/zero of=temp/tst bs=1M count=10 oflag=direct
>   6. dd if=/dev/zero of=temp/tst bs=1M count=10 oflag=direct
> 
> Fix it by initializing rq.limits.discard_granularity if device supports
> discard operation.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
