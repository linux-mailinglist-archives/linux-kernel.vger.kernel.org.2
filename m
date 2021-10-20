Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25DD4347AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJTJO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:14:29 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37187 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJTJOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:14:23 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F3789C0018;
        Wed, 20 Oct 2021 09:12:06 +0000 (UTC)
Date:   Wed, 20 Oct 2021 11:12:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mtd: rawnand: nand_bbt: hide suspend/resume
 hooks while scanning bbt
Message-ID: <20211020111206.342bd9d5@xps13>
In-Reply-To: <20211020110303.6f21c057@collabora.com>
References: <20211020084534.2472305-1-sean@geanix.com>
        <20211020084534.2472305-2-sean@geanix.com>
        <20211020105326.0dca864a@collabora.com>
        <20211020090132.zuxojg6cnwsm4dwg@skn-laptop>
        <20211020110303.6f21c057@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

boris.brezillon@collabora.com wrote on Wed, 20 Oct 2021 11:03:03 +0200:

> On Wed, 20 Oct 2021 11:01:32 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
> > On Wed, Oct 20, 2021 at 10:53:26AM +0200, Boris Brezillon wrote:  
> > > On Wed, 20 Oct 2021 10:45:31 +0200
> > > Sean Nyekjaer <sean@geanix.com> wrote:
> > >     
> > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > 
> > > > The BBT scan logic use the MTD helpers before the MTD layer had a
> > > > chance to initialize the device, and that leads to issues when
> > > > accessing the uninitialized suspend lock. Let's temporarily set the
> > > > suspend/resume hooks to NULL to skip the lock acquire/release step.
> > > > 
> > > > Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> > > > Tested-by: Sean Nyekjaer <sean@geanix.com>    
> > > 
> > > It's missing our Signed-off-by tags.
> > >     
> > 
> > Patch is from you ;)
> > If you are okay with it, I will add your Signed-off-by tag.  
> 
> You should add both (mine and yours).

And put the one matching the author (Boris') before the other (yours).
