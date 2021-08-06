Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F65E3E3017
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbhHFUGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:06:05 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:45513 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbhHFUGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:06:04 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 3DAE5100003;
        Fri,  6 Aug 2021 20:05:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] mtdblock: Update old JFFS2 mention in Kconfig
Date:   Fri,  6 Aug 2021 22:05:46 +0200
Message-Id: <20210806200546.394389-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210801234509.18774-6-ezequiel@collabora.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6bc219b7b2cdd9d45ea15926d32c5e5c1d63881e'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-08-01 at 23:45:07 UTC, Ezequiel Garcia wrote:
> JFFS2 can be mounted without 'mtdblock' since
> a really, really long time. Some git-log
> archaeology shows that in 2006 it was possible
> to use 'root=' to mount a JFFS2 rootfs:
> 
>   commit e9482b4374e2596e6f3f1ab30c4ea469f4ac6311
>   Author: Joern Engel <joern@wh.fh-wedel.de>
>   Date:   Tue May 30 14:25:46 2006 +0200
> 
>       [MTD] Allow alternate JFFS2 mount variant for root filesystem.
> 
>       With this patch, "root=mtd3" and "root=mtd:foo" work for a JFFS2 rootfs.
> 
> However, there are still plenty of tutorials that mention
> mtdblock, so users are still taking this route. Update the Kconfig
> to reflect this is no longer needed.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
