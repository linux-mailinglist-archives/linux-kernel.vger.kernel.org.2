Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E3A3B8223
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhF3Mby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234426AbhF3Mby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:31:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECF4B61494;
        Wed, 30 Jun 2021 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625056165;
        bh=EHmQTb8e2YECJNCJlq3BRBtEN7eaK8TcnhlyN2zl1Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6abjA0D+JFT5yVpRLqglk9ebYLSi+YqwIN6uwyR99YPpXfR6ESoifyNJnQMKCXoy
         x85Lh5y/mN1Cmd/g4TBcrYu6eI/1Fw52Aea8A8pzBtycj1scru8n4sOHxVcp0Z9sD2
         hqtQA9kcsrWHBI0cqIxkg65etcteWT1GD1USZHyE=
Date:   Wed, 30 Jun 2021 14:29:23 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?utf-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: cleancache: fix potential race in cleancache apis
Message-ID: <YNxjoxBNdWm604FU@kroah.com>
References: <CGME20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
 <20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
 <YNwnqOuFlIG6Jofy@kroah.com>
 <YNxVAZDttnWncNUy@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNxVAZDttnWncNUy@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 12:26:57PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 30, 2021 at 10:13:28AM +0200, gregkh@linuxfoundation.org wrote:
> > On Wed, Jun 30, 2021 at 04:33:10PM +0900, 권오훈 wrote:
> > > Current cleancache api implementation has potential race as follows,
> > > which might lead to corruption in filesystems using cleancache.
> > > 
> > > thread 0                thread 1                        thread 2
> > > 
> > >                         in put_page
> > >                         get pool_id K for fs1
> > > invalidate_fs on fs1
> > > frees pool_id K
> > >                                                         init_fs for fs2
> > >                                                         allocates pool_id K
> > >                         put_page puts page
> > >                         which belongs to fs1
> > >                         into cleancache pool for fs2
> > > 
> > > At this point, a file cache which originally belongs to fs1 might be
> > > copied back to cleancache pool of fs2, which might be later used as if
> > > it were normal cleancache of fs2, and could eventually corrupt fs2 when
> > > flushed back.
> > > 
> > > Add rwlock in order to synchronize invalidate_fs with other cleancache
> > > operations.
> > > 
> > > In normal situations where filesystems are not frequently mounted or
> > > unmounted, there will be little performance impact since
> > > read_lock/read_unlock apis are used.
> > > 
> > > Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> > 
> > What commit does this fix?  Should it go to stable kernels?
> 
> I have a commit I haven't submitted yet with this changelog:
> 
>     Remove cleancache
> 
>     The last cleancache backend was deleted in v5.3 ("xen: remove tmem
>     driver"), so it has been unused since.  Remove all its filesystem hooks.
> 
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

That's even better!

But if so, how is the above reported problem even a problem if no one is
using cleancache?

thanks,

greg k-h
