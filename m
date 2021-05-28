Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40DA393AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 03:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhE1B3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 21:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhE1B3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 21:29:22 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B32C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 18:27:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i9so2852407lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 18:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oiL2+jMjytGTOxMvXGwzwUo5vCZt66vYTiHQDgUEKHE=;
        b=BttFZy0GPIhhl/djFDRh9gv/Yz2WzqdPIHwZvXr+4BWx1KPOte4Hb1m+Mi1zIdnLrs
         bip3zV2OG4EdjV0YO/KOAp3nhTw2oJoWHS5y1Nrf0wj034n38qtAnqNjGXirOKcjGiqX
         y8bGEQFPwKJnxQLA3n+m20YGnQOUUbK+jnmFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiL2+jMjytGTOxMvXGwzwUo5vCZt66vYTiHQDgUEKHE=;
        b=U5TJJG0xFOMcNa8aPbtcLf7vtx0RRugpwofC+9Aop4NmuQIiof0TWarjs/ch2p7x1L
         /IrOLjagD34Lf/z8uSjRWQ68NLrZ/0ZQlrqgztaBpvJs8IQVGpQp+uLuLvjqH7BBZZ2r
         y37rxWRwfOKc6Yx92r+ya39wEOX/YqisLzv2FYSlIQzl4Fc7pdCSkcBbno3hrYRtxgPu
         km2xssiQtruYegNJc6MF13FYddE//tDvwVvGYEqzhCdAEZ7M+iuAkcw+eEFWSsGJh5rq
         KKUGMAJl6q0eehYwp0TFLV/HL9wrveAtw0PKUtanKFogczTxL8PZsjdnMsGAP+dCz6fq
         shzg==
X-Gm-Message-State: AOAM532PRyx413a6S8R1HPX3r3jcltTKXDa+x6AfeFJGePprOg8zS1uo
        TYIKXULFsHhEHTX17flDiLhwe6g1ulmq5kXf
X-Google-Smtp-Source: ABdhPJyrEC2e5OvnQ7Z5TJgE7LtzfgMmB3SGnk4BFJvnuvKwE2jXz3gqYTSjz0YfzEPhcFM83iLXdw==
X-Received: by 2002:a05:6512:3990:: with SMTP id j16mr4069548lfu.367.1622165265588;
        Thu, 27 May 2021 18:27:45 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f27sm334376lfk.285.2021.05.27.18.27.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 18:27:44 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id v5so3200091ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 18:27:44 -0700 (PDT)
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr4882494ljq.220.1622165264266;
 Thu, 27 May 2021 18:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210527084953.573788-1-ying.huang@intel.com> <YK/OaEAwL4cufITY@cmpxchg.org>
In-Reply-To: <YK/OaEAwL4cufITY@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 May 2021 15:27:28 -1000
X-Gmail-Original-Message-ID: <CAHk-=wibch8fg0WpbHitC9aR1v_YMwhM01Ecwas1-L4wg6xsSg@mail.gmail.com>
Message-ID: <CAHk-=wibch8fg0WpbHitC9aR1v_YMwhM01Ecwas1-L4wg6xsSg@mail.gmail.com>
Subject: Re: [PATCH -V2] mm: move idle swap cache pages to the tail of LRU
 after COW
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 6:53 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> OTOH, freeing is a two-liner reusing the swap unmap code:
>
>         if (page_copied)
>                 free_swap_cache(old_page);
>
> Linus, what do you think?

I'm ok with that version, the important thing was

 (a) avoiding the unconditional page lock we used to have (well, it
first did "trylock", but if tht failed it would then get a page ref,
and do the unconditional lock_page())

 (b) avoid the re-use based on "mapcount" that had problems with
non-mapped page references (ie GUP)

and

 (c) that I wanted to see some numbers rather than just blindly
re-introduce free_swap_cache()

But doing the above two-liner in wp_page_copy() doesn't have the
(a)/(b) issues, and if we have numbers that it helps, then that takes
care of (c) too.

Of course, I don't think it's just that two-liner, because you'd
actually have to export (or move )that "free_swap_cache()" function
that is now private to swapfile.c.

But no, I'm not adverse to the above at all, I just had the above reservations.

I was worried about non-swap behavior (which the old code had with
that whole unconditional page locking whether needed or not), but
free_swap_cache() should be basically free for the non-swap behavior
since it doesn't even do the trylock until after it has checked that
it is now an unmapped swap cache page.

              Linus
