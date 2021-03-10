Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4720F333CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhCJMwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhCJMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:52:16 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB739C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:52:16 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id x29so11350681pgk.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BK42rEfZDnxMm7tn7QJoRMRkMDyVR3i3bNbcPekdIg=;
        b=h3fEZUkobZr1jCHE1WazBNRG4q6cvgfOa2N+PfxLN8F7RZJkzgxy8/c570n7v1gsgE
         wSVCeFTC/83l9s7h3AlU7OrKC5RGtvsuxScUqY6IJhXjcghZQ8EL07clpakh4MTYsG7o
         6KoC27yoGboGzxYaB+5W8my72cxKXJZYwPWTh6e8c4ZfV+hRQj3DRwvP3l72LQhNw298
         sOkfAxTRzwbtQwEezjar0b8cKncz7NqR60/GEO5Od0xr52s3xXhE73SXrE4cXBPxJIlS
         lmmdDl8v0ikLdUjBpWCTlgfWxaqXztaooul2c927TtNy00/RKZdi/4PbDlNVnuRV13n1
         rroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BK42rEfZDnxMm7tn7QJoRMRkMDyVR3i3bNbcPekdIg=;
        b=ThWfts9PhBHey9dOYlCjETDwRs6txslNk4taATsm27nJpeuwJEGonCfT+CauK2uAgB
         srnLqYUTK1a/Av1Gp3QzAk4ayosC87ZE0QuUYsjOnu8R7vafUH02JczeylxlcBvSNVQg
         p8KVFg/6TYhYtTG5hSUhWuVltEbKejcJ2Cg8p+Q/lPcuw1KKgIgxBYEbUdymELj+JLUr
         s0wMaC72QFJKPFcHsROu+Gd1YtYu5l1tHIVoWNlA6woxNi6sqglWufAeKFFWtIxs02fz
         H+HK93BLGFM7n/fJ6lA0poR2Gn90GOK7MKwMXZ0R6cpQSRE86/HKhlPJJ1BouYlR3NMF
         JyMA==
X-Gm-Message-State: AOAM530JBVps0mgSKWk85jxolCtJ58SJGQbXqJcIR7ottvrST3gJP8lW
        TSA/u+PaVG+9wBoHYFMyRWUdXrLqHOeyh5CDvksG4A==
X-Google-Smtp-Source: ABdhPJz6Al6cQ9o2Jkic0AM6aT+uI8HXaIO3FGRdEqDpDV6bZgYd+QRynVKdHFUIi1JAN2QCB/oYogOY84k0cBj6NyQ=
X-Received: by 2002:a63:455d:: with SMTP id u29mr2647321pgk.286.1615380735994;
 Wed, 10 Mar 2021 04:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20210309214301.678739-1-keescook@chromium.org> <20210309214301.678739-4-keescook@chromium.org>
In-Reply-To: <20210309214301.678739-4-keescook@chromium.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 10 Mar 2021 13:52:04 +0100
Message-ID: <CAAeHK+xog8-DP1o=1qqKgSP7Hii2Yjah6oyowNE3zSNVW5pRSw@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] init_on_alloc: Unpessimize default-on builds
To:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 10:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> Right now, the state of CONFIG_INIT_ON_ALLOC_DEFAULT_ON (and
> ...ON_FREE...) did not change the assembly ordering of the static branch
> tests. Use the new jump_label macro to check CONFIG settings to default
> to the "expected" state, unpessimizes the resulting assembly code.
>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Link: https://lore.kernel.org/lkml/CAG_fn=X0DVwqLaHJTO6Jw7TGcMSm77GKHinrd0m_6y0SzWOrFA@mail.gmail.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/mm.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bf341a9bfe46..2ccd856ac0d1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2874,7 +2874,8 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
>  DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
>  static inline bool want_init_on_alloc(gfp_t flags)
>  {
> -       if (static_branch_unlikely(&init_on_alloc))
> +       if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> +                               &init_on_alloc))
>                 return true;
>         return flags & __GFP_ZERO;
>  }
> @@ -2882,7 +2883,8 @@ static inline bool want_init_on_alloc(gfp_t flags)
>  DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
>  static inline bool want_init_on_free(void)
>  {
> -       return static_branch_unlikely(&init_on_free);
> +       return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
> +                                  &init_on_free);
>  }
>
>  extern bool _debug_pagealloc_enabled_early;

Should we also update slab_want_init_on_alloc() and slab_want_init_on_free()?
