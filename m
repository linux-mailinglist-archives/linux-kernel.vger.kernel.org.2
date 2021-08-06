Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5FD3E3016
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbhHFUGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:06:00 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35109 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbhHFUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:05:59 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7331160002;
        Fri,  6 Aug 2021 20:05:42 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/3] mtdblock: Add comment about UBI block devices
Date:   Fri,  6 Aug 2021 22:05:42 +0200
Message-Id: <20210806200542.394325-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210801234509.18774-7-ezequiel@collabora.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'42ba8c3b426342b39341e1b7a97f2387821bff86'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-08-01 at 23:45:08 UTC, Ezequiel Garcia wrote:
> There is a surprisingly large number of tutorials
> that suggest using mtdblock to mount SquashFS filesystems
> on flash devices, including NAND devices.
> 
> Given this approach is suboptimal than using UBI, and given
> the UBI block device layer was introduced many years ago
> specifically with this use case in mind, add a small
> comment inviting users and developers to consider UBI block.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
