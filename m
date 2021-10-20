Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7AC43478D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhJTJFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTJFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:05:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049F9C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:03:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8F0421F43F56;
        Wed, 20 Oct 2021 10:03:06 +0100 (BST)
Date:   Wed, 20 Oct 2021 11:03:03 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mtd: rawnand: nand_bbt: hide suspend/resume
 hooks while scanning bbt
Message-ID: <20211020110303.6f21c057@collabora.com>
In-Reply-To: <20211020090132.zuxojg6cnwsm4dwg@skn-laptop>
References: <20211020084534.2472305-1-sean@geanix.com>
        <20211020084534.2472305-2-sean@geanix.com>
        <20211020105326.0dca864a@collabora.com>
        <20211020090132.zuxojg6cnwsm4dwg@skn-laptop>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 11:01:32 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On Wed, Oct 20, 2021 at 10:53:26AM +0200, Boris Brezillon wrote:
> > On Wed, 20 Oct 2021 10:45:31 +0200
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
> > > Tested-by: Sean Nyekjaer <sean@geanix.com>  
> > 
> > It's missing our Signed-off-by tags.
> >   
> 
> Patch is from you ;)
> If you are okay with it, I will add your Signed-off-by tag.

You should add both (mine and yours).

