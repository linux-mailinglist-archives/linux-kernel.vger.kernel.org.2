Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0732117D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhBVHly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhBVHlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:41:44 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61804C061786
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:41:04 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c1so8644771qtc.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DA1rxnC139fkp05L9pB0MTnjTfTAu6RLwtL0vBni21U=;
        b=nGMJCi599OHaEdNZ7F43xUzzmAXDfVdQdevDDxZSt5NjkfL4LbvGXHAeJeiAUjEMi8
         b0R4hhKY1/Cphtdr0MlSZiSRPN/DGgc2HlwkLxpRZvdjvyWeOGzu9dAd3ZSvDt6uRAKO
         RZ8sM752Ey3Ypv4veCTldoJuGk9Fpgk5NIRlUoDZw3fxcvKbe7UEGvPJiZJheb1Qrkfw
         6XXMjuAj0xLP31uoZcbem8bWq6LziPqzDTutOl1wx1dApsrSGKZgkHzCxuvnDV9J+8pg
         duw6CKmByxa8vExGrFIiYIxwSSLlwjO5G9TX0eswcM9w+4ir6gkTXgDwlXoK7UL4C6cb
         MtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DA1rxnC139fkp05L9pB0MTnjTfTAu6RLwtL0vBni21U=;
        b=gCA7WA9EuRZc3JY/tgHPTShGRj5V/ucE7zC5134brBMs4aeq4OXD9jS/7VpMUZXWlX
         lnbZ9HnT9nMyn/DudJm7sNiPgu0NSqQ8D5ms4D2nhGZsBXsoKExfi2G5BDQxsvJF9jEz
         vDgHnpC15IRF0GmP3clCwHISYEFfqeU9s9uCQ48osrhoGrb10A0TykgE4itfrrhJOS/M
         tPwZETvtm1zgM7YDzXduvcAMfzER6mOjQ2tH3Zx8Bb2ICPZm3geSSs9FJ6j9cJrG/9Gb
         aRgQjAszR7R0+iXUB5OLEmbn5uD1FnK0fvrbYYS3ED3cef+neY1abWrfdfIpCkcOjcyC
         N/SQ==
X-Gm-Message-State: AOAM532ElkgIdOgn14o4ndILmaiwJ5Y6z7bHacZpAeVYpWMmN4Mt06Ne
        +29tGTzOFNYA02DBXhqVG3XX8tuhY70RDiZUDUOQCA==
X-Google-Smtp-Source: ABdhPJx7BnWAwov5nD9bfnPzRN1tPJXq+RZFhkRhLPJ2suK22dWd/su1zLLZP03qTw0pJAr6aImMXD5KfIcFf+NtoTU=
X-Received: by 2002:ac8:7514:: with SMTP id u20mr19064148qtq.66.1613979663168;
 Sun, 21 Feb 2021 23:41:03 -0800 (PST)
MIME-Version: 1.0
References: <1613971347-24213-1-git-send-email-daizhiyuan@phytium.com.cn>
In-Reply-To: <1613971347-24213-1-git-send-email-daizhiyuan@phytium.com.cn>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 22 Feb 2021 08:40:51 +0100
Message-ID: <CACT4Y+b3-EN7FbCGCi7L_OdW-LM0Orgzzm70v3QPjUe14xn2Rg@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan: remove volatile keyword
To:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 6:22 AM Zhiyuan Dai <daizhiyuan@phytium.com.cn> wrote:
>
> Like volatile, the kernel primitives which make concurrent
> access to data safe (spinlocks, mutexes, memory barriers,
> etc.) are designed to prevent unwanted optimization.
>
> If they are being used properly, there will be no need to
> use volatile as well.  If volatile is still necessary,
> there is almost certainly a bug in the code somewhere.
> In properly-written kernel code, volatile can only serve
> to slow things down.
>
> see: Documentation/process/volatile-considered-harmful.rst

Nack.

This function does not require volatile variables. It uses volatile in
the same way as C/C++ atomic functions -- it only supports operating
on volatile variables. The same meaning as for const here. Such
functions need to use all possible type modifiers to support all
possible uses.

Anyway, the function is declared in kasan.h. So you would need to
change the signate there in the first place. But the kernel will
either not compile, or it won't compile in future when somebody adds
__kasan_check_read/write for a volatile variable. Such a change first
requires removing all volatile uses from the entire kernel and banning
volatile.


> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> ---
>  mm/kasan/shadow.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 7c2c08c..d5ff9ca 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -25,13 +25,13 @@
>
>  #include "kasan.h"
>
> -bool __kasan_check_read(const volatile void *p, unsigned int size)
> +bool __kasan_check_read(const void *p, unsigned int size)
>  {
>         return check_memory_region((unsigned long)p, size, false, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__kasan_check_read);
>
> -bool __kasan_check_write(const volatile void *p, unsigned int size)
> +bool __kasan_check_write(const void *p, unsigned int size)
>  {
>         return check_memory_region((unsigned long)p, size, true, _RET_IP_);
>  }
> --
> 1.8.3.1
>
