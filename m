Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6615C3535F4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 01:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbhDCXwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 19:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbhDCXwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 19:52:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5D6C061756
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 16:52:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b16so8989693eds.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 16:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qslKCvwXbzOJ0dkzl5lj4jMLTkdwognZQlXTLjB2Jz4=;
        b=EJdOq7MtZY97RF3QlCvNh3iCGm945ySKJ1DdpH1xiPNoTD7Ab6dOpHAGSAI3imDxEs
         k8L+6AA8HkMklqJtG6C0n9p8Y8h8x7P4jLqkOaNpxygaSxGmzffZ6jYD9dnMf1g/51XZ
         8/o6KY6hv4pscx/SpouTfv8Xx1YNvVelWSBonWeV0Jb4i8ffmcntVhN2uxXqtNTRw1fH
         ThM20xZskt1MfXuNeH1mtlaWxVBgXAgr5vSMirjTuTOTXQlp6w0bYFh1odzmX+xo8y9d
         dQUtcO5FnDANnFLdYgfQNIh/JePqDuXkmOij1BvVzW0j/ujJTkLfObUQWNRLZI+Ja+U8
         ChfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qslKCvwXbzOJ0dkzl5lj4jMLTkdwognZQlXTLjB2Jz4=;
        b=UEmYBZNWDB9WXryyU0Qu1U6/Tak3DmbCARn1cF35TI5dICnVQycofneTgvg23Yo/JG
         mT/ju3VW9POftpJtYx2d6WwkEr/ZjzSyWR1n54i1G20tnzVAmv9v8Is9qwumiFCI1aFV
         Q1d9iO3C2/p5EZxXfzswba5GRpfdLFz6V4CyGYHZdbl/Zi5ipssVQCn2fpQmLmNaaIDB
         trHynghS8Vm2P3EmtPkS3dCxfGie6ZE1mwoumiX0WmIYcxkyImrSc4o6CJ5laHmQtJsx
         BlU6sf/4nkQfNOo6yuT0Bf7NN9aQvBrU9jpd4LE5sEMhaeuynL12xHYNCBBYo53oyr2h
         R1ZA==
X-Gm-Message-State: AOAM531sCBxD8G2uKJODXntAFr2zyIwJI6hHDyYow/ajRpH8uMMUA3pT
        bRWpzXTe+iZQYZApbzMmKWVCgvXtCsn1cb0Rdk07pOgZomBPRg==
X-Google-Smtp-Source: ABdhPJwhMQBrFoqDS11xvrKwoYHY/cTTRSFQJkyVchSYtGYqx46aa0KCsf1PuGgd0Juzt5H8J0j3NVU979DEuSgB2xQ=
X-Received: by 2002:aa7:cf17:: with SMTP id a23mr24185964edy.30.1617493935384;
 Sat, 03 Apr 2021 16:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210403051325.683071-1-pcc@google.com> <CANpmjNOzaOJY5K+Sq78AF5N1_6=1kv3rXZ6w+XPuEf9G+cd8iA@mail.gmail.com>
 <CAMn1gO5mQ2WPs9B9jN91T90Qxf3k6eK-GeBUhs=YqmkZu4NKFg@mail.gmail.com> <CANpmjNM__Dk_MVd-9fPT=TbPw=a1giicUcFS+RwCfQ7yue8Xdw@mail.gmail.com>
In-Reply-To: <CANpmjNM__Dk_MVd-9fPT=TbPw=a1giicUcFS+RwCfQ7yue8Xdw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 4 Apr 2021 01:52:04 +0200
Message-ID: <CA+fCnZd4BaejuyyWuT4xeiEyY1J0-6RWiyP3_u+w-xdOrALd9w@mail.gmail.com>
Subject: Re: [PATCH] kfence: unpoison pool region before use
To:     Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 4, 2021 at 12:31 AM Marco Elver <elver@google.com> wrote:
>
> However, given the above, I think we need to explain this in the
> commit message (which also makes the dependency between these 2
> patches clear) and add a comment above the new kasan_unpoison_range().
> That is, if we still think this is the right fix -- I'm not entirely
> sure it is.
>
> Because what I gather from "kasan: initialize shadow to TAG_INVALID
> for SW_TAGS", is the requirement that "0xFF pointer tag is a match-all
> tag, it doesn't matter what tag the accessed memory has".
>
> While KFENCE memory is accessible through the slab API, and in this
> case ksize() calling kasan_check_byte() leading to a failure, the
> kasan_check_byte() call is part of the public KASAN API. Which means
> that if some subsystem decides to memblock_alloc() some memory, and
> wishes to use kasan_check_byte() on that memory but with an untagged
> pointer, will get the same problem as KFENCE: with generic and HW_TAGS
> mode everything is fine, but with SW_TAGS mode things break.

It makes sense to allow this function to operate on any kind of
memory, including memory that hasn't been previously marked by KASAN.

> To me this indicates the fix is not with KFENCE, but should be in
> mm/kasan/sw_tags.c:kasan_byte_accessible(), which should not load the
> shadow when the pointer is untagged.

The problem isn't in accessing shadow per se. Looking at
kasan_byte_accessible() (in both sw_tags.c and kasan.h), the return
statement there seems just wrong and redundant. The KASAN_TAG_KERNEL
check should come first:

return tag == KASAN_TAG_KERNEL || (shadow_byte != KASAN_TAG_INVALID &&
tag == shadow_byte);

This way, if the pointer tag is KASAN_TAG_KERNEL, the memory is
accessible no matter what the memory tag is.

But then the KASAN_TAG_INVALID check isn't needed, as this value is
never assigned to a pointer tag. Which brings us to:

return tag == KASAN_TAG_KERNEL || tag == shadow_byte;

Which is essentially the same check that kasan_check_range() performs.

Although, kasan_check_range() also checks that the shadow is <
KASAN_SHADOW_START. It makes makes sense to add this check into
kasan_byte_accessible() as well, before accessing shadow.

Thanks!
