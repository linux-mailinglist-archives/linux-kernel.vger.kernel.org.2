Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B133784E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhEJK40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:56:26 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60253 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhEJKo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:44:57 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13.home (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 803171C000E;
        Mon, 10 May 2021 10:43:51 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: mtd_oobtest: Remove redundant assignment to err
Date:   Mon, 10 May 2021 12:43:50 +0200
Message-Id: <20210510104350.11011-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To:  <1619346498-43617-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6500dc2bde937fb124a399211686e04b8ef9d44e'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-04-25 at 10:28:18 UTC, Jiapeng Chong wrote:
> Variable err is set to zero but this value is never read as it is
> overwritten with a new value later on, hence it is a redundant
> assignment and can be removed.
> 
> Cleans up the following clang-analyzer warning:
> 
> drivers/mtd/tests/oobtest.c:626:4: warning: Value stored to 'err' is
> never read [clang-analyzer-deadcode.DeadStores].
> 
> drivers/mtd/tests/oobtest.c:603:4: warning: Value stored to 'err' is
> never read [clang-analyzer-deadcode.DeadStores].
> 
> drivers/mtd/tests/oobtest.c:579:4: warning: Value stored to 'err' is
> never read [clang-analyzer-deadcode.DeadStores].
> 
> drivers/mtd/tests/oobtest.c:556:4: warning: Value stored to 'err' is
> never read [clang-analyzer-deadcode.DeadStores].
> 
> drivers/mtd/tests/oobtest.c:532:3: warning: Value stored to 'err' is
> never read [clang-analyzer-deadcode.DeadStores].
> 
> drivers/mtd/tests/oobtest.c:509:3: warning: Value stored to 'err' is
> never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
