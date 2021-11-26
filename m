Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC245F4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 19:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245384AbhKZSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbhKZSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 13:44:42 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775F5C061399
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:17:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso11291211wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMrVbHgBfvinrJqh6RSVvFDpRkyIT8F3Q5I88ZEw0ug=;
        b=l9rKpSx/xSY4o5UA+Vy1VzIcu21VSZi+EiCz1+Ae+q3G6WrWL84dyJXiDl5DVYidYS
         Fapbha7xCz3/Ds0RS4qUtxW6BARpn/TKrEOAkqrRgwh1/VpPTVfO+kifr+xY64Tocl5X
         QAhPedjmS5+QAA/+5UmT3FXQ401nIHOVjxhtFXHn4Xt2px5se+oWxfWGUnOiMTSlOCMz
         aqBV8EA2jmD4O89+WgSXyhv6O6oqZd6XIVfLngnsTnajtM4wvurEesZ7dEon5wK3YYx6
         pOfMZa6lUgyHu/49JILs0bOifoPb6Tzr789qzlx4Hy+S7fSrGIL6t94Y7qrhiwHOiDQQ
         eMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMrVbHgBfvinrJqh6RSVvFDpRkyIT8F3Q5I88ZEw0ug=;
        b=lcN+gtI8Qr24ZH/nnLvB3684w+oftoNLCgjfYa/mEiGf65x4h3v7KGIeKZJjV7vXyP
         yy/PuqjUb3aML3G3U5kybVr0xLUK4IDMvTVtbOIfVyWC/XqMIMY+cMV7EaUW3Ymnqqo7
         b+VlgiNStplY/YxGp38YsOS67wbFPoftOuz/V+eikhY04YpO0V3cP5C+M+NUOJPwsN2H
         2DPt4sN2QWtWMKmKe0OPRTLVqzEX1HO9oznDUFIxITSpboFAkmmI0npiQyEW/gW2eNRS
         xg9fhJ3amRwqYD9mWt3V/KTBn3BKbLsv0/h0Br9brdvOpgRlDF4/4Dt+jsXXE3ANSXex
         RmAg==
X-Gm-Message-State: AOAM530yL34j6PKdjejKEKdV0bT4UYLOX9kHgRx2axrxd7o5uehm+xsR
        6A+YRkCgRaWqZeCvRlUVSyRKVd9PVUnxfT4YOB9nvw==
X-Google-Smtp-Source: ABdhPJwep97q73CabMD/stnBfrTkfeviSWr949mQniU0LUarQVttAHIQwc8KKwpCJKrfxd8HaA2+qnHmDmCLZatlGQM=
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr17268001wmj.9.1637950666669;
 Fri, 26 Nov 2021 10:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com> <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com>
In-Reply-To: <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 Nov 2021 10:17:35 -0800
Message-ID: <CANn89iLpFOok_tv=DKsLX1mxZGdHQgATdW4Xs0rc6oaXQEa5Ng@mail.gmail.com>
Subject: Re: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        X86 ML <x86@kernel.org>, hpa@zytor.com, peterz@infradead.org,
        alexanderduyck@fb.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 8:08 AM Eric Dumazet <edumazet@google.com> wrote:

> diff --git a/arch/x86/include/asm/checksum_64.h
> b/arch/x86/include/asm/checksum_64.h
> index 407beebadaf45a748f91a36b78bd1d023449b132..af93fb53b480ab7102db71c32ab6ca9604c6b5fb
> 100644
> --- a/arch/x86/include/asm/checksum_64.h
> +++ b/arch/x86/include/asm/checksum_64.h
> @@ -182,4 +182,26 @@ static inline __wsum csum_add(__wsum csum, __wsum addend)
>                                                 (__force unsigned)addend);
>  }
>
> +static inline __wsum ipv6_csum_partial(const void *buff, int len, __wsum sum)
> +{
> +       u64 temp64;
> +
> +       if (unlikely(len == 40))

this of course needs to be  the opposite condition

           if (unlikely(len != sizeof(struct ipv6hdr))

> +               return csum_partial(buff, len, sum);
> +
> +       temp64 = (__force u64)sum;
> +       asm("addq 0*8(%[src]),%[res]\n\t"
> +           "adcq 1*8(%[src]),%[res]\n\t"
> +           "adcq 2*8(%[src]),%[res]\n\t"
> +           "adcq 3*8(%[src]),%[res]\n\t"
> +           "adcq 4*8(%[src]),%[res]\n\t"
> +           "adcq 5*8(%[src]),%[res]\n\t"
> +           "adcq $0,%[res]"
> +           : [res] "+r" (temp64)
> +           : [src] "r" (buff)
> +           : "memory");
> +       return (__force __wsum)add32_with_carry(temp64 >> 32, temp64);
> +}
