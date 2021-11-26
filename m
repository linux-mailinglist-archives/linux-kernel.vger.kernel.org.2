Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7365645F5B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbhKZUUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhKZUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:18:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086F9C061757
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 12:07:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o29so9020920wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 12:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+s3OfiF0bMiZe55Q/N4+QD0w4tiTh4PXCDDuyCPFgdQ=;
        b=N12hGyM4VRy7C1UVbyAuEI+yvb5Y+WnhNgJc0YEbUeSTLWaz0YHUANuH5yE6alKqV/
         tVmGpgNPTZK71hClNJz+oY8ybI1clsHMchbMVom7Sqv8vPpla0+2VJOPvFiDXCGOMceT
         FvrSox6xylnraSeT5v7IC3uXd1UPmECYdHdYG9WhvulnWhacdouLgxittNT2vTwKUT0w
         BNbZc7gzuPfv4w2XEmp9ug3Ek914vfNGzYM74oN82w0UDqeUZseuLGS+0oaOVnt1EjWs
         lt0r7V638OUO/4a8nA/D31mCnT7GX0pmNRA1Kwt6hPRvgCWFv+fFm8ZMn+HTiTxfnxhN
         pIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+s3OfiF0bMiZe55Q/N4+QD0w4tiTh4PXCDDuyCPFgdQ=;
        b=D7SMrAeFclubb+qk+5S7lJkOuDUYroRRqaiYlxWfQVTesr4/ypcb+nE4d/90RhTe4t
         wdX6RtcJv2/P3aXeY55rtLp4WEcBYDavjHW9oHJPC4cGP+G9jxZbDePRhckCiKzPCUXH
         n+wogs7f2YMYeqANy3KMu+RBfax4gT88pJN6AD8K6orTlzYT8XJ3uzM/rWYng5kqpMix
         Ks17w5Cl5PCGluU+8bS4+TZmriq+CKogoQ+CxqnQMhc+LNYWV+Q0MFFMpCXU8h75SFk+
         S8G1BDm2I1fjMfbrgx+GVvfVYYhDUTdevvwrNkuigOwNv72OZRqxI6aBKd2E9ulGE00I
         5lNg==
X-Gm-Message-State: AOAM531zpWDqamrU6An3iZ+z27JLwSB6YmNV739++O/bYw5tlXVUnnso
        oheV6FfqKdTPMi9C5pV1EPB3oNcI/21DqEvSaakWPg==
X-Google-Smtp-Source: ABdhPJwOBtzIsE7M6xUMJh8HZkWQJLVovgpiZmoCfwTd5r+6Ngp8ODvRLbB3vL9OUwI/M1z8SRdb+lsFNwIEwGiKZ04=
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr18222608wml.49.1637957261260;
 Fri, 26 Nov 2021 12:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
 <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com>
 <CAFUsyfLeVGW8etXHuSGvYy_RoS3RGaA1L+NLKnpc7EsSMVORBg@mail.gmail.com>
 <CANn89iJxMhGfp364rPu6p_ZLrKnM1qWF_NWrw4_oL_KG+piByg@mail.gmail.com>
 <CAFUsyfJ33cKFQdUagHQ_b4N80CfBtGQZhyA4CN_JLgEmXEX=DA@mail.gmail.com>
 <CAFUsyf+TuU2Xe5Guy5yiFWsV-JZSjUJxcGZv=f0BYDSmODV+_w@mail.gmail.com>
 <CANn89iLjw7YeWNGNtVNi690adJfoSVwgLScrtx-zSyh=COZRsQ@mail.gmail.com> <CAFUsyfK5r+P6aQLBpYZoi0FSgvLwfawBUYTHtQL0TJRozujp3g@mail.gmail.com>
In-Reply-To: <CAFUsyfK5r+P6aQLBpYZoi0FSgvLwfawBUYTHtQL0TJRozujp3g@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 Nov 2021 12:07:29 -0800
Message-ID: <CANn89iKkK0eMQkOTSMGbvdtf+G=eRfXJG0Semju5h-C63QytaQ@mail.gmail.com>
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

On Fri, Nov 26, 2021 at 11:50 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> Bright :) but it will need a BMI support check.

Yes, probably not worth the pain.

>
> I actually get better performance in hyperthread benchmarks with 2 accum:
>
> Used:
>
>         u64 res;
>         temp64 = (__force uint64_t)sum;
>         asm("movq 0*8(%[src]),%[res]\n\t"
>             "addq 1*8(%[src]),%[res]\n\t"
>             "adcq 2*8(%[src]),%[res]\n\t"
>             "adcq   $0, %[res]\n"
>             "addq 3*8(%[src]),%[temp64]\n\t"
>             "adcq 4*8(%[src]),%[temp64]\n\t"
>             "adcq   %[res], %[temp64]\n\t"
>             "mov  %k[temp64],%k[res]\n\t"
>             "rorx $32,%[temp64],%[temp64]\n\t"
>             "adcl %k[temp64],%k[res]\n\t"
>             "adcl $0,%k[res]"
>             : [temp64] "+r"(temp64), [res] "=&r"(res)
>             : [src] "r"(buff)
>             : "memory");
>         return (__force __wsum)res;
>
> w/ hyperthread:
> size,    2acc lat,    1acc lat,   2acc tput,   1acc tput
>   40,       6.511,       7.863,       6.177,       6.157
>
> w/o hyperthread:
> size,    2acc lat,    1acc lat,   2acc tput,   1acc tput
>   40,       5.577,       6.764,       3.150,       3.210
