Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92D7339040
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhCLOqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230302AbhCLOpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:45:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4536A64FD6;
        Fri, 12 Mar 2021 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615560350;
        bh=5OcUS67DMAnxCxpF2YhrDjA4ZH7gotBBF3aF5cp7VAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGrTW2c5kQMZqDLHOuPubJDXsH5iNNl9G1C8bABPxHyPcm06lamlCYPxjL/7xokSu
         6xqdQEaz0tP0k8l4U3D3jCYKk3PxisKyYJ9L5pw2AdXmglGrmAxermQHLMydovsQSS
         IA2wUtJS7RrAgy28DpmknVJbOyZw2fAvOZcmmZbs=
Date:   Fri, 12 Mar 2021 15:45:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v4] f2fs: add sysfs nodes to get runtime compression stat
Message-ID: <YEt+nAEOd+YUdln8@kroah.com>
References: <20210312122531.2717093-1-daeho43@gmail.com>
 <YEtg8U7whCVV2tQt@kroah.com>
 <CACOAw_zhZ0OgT-KCBmD_H6_U=CZCNY44D-ojH2AZah2cbAvdAQ@mail.gmail.com>
 <YEt00vJ6oVfoRjSJ@kroah.com>
 <CACOAw_yjyy+58B=RawAaQO98NQB43roZOv4sq5313sFHN1myXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_yjyy+58B=RawAaQO98NQB43roZOv4sq5313sFHN1myXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top


On Fri, Mar 12, 2021 at 11:37:29PM +0900, Daeho Jeong wrote:
> As you can see, if we're doing like the below.
> 
> sbi->compr_written_block += blocks;
> 
> Let's assume the initial value as 0.
> 
> <thread A>                                             <thread B>
> sbi->compr_written_block = 0;
> 
> sbi->compr_written_block = 0;
> +blocks(3);
>                                                                + blocks(2);
> sbi->compr_written_block = 3;
> 
> sbi->compr_written_block = 2;
> 
> Finally, we end up with 2, not 5.
> 
> As more threads are participating it, we might miss more counting.

Are you sure?  Isn't adding a number something that should happen in a
"safe" way?

And if you miss 2 blocks, who cares?  What is so critical about these
things that you take the cache flush of 2 atomic writes just for a
debugging statistic?

Why not just take 1 lock for everything if it's so important to get
these "correct"?

What is the performance throughput degradation of adding 2 atomic writes
to each time you write a block?

But really, will you ever notice missing a few, even if that could be
possible on your cpu (and I strongly doubt most modern cpus will miss
this...)

But this isn't my code, I just hate seeing atomic variables used for
silly things like debugging stats when they do not seem to be really
needed.  So if you want to keep them, go ahead, but realize that the
number you are reading has nothing to do with being "atomic" at all.

thanks,

greg k-h
