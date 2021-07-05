Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4753BBE5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhGEOoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhGEOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:44:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA6C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 07:41:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id nd37so29335508ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAbvWLlq9ACgk831d9oOZ3Sk5AFBCQPn8le+JrfsWvM=;
        b=oVi79ZcuXpZ9CHQUw/iwBcEb7qnIyQJZxddWmaug5BjbgLJxQmbZtwFADrZwSfRgi0
         iYp7+OZxfbgyxjPrxdWRK2Jp6WWTtuZt4y/5l7bbDR7YFXreTDQcI/20yVezPhFV6E8J
         HWZTS8Czi7PocN4l6NdzISXNDhAhsZL8AZaftVh9uPh630z0UvaqDZ51z6j12YP2TPU+
         WjzEYhdjQiUCrKHdIZPta27KizeaY3gaIJTOuNg7VoWhkWAu9jWrGxJgKdiUoLi9F6VM
         fYZKgiDGjYpkVg0p23Mpwyom3AEsxo2Jp9sGvVBR6gSeVO6E2b9sSZSCqo8Xv6+QCIM/
         JHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAbvWLlq9ACgk831d9oOZ3Sk5AFBCQPn8le+JrfsWvM=;
        b=I1Sg6ECX0lqf6xJE8wx2B2sYOLOhnWTvGQiWRotE6c6uCpkdU+5EZrZ3cBO/Zgegob
         65DPxh7VUYyCfiJIOkLDwLKMfSj7UetT8VDOVfNcnJ6hW39n79PGh4lPNtDMcZ0jVkbi
         kPckF77bmiyHcyLw/cb5HomDE3DI4DiM1Ls1WI6VtocD6NP+q8leHGqPu0yOx06ZuPxe
         PrTWXgtEuIYmunBnMz3EzL18IF9c1wk/pe7YyVxnqNGin6YeYqxdRD1iQKO7RB++YdyT
         sHJSGhwx8K0gMEEO/LM0TDH6caGchYViun3sfE9PHGRaUMJl57a1OlIrV5qfQdvVzETE
         UzJw==
X-Gm-Message-State: AOAM5323zaKh8lHi366SEegUvw6wNA42NULhiTUPz9AXoGEUmqDa8cbE
        PHnM7iSKutlhzH3BnlJ0l8iS668dkqmhWezWupE=
X-Google-Smtp-Source: ABdhPJxBWF6k4qxL/WTwuWOk/hgPz7DDwDGY9wC2hQ6nob3k3f/a1TDRAxqgf6EJG4KigP3jzY+N6o6bOFZzFtf+ZMI=
X-Received: by 2002:a17:906:f14e:: with SMTP id gw14mr13913822ejb.439.1625496086980;
 Mon, 05 Jul 2021 07:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210705072716.2125074-1-elver@google.com>
In-Reply-To: <20210705072716.2125074-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 5 Jul 2021 16:41:16 +0200
Message-ID: <CA+fCnZc4XrsCbh1ZXwFShmaZ41_4Sj9LywZAq1fYju2V_t0HQw@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix build by including kernel.h
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 9:27 AM Marco Elver <elver@google.com> wrote:
>
> The <linux/kasan.h> header relies on _RET_IP_ being defined, and had
> been receiving that definition via inclusion of bug.h which includes
> kernel.h. However, since f39650de687e that is no longer the case and get
> the following build error when building CONFIG_KASAN_HW_TAGS on arm64:
>
>   In file included from arch/arm64/mm/kasan_init.c:10:
>   ./include/linux/kasan.h: In function 'kasan_slab_free':
>   ./include/linux/kasan.h:230:39: error: '_RET_IP_' undeclared (first use in this function)
>     230 |   return __kasan_slab_free(s, object, _RET_IP_, init);
>
> Fix it by including kernel.h from kasan.h.
>
> Fixes: f39650de687e ("kernel.h: split out panic and oops helpers")
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/kasan.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 5310e217bd74..dd874a1ee862 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_KASAN_H
>
>  #include <linux/bug.h>
> +#include <linux/kernel.h>
>  #include <linux/static_key.h>
>  #include <linux/types.h>
>
> --
> 2.32.0.93.g670b81a890-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
