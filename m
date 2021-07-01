Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CFD3B8D92
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhGAGBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234404AbhGAGBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:01:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96ECE6144F;
        Thu,  1 Jul 2021 05:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625119119;
        bh=YM4h91lQVhhKo9kyJdMeS5B6QjU+m6LOaBDhjy1qm5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wESa4qrnvjgKLn65W3rWr0Wo7Aa4l/llDw6FHRNfKmdcFYkpSVmJvcsdI6nc/Jx7b
         xcnQd2P1TjlDWHmtAQVJG+AwOaGg5sfU2YOd9ohObza17xg1LHiy2kcCQcY3xdmyFv
         QNC9d81sIdNO2EiUNyP27tfBgeIp19cF/NbbF+1w=
Date:   Thu, 1 Jul 2021 07:58:36 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: cleancache: fix potential race in cleancache apis
Message-ID: <YN1ZjHx74KUzA4Rs@kroah.com>
References: <YNxjoxBNdWm604FU@kroah.com>
 <20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
 <YNwnqOuFlIG6Jofy@kroah.com>
 <YNxVAZDttnWncNUy@casper.infradead.org>
 <CGME20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p5>
 <20210701050644epcms1p5ceaf654fdabec4a126081f9edcbb3fff@epcms1p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210701050644epcms1p5ceaf654fdabec4a126081f9edcbb3fff@epcms1p5>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 02:06:44PM +0900, 권오훈 wrote:
> On Thu, Jul 1, 2021 at 02:06:45PM +0900, 권오훈 wrote:
> > On Wed, Jun 30, 2021 at 12:26:57PM +0100, Matthew Wilcox wrote:
> > > On Wed, Jun 30, 2021 at 10:13:28AM +0200, gregkh@linuxfoundation.org wrote:
> > > > On Wed, Jun 30, 2021 at 04:33:10PM +0900, 권오훈 wrote:
> > > > > Current cleancache api implementation has potential race as follows,
> > > > > which might lead to corruption in filesystems using cleancache.
> > > > > 
> > > > > thread 0                thread 1                        thread 2
> > > > > 
> > > > >                         in put_page
> > > > >                         get pool_id K for fs1
> > > > > invalidate_fs on fs1
> > > > > frees pool_id K
> > > > >                                                         init_fs for fs2
> > > > >                                                         allocates pool_id K
> > > > >                         put_page puts page
> > > > >                         which belongs to fs1
> > > > >                         into cleancache pool for fs2
> > > > > 
> > > > > At this point, a file cache which originally belongs to fs1 might be
> > > > > copied back to cleancache pool of fs2, which might be later used as if
> > > > > it were normal cleancache of fs2, and could eventually corrupt fs2 when
> > > > > flushed back.
> > > > > 
> > > > > Add rwlock in order to synchronize invalidate_fs with other cleancache
> > > > > operations.
> > > > > 
> > > > > In normal situations where filesystems are not frequently mounted or
> > > > > unmounted, there will be little performance impact since
> > > > > read_lock/read_unlock apis are used.
> > > > > 
> > > > > Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> > > > 
> > > > What commit does this fix?  Should it go to stable kernels?
> > > 
> > > I have a commit I haven't submitted yet with this changelog:
> > > 
> > >     Remove cleancache
> > > 
> > >     The last cleancache backend was deleted in v5.3 ("xen: remove tmem
> > >     driver"), so it has been unused since.  Remove all its filesystem hooks.
> > > 
> > >     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >  
> > That's even better!
> >  
> > But if so, how is the above reported problem even a problem if no one is
> > using cleancache?
> >  
> > thanks,
> >  
> > greg k-h
> > 
> Dear all.
> 
> We are using Cleancache APIs for our proprietary feature in Samsung.
> As Wilcox mentioned, however, there is no cleancache backend in current kernel
> mainline.
> So if the race patch shall be accepted, then it seems unnecessary to patch 
> previous stable kernels.
> 
> Meanwhile, I personally think cleancache API still has potential to be a good
> material when used with new arising technologies such as pmem or NVMe.
> 
> So I suggest to postpone removing cleancache for a while.

If there are no in-kernel users, it needs to be removed.  If you rely on
this, wonderful, please submit your code as soon as possible.

thanks,

greg k-h
