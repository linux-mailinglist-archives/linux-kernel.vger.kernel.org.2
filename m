Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD83845767E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhKSSiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:38:51 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:65165 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbhKSSiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:38:50 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 176A940006;
        Fri, 19 Nov 2021 18:35:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sean Nyekjaer <sean@geanix.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] mtd: mtdconcat: don't use mtd_{suspend,resume}()
Date:   Fri, 19 Nov 2021 19:35:46 +0100
Message-Id: <20211119183546.1330250-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211102110204.3334609-3-sean@geanix.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'46c8159560c994248fbb3c866bc27ad87c304419'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-02 at 11:02:02 UTC, Sean Nyekjaer wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> The MTD suspend logic will soon be adjusted to automatically wait for
> device wake-up before issuing IOs. In order to do that a new read-write
> lock will be added and taken in write-mode in the
> mtd_{suspend,resume}() path. Since mtdconcat.c itself is an MTD device,
> calling mtd_suspend/resume() on subdevices from the mtdconcat
> ->_{suspend,resume}() hook will lead to a nested lock, which lockdep
> will complain about if we don't add a proper annotation. Let's keep
> things simple and replace those mtd_{suspend,resume}(subdev) calls by
> subdev->_{suspend,resume}() ones to avoid this situation.
> 
> Tested-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
