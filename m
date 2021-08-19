Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBF03F1529
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbhHSI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbhHSI2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:28:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD28C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:27:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d4so11044308lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fnux9c4rs4QAwYzHEIhmWyQkib9slllVEKuUIkxZE4U=;
        b=hOYdmFoKoEgNHqgucA6LMg9vfQKBXNg9AF8pFlq42o1xRgIW3yE+LurXE3ntggZBTH
         b7UmQz756HBNv7YCtADHrbPG1UFWZ4SkfysIRSgPbVM2DhcjX0peKKJ7ojvvZjcWFNYA
         dZg/1y9o+kgZmwmu7JL8BuLC1vLmhEZXdESTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fnux9c4rs4QAwYzHEIhmWyQkib9slllVEKuUIkxZE4U=;
        b=dZEscI111/LBGDlFP/AeMeBtUz/8/GtoNriMj6bnYtmdrVnaT+IYh7JcOBJGshlzu8
         Bm8HTvQgAHt9J4O3wgbfzZY8VvS43nfOKoj1HcVJZNH8y4q+njewyLlwUbpGvBl6OFrE
         wlxSdkDgGqqPFd45A33HnqZlRhWMmqFnhdrumYJYsFk9tCTDJP0H2o2KtNi7cdOEaQBI
         Ul/wtVATo1PW+NMtcFIpbDWJFZ8lZUgOOVDINnBwTsv6j83BwxHmhkUz6xk3CMI9MuBz
         /duFBxWSTF9Nqn/rA6xb9gU10zHUF8TIhQpnRYGYx+AWHC1KDUe/qMG1ooeFhnoF5b3T
         li0w==
X-Gm-Message-State: AOAM5316UGkZqAiQctBcMoKBJdcX1Xw2i6wlpxZ7UFbzaVbxPbSq5VLz
        jDHuY1OwSpePQTHiT4gIG+3K3g==
X-Google-Smtp-Source: ABdhPJyouvHEQUt0g1C4b6sjpes/07r3gE6nWd5YO8P/tYJueCo9kkvIivms2bRFv5I/d17VlOiGTQ==
X-Received: by 2002:ac2:5f0f:: with SMTP id 15mr9840865lfq.25.1629361655585;
        Thu, 19 Aug 2021 01:27:35 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r7sm256655lfr.60.2021.08.19.01.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 01:27:35 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] slab: Add __alloc_size attributes for better
 bounds checking
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Daniel Micay <danielmicay@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210818214021.2476230-1-keescook@chromium.org>
 <20210818214021.2476230-5-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a54715b4-3d95-293c-6b18-6d84299bd58f@rasmusvillemoes.dk>
Date:   Thu, 19 Aug 2021 10:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818214021.2476230-5-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2021 23.40, Kees Cook wrote:
> As already done in GrapheneOS, add the __alloc_size attribute for
> regular kmalloc interfaces, to provide additional hinting for better
> bounds checking, assisting CONFIG_FORTIFY_SOURCE and other compiler
> optimizations.
> 

>  #ifdef CONFIG_NUMA
> +__alloc_size(1)
>  void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_slab_alignment __malloc;

Eh, can we keep all the attributes together instead of having some
before, some after?

I don't necessarily think this is a good idea, but just throwing it out
there: __alloc_size almost always goes along with __malloc, so one could
define __alloc_size in such a way that it implies __malloc, then just
have a "raw" ____alloc_size version to use for krealloc() and similar.
But I guess it's cleaner to keep it this way.

While declared in string.h, kmemdup() is also eligible for alloc_size(2).

Which brings me to an old wishlist item of mine [it's almost christmas]:
that alloc_size could understand more general expressions for the size
of the returned memory, not just the primitive one based on
malloc()/calloc() prototypes. So e.g. kmemdup_nul() returns something of
size $2+1, while it is also very common to have a alloc_foo(void) helper
which returns something of size sizeof(struct foo). Unfortunately I
don't think gcc's attribute parsing machinery can easily be tweaked into
accepting

struct bar *alloc_bars(unsigned count) __new_a_s(count * sizeof(struct bar))

but maybe clang could. If a compiler could understand that kind of
attribute, it would also pave the way for implementing
__attribute__((__buffer_size__(param, size, access)))

e.g.

memchr(src, c, size) __buffer_size(src, size, "r")

clk_bulk_get(struct device *dev, int num_clks, struct clk_bulk_data
*clks) __buffer_size(clks, num_clks * sizeof(*clks), "rw")

which could be used for both static analysis and optional run-time
instrumentation.

Rasmus
