Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A81417BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348204AbhIXTpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344606AbhIXTpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 15:45:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69EC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 12:43:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r2so10814144pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yh0tKFftKMpaU5zCDGgZ0wFbWRfGqnJFa/3ltlAnWS4=;
        b=A4RrQfNq32FTd/c8bdBoYqxW/Sy/dQlKL1FezuBgHX37do9WZ7n9TbVf+3wF8wCu5T
         gT3kkUxFzcWSrNMpzVXlqfGAF/lbUcv+KpqyY9qzc/osL1j8sfC5fJXtSgse/w54CohC
         BkjCg8SlBRERoVcxA9VpQdfG7PqHNCIONoJVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yh0tKFftKMpaU5zCDGgZ0wFbWRfGqnJFa/3ltlAnWS4=;
        b=swphNxQZGgvcZqIG54JnoDZn/jMJZ1W0dxXYglAG78FEP4yUrPLdGwgMjhWOAyoCuE
         jtOhw2w7BI8pV6p+5MGOb/L1bshwJ++vFUWvxslOuoecHOtHmF4bRJdA8kuxjqKHW625
         UYm2+mWTN5OSEsgV2WEcDXxrkDYle86PO6uerKblStP4kSECmaCu7kZYiUrFmhKfbmSD
         ulvmbpjHfml0ZS6+uDFMkPzogrKxjJ7Mb52OHungR1TFg++3FtILq2RKSzmXpGUy7i94
         98aE1lo4xt/7AMNo/1/jH2BN/94hg/OH9eo1dpcbe0h3Kr23qbm65hQqF1m7R/T83NWe
         yOYA==
X-Gm-Message-State: AOAM5326PX5NlAUrI7yWfVWFlHoGcruuoRaxS1YQmVhWQrLwh+1uLa97
        XqzIDZd+W/4HEiUfdBS9fgZvkw==
X-Google-Smtp-Source: ABdhPJz8N9L10FfNCCZ++/172JLdRltAaPOsWjfROEN1Oo+YHcmLZt2hS+BpTokuHRwxozTdKDXGKg==
X-Received: by 2002:aa7:998a:0:b0:44b:6b98:5ae8 with SMTP id k10-20020aa7998a000000b0044b6b985ae8mr1435363pfh.35.1632512620133;
        Fri, 24 Sep 2021 12:43:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g27sm9992651pfk.173.2021.09.24.12.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 12:43:39 -0700 (PDT)
Date:   Fri, 24 Sep 2021 12:43:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, apw@canonical.com,
        Christoph Lameter <cl@linux.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, dwaipayanray1@gmail.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux-MM <linux-mm@kvack.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        mm-commits@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-doc@vger.kernel.org
Subject: Re: function prototype element ordering
Message-ID: <202109241238.13C92BA004@keescook>
References: <20210909200948.090d4e213ca34b5ad1325a7e@linux-foundation.org>
 <20210910031046.G76dQvPhV%akpm@linux-foundation.org>
 <CAHk-=wgfbSyW6QYd5rmhSHRoOQ=ZvV+jLn1U8U4nBDgBuaOAjQ@mail.gmail.com>
 <202109211630.2D00627@keescook>
 <af3c775a1515f97c8dbe6a6651bd6e4b6986e8cd.camel@perches.com>
 <202109211757.F38DF644@keescook>
 <0b1c78b395a7a198a089ba8f6283d8d10829720c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b1c78b395a7a198a089ba8f6283d8d10829720c.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:24:04PM -0700, Joe Perches wrote:
> On Tue, 2021-09-21 at 19:25 -0700, Kees Cook wrote:
> > [...]
> > Looking through what was written before[1] and through examples in the
> > source tree, I find the following categories:
> > 
> > 1- storage class: static extern inline __always_inline
> > 2- storage class attributes/hints/???: __init __cold
> > 3- return type: void *
> > 4- return type attributes: __must_check __noreturn __assume_aligned(n)
> > 5- function attributes: __attribute_const__ __malloc
> > 6- function argument attributes: __printf(n, m) __alloc_size(n)
> > 
> > Everyone seems to basically agree on:
> > 
> > [storage class] [return type] [return type attributes] [name]([arg1type] [arg1name], ...)
> > 
> > There is a lot of disagreement over where 5 and 6 should fit in above. And
> > there is a lot of confusion over 4 (mixed between before and after the
> > function name) and 2 (see below).
> > 
> > What's currently blocking me is that 6 cannot go after the function
> > (for definitions) because it angers GCC (see quoted bit above), but 5
> > can (e.g. __attribute_const__).
> > 
> > Another inconsistency seems to be 2 (mainly section markings like
> > __init). Sometimes it's after the storage class and sometimes after the
> > return type, but it certainly feels more like a storage class than a
> > return type attribute:
> > 
> > $ git grep 'static __init int' | wc -l
> > 349
> > $ git grep 'static int __init' | wc -l
> > 8402
> > 
> > But it's clearly positioned like a return type attribute in most of the
> > tree. What's correct?
> 
> Neither really.  'Correct' is such a difficult concept.
> 'Preferred' might be better.

Right -- I expect it to be a guideline.

> btw: there are about another 100 other uses with '__init' as the
> initial attribute, mostly in trace.

Hah, yeah.

> And I still think that return type attributes like __init, which is
> just a __section define, should go before the function storage class
> and ideally on a separate line to simplify the parsing of the actual
> function declaration.  Attributes like __section, __aligned, __cold,
> etc... don't have much value when looking up a function definition.
> 
> > Regardless, given the constraints above, it seems like what Linus may
> > want is (on "one line", though it will get wrapped in pathological cases
> > like kmem_cache_alloc_node_trace):
> 
> Pathological is pretty common these days as the function name length
> is rather longer now than earlier times.

Agreed!

> > [storage class] [storage class attributes] [return type] [return type attributes] [function argument attributes] [name]([arg1type] [arg1name], ...) [function attributes]
> > 
> > Joe appears to want (on two lines):
> > 
> > [storage class attributes] [function attributes] [function argument attributes]
> > [storage class] [return type] [return type attributes] [name]([arg1type] [arg1name], ...)
> 
> I would put [return type attributes] on the initial separate line
> even though that's not the most common use today.

I found a few other people wanting separate lines too, so at the risk of
annoying Linus, I guess I'll attempt this (again).

> > I would just like to have an arrangement that won't get NAKed by
> > someone. ;)
> 
> Bikeshed building dreamer...

I just want to know the right place to put stuff. :P

> But IMO the desire here is to ask for a bit more uniformity, not
> require it.

Yeah.

-- 
Kees Cook
