Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFA732FB52
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 16:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhCFPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 10:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhCFPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 10:20:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C3C06174A;
        Sat,  6 Mar 2021 07:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NjnK0qgYgEfs1buaAUZnKhf/ZDhnvWuO8bhHT6AcXzo=; b=u1ZJJ6BKay/Yg+3YE7MnYVhWQ9
        JH+ifgjLjYNnhi+zBeT4w/oX975qexDEVTXt4FflUFdQfTGPVDkR+XA+xM/+vJzc156wErA6MPDw+
        ufgwJmv/M9ePV01+Cny/kP3fiwa1g5LfJkIsT6mnGm8L5UTiGyWg3zMNznT3xRHrbKk46N07auZCi
        rieDnUxpby6xrLq1GcMxJPDl3nByJAzOs33sq1ZI6vGzxoWOJQ16S+YX2qpmtv6m9kPnib8YiAWAZ
        vo2gxEZPISlMYlyA/a2sG30uBAhkvwzYZU0yZXspc5Q+vv80zlmBgDijxL2KPYTpsYdm0S39aRQyU
        JxVc5XlA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lIYio-00DBQ3-0D; Sat, 06 Mar 2021 15:20:04 +0000
Date:   Sat, 6 Mar 2021 15:20:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Aditya <yashsri421@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC v3] scripts: kernel-doc: fix typedef support for
 struct/union parsing
Message-ID: <20210306152001.GP2723601@casper.infradead.org>
References: <CAKXUXMzHPnM=ie06ZGuFXyJ7RcRjYomjyASbp3ND9-Mb2Es+2w@mail.gmail.com>
 <20210225145033.11431-1-yashsri421@gmail.com>
 <20210306043548.GO2723601@casper.infradead.org>
 <CAKXUXMwD_ZZA7EJaxZBRfMDEvwd4Ghsj2vy9KCfj0R-yx2_K0Q@mail.gmail.com>
 <6a75c9f4-460f-f83e-7fe2-5a3a4c64232b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a75c9f4-460f-f83e-7fe2-5a3a4c64232b@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 01:18:38PM +0530, Aditya wrote:
> On 6/3/21 11:55 am, Lukas Bulwahn wrote:
> > I agree. That might be a suitable clean-up to keep the code for
> > functions and struct/union parsing similar in style/spirit.
> > 
> > Aditya, would you like to create a patch for that?
> 
> Sure Lukas.
> I have a doubt though, Can't we use a single expression separated by
> "|" here, instead of multiple lines? i.e.,
> 
> $x =~
> s/__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)\s*//;
> 
> 
> Probably we could do something similar for dump_function, i.e.,
> -    $prototype =~ s/^static +//;
> -    $prototype =~ s/^extern +//;
> -    $prototype =~ s/^asmlinkage +//;
> -    $prototype =~ s/^inline +//;
> -    $prototype =~ s/^__inline__ +//;
> -    $prototype =~ s/^__inline +//;
> -    $prototype =~ s/^__always_inline +//;
> -    $prototype =~ s/^noinline +//;
> 
> +    $prototype =~
> s/^(?:static|extern|asmlinkage|__?inline__?|__always_inline|noinline) +//;
> And so on for other regexps.
> 
> What do you think?

I think there's a tradeoff between speed / compactness and readability.
As someone who doesn't know perl particularly well, I can look at the
series of lines and say "Oh, it's stripping out these unwanted things".
Your one line, while undoubtedly more efficient, is considerably less
easy to understand.

Maybe there's another way to do it that's more efficient while not
sacrificing the readability?

Also, would your suggestion work for 'static inline void foo(void)'?
I think it needs to remove multiple occurrences of the things in the
regex.  But maybe that's what the ?: on the beginning is for?
