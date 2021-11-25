Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A391A45D4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352774AbhKYGxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348915AbhKYGvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:51:08 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D871C06175C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:47:57 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id o14so3809387plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tWEvLfMJoAoTTc40DQ9gWFDkqXWTCMgKmFU2lKzFdQ=;
        b=qGIAY0T+m4Jcqw/fzV95ieK5iGCx4kUw0u+G6bhk5A2lRPoc7szRFSdnSd64vmU2IU
         Zpv0TqkIskQpvakMPdZuokiZHe4U2HSz1+TKUCTEh4Zpe0gRR/6eYSLOZk9kbeNQhOst
         7xdNVRQ++X+ktrgCSz27BvW23xdFYkvLRQVKb1k2DbQv6SL8X1Hp8KhoXIKb1+2BvarV
         DrmF/zi16onvVSbizFjukPHdUj7rhF/zTtwHQR9texPhHIAUuys/rZMGvZlfK3C7mH+1
         zlDetO75ItX3hDU76VXAzCItLyyE4MlOMGO3XYBZn4UPoa+xdkoQ5WRNKVnsQGeMNiJ3
         o9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tWEvLfMJoAoTTc40DQ9gWFDkqXWTCMgKmFU2lKzFdQ=;
        b=uQrA7TAmRkTI5F/uxXZTi4P2DmRHmjYwev44K6noy/v4ISBMgPXw4m37O+1nnOcoso
         jvhfFmV6cs2BRjlhoAqhUAAQWoJ55VzzpfV0rdXni5QT5MGTKSj3a6Vn0xeEoX1M8w1v
         dely0Nqc3rplt4MIbmpE4UYXviiFSUmzSP9hBThSEVfoTxXdskpTg0xfLKRXiA8ZHZT/
         p5szDOWrwnna0fLFJe3o+glJNzx8gdJquqENQYblgLFvU4aoXAkN+BgnRWMC/PeddCLB
         NUXzjArUEuQVRbIgFAm3VTtOIfpVJHjEM1+jPFqZWeoPgoGJU1BpUXkEBMTOZHYsiljU
         QCyg==
X-Gm-Message-State: AOAM532HbbrXUv1LW9R7W9OSbSwpRdtzhhQJS+Ma19jyO06QXiZ7KPFp
        mt9uILvMgxyiiWTkuFsd9g+DExP1qEAeSwRmNY0=
X-Google-Smtp-Source: ABdhPJwkBYadKPp+4j5TvTQfCnj1EqEW9F+jbgns5uLiqKhAlTb7KXflw46IKqs8QWxs79LlBbRHadJfFB4lbfZxpcE=
X-Received: by 2002:a17:902:6905:b0:142:9e19:702e with SMTP id
 j5-20020a170902690500b001429e19702emr27575070plk.34.1637822877085; Wed, 24
 Nov 2021 22:47:57 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com>
 <CANn89iJqZm9Mcfu+4-aZ_pZok1j4RsHK8YoFBVqjVYpGbt_P8Q@mail.gmail.com>
 <CAFUsyfL3RF-UC-HBUcbRn0e5S3URo9gpz5V85buF8C7xVb6K7w@mail.gmail.com>
 <CAFUsyfLz89DrkvTwDTDqNCHVbBzk1QgEKu0+PuwBoF=Y6me7cQ@mail.gmail.com> <CANn89iLYHkyaLawrZJYuRETx63c0QWQ0kLGysPbGpWj2+C5Jfw@mail.gmail.com>
In-Reply-To: <CANn89iLYHkyaLawrZJYuRETx63c0QWQ0kLGysPbGpWj2+C5Jfw@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Thu, 25 Nov 2021 00:47:46 -0600
Message-ID: <CAFUsyfKx=444zNM40rVznS+=0YKxz2+O+qNA2NbiAv2Qs+Xhrg@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     Eric Dumazet <edumazet@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, alexanderduyck@fb.com,
        kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>,
        linux-um@lists.infradead.org, lkp@intel.com, peterz@infradead.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 12:32 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 24, 2021 at 9:09 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> >
> >
> > Although I see slightly worse performance with aligned `buff`  in
> > the branch-free approach. Imagine if non-aligned `buff` is that
> > uncommon might be better to speculate past the work of `ror`.
>
> Yes, no clear win here removing the conditional (same cost really),
> although using a ror32() is removing the from32to16() helper and get
> rid of one folding.
>
> I will formally submit this change, thanks !

Great :)

Can you put me on the cc list? I have a patch for the function that I'll post
once yours gets through.

>
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..cf4bd3ef66e56c681b3435d43011ece78438376d
> 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -11,16 +11,6 @@
>  #include <asm/checksum.h>
>  #include <asm/word-at-a-time.h>
>
> -static inline unsigned short from32to16(unsigned a)
> -{
> -       unsigned short b = a >> 16;
> -       asm("addw %w2,%w0\n\t"
> -           "adcw $0,%w0\n"
> -           : "=r" (b)
> -           : "0" (b), "r" (a));
> -       return b;
> -}
> -
>  /*
>   * Do a checksum on an arbitrary memory area.
>   * Returns a 32bit checksum.
> @@ -41,6 +31,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>         if (unlikely(odd)) {
>                 if (unlikely(len == 0))
>                         return sum;
> +               temp64 = ror32((__force u32)sum, 8);
>                 temp64 += (*(unsigned char *)buff << 8);
>                 len--;
>                 buff++;
> @@ -129,10 +120,8 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  #endif
>         }
>         result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
> -       if (unlikely(odd)) {
> -               result = from32to16(result);
> -               result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> -       }
> +       if (unlikely(odd))
> +               result = ror32(result, 8);
>         return (__force __wsum)result;
>  }
>  EXPORT_SYMBOL(csum_partial);
