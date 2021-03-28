Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E76734BDA0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 19:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhC1R2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 13:28:46 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50959 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhC1R2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 13:28:39 -0400
Received: from xps13.home (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A0E14200003;
        Sun, 28 Mar 2021 17:28:36 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mtd: require write permissions for locking and badblock ioctls
Date:   Sun, 28 Mar 2021 19:28:36 +0200
Message-Id: <20210328172836.10072-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303155735.25887-1-michael@walle.cc>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'1e97743fd180981bef5f01402342bb54bf1c6366'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-03 at 15:57:35 UTC, Michael Walle wrote:
> MEMLOCK, MEMUNLOCK and OTPLOCK modify protection bits. Thus require
> write permission. Depending on the hardware MEMLOCK might even be
> write-once, e.g. for SPI-NOR flashes with their WP# tied to GND. OTPLOCK
> is always write-once.
> 
> MEMSETBADBLOCK modifies the bad block table.
> 
> Fixes: f7e6b19bc764 ("mtd: properly check all write ioctls for permissions")
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Rafał Miłecki <rafal@milecki.pl>
> Acked-by: Richard Weinberger <richard@nod.at>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
