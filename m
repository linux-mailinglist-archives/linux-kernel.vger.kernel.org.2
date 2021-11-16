Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACA2452930
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbhKPEmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbhKPEmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:42:39 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309D3C09A946
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 17:41:17 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id t127so10252356vke.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 17:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMK6uozsodrf5Zmr8QGj3aYlz+vsrKUh1MXjQekIVNk=;
        b=CjcJLxIUvmhi/Ks6Jh9ofjDmpaPzofIg6TD4d9KDUrQjq9JEVokg1G0wkwvjuCXk8b
         C8wmxqBWEK9DmvqMeZh4oPUXbpP1KXM+29SZ+yOLFI6HQ3o8yyUGQjizqiFwQ95hq3Md
         aMAS5h/QvN8SpAD7TIIciyDzhEkSs2qhYQ1oB25nSujhAT9MsbLZnacYLhOgTfapYRPk
         EbaxkgAXu/rI2s2hAgW4AGOWe3174r2usyZSj6x0iuxB0Q2RGQ1Ob44wSDM1gNSkq+vV
         uaq0pw4FCLNinKePthDb4mtqDrb5dcnwo6Zdh+nb7QR7HzwlkESa+k/kDVe/Kt3T0MDF
         CW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMK6uozsodrf5Zmr8QGj3aYlz+vsrKUh1MXjQekIVNk=;
        b=0GAGUsMCyD7K4ILGPFzKQsdb4K42bf3TbMMx+vGtnKk6GcC/Eo4+qdn/cTZ4nSlTHN
         VIyNNSM09dZuRn8XH9eMqHuexoQQWOh4elCbPWomPMoH1kB0qn6/OH+H2mNkTznn4xWK
         KFYQZTpAcaTNiz+uU+gqJCb3RHK7SD89BXtw/B+SaftqKNAwUMudWovkTMR2FMOubgr0
         XTJ8g3YzSS3EmqqOSWl3Iq6LF5JkLTBSuHLlxOzulZ927yO1MAjioaHL98bevFqMGSTY
         gJehGi/Qst40V9nTGwePnT4FIUmCUSWb5F7svk41mPwhzUOd//j+ogKavhKg5ytsAAMa
         tyPw==
X-Gm-Message-State: AOAM532uFX3RS0d2VspUENqcDWkzpu9xofuApk1Wc1hNIubZwxgGLYj/
        NMpBHayGhaEAnqS/UYZRkbHEnFfS08oNo0iel0cFeGM/pVfUrBiEmSA=
X-Google-Smtp-Source: ABdhPJz7BAgIKnAsC5786/plx9fCqKDF1RLoJ2HyTn1rlhc81SCkaeBDGHtZNsruAJF0qz6w/4ER7wj+hcy2Rbp6V+M=
X-Received: by 2002:a05:6122:20ab:: with SMTP id i43mr66679851vkd.19.1637026876429;
 Mon, 15 Nov 2021 17:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20211114074704.3508622-1-chenhuacai@loongson.cn> <CALAqxLVpTtjFrtKAkcrjDKN9R6FuSdY6LKQw8Mye-3Atqv7kQw@mail.gmail.com>
In-Reply-To: <CALAqxLVpTtjFrtKAkcrjDKN9R6FuSdY6LKQw8Mye-3Atqv7kQw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 16 Nov 2021 09:41:05 +0800
Message-ID: <CAAhV-H6Bq63uM-ifkM8KDJGD1uavv42bG9ij_CZBbCpC-AFSjg@mail.gmail.com>
Subject: Re: [PATCH] time/sched_clock: Allow architecture to override cyc_to_ns()
To:     John Stultz <john.stultz@linaro.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, John,

On Tue, Nov 16, 2021 at 1:27 AM John Stultz <john.stultz@linaro.org> wrote:
>
> On Sat, Nov 13, 2021 at 11:47 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > The current cyc_to_ns() implementation is like this:
> >
> > static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
> > {
> >         return (cyc * mult) >> shift;
> > }
> >
> > But u64*u32 maybe overflow, so introduce ARCH_HAS_CYC_TO_NS to allow
> > architecture to override it.
> >
>
> If that's the case, it would seem too large a mult/shift pair had been selected.
We use a 100MHz clock and the counter is 64bit, the mult is ~160M. But
even if we use a smaller mult, cyc*mult, it can also overflow.

>
> What sort of cycle range are you considering to be valid here? Can you
> provide more rationale as to why this needs the ability to be
> overridden?
>
> And what sort of arch-specific logic do you envision, rather than
> having a common implementation to avoid the overflow?
u64*u64 can be handled by hardware (store the high bits and low bits
of result in two registers). So, if we use assembly, we can handle the
overflow correctly. E.g., LoongArch (and MIPS) can override
cyc_to_ns() like this:

static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
{
        u64 t1, t2, t3;
        unsigned long long rv;

        /* 64-bit arithmetic can overflow, so use 128-bit. */
        __asm__ (
                "nor            %[t1], $r0, %[shift]    \n\t"
                "mulh.du        %[t2], %[cyc], %[mult]  \n\t"
                "mul.d          %[t3], %[cyc], %[mult]  \n\t"
                "slli.d         %[t2], %[t2], 1         \n\t"
                "srl.d          %[rv], %[t3], %[shift]  \n\t"
                "sll.d          %[t1], %[t2], %[t1]     \n\t"
                "or             %[rv], %[t1], %[rv]     \n\t"
                : [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2),
[t3] "=&r" (t3)
                : [cyc] "r" (cyc), [mult] "r" (mult), [shift] "r" (shift)
                : );
        return rv;
}

Huacai
>
> thanks
> -john
