Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2933E31523A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhBIO6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:58:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:46826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbhBIO62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:58:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612882661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NT5My67JE83c8tAQ8Vj7O5VdNPEkjvw0Ln0YAFM1sgc=;
        b=DmFSBCWKMuwLh62B0GyHFP86vFiEERQKvPAVLlLH7/QvzDqlqOq4BiRSAmY/Gb+F9QBW/y
        O2+gt58hpWIAHwj2BaiDlTSjPQm11giinGHuVnb2d198F333Kkt4qNYoZULj9hD60StZgd
        hxVCDOXOU5Xuz/koVQemOXEPW03Pj2U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9851BB201;
        Tue,  9 Feb 2021 14:57:41 +0000 (UTC)
Date:   Tue, 9 Feb 2021 15:57:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, willy@infradead.org,
        david@redhat.com, linmiaohe@huawei.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com, joe@perches.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <YCKi4mcFrJ9Qu2b5@alley>
References: <20210209105613.42747-1-laoar.shao@gmail.com>
 <20210209105613.42747-4-laoar.shao@gmail.com>
 <YCKT8WCPGU+HBY91@alley>
 <YCKZIWMYjD33xXnr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCKZIWMYjD33xXnr@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-09 16:16:01, Andy Shevchenko wrote:
> On Tue, Feb 09, 2021 at 02:53:53PM +0100, Petr Mladek wrote:
> > On Tue 2021-02-09 18:56:13, Yafang Shao wrote:
> 
> ...
> 
> > I am sorry for my ignorance. I am not familiar with MM.
> > But it is pretty hard to understand what call does what.
> > 
> > I have found the following comment in include/linux/page_flags.h:
> > 
> >  * The page flags field is split into two parts, the main flags area
> >  * which extends from the low bits upwards, and the fields area which
> >  * extends from the high bits downwards.
> > 
> > Sigh, I know that you already reworked this several times because
> > people "nitpicked" about the code style. But it seems that it
> > rather diverged instead of converged.
> > 
> > What about the following?
> 
> Isn't is some like v1 or v2?

Yes. And people suggested only some micro-optimizations and reported
few small bugs there.

But the code was heavily reworked in v3 to support the new
%pGp[bl] variants. It also added the trick with the bitmap
which invalidated all the previous suggestions.

v3 and v4 review focused on behavior changes. We finally
agreed on it. Let's give it more cycle and clean up the code
after so many shuffles.


> > Note: It is inpired by the names "main area" and "fields area"
> >       mentioned in the above comment from page_flags.h.
> >       I have later realized that "page_flags_layout" actually made
> >       sense as well. Feel free to rename page_flags_fileds
> >       back to page_flags_layout.
> > 
> > Anyway, this is my proposal:
> 
> What about to create a one format_flags() function which accepts new data
> structure and do something like
> 
> buf = format_flags(main_area);
> buf = format_flags(fields_area);
> return buf;

I am not sure that it would make things easier. The handling of
the main area is trivial and reuses existing structures. The handling
of the fields area seems to be much more complicated.

Best Regards,
Petr
