Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C0E40AD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhINMOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhINMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:14:38 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:13:20 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b64so14504068qkg.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pJ0yW4/1Jn6ZEeGlxOvvBqEA1VuZRtIwgqtBes2tjIY=;
        b=ZT9oblhQOkOXScfXKv8+xOqRaGE0WgSKWm93+I3oT8FQcNL6gNEpMSrGUSsbksVmfb
         y3GdJxN/nkFI6szxiiq0GYBxjof1k3RzFbKXcRnSuWr4rVjPew9FTFreNBDbfz40ABvo
         YanTFu3rpFNJteFkq1DEjpegEKUARWnyRjEIzDqMN7dP42I5ZDNIpsB9bI+TihY+0XUL
         bv4DOR9LPuDOLM35CzaDQdyEX5X0wD3aSkGeKI7PsqOJ8PCeYKPsRhATLiU1PE4trcAM
         Ds5AcFT2m80OecQVCK6+2q3MWUedgmTfqjtPs1EYRflv/K24dgoNYftDbBq4MCldfxXH
         qnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pJ0yW4/1Jn6ZEeGlxOvvBqEA1VuZRtIwgqtBes2tjIY=;
        b=g4Rc0GaHzCp0yWKlb8vOA2Ji6D3Vh1RTkFBdIsfzdOTmVYHAATQJn4ypDmMwe69Z0S
         aoup603zq6TgQk7SSJ3o39qeiYmpyALalScpKZpK/m9q+qcG7zBoy9INDBXFekk07k8M
         4TzqmYRqIOpADeJH5SLJh+5Ti5DN8KVR52mG8NecOcIgqIvji8zUajsV0HlOlUGNS2xy
         SSYqN+hUK5P+G/22zYKlq1Uf3LIFE5mIMOdtCIVYGgBvFbZT2eAz2F3G9VQVBXd7c1oJ
         fnvN07VazUXfdRtg5fmPhWOxnO3gf+7MF1ylXyV0+Yfb4ft8b+DUh9mQEOhyNoUBTJsv
         gmXg==
X-Gm-Message-State: AOAM531enZUcxHc+qDWdbsDTwoWzNh1vKxcKTQQstglThYIG+GGicyVI
        KbLv6aJjC8Ktx8ewIfYcajJFDCcT09JYPZ2f+8mYzg==
X-Google-Smtp-Source: ABdhPJwLVdTNZsVxxo92ilXBQEiuYtzkaFYtDjigb7vv+T3hwYVL5wZO3l5lC4q8vtXtFjs2gqHYUYVCTZ6pi+MGjVQ=
X-Received: by 2002:a05:620a:191d:: with SMTP id bj29mr4500655qkb.362.1631621599977;
 Tue, 14 Sep 2021 05:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210907141307.1437816-1-elver@google.com> <20210907141307.1437816-3-elver@google.com>
In-Reply-To: <20210907141307.1437816-3-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 14 Sep 2021 14:12:43 +0200
Message-ID: <CAG_fn=XGa=UK6cduTNAd2AREA6jxUaGFJqTWT1cNTXCK4-6k0Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] lib/stackdepot: remove unused function argument
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 4:14 PM Marco Elver <elver@google.com> wrote:
>
> alloc_flags in depot_alloc_stack() is no longer used; remove it.
>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  lib/stackdepot.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 0a2e417f83cb..c80a9f734253 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -102,8 +102,8 @@ static bool init_stack_slab(void **prealloc)
>  }
>
>  /* Allocation of a new stack in raw storage */
> -static struct stack_record *depot_alloc_stack(unsigned long *entries, in=
t size,
> -               u32 hash, void **prealloc, gfp_t alloc_flags)
> +static struct stack_record *
> +depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **pre=
alloc)
>  {
>         struct stack_record *stack;
>         size_t required_size =3D struct_size(stack, entries, size);
> @@ -309,9 +309,8 @@ depot_stack_handle_t stack_depot_save(unsigned long *=
entries,
>
>         found =3D find_stack(*bucket, entries, nr_entries, hash);
>         if (!found) {
> -               struct stack_record *new =3D
> -                       depot_alloc_stack(entries, nr_entries,
> -                                         hash, &prealloc, alloc_flags);
> +               struct stack_record *new =3D depot_alloc_stack(entries, n=
r_entries, hash, &prealloc);
> +
>                 if (new) {
>                         new->next =3D *bucket;
>                         /*
> --
> 2.33.0.153.gba50c8fa24-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
