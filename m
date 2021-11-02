Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB34429BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhKBIqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:46:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57982 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhKBIqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:46:19 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3FB181F4417D;
        Tue,  2 Nov 2021 08:43:43 +0000 (GMT)
Date:   Tue, 2 Nov 2021 09:43:35 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] mtd: rawnand: nand_bbt: hide suspend/resume
 hooks while scanning bbt
Message-ID: <20211102094335.0e7c80de@collabora.com>
In-Reply-To: <20211101084623.xrpwwvweez24svib@skn-laptop>
References: <20211026055551.3053598-1-sean@geanix.com>
        <20211026055551.3053598-2-sean@geanix.com>
        <20211101083824.236b9983@collabora.com>
        <20211101084623.xrpwwvweez24svib@skn-laptop>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 09:46:23 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> On Mon, Nov 01, 2021 at 08:38:24AM +0100, Boris Brezillon wrote:
> > On Tue, 26 Oct 2021 07:55:48 +0200
> > Sean Nyekjaer <sean@geanix.com> wrote:
> >   
> > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > 
> > > The BBT scan logic use the MTD helpers before the MTD layer had a
> > > chance to initialize the device, and that leads to issues when
> > > accessing the uninitialized suspend lock. Let's temporarily set the
> > > suspend/resume hooks to NULL to skip the lock acquire/release step.
> > > 
> > > Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")  
> > 
> > I think I already mentioned this Fixes tag should not be there.
> >   
> 
> No, I didn't recall that, but nevermind :)
> 
> Hmm when ('mtd: core: protect access to MTD devices while in suspend')
> is backported we want to live with the use before init of the rwsem?

It's not meant to be backported. You'll need something simpler...

> 
> /Sean

