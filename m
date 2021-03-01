Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BCB328329
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 17:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhCAQLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 11:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237559AbhCAQGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:06:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FFE564DF5;
        Mon,  1 Mar 2021 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614614754;
        bh=i198r6jtTCRsZqWaZm7Kh1ycZSMAjkCxokbm36sHl8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJ2L1VIkg/VZo1RT8kTKIwVVXFx2S6A6yQZb6Sdue0ou9DAqhcZNPX5yaDKGZjam1
         DkHv1zoAHN2nEtSxh49Q/+xKrksvaQDoCExjCWAbqXW0bG0w7VYNZndxoMk9Tzb39f
         /VItL6HJMOOOiJGSaAJT/x2WlxqYPnvL8mGxxFScqU81ipfjl00IogkAT5MXytF8nO
         rZ8SEIRCfSaZg+esD+ye9gkg4TGYGQwMls12CNrZgM+YbdKSqvsbVqEL78n4GlfkNz
         aCp0DD2h7VL2nNyC91dfevS19Yuj2fRechEQuXKq7/KnqtmmWgEZSFQa3BSrM/Lg4s
         o3qZN1l7lBtoQ==
Date:   Tue, 2 Mar 2021 01:05:47 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210301160547.GB17228@redsun51.ssa.fujisawa.hgst.com>
References: <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
 <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
 <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
 <20210301132639.n3eowtvkms2n5mog@beryllium.lan>
 <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 02:55:30PM +0100, Hannes Reinecke wrote:
> On 3/1/21 2:26 PM, Daniel Wagner wrote:
> > On Sat, Feb 27, 2021 at 02:19:01AM +0900, Keith Busch wrote:
> >> Crashing is bad, silent data corruption is worse. Is there truly no
> >> defense against that? If not, why should anyone rely on this?
> > 
> > If we receive an response for which we don't have a started request, we
> > know that something is wrong. Couldn't we in just reset the connection
> > in this case? We don't have to pretend nothing has happened and
> > continuing normally. This would avoid a host crash and would not create
> > (more) data corruption. Or I am just too naive?
> > 
> This is actually a sensible solution.
> Please send a patch for that.

Is a bad frame a problem that can be resolved with a reset?

Even if so, the reset doesn't indicate to the user if previous commands
completed with bad data, so it still seems unreliable.
