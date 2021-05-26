Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F687390E53
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhEZCeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhEZCeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:34:14 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E42C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:32:43 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so30681681oto.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dUaqe5ooj/3bNo6XBYYqy6v0GEoSXYJ7MyebHBms/88=;
        b=XC/DW2AYPUyj9I8HZSfeH058rejqHpdwan/4THeH/RpGxK1Bx69kpaS3bb+er4ITmE
         60eQ+P4e3MGiFxa9PmyC1rhO+6h6rqWqWC5cnRCsqErG8P9Ww7fDiLXqzjR9Bpchw8dn
         Ops4OLyj64FLFp0yJgGW75Cc2zR2JbJiDJlSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dUaqe5ooj/3bNo6XBYYqy6v0GEoSXYJ7MyebHBms/88=;
        b=mBrmainB1nLFQ/pZ295BXvsyDgJC9eQfO8Qym58Nou+Ks7olgd6cuEp+6MFkUzIAJ1
         wWDM8UznKz/58hggUeiQbMoIytGVp1b9NjGKWCpUb9AQ/a/xPOQn0nn8jkKpjE3nMC0G
         a/XUQKJic3PAmHBPFWU1PBGO0GyJZJ8bKHZSqA1YmSYCQ1BcHpA9E8DNjR23UFUhZXC/
         qm5TvW8TjdTt4x/e3DluJCRoS4GYT3w5YV546rx/OcyC3RINj31N+LFsqdSLH2oMRE5B
         MczLrT4qdT+NgXF06QmJMtXx9Emm8XX+iEZasQFW9s3+iYr1fX8HwNcrAYTih5iHIo3A
         M2Lg==
X-Gm-Message-State: AOAM530kb8cy1cpzsbiVyTuzQ6x8oxj7gzPDza+Ssus1HrSu1WjGPWho
        OlWu7AEcDxm2glCPYxNYTGyxoEMpseQJc+YcYi7HSg==
X-Google-Smtp-Source: ABdhPJxMhZvFoxJ/pP3prXL1ahoqgnftmtFnXXh27NlilMrRx0x8Z6XPZSxZHABrliu0Bdku85i0jhgxpTFqlmWmkmo=
X-Received: by 2002:a05:6830:1556:: with SMTP id l22mr564426otp.34.1621996363093;
 Tue, 25 May 2021 19:32:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 May 2021 22:32:42 -0400
MIME-Version: 1.0
In-Reply-To: <858b8d14673a200c3c2162fb7a9bf891ecd2a2d9.camel@perches.com>
References: <20210520013539.3733631-1-swboyd@chromium.org> <20210520013539.3733631-4-swboyd@chromium.org>
 <f4da67db-a53b-a710-947d-474be7aad07@google.com> <858b8d14673a200c3c2162fb7a9bf891ecd2a2d9.camel@perches.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 25 May 2021 22:32:42 -0400
Message-ID: <CAE-0n50NAaWNdFbsUGw==u+=X+4ZxDA=Qf_YesxXLVsyU8e8YA@mail.gmail.com>
Subject: Re: [PATCH 3/3] slub: Actually use 'message' in restore_bytes()
To:     David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joe Perches (2021-05-25 00:37:45)
> On Sun, 2021-05-23 at 22:12 -0700, David Rientjes wrote:
> > On Wed, 19 May 2021, Stephen Boyd wrote:
> >
> > > The message argument isn't used here. Let's pass the string to the
> > > printk message so that the developer can figure out what's happening,
> > > instead of guessing that a redzone is being restored, etc.
> > >
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >
> > Acked-by: David Rientjes <rientjes@google.com>
>
> Ideally, the slab_fix function would be marked with __printf and the
> format here would not use \n as that's emitted by the slab_fix.

Thanks. I can make this into a proper patch and author it from you. Can
you provide a signed-off-by? The restore_bytes() hunk is slightly
different but I can fix that up.

> ---
>  mm/slub.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index ee51857d8e9bc..46f9b043089b6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -702,6 +702,7 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
>         va_end(args);
>  }
>
> +__printf(2, 3)
>  static void slab_fix(struct kmem_cache *s, char *fmt, ...)
>  {
>         struct va_format vaf;
> @@ -816,7 +817,8 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
>  static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
>                                                 void *from, void *to)
>  {
> -       slab_fix(s, "Restoring %s 0x%px-0x%px=0x%x\n", message, from, to - 1, data);
> +       slab_fix(s, "Restoring %s 0x%px-0x%px=0x%x",
> +                message, from, to - 1, data);
>         memset(from, data, to - from);
>  }
>
> @@ -1069,13 +1071,13 @@ static int on_freelist(struct kmem_cache *s, struct page *page, void *search)
>                 slab_err(s, page, "Wrong number of objects. Found %d but should be %d",
>                          page->objects, max_objects);
>                 page->objects = max_objects;
> -               slab_fix(s, "Number of objects adjusted.");
> +               slab_fix(s, "Number of objects adjusted");
>         }
>         if (page->inuse != page->objects - nr) {
>                 slab_err(s, page, "Wrong object count. Counter is %d but counted were %d",
>                          page->inuse, page->objects - nr);
>                 page->inuse = page->objects - nr;
> -               slab_fix(s, "Object count adjusted.");
> +               slab_fix(s, "Object count adjusted");
>         }
>         return search == NULL;
>  }
>
>
