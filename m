Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0242EEC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhJOKdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:33:21 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52371 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbhJOKdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:33:19 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 44DC81C0011;
        Fri, 15 Oct 2021 10:31:09 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zev Weiss <zev@bewilderbeest.net>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Jon Hunter <jonathanh@nvidia.com>, Petr Malat <oss@malat.biz>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mario Rugiero <mrugiero@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: core: don't remove debugfs directory if device is in use
Date:   Fri, 15 Oct 2021 12:31:07 +0200
Message-Id: <20211015103107.948869-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211014203953.5424-1-zev@bewilderbeest.net>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c13de2386c78e890d4ae6f01a85eefd0b293fb08'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-10-14 at 20:39:52 UTC, Zev Weiss wrote:
> Previously, if del_mtd_device() failed with -EBUSY due to a non-zero
> usecount, a subsequent call to attempt the deletion again would try to
> remove a debugfs directory that had already been removed and panic.
> With this change the second call can instead proceed safely.
> 
> Fixes: e8e3edb95ce6 ("mtd: create per-device and module-scope debugfs entries")
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
