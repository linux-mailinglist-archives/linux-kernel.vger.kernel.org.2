Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3DD397F66
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 05:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhFBDVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 23:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhFBDUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 23:20:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A26C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 20:19:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f11so1075027lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 20:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/zWmzR0Uw8QrtnlcpwUmwYP/OScyryb/Sf1j0emqwg=;
        b=SsECy9lobUU8r8wKfxNiZRL2vW9bwzGqVFMzpdTKmkOrs80r2ixuRUvKnSf39X8ZJ7
         /bmQdGbqnckxAwQQpztZtvI6Byphk5K/ZkdikURvwRNL+Ix0bVk/KrUBDQFELRbPWZgO
         uIPRHzOJm2ARnkQVoO3gRPovpAaRqx2bC6eos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/zWmzR0Uw8QrtnlcpwUmwYP/OScyryb/Sf1j0emqwg=;
        b=NT7pmAbj0KLB2qPo3UnyabIBSfVOkan0giRnAIrgvY7hQt07yPP6le7aQT7fFr38To
         yHASd3qLqVceIQv8x/lvQnM1ISdhZq3R9cnNzVwwHHVnNsfokevHxbu8L6B8WTkQcvFD
         ChKUegRG57BGZzIs8IY1+yCmE7E6abW1+jZDxsDH88/OhlvKKTbtrw6zuM7E6s+jVFAK
         KNVVMukq9gTZTOvvjZdk60UIVFQCxkjQa2Uhp3ZMA9r6k6CaF/Wr9h/ulAx0Ars1cNwc
         EJGyrq8qT35eSaGmNUfNiIyUm49Ru+WDYhKpmatg9RLJ26WL1dNy79CUV2rQzIX12TyA
         XWRw==
X-Gm-Message-State: AOAM531zhuwka9z/4he0HzVeB5FNhUYLN52h7PnC2lR17goL1IwPRUAg
        35inDKBOWTpVEwo/EohfVPSwxqyx9LtnuWnvJEI=
X-Google-Smtp-Source: ABdhPJymTCx7G8sZ8GnGuo+HrMUJzf9ib2gAyXSM33K7y76egxisEYfZTzj7dQgqyLt7hHbh8MAT2Q==
X-Received: by 2002:a05:6512:2249:: with SMTP id i9mr9853160lfu.592.1622603950825;
        Tue, 01 Jun 2021 20:19:10 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id p21sm1849483lfg.97.2021.06.01.20.19.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 20:19:10 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id m3so682086lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 20:19:10 -0700 (PDT)
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr1816032ljn.220.1622603949840;
 Tue, 01 Jun 2021 20:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210601053143.1380078-1-ying.huang@intel.com>
 <YLYef3i2OGseGbsS@casper.infradead.org> <YLZLf7MI11rzGI1B@cmpxchg.org>
In-Reply-To: <YLZLf7MI11rzGI1B@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Jun 2021 17:18:54 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjg66VL1=F74-YDndwN2FvfUDG30XMgG7USiNkmExDeZA@mail.gmail.com>
Message-ID: <CAHk-=wjg66VL1=F74-YDndwN2FvfUDG30XMgG7USiNkmExDeZA@mail.gmail.com>
Subject: Re: [PATCH] mm: free idle swap cache page after COW
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, Jun 1, 2021 at 5:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> It's free_page[s]_and_swap_cache() we should reconsider, IMO.
>
> free_swap_cache() makes for a clean API function that does one thing,
> and does it right. free_page_and_swap_cache() combines two independent
> operations, which has the habit of accumulating special case-handling
> for some callers that is unncessary overhead for others (Abstraction
> Inversion anti-pattern).

Agreed. That "free_page_and_swap_cache()" function is odd. Much better
written as

        free_swap_cache();
        free_page();

because there's no real advantage to try to merge the two.

It's not like the merged function can actually do any optimization
based on the merging, it just does the above anyway - except it then
has that extra odd huge_zero_page test that makes no sense
what-so-ever.

So if anything we should try to get rid of uses of that odd
free_page_and_swap_cache() thing. But it's not exactly urgent.

             Linus
             Linus
