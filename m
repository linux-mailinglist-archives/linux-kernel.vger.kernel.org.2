Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C230889C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 12:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhA2LxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 06:53:19 -0500
Received: from hmm.wantstofly.org ([213.239.204.108]:51438 "EHLO
        mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhA2K0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 05:26:18 -0500
Received: by mail.wantstofly.org (Postfix, from userid 1000)
        id 90D707F45D; Fri, 29 Jan 2021 12:20:57 +0200 (EET)
Date:   Fri, 29 Jan 2021 12:20:57 +0200
From:   Lennert Buytenhek <buytenh@wantstofly.org>
To:     David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] io_uring: add support for IORING_OP_GETDENTS64
Message-ID: <20210129102057.GD193464@wantstofly.org>
References: <20210123114152.GA120281@wantstofly.org>
 <a99467bab6d64a7f9057181d979ec563@AcuMS.aculab.com>
 <20210128230710.GA190469@wantstofly.org>
 <20210129053703.GB190469@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210129053703.GB190469@wantstofly.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 07:37:03AM +0200, Lennert Buytenhek wrote:

> > > > One open question is whether IORING_OP_GETDENTS64 should be more like
> > > > pread(2) and allow passing in a starting offset to read from the
> > > > directory from.  (This would require some more surgery in fs/readdir.c.)
> > > 
> > > Since directories are seekable this ought to work.
> > > Modulo horrid issues with 32bit file offsets.
> > 
> > The incremental patch below does this.  (It doesn't apply cleanly on
> > top of v1 of the IORING_OP_GETDENTS patch as I have other changes in
> > my tree -- I'm including it just to illustrate the changes that would
> > make this work.)
> > 
> > This change seems to work, and makes IORING_OP_GETDENTS take an
> > explicitly specified directory offset (instead of using the file's
> > ->f_pos), making it more like pread(2) [...]
> 
> ...but the fact that this patch avoids taking file->f_pos_lock (as this
> proposed version of IORING_OP_GETDENTS avoids using file->f_pos) means
> that ->iterate_shared() can then be called concurrently on the same
> struct file, which breaks the mutual exclusion guarantees provided here.
> 
> If possible, I'd like to keep the ability to explicitly pass in a
> directory offset to start reading from into IORING_OP_GETDENTS, so
> perhaps we can simply satisfy the mutual exclusion requirement by
> taking ->f_pos_lock by hand -- but then I do need to check that it's OK
> for ->iterate{,_shared}() to be called successively with discontinuous
> offsets without ->llseek() being called in between.
> 
> (If that's not OK, then we can either have IORING_OP_GETDENTS just
> always start reading at ->f_pos like before (which might then require
> adding a IORING_OP_GETDENTS2 at some point in the future if we'll
> ever want to change that), or we could have IORING_OP_GETDENTS itself
> call ->llseek() for now whenever necessary.)

Having IORING_OP_GETDENTS seek to sqe->off if needed seems easy
enough to implement, and it simplifies the other code as well, so
I'll send out a v2 RFC shortly that does this.
