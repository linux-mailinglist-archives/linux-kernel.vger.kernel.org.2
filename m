Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199B1380E36
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 18:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhENQbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhENQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 12:31:07 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E074CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:29:55 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f18so7393044qko.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nNOoTRZpAzYHsHWkewGeCeox6yCRKtMGg5MUAH69bMo=;
        b=DhAFZgIFuuI0bJtym0uubsrGx3AKA8gBahBew5l6Msd81Ij0ID5s8x2qsuhynabF5H
         EsYiEiOjHnqsq0ttUUVYNfuW9SEuTFk9Z2P9DWybSVzG/Jpp2wihbraUO4nNHBV6+P4t
         DBrdQf5M2dTKxaHI8bqd9zQrZ+wE23N7rVUbynXEMaNdBphDtT5tsHlaf0FAObaXqoKY
         d9tStTFO5A/Sh6aJqa+2UiJA4b+kWI8TynKSHuqQ8RsStHxo7mjINqDnM8XZ+M+ukrmn
         ehYBRmIgw3rs4twTjbhuAG9zlOEDnVM+X7SZVsQwEeNwJCeX5RIAsP3sw4lXZMpOB3wi
         XQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nNOoTRZpAzYHsHWkewGeCeox6yCRKtMGg5MUAH69bMo=;
        b=tQ1n1AVrXk/A4c332gUKqk8ovKU1f1iwKCKEMXsw2yiDba29FKt0c89Q+XjFr60fAt
         AWx+/0rEQqgn+rzehNVPoDoFZKTcVCBJ9JdfNYc0BWKb3WaAgnq2bKu/PqwN2doffJB2
         ZMJSL0H85gewJi0FFrf3dIA5d6AVzDQ3boTd4AC/9CBvbgOkvrv5G6MiCce1IjOwIl3g
         eZI8i3u5FrlhZVrg1AEuTNF5pPrj7NXKjgabCeCPXtbPAbj26f3w7cOzlCYsIIK7YePi
         uvy+2+PZPe/gcqpvfix/iiGSR+XSdmLfgr5wNrbzC/rql1OzwiMMO9PYSE7fA7NYsyos
         NVmg==
X-Gm-Message-State: AOAM532knmICBc6hou1H5/vR1+c3offB5u5/WTk6TjfxoDXtmCf8mt2X
        9wCV7t7ELpjJvkyML0BVjrfwbZdxfrc38K2Gq/obmg==
X-Google-Smtp-Source: ABdhPJxZzHbXS0JCPo2ZF5DT5rvb02iW2YoS7SALGAseX7opJs5UzzOLG3dx3VsxqO3d3dji43tsRnJZsimrT4SuQg0=
X-Received: by 2002:a37:ef17:: with SMTP id j23mr40532775qkk.392.1621009794859;
 Fri, 14 May 2021 09:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210514072228.534418-1-glider@google.com>
In-Reply-To: <20210514072228.534418-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 14 May 2021 18:29:18 +0200
Message-ID: <CAG_fn=UUbex_=Tao8g2Pcz2A7ZrhnOvEnV=8HCR5myWP5eL+AQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: slab: always reset the tag in get_freepointer_safe()
To:     akpm@linux-foundation.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Elliot Berman <eberman@codeaurora.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 9:22 AM Alexander Potapenko <glider@google.com> wro=
te:
>
> With CONFIG_DEBUG_PAGEALLOC enabled, the kernel should also untag the
> object pointer, as done in get_freepointer().
>
> Failing to do so reportedly leads to SLUB freelist corruptions that
> manifest as boot-time crashes.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Elliot Berman <eberman@codeaurora.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  mm/slub.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index feda53ae62ba..9a4f59e5b0c2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -301,6 +301,7 @@ static inline void *get_freepointer_safe(struct kmem_=
cache *s, void *object)
>         if (!debug_pagealloc_enabled_static())
>                 return get_freepointer(s, object);
>
> +       object =3D kasan_reset_tag(object);
>         freepointer_addr =3D (unsigned long)object + s->offset;
>         copy_from_kernel_nofault(&p, (void **)freepointer_addr, sizeof(p)=
);
>         return freelist_ptr(s, p, freepointer_addr);
> --
> 2.31.1.751.gd2f1c929bd-goog
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
