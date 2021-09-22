Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA21413F62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhIVC1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhIVC1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:27:24 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 19:25:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s16so1448943pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 19:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EYPmTFwbBM8fuIC7340+u45bIhCGBLoT/UxK4/aF7nk=;
        b=TFaCJt2y2zqQlkhVDjb7c8BaPXdlhPaEKCtoXHb2T2wQiroGttSgKzFtnrgLVruaDw
         J+Jag16UKxeqZduzZ4xEvTVQg07tq77BwNCwGSEtPmptzBod+N4ApxcUnBvc/HEfu0yJ
         X75omPNroUAgC4zFjzop9DXt3J21yEfJKAU2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EYPmTFwbBM8fuIC7340+u45bIhCGBLoT/UxK4/aF7nk=;
        b=B3MeWkNS+jOil9urKacJ+bxVr7F5oNd1lBg/jTtErinN13QVwBzKoJJ+Nv7tlbGaeH
         nhJkBLRVYrfhrt4KKzbXptosIl9pPPlu66Sq7q/HbeLqKGEHxEFqoWmoFfujq+XQF6nt
         rrn/RHahNIkhaXYu5zNvkUxy+56/iqUv/5FRY0PkJoM1RShphsRmS+Y15V7bE7hHIlbC
         TN0QOqdjLFkLZKEFRY5HmEHe5BSCTUruVuZ19ZnXhRsuBQZ/pcT+pa2Fo637DyazsIa2
         AqPBv49wM4QXrRAJKU6uzMA+I4xjC2OGXIDfUZ7QXHkwIdjkxCImSsDkSabyaoq2IlH7
         hxlw==
X-Gm-Message-State: AOAM532U6+uDK1N2XYvZi5Kl9qEhIKAJt5rwGKlJgX1bhhfbiC/8e0ou
        fL0lqbcH4WIJ+fYOB2AXcn0R7Q==
X-Google-Smtp-Source: ABdhPJxz0SutMentjbJobo7DWQY5POAP3HTNcaTOVTZ41K0G+D644hPUDDoWvL58U2CfuqMWpknYyA==
X-Received: by 2002:a63:d0d:: with SMTP id c13mr30587088pgl.294.1632277554505;
        Tue, 21 Sep 2021 19:25:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p2sm329269pja.51.2021.09.21.19.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 19:25:53 -0700 (PDT)
Date:   Tue, 21 Sep 2021 19:25:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
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
Subject: function prototype element ordering
Message-ID: <202109211757.F38DF644@keescook>
References: <20210909200948.090d4e213ca34b5ad1325a7e@linux-foundation.org>
 <20210910031046.G76dQvPhV%akpm@linux-foundation.org>
 <CAHk-=wgfbSyW6QYd5rmhSHRoOQ=ZvV+jLn1U8U4nBDgBuaOAjQ@mail.gmail.com>
 <202109211630.2D00627@keescook>
 <af3c775a1515f97c8dbe6a6651bd6e4b6986e8cd.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af3c775a1515f97c8dbe6a6651bd6e4b6986e8cd.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:45:44PM -0700, Joe Perches wrote:
> On Tue, 2021-09-21 at 16:37 -0700, Kees Cook wrote:
> > On Fri, Sep 10, 2021 at 10:23:48AM -0700, Linus Torvalds wrote:
> > > On Thu, Sep 9, 2021 at 8:10 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > 
> > > > +__alloc_size(1)
> > > >  extern void *vmalloc(unsigned long size);
> > > [...]
> > > 
> > > All of these are added in the wrong place - inconsistent with the very
> > > compiler documentation the patches add.
> > > 
> > > The function attributes are generally added _after_ the function,
> > > although admittedly we've been quite confused here before.
> > > 
> > > But the very compiler documentation you point to in the patch that
> > > adds these macros gives that as the examples both for gcc and clang:
> > > 
> > > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
> > > + * clang: https://clang.llvm.org/docs/AttributeReference.html#alloc-size
> > > 
> > > and honestly I think that is the preferred format because this is
> > > about the *function*, not about the return type.
> > > 
> > > Do both placements work? Yes.
> > 
> > I'm cleaning this up now, and have discovered that the reason for the
> > before-function placement is consistency with static inlines. If I do this:
> > 
> > static __always_inline void * kmalloc(size_t size, gfp_t flags) __alloc_size(1)
> > {
> > 	...
> > }
> > 
> > GCC is very angry:
> > 
> > ./include/linux/slab.h:519:1: error: attributes should be specified before the declarator in a function definition
> >   519 | static __always_inline void *kmalloc_large(size_t size, gfp_t flags) __alloc_size(1)
> >       | ^~~~~~
> > 
> > It's happy if I treat it as a "return type attribute" in the ordering,
> > though:
> > 
> > static __always_inline void * __alloc_size(1) kmalloc(size_t size, gfp_t flags)
> > 
> > I'll do that unless you have a preference for somewhere else...
> 
> _please_ put it before the return type on a separate line.
> 
> [__attributes]
> [static inline const] <return type> function(<args...>)

Somehow Linus wasn't in CC. :P

Linus, what do you want here? I keep getting conflicting (or
uncompilable) advice. I'm also trying to prepare a patch for
Documentation/process/coding-style.rst ...

Looking through what was written before[1] and through examples in the
source tree, I find the following categories:

1- storage class: static extern inline __always_inline
2- storage class attributes/hints/???: __init __cold
3- return type: void *
4- return type attributes: __must_check __noreturn __assume_aligned(n)
5- function attributes: __attribute_const__ __malloc
6- function argument attributes: __printf(n, m) __alloc_size(n)

Everyone seems to basically agree on:

[storage class] [return type] [return type attributes] [name]([arg1type] [arg1name], ...)

There is a lot of disagreement over where 5 and 6 should fit in above. And
there is a lot of confusion over 4 (mixed between before and after the
function name) and 2 (see below).

What's currently blocking me is that 6 cannot go after the function
(for definitions) because it angers GCC (see quoted bit above), but 5
can (e.g. __attribute_const__).

Another inconsistency seems to be 2 (mainly section markings like
__init). Sometimes it's after the storage class and sometimes after the
return type, but it certainly feels more like a storage class than a
return type attribute:

$ git grep 'static __init int' | wc -l
349
$ git grep 'static int __init' | wc -l
8402

But it's clearly positioned like a return type attribute in most of the
tree. What's correct?

Regardless, given the constraints above, it seems like what Linus may
want is (on "one line", though it will get wrapped in pathological cases
like kmem_cache_alloc_node_trace):

[storage class] [storage class attributes] [return type] [return type attributes] [function argument attributes] [name]([arg1type] [arg1name], ...) [function attributes]

Joe appears to want (on two lines):

[storage class attributes] [function attributes] [function argument attributes]
[storage class] [return type] [return type attributes] [name]([arg1type] [arg1name], ...)

I would just like to have an arrangement that won't get NAKed by
someone. ;) And I'm willing to document it. :)

-Kees

[1] https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/

-- 
Kees Cook
