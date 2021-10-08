Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1AF426E64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhJHQKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:10:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50194 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJHQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:10:11 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6B6821F45B9B;
        Fri,  8 Oct 2021 17:08:14 +0100 (BST)
Date:   Fri, 8 Oct 2021 18:08:11 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mtd: core: protect access to mtd devices while
 in suspend
Message-ID: <20211008180811.36c371f5@collabora.com>
In-Reply-To: <20211008173526.19745a10@xps13>
References: <20211008141524.20ca8219@collabora.com>
        <20211008143825.3717116-1-sean@geanix.com>
        <20211008173526.19745a10@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 17:35:26 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> > into suspend. But it's actually "mtd: rawnand: Simplify the locking" that
> > allows it to return errors rather than locking, before that commit it would
> > have waited for the rawnand device to resume.  
> 
> I don't think so, I believe it was broken in the same way but was just
> not returning errors.

Actually I was wrong, 013e6292aaf5 ("mtd: rawnand: Simplify the
locking") removed the blocking wait (returning -EBUSY when the device
is suspended instead of putting the thread on a waitqueue). At that
time, I assumed all threads would be paused when the device is
suspended, which appeared to be incorrect. So I guess the Fixes tag
should remain, and we might want to consider backporting a less
invasive patch to stable releases (one touching only the raw NAND
layer).
