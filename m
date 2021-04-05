Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CBF3546EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhDETEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 15:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhDETEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 15:04:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30111C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 12:04:40 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k8so10534308iop.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtQ/iLv+P2BCeEfpOcDLO0PQnggEhhArpE78rF7iphg=;
        b=NAb0SiRSe1AlRkL2bmmINYRdC8ThFQ3ukE/dpa44nJ5GYFyIiWmOAYpLY5tKXKRg7D
         O1/FBpa4NJOvwWDjbxDdF1VmizuoDKRi5IeWN7AqZvTaeGtuBrpEgYdMmIr1LLOz7t75
         cJjmVxhmoG9/QiH//3RAwu3HDEstFnkbi88RFe+0BSaBAQi179+7A+t576d9KyGfp+CK
         Xta3GrwX71FttaU0RsS9FKaiPTjBYXaGrveYsg5Dl/q11OdaCuvxaOuFtWy25YxbYBPM
         nkelWJ8e5WU8x0sv76Yt0Ln0K1Zh23cwGEW77B0RhfeySn6cmfLznQlAiHu+ZCP2BWWC
         mtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtQ/iLv+P2BCeEfpOcDLO0PQnggEhhArpE78rF7iphg=;
        b=Zq8ii5iD2AoD6++0B9LwVXERTG4AoWstHVaZlmhXDZmexCWyhUPDDiXkX6y1qHf4h/
         a6ZB4X+lqUGOAu5LxreAq28+V2nBRb8w2kuKfcp3isxHx8tTbVfki0S+bCr25n7Bqmxy
         DRk6VG7KcUk20pGzo5qlkzNjLPdv3vklbc8dnFgBTPer2q/ElgExFKjGqI6FRUdCgTW3
         8IY+uv2GzYpjFhlta7Qb9pvSu9hKutgJEnI3LwYJ1T8CtCdl4ObKpV2GBkUZ1V3TPDia
         5PCoS7ULne4cQR/Vqwn0piTh2ibT8Re/H1E9tA4IsLQwuWnpQHNv6XrxmtTKcWS2IURU
         rnJw==
X-Gm-Message-State: AOAM5320UQN2g1qKA0ytCabOI4zZ09SQXgGx4t18FAX+0JGgaJ7vJPMR
        OCLLCfm8rdPslHqY7wY7RmsQKt4XkVSkgjrRgOy7fA==
X-Google-Smtp-Source: ABdhPJzIKqxoQCsNbUfm9Y3yjcNlIcYGi/rTWHMvpFVcm309RO2qkfaj7h6fjFZu33MLbjK/27mP8SfZVfFNrFUB7EQ=
X-Received: by 2002:a02:b39a:: with SMTP id p26mr25364409jan.20.1617649479285;
 Mon, 05 Apr 2021 12:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210403051325.683071-1-pcc@google.com> <CANpmjNOzaOJY5K+Sq78AF5N1_6=1kv3rXZ6w+XPuEf9G+cd8iA@mail.gmail.com>
 <CAMn1gO5mQ2WPs9B9jN91T90Qxf3k6eK-GeBUhs=YqmkZu4NKFg@mail.gmail.com>
 <CANpmjNM__Dk_MVd-9fPT=TbPw=a1giicUcFS+RwCfQ7yue8Xdw@mail.gmail.com> <CA+fCnZd4BaejuyyWuT4xeiEyY1J0-6RWiyP3_u+w-xdOrALd9w@mail.gmail.com>
In-Reply-To: <CA+fCnZd4BaejuyyWuT4xeiEyY1J0-6RWiyP3_u+w-xdOrALd9w@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 5 Apr 2021 12:04:28 -0700
Message-ID: <CAMn1gO6bmtA6mtTg5OzDPV1Ta=rRhKknJO324_eS3CWtuThaHQ@mail.gmail.com>
Subject: Re: [PATCH] kfence: unpoison pool region before use
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 4:52 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Sun, Apr 4, 2021 at 12:31 AM Marco Elver <elver@google.com> wrote:
> >
> > However, given the above, I think we need to explain this in the
> > commit message (which also makes the dependency between these 2
> > patches clear) and add a comment above the new kasan_unpoison_range().
> > That is, if we still think this is the right fix -- I'm not entirely
> > sure it is.
> >
> > Because what I gather from "kasan: initialize shadow to TAG_INVALID
> > for SW_TAGS", is the requirement that "0xFF pointer tag is a match-all
> > tag, it doesn't matter what tag the accessed memory has".
> >
> > While KFENCE memory is accessible through the slab API, and in this
> > case ksize() calling kasan_check_byte() leading to a failure, the
> > kasan_check_byte() call is part of the public KASAN API. Which means
> > that if some subsystem decides to memblock_alloc() some memory, and
> > wishes to use kasan_check_byte() on that memory but with an untagged
> > pointer, will get the same problem as KFENCE: with generic and HW_TAGS
> > mode everything is fine, but with SW_TAGS mode things break.
>
> It makes sense to allow this function to operate on any kind of
> memory, including memory that hasn't been previously marked by KASAN.
>
> > To me this indicates the fix is not with KFENCE, but should be in
> > mm/kasan/sw_tags.c:kasan_byte_accessible(), which should not load the
> > shadow when the pointer is untagged.
>
> The problem isn't in accessing shadow per se. Looking at
> kasan_byte_accessible() (in both sw_tags.c and kasan.h), the return
> statement there seems just wrong and redundant. The KASAN_TAG_KERNEL
> check should come first:
>
> return tag == KASAN_TAG_KERNEL || (shadow_byte != KASAN_TAG_INVALID &&
> tag == shadow_byte);
>
> This way, if the pointer tag is KASAN_TAG_KERNEL, the memory is
> accessible no matter what the memory tag is.
>
> But then the KASAN_TAG_INVALID check isn't needed, as this value is
> never assigned to a pointer tag. Which brings us to:
>
> return tag == KASAN_TAG_KERNEL || tag == shadow_byte;
>
> Which is essentially the same check that kasan_check_range() performs.
>
> Although, kasan_check_range() also checks that the shadow is <
> KASAN_SHADOW_START. It makes makes sense to add this check into
> kasan_byte_accessible() as well, before accessing shadow.
>
> Thanks!

Okay, if the intent is that kasan_byte_accessible() should work on any
memory, not just slab memory, then I agree that it should do the same
thing as kasan_check_range().

Peter
