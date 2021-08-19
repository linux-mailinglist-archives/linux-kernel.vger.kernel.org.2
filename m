Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431873F206D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 21:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhHSTQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 15:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhHSTQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:16:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A943C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:15:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d11so14951147eja.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47eBvc3morcta5Nynwcfir11Tm/8Tdt9QjDTf46bd28=;
        b=CvQP0aLgX9ae5Hc/8Bcp+kZ0Gxk9PyruGSgedrMRoG9uh8NRj8Xb7JRC3jT7s4a8qZ
         NMLDEKuam1GC97jSirK6f4V6WFZpxp15taQzaltBOnh5Fiy2Vt18/59rapCHUcVNOt7w
         QfXaUM3dini5pJyTDHtMVatSFEe3fxEPGFUIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47eBvc3morcta5Nynwcfir11Tm/8Tdt9QjDTf46bd28=;
        b=nSBgeCMbzYZqiD+J3+dzK8hO+gIOCUD8ORT4HVmySViaeE8MyufwK9VGP6Ai0ODezz
         oy+upCOMcN4AKq/jes/xfdOL2OtZ13jO3h69qSTQNbWyv+i7lcWw6W7eFP+y4YhFmVNy
         CTKdsuICJ65ccaQKWTMZSiXZgN0SN6EvBwfaZEjxxTZclKYw5Xmd67MjD3JxdY9qXLsR
         VVSX5iLrhcWW8axqyWoByPyYOhKE447HqH3X0tU+s9TvyupcIp1EGiaJnFBN4XqZrmgp
         hWvL+Oi9qv5FdCR90RS80LgBwA9wvsctjTdcx7q2QGt2GDUAkWf7suZSzuQ33SwnFyd3
         W43A==
X-Gm-Message-State: AOAM530OnhrAL5TJUZjNj2zTfKLO5++FsYX4o1D4a/FvS+4+6Xma5mfp
        qaQ8Ifl8hh/GOjntA+TrVOZU+fXnm09gE3wlLqg=
X-Google-Smtp-Source: ABdhPJwNcxF5D4N1K4GESiBBVNXF4YkH262GCYb38IVt5w21iCqKdOuAfBaAj7hG+xe7SGkwlZwNLA==
X-Received: by 2002:a17:906:3699:: with SMTP id a25mr17168628ejc.452.1629400533567;
        Thu, 19 Aug 2021 12:15:33 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id h8sm2203727edv.30.2021.08.19.12.15.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 12:15:33 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id w5so15035544ejq.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:15:33 -0700 (PDT)
X-Received: by 2002:a2e:557:: with SMTP id 84mr13169568ljf.507.1629400193248;
 Thu, 19 Aug 2021 12:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20210720160127.ac5e76d1e03a374b46f25077@linux-foundation.org>
 <20210819132131.GA15779@willie-the-truck> <YR5ldaQvAnCKMnkk@hirez.programming.kicks-ass.net>
 <YR52igt/lJ7gQqOG@hirez.programming.kicks-ass.net>
In-Reply-To: <YR52igt/lJ7gQqOG@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Aug 2021 12:09:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_vEzmYnMufOa=03WAU=DRM5+n6uZy=dVtJERFJm3Q-Q@mail.gmail.com>
Message-ID: <CAHk-=wh_vEzmYnMufOa=03WAU=DRM5+n6uZy=dVtJERFJm3Q-Q@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: Convert from atomic_t to refcount_t on anon_vma->refcount
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 8:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> If we can skip the OF... we can do something like this:

Honestly, I think a lot of the refcount code is questionable. It was
absolutely written with no care for performance AT ALL.

I'm not sure it helps to then add arch-specific code for it without
thinking it through a _lot_ first.

It might be better to just have a "atomic_t with overflow handling" in
general, exactly because the refcount_t was designed and written
without any regard for code that cares about performance.

> static inline bool refcount_dec_and_test(refcount_t *r)
> {
>         asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
>                            "jz %l[cc_zero]\n\t"
>                            "jns 1f\n\t"

I think you can use "jl" for the bad case.

You want to fail if the old value was negative, or if the old value
was less than what you subtracted. That's literally the "less than"
operator.

I think it's better to handle that case out-of-line than play games
with UD, though - this is going to be the rare case, the likelihood
that we get the fixup wrong is just too big. Once it's out-of-line
it's not as critical any more, even if it does add to the size of the
code.

So if we do this, I think it should be something like

   static inline __must_check bool refcount_dec_and_test(refcount_t *r)
   {
        asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
                "jz %l[cc_zero]\n\t"
                "jl %l[cc_error]"
                : : [var] "m" (r->refs.counter)
                : "memory" : cc_zero, cc_error);

        return false;

   cc_zero:
        return true;
   cc_error:
        refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
        return false;
   }

and we can discuss whether we could improve on the
refcount_warn_saturate() separately.

But see above: maybe just make this a separate "careful atomic_t",
with the option to panic-on-overflow. So then we could get rid of
refcount_warn_saturate() enmtirely above, and instead just have a
(compile-time option) BUG() case, with the non-careful version just
being our existing atomic_dec_and_test.

Giving people who want a smaller kernel the option to do so, while
giving people who want checking the option too.

                Linus
