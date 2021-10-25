Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB1D438F13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJYGDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhJYGDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:03:52 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E85C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:01:30 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s9so14096366oiw.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BHDHCA2tdEWpGSchMhf7ru08fjMx1410uewWoCJjgb8=;
        b=U57c8msbVFW1pdo7Wt+RxHaOa9+S2A8WBhJVIQvNimZ/avAETH2yXPeasAPqYAj4hn
         4BS+qfXA75PC8NEmYwQ7trmKHqz5HX5XekpF/cHjSC9XYkjDDE4QoegbfCaGr+gCXYKW
         XKyEkA8iU1KUd4bmMbuk7yeKU8zG5pyLbJL8O4MuSnxCrP1G4Ugcdi7/v2CnVCmWkdRK
         6QubTlJCbc+r4F9cQxft9P7RdzZNtBatskDGdHFQGMUccUJM5VQmJvTKpISN4YjvEKLV
         MgamsQApMOLIjPrPfz/qBmHoRL1TlwHHbLok6/Cub6BYZODoagL1I97vBkMW6WZmoL4L
         Qrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BHDHCA2tdEWpGSchMhf7ru08fjMx1410uewWoCJjgb8=;
        b=Ah00Xn7EJHjCC/X3w/y8FlFJwMH2EODSike4qINI6xyuZBJyjbMF8+cd/gStZ+pYTu
         0bD8Wy22kIs2FPJbHYu9Rbg8h+cqx9xfwF1O7hiL5sYi0QKyLz0SaJrQt+RC+HfHO+o7
         4nZiecAbJ2o7Afnz5g//y+frjJTVIl4PiwJziv1zUKQ3WlyDq1/bRqNSNyhDqFGvikY7
         1iZwjVnkelLXphAgCpZkel9RlO0/b+UY8jl8EhGqwFioVjTIqywlwlxccH7ycrhOBhld
         rHHOjvZKHjvmL4jNBjhd8hQbmTDqZdAQ4Z9aa77dEWTfiSQ1PkCK8WTfgNgUlYyl2K2l
         x9wg==
X-Gm-Message-State: AOAM532rIaf+P+fwaBzse7EKa4da1Q4DzlldDHZ5fxUcu9B6VfR0MyL/
        fqDSiSvm/WAm6iFCPU1w63lk10YeIrJNJQPcXBTB1m9kuzs=
X-Google-Smtp-Source: ABdhPJyOtGRa46Y1SOqS2myG7Z14PZ1hG6KK9U2T+syRBGvynCbsCkh6QCijM8IzyX0BL2KDkBSm/4syiYs7YcipQMo=
X-Received: by 2002:a05:6808:6ce:: with SMTP id m14mr10715106oih.134.1635141689795;
 Sun, 24 Oct 2021 23:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211023171802.4693-1-cyeaa@connect.ust.hk> <CANpmjNP8uAexEZ3Qa-GfBfX6V8tAd7NK0vt3T3Xjh4CkzxfS-g@mail.gmail.com>
 <TYCP286MB1188F7FAA423CFA03225B3BE8A819@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB1188F7FAA423CFA03225B3BE8A819@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
From:   Marco Elver <elver@google.com>
Date:   Mon, 25 Oct 2021 08:00:00 +0200
Message-ID: <CANpmjNO5-o1B9r2eYS_482RBVJSyPoHSnV2t+M8fJdFzBf6d2A@mail.gmail.com>
Subject: Re: [PATCH] mm/kfence: fix null pointer dereference on pointer meta
To:     YE Chengfeng <cyeaa@connect.ust.hk>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2021 at 21:22, YE Chengfeng <cyeaa@connect.ust.hk> wrote:
[...]
> Thanks for your reply, this is reported by a static analysis tool develop=
ed by us. It just checks dataflow and doesn't know other complex semantics.=
 I didn't know whether it is a real bug, so I send the patch just in case. =
It seems that if the index is incorrect, the function addr_to_metadata will=
 also return null-ptr, I don't know whether this is checked by other upper-=
level functions.
[...]
> And you are right, if it is a null-ptr, the root cause of it should be in=
 the upper-level function. I think you can add some null-ptr check like ass=
ert(meta !=3D null) if you want, this will suppress this kind of false posi=
tive report. Anyway, I think it is not a very good thing to just let this n=
ull-ptr dereference happen, even though it is not a big deal. Adding some c=
hecking to handle this case may be better, for example, print some error lo=
gging.

It's a little more complicated than this: the negative index may
happen when called with an object in range R =3D [__kfence_pool,
__kfence_pool+(PAGE_SIZE*2)-1]. The first thing to note is that this
address range is never returned by KFENCE as a valid object because
both pages are "guard pages".

Secondly, while calling kfence_free(R) will result in the NULL-deref,
however, such a call is either buggy or malicious because it's only
meant to be called from the allocators' kfree slow-path (slub.c and
slab.c). Calling kfree(R) _does not_ lead to the kfree slow-path which
calls kfence_free(), because the first 2 pages in KFENCE's pool do not
have PageSlab nor page->slab_cache set.

You can try it yourself by randomly doing a kfree(__kfence_pool)
somewhere, and observing that nothing happens.

As you can see, encountering the NULL-deref in __kfence_free() really
should be impossible, unless something really bad is happening (e.g.
malicious invocation, corrupt memory, bad CPU, etc.).

And regarding assert(meta !=3D null) you mentioned: the kernel does not
have asserts, and the closest we have to asserts are WARN_ON() and
BUG_ON(). That latter of which is closest to an assert() you may be
familiar with from user space. However, its use is heavily
discouraged: unlike user space, the kernel crashing takes the whole
machine down. Therefore, the kernel wants to handle errors as
gracefully as possible, i.e. recover where possible.

However, something like BUG_ON(!ptr) is quite redundant, because a
NULL-deref always crashes the kernel and also prints a helpful call
trace.

But as reasoned above, really shouldn't happen in our case. And if it
does, we'd _really_ want to know about it (just crash) -- we either
have a serious bug somewhere, or something more malicious is
happening. Therefore, handling this case more gracefully, be it with a
WARN_ON() or otherwise, does not seem appropriate as I couldn't say if
it's safe to recover and continue execution in such a state.

The same is true for any other place in the kernel handling pointers:
if a NULL-deref really isn't expected, often it makes more sense to
crash rather than continue in an unknown bad state potentially
corrupting more data.

Thanks,
-- Marco
