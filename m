Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69BE45270D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 03:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245580AbhKPCO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 21:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbhKORwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 12:52:44 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5B9C0A3BDF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:27:06 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bu18so45686793lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AO0NlSmR9mYSq3oMlnIAASaFgPIFheiRI7IL5/kqzF8=;
        b=qXa3KLevB5uCBsT0Mm5p0HktCkRkxKQ/ENCpexU4hG++JphgeKtZeuxIas0FmMuqUQ
         pzpOAPGyKhBpWBvu2C80NnYrI8XeoEI5NJOyWph1tl/7NKchV7n4LxslMYVj0sLnfAPg
         WhCjRA3DUuc9MK3sD3YhHK5qXoqfDQwaJVjNli31Ps0soT/fj0w8DJdtegy8r6/uQ9Th
         u9iuAlyjmKNodyLh2JKI5xnYdbrl1OJe1PrdX4VG3CAHlkehCORN8RtUbtFUHiHDCIPn
         miCCm009EaB9cB7HICqqW5Id4Bc10marZBEUds9F2XR6cfS5nYGEWoJ4oKAMWucGTeYV
         nWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AO0NlSmR9mYSq3oMlnIAASaFgPIFheiRI7IL5/kqzF8=;
        b=IGGxRlOeJFvVkjejsxJh/rbA6mxxS1Kot/om9F4puevI1eb7F0AZQ70ZmB9Tph2lo8
         ZnOjxISCnEZcSH7KU2KtYOocFFud6qMSdNjhg76m6sxbKODlcyWX14WkvOq3RnFYyrXJ
         NtnQinY9H/PDAJ3oCCvZNgvts7GfOqu0due1XQpz0Snj+DJpxTZEAw1y6ZD8oAKj87mq
         Vv1CNlpMEZ8FEUaXPxu5fkhdWokpy1LQdpmxLb/yUt6MJJ08qTZ51F3eWMvDTClYVORY
         9Vzlrbhz3h/YPx/3Y+pFxOxRd1AM4FuML6YUlxdN9cF5f/I7SK+WDQuxqniLilsECZo8
         Q8JA==
X-Gm-Message-State: AOAM530s8t576nN1Hg2Snsd9g53ulxGswXUNA2B+GD1rt2QwwF9PEoyv
        h13r9Sc5G2UVp5C+g9Eu9wl0MbjYucBuSeVHagkzMg==
X-Google-Smtp-Source: ABdhPJyarUCJGrjo9ggl2A5teymD6Qc043RuPNXNnJ0zjFUIdWzvyopOLXQZTcdMvfx/3QZddl59x13RofDojPGp/mQ=
X-Received: by 2002:a05:6512:3901:: with SMTP id a1mr362673lfu.36.1636997224744;
 Mon, 15 Nov 2021 09:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20211114074704.3508622-1-chenhuacai@loongson.cn>
In-Reply-To: <20211114074704.3508622-1-chenhuacai@loongson.cn>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 15 Nov 2021 09:26:54 -0800
Message-ID: <CALAqxLVpTtjFrtKAkcrjDKN9R6FuSdY6LKQw8Mye-3Atqv7kQw@mail.gmail.com>
Subject: Re: [PATCH] time/sched_clock: Allow architecture to override cyc_to_ns()
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 11:47 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> The current cyc_to_ns() implementation is like this:
>
> static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
> {
>         return (cyc * mult) >> shift;
> }
>
> But u64*u32 maybe overflow, so introduce ARCH_HAS_CYC_TO_NS to allow
> architecture to override it.
>

If that's the case, it would seem too large a mult/shift pair had been selected.

What sort of cycle range are you considering to be valid here? Can you
provide more rationale as to why this needs the ability to be
overridden?

And what sort of arch-specific logic do you envision, rather than
having a common implementation to avoid the overflow?

thanks
-john
