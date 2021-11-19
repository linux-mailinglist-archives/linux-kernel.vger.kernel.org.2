Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F064570C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbhKSOjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbhKSOjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:39:13 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996F7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:36:11 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id h23so10412000ila.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+RDH+9iEIrcuUvczXJii8lb9lf6yHmXP37Xa9ufdcY=;
        b=S09SVRr+zWdUHbTD/+aAN5QR8Hsi1IqqM0LJ0U3MMPyAECPNGmdb43U/ARrEA69M47
         tlnsKy4QlTD2c10h8SPqDfJx0umnVVqvJdwR5FHT3M13/fYcdac9DHLd62xQD28PH9Jy
         OxRzmERtSWd9wKNPb229m8W/4AlD4GjAlogfStR49oPQlUqt9Y4K/24DHcNDlEWv54Do
         KXZlzclychv7CB4Y/ZJwAJmbMYys91ybHXiyq3cQ8qbLopylJG0Cb6OxCZIQo3MDkm8T
         sf2QFNLsJsUMQtPKgsIMUtYgZwDbp0W+jkqpnyniHYGxqJNP9T/cGfEdcWoMQwHQk3+y
         HEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+RDH+9iEIrcuUvczXJii8lb9lf6yHmXP37Xa9ufdcY=;
        b=pYE9iNDDNRbxZgi9lKA3sf3DcUb5wcI+0iLKRRTIyqdV+RX/Ykyk86kLIp/IStdtv4
         L7JnZbw07eMTMCi0zOrqZ+UQmoO0J6Ze0hG9n2gEU4z80uaUxDtKPAj6niPBBJEmS4oY
         c/Fjpk8WYoL9piZ0Wij7PU1GP/lFBWTWBE06phZgnrKe9QQ9E36dFN7bP0XsKrNKtRno
         bTawjKcyctKtG5DoA+t+oepnGUJbGfiJ5qEW+tfrDPyJq3W6h1jAjMsVK6lM+RxoyaGx
         h2VZrfSW9tKjW0ZJlvU1zptwGx+l0nlosKlr4myxLUCyqPEoGVbfrh0a2S16VpuzuA7H
         mFBg==
X-Gm-Message-State: AOAM532JNFTJnbcaw2ZNdY3r/E8Fq1dNUfltmGcvAKs147PmQ6xsTbQu
        aM9tdT1KRQhQrDfXWLuvhbPSL359ixo1cepXnc/HoKCRlQg=
X-Google-Smtp-Source: ABdhPJyAiozoEc+fe7KgSFNpGGDIWeRw8ZbJ0IFuJnE6kS8Ffn5g9NM1DEQBPBJXLdKgdaNqBRi+pRK+tnpKQd3OotE=
X-Received: by 2002:a05:6e02:1d1b:: with SMTP id i27mr269533ila.248.1637332571116;
 Fri, 19 Nov 2021 06:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20211119142219.1519617-1-elver@google.com>
In-Reply-To: <20211119142219.1519617-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 19 Nov 2021 15:36:00 +0100
Message-ID: <CA+fCnZfL_XKVhK1HxjyWzgxC1o0U76M0DK5CkOQJAGcPL3zt0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: add ability to detect double-kmem_cache_destroy()
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 3:22 PM Marco Elver <elver@google.com> wrote:
>
> Because mm/slab_common.c is not instrumented with software KASAN modes,
> it is not possible to detect use-after-free of the kmem_cache passed
> into kmem_cache_destroy(). In particular, because of the s->refcount--
> and subsequent early return if non-zero, KASAN would never be able to
> see the double-free via kmem_cache_free(kmem_cache, s). To be able to
> detect a double-kmem_cache_destroy(), check accessibility of the
> kmem_cache, and in case of failure return early.
>
> While KASAN_HW_TAGS is able to detect such bugs, by checking
> accessibility and returning early we fail more gracefully and also
> avoid corrupting reused objects (where tags mismatch).
>
> A recent case of a double-kmem_cache_destroy() was detected by KFENCE:
> https://lkml.kernel.org/r/0000000000003f654905c168b09d@google.com
> , which was not detectable by software KASAN modes.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  mm/slab_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e5d080a93009..4bef4b6a2c76 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -491,7 +491,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  {
>         int err;
>
> -       if (unlikely(!s))
> +       if (unlikely(!s || !kasan_check_byte(s)))
>                 return;
>
>         cpus_read_lock();
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
