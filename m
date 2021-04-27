Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F7C36CB86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhD0TOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0TOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:14:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB5C061756
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:14:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j10so2194655lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AB1V5oTeJ2WhmRUJ2GQVF15rRhUULVDZ8xbuGavAGZA=;
        b=I8zIhzF4xgs5c9h1B1B6xucfwUSXsJCLvkzdvgFByQMkD/6NohNVrRzONOvdpaA7Yt
         9flVvqBihPi+J/VFGoIeA+5FWdpIVgL4jXedmK4WaWIH6QSYY/Y099cYHSbZZCZnSX/e
         eAs+KD+7AF7yVcTjiL8nPKQRhuRs2KHwUSfcRs+EAXl8dZw79iBX5mr8sTM/RHfgLjGv
         c7S/fgXvQ7rOqxXwwX9eqRS+KymuHnsiiMELAfJoasgxe1gH9JkpBWGmbQ+ySfwQc0IF
         mFQcSyMPUoDIAnzO0u7bBbiuDv+PCAICjPvJ73Pftnqtcsf6KfhM4VKGU49R2y5NaR0B
         oNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AB1V5oTeJ2WhmRUJ2GQVF15rRhUULVDZ8xbuGavAGZA=;
        b=fn7XRDqTZm1JRqT5iQXE4JcbWrnISMk2zdPO9L70vhbGSD+210hC4rG20h3JOrAqJL
         5fIyRxV7AalDk42QtcBQxmfFatNt6pQ/aYAftbgEoKNJeZAQwvxVdnxSgJJZe+r+v/5y
         1VUm4pNI91KG3uNFpRRTTWWbDV9+1jodu3st5WkF43clu3yMCwPFG6or1FxxYEizSgJw
         ykCMB11/bEsA9m+gCatZtW7Y8iOloX+XrKtQQiCdVdukzZKxt37kK3rYRJKJCET4CKZc
         GbvwZOyASVLWzvWnHpWZomt4DJJ1xgrAsD5zL9q2nx3tl9ANm2cZSvoke6LSQBlHjRfS
         bxHA==
X-Gm-Message-State: AOAM532051XVQhKrOkraRQqn+TjSUouCZN3w12Q3DPri82DX1w5+qEJr
        zEB8mGzmcX1EDK33O2IPhZeEPshLdnDIsg2x7gqUHg==
X-Google-Smtp-Source: ABdhPJykOuvO+JF+ov+nYGOflfc88og8ntGA+7tM52OJQhzJrCmQGKukRAhEsqS2SSb9bsrTAuPydW4Pn7czvNa/p20=
X-Received: by 2002:ac2:46ed:: with SMTP id q13mr17241394lfo.543.1619550842376;
 Tue, 27 Apr 2021 12:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210427183755.2790654-1-trix@redhat.com>
In-Reply-To: <20210427183755.2790654-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Apr 2021 12:13:50 -0700
Message-ID: <CAKwvOdmj5YvWZZWwcq1G7JgRALwPbqwiROiedMeEbBst2sGeiQ@mail.gmail.com>
Subject: Re: [PATCH] samples/landlock: fix path_list memory leak
To:     Tom Rix <trix@redhat.com>
Cc:     mic@digikod.net, Nathan Chancellor <nathan@kernel.org>,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:38 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this error
>
> sandboxer.c:134:8: warning: Potential leak of memory
>   pointed to by 'path_list'
>         ret = 0;
>               ^
> path_list is allocated in parse_path() but never freed.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  samples/landlock/sandboxer.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 7a15910d2171..4629d011ed61 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -134,6 +134,8 @@ static int populate_ruleset(
>         ret = 0;
>
>  out_free_name:
> +       if (path_list)
> +               free(path_list);

I don't think the conditional is even necessary? By our first `goto
out_free_name;`, `parse_path` has already been called/memory for
`path_list` has already been allocated. `parse_path` doesn't check
whether `malloc` has failed.

>         free(env_path_name);
>         return ret;
>  }
> --
> 2.26.3
>


-- 
Thanks,
~Nick Desaulniers
