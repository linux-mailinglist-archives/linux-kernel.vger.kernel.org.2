Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F03457681
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhKSSjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:39:04 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:38991 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbhKSSiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:38:55 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id ACA7040006;
        Fri, 19 Nov 2021 18:35:51 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sean Nyekjaer <sean@geanix.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] mtd: rawnand: nand_bbt: hide suspend/resume hooks while scanning bbt
Date:   Fri, 19 Nov 2021 19:35:51 +0100
Message-Id: <20211119183551.1330314-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211102110204.3334609-2-sean@geanix.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'39a3663f82ee78608eabf8c838e2949e4c6ce993'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-02 at 11:02:01 UTC, Sean Nyekjaer wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> The BBT scan logic use the MTD helpers before the MTD layer had a
> chance to initialize the device, and that leads to issues when
> accessing the uninitialized suspend lock. Let's temporarily set the
> suspend/resume hooks to NULL to skip the lock acquire/release step.
> 
> Tested-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
