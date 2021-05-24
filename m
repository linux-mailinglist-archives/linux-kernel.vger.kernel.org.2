Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D015438E429
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhEXKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhEXKiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:38:16 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC6DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 03:36:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x15so26607100oic.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OyogGDxMaGSBrj2rkEP+jK8JOL+4OXbDVcsd7RbbjgQ=;
        b=vO8TRdchq8qlXFP7kNIZKyborERcCPCFxcRJlmVAg91ZhBc+M/OlVcyjenZaivhTHq
         SFT99XA7iNxm5biJlXDD6SDFMlUDP4f+KFEVn43PqGQyRm/xeH3pTNwqy2XaJPlQdJMs
         Wo3I/Ob/uXt+TrLVe1h7dpHeOsUo8sDpK+1yhlTf3UCuW/GzVoABNtORkiLQL98hJWLU
         ZPUOvhlgokNhXjOlFavc8zrbqCUyohZECH3qe8YwsRgKibc53g4FQOoC5ds1BJznXRJQ
         P2qvqB+EzJ5NnOH6CRr/FCln8RaGoqcqdM4/E+3de9AN3hMDF+gWMRuNDLir7A04Gk11
         ITKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyogGDxMaGSBrj2rkEP+jK8JOL+4OXbDVcsd7RbbjgQ=;
        b=Yw8qR7PpzTachkVKcqhSQzKcFWDLb0t3QGo3/a8OIHhoAXZzPNMg9NBoqVTwBctTH/
         Uzxc3JMrAfTvkhq4/a6WG0u3I8jDi8dzZiKVjw2oNkt/ndB1vItcV3wbt9uhJ4YJpALK
         E66oV+5AlwB0RXWetJzKv38ban5qQfTNwyriqDhYhxVfQ42/Rei33oP4it+rE54i4jzT
         FwXtSmQP3I/d1/+Kd7ArrvHixZZmuPe5ddGDcl/R+AwnNVOSgzVhtRBQp02FKLalcOKj
         fxlxwvMcFEvlD02cd1ZB69ly3fsBeedb5evYDd1YH70hEUbWhhiqSPE7EmZb7IZDaW/w
         s8Mg==
X-Gm-Message-State: AOAM530rmJr2MtK8JJ2mEXt6tRZep7rtsPzu2mQdqh9HDJ2TOpfmt3YE
        zV1Gf/4KzQzo0Tw+/7jUjvaS40OHfJmrVkExSSOWAA==
X-Google-Smtp-Source: ABdhPJxTHFDXkF0sGbpwKQ/wGAzN9+c/BhxVAg382Xrdc+7foZ+2Jc5h0xV9kkBUR2lsvZI4bw9Advoi1aORJHu1tpk=
X-Received: by 2002:a05:6808:10d4:: with SMTP id s20mr10530580ois.70.1621852606335;
 Mon, 24 May 2021 03:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210524172433.015b3b6b@xhacker.debian> <20210524172529.3d23c3e7@xhacker.debian>
In-Reply-To: <20210524172529.3d23c3e7@xhacker.debian>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 May 2021 12:36:34 +0200
Message-ID: <CANpmjNOVikz=u90-xQKzWGxbH_ov5R_EkuG6ZLqVAkjkgw8Z2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kfence: allow providing __kfence_pool in arch
 specific way
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 at 11:26, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> Some architectures may want to allocate the __kfence_pool differently
> for example, allocate the __kfence_pool earlier before paging_init().
> We also delay the memset() to kfence_init_pool().
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  mm/kfence/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index e18fbbd5d9b4..65f0210edb65 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -430,6 +430,8 @@ static bool __init kfence_init_pool(void)
>         if (!__kfence_pool)
>                 return false;
>
> +       memset(__kfence_pool, 0, KFENCE_POOL_SIZE);
> +

Use memzero_explicit().

Also, for the arm64 case, is delaying the zeroing relevant? You still
call kfence_alloc_pool() in patch 2/2, and zeroing it on
memblock_alloc() is not wrong, correct?

Essentially if there's not going to be any benefit to us doing the
zeroing ourselves, I'd simply leave it as-is and keep using
memblock_alloc(). And if there's some odd architecture that doesn't
even want to use kfence_alloc_pool(), they could just zero the memory
themselves. But we really should use kfence_alloc_pool(), because
otherwise it'll just become unmaintainable if on changes to
kfence_alloc_pool() we have to go and find other special architectures
that don't use it and adjust them, too.

Thanks,
-- Marco

>         if (!arch_kfence_init_pool())
>                 goto err;
>
> @@ -645,10 +647,10 @@ static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
>
>  void __init kfence_alloc_pool(void)
>  {
> -       if (!kfence_sample_interval)
> +       if (!kfence_sample_interval || __kfence_pool)
>                 return;
>
> -       __kfence_pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
> +       __kfence_pool = memblock_alloc_raw(KFENCE_POOL_SIZE, PAGE_SIZE);
>
>         if (!__kfence_pool)
>                 pr_err("failed to allocate pool\n");
> --
> 2.31.0
>
