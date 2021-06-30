Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B924D3B8142
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 13:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhF3LaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 07:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhF3LaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 07:30:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F15C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=YcUqSyb80R0ASzDoWxv2Nvd88ZLCZUq6ve4o6p7i3Ak=; b=MUCOpy6PjkSvywNfWoKvM57NpI
        0NO2Ps32CpkfQS9cSMf93CERw2kuAXGH/qxxGL2IEuhTV2BsvFebQyw6hrDit3J3Fbxx33yYCMKJ0
        98ZPG0mtPfuC2Ik5rZubWJXXbtI31zXYeJBKrcxq0gPRH40kZd3OnqQrO/YPpG5B3AqngUSkJs4ym
        +AsIOq5iZTIX6I+VklqGv7X+NtRd3ArU/7CH6tdqRVYoyZbb5qIbD6bQaYCQ7oE9ewUgZKRJiCboB
        om1RCRz6ZCV9pU66hk7LEsp96ZC6aSP3h6yz0A3qSt5RHqKWjOT3GdQyOSEiAx0P48P6setvhe51U
        bMV8/ZGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyYMr-005H5W-7v; Wed, 30 Jun 2021 11:27:07 +0000
Date:   Wed, 30 Jun 2021 12:26:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     =?utf-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: cleancache: fix potential race in cleancache apis
Message-ID: <YNxVAZDttnWncNUy@casper.infradead.org>
References: <CGME20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
 <20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
 <YNwnqOuFlIG6Jofy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNwnqOuFlIG6Jofy@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 10:13:28AM +0200, gregkh@linuxfoundation.org wrote:
> On Wed, Jun 30, 2021 at 04:33:10PM +0900, 권오훈 wrote:
> > Current cleancache api implementation has potential race as follows,
> > which might lead to corruption in filesystems using cleancache.
> > 
> > thread 0                thread 1                        thread 2
> > 
> >                         in put_page
> >                         get pool_id K for fs1
> > invalidate_fs on fs1
> > frees pool_id K
> >                                                         init_fs for fs2
> >                                                         allocates pool_id K
> >                         put_page puts page
> >                         which belongs to fs1
> >                         into cleancache pool for fs2
> > 
> > At this point, a file cache which originally belongs to fs1 might be
> > copied back to cleancache pool of fs2, which might be later used as if
> > it were normal cleancache of fs2, and could eventually corrupt fs2 when
> > flushed back.
> > 
> > Add rwlock in order to synchronize invalidate_fs with other cleancache
> > operations.
> > 
> > In normal situations where filesystems are not frequently mounted or
> > unmounted, there will be little performance impact since
> > read_lock/read_unlock apis are used.
> > 
> > Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> 
> What commit does this fix?  Should it go to stable kernels?

I have a commit I haven't submitted yet with this changelog:

    Remove cleancache

    The last cleancache backend was deleted in v5.3 ("xen: remove tmem
    driver"), so it has been unused since.  Remove all its filesystem hooks.

    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

