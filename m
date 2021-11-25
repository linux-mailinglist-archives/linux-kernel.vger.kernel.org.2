Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86E445D3E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 05:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbhKYEZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 23:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbhKYEXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 23:23:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEA6C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 20:20:40 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 137so4394995wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 20:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWe1jPEc9DTZ15Sy6PyJ0tM0GbmFcQdQEbC/GjwL3Tg=;
        b=XsduBb9TjBryJyb+/Vcob94RpxpimLIr7BU81beUOcLqr5wjVXjUcdA8I3MdDCw5+6
         aaO5/Fmpo/466KOg/7Lgmkudcg9+B4VhD0tVfulCzwzYYD+IfSNxK36zWNEPhBLhwl+g
         xcGGq+oskOeaLiCwoqyqZ+VCs/9620+D9RhHUIQGpBZlu6DQsZK0wYfFA8KhnAI1w9yB
         b8WeNyOzHywTNSWpnz6pfe5CdZAv1LPgM9MQphOWknHScX8/zqnbDDWWJEl2dBdQpuC0
         gv8AxuE5PyXHHDUKjln2IE/YKZ6gzTdmddUVSUdqDP8aLfo3Y4bAtGgceLUs5eUXouOQ
         4kHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWe1jPEc9DTZ15Sy6PyJ0tM0GbmFcQdQEbC/GjwL3Tg=;
        b=F47hAq6C4kF7ghuc8cbCzoKg88XwBUyi5Rt8MJUDAdgFjJDJIAFG2OpkjFUX3tjk/q
         vdroWddAlRxOSokySeftoS+emcbsqlq/1fnJl1ScZVnuFreWnCFGTTZjyxHYYZ2kVSgJ
         XuCmnBFGqZmcol2eXGyCHm6Ug++cBSZssx2IM1yzg+WLk9aoAYry2VNLj6TUggcjIs4x
         0+UrZ62rPSRO7+PEg6PmAwQFlpFkmAZs0LVu2O7Cj4IrRIUpdGPOnp4M4EyPpW6yAqj+
         UXVCJ+m+C5rwq9zUjf/jyzoabPe6VLvzw2dDzalKI9l8wBdBHvLzPuUtMSgCqAjir3Bd
         zmww==
X-Gm-Message-State: AOAM5309I11wduJTDWNzt9V3tRuOnLB0tmZbMAu8KtnDggp24ZMwKo9D
        BGfRwKhj6RKd2ucryBtqIxKiNtu/BDYeNt9fvczjQA==
X-Google-Smtp-Source: ABdhPJwtGz9RoRmitT+jmLsEMg3T74hs3eKwMcyela+Bv1zs5FkFNcTHoTNnugZk7Kc6ojn5G2OGl5cYCnj+KxdLemo=
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr3482337wmf.73.1637814038627;
 Wed, 24 Nov 2021 20:20:38 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com> <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com>
In-Reply-To: <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 24 Nov 2021 20:20:27 -0800
Message-ID: <CANn89iJqZm9Mcfu+4-aZ_pZok1j4RsHK8YoFBVqjVYpGbt_P8Q@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, alexanderduyck@fb.com,
        kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>,
        linux-um@lists.infradead.org, lkp@intel.com, peterz@infradead.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 8:08 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 24, 2021 at 8:00 PM Eric Dumazet <edumazet@google.com> wrote:
>
> >
> > It is an issue in general, not in standard cases because network
> > headers are aligned.
> >
> > I think it came when I folded csum_partial() and do_csum(), I forgot
> > to ror() the seed.
> >
> > I suspect the following would help:
> >
> > diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> > index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..ee7b0e7a6055bcbef42d22f7e1d8f52ddbd6be6d
> > 100644
> > --- a/arch/x86/lib/csum-partial_64.c
> > +++ b/arch/x86/lib/csum-partial_64.c
> > @@ -41,6 +41,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
> >         if (unlikely(odd)) {
> >                 if (unlikely(len == 0))
> >                         return sum;
> > +               temp64 = ror32((__force u64)sum, 8);
> >                 temp64 += (*(unsigned char *)buff << 8);
> >                 len--;
> >                 buff++;
> >
> >
>
> It is a bit late here, I will test the following later this week.
>
> We probably can remove one conditional jump at the end of the function
>
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..15986ad42ed5ccb8241ff467a34188cf901ec98e
> 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -41,9 +41,11 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>         if (unlikely(odd)) {
>                 if (unlikely(len == 0))
>                         return sum;
> +               temp64 = ror32((__force u64)sum, 8);
>                 temp64 += (*(unsigned char *)buff << 8);
>                 len--;
>                 buff++;
> +               odd = 8;
>         }
>
>         while (unlikely(len >= 64)) {
> @@ -129,10 +131,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  #endif
>         }
>         result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
> -       if (unlikely(odd)) {
> -               result = from32to16(result);
> -               result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> -       }
> +       ror32(result, odd);

this would be
          result = ror32(result, odd);

definitely time to stop working today for me.

>         return (__force __wsum)result;
>  }
>  EXPORT_SYMBOL(csum_partial);
