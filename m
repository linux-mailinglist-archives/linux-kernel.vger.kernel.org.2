Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026C6378550
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhEJLAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:00:02 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:52707 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhEJKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:44:52 -0400
Received: from xps13.home (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C8E54240005;
        Mon, 10 May 2021 10:43:46 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: return -ENOMEM when kmalloc failed
Date:   Mon, 10 May 2021 12:43:46 +0200
Message-Id: <20210510104346.10947-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <1619429543-52234-1-git-send-email-yang.lee@linux.alibaba.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8fa7c3618e8abcca09e16a1c9048b8e78bcf803d'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-26 at 09:32:23 UTC, Yang Li wrote:
> The driver is using -1 instead of the -ENOMEM defined macro to
> specify that a buffer allocation failed. Using the correct error
> code is more intuitive
> 
> Smatch tool warning:
> drivers/mtd/inftlmount.c:333 check_free_sectors() warn: returning -1
> instead of -ENOMEM is sloppy
> drivers/mtd/nftlmount.c:272 check_free_sectors() warn: returning -1
> instead of -ENOMEM is sloppy
> 
> No functional change, just more standardized.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
