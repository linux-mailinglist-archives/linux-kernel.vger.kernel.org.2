Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB2B3E3015
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244515AbhHFUF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:05:57 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35907 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHFUF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:05:56 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4804AC0005;
        Fri,  6 Aug 2021 20:05:38 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] mtdblock: Warn if the added for a NAND device
Date:   Fri,  6 Aug 2021 22:05:37 +0200
Message-Id: <20210806200537.394260-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210801234509.18774-8-ezequiel@collabora.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b4675c64f9326a8caff211ec02599d5d64eb4f81'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-08-01 at 23:45:09 UTC, Ezequiel Garcia wrote:
> There is a surprisingly large number of tutorials
> that suggest using mtdblock to mount SquashFS filesystems
> on flash devices, including NAND devices.
> 
> This approach is suboptimal than using UBI. If the flash device
> is NAND, this is specially true, due to wear leveling, bit-flips and
> badblocks. In this case UBI is strongly preferred, so be nice to users
> and print a warning suggesting to consider UBI block, if mtdblock
> is added for a NAND device.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
