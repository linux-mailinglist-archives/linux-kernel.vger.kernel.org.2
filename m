Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D3F39BF89
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFDS04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhFDS0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:26:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D815C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 11:24:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i13so12208027edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NkZLuODRGewH4zgC3asg1j+OkGGx+7ZEADeUCWN74M=;
        b=AZOMP7RwTJv+l9AGvBTpG43OcDsnnTvgcZRvwckXkRIPNds68iR+iR6l1vRACYm0eF
         znXZdiMm+96xHm4rcPmcza3bIy6sTFZiupGZPbw6MbkkSJD+vmsDjjq1KkdrTno4J/F8
         gSlQ7cA7SyyHwaiBKj2t60vTm4puwPSkfWgGZAeCa0Ew95TCCj7jcwCpe5vyTPKJUhoT
         +QOHqzem+HNdUt2Ywtwp07U0tswsfMNeZWdtQlYHWxIsk+PTFYmKxZ3H21a5UD6udAxL
         gnnDD7SOfX5MWhpqkFMK/QonB3sZCo5E1AaUyCUlAG2pF4TqPXYZY7p9m86yy0+IAgSO
         mYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NkZLuODRGewH4zgC3asg1j+OkGGx+7ZEADeUCWN74M=;
        b=gJTcPZ+CkSXCD0Pr4sLUE33dBTEykHn01PhE7teJSwu2nMUGMPGtVZogoYeuHYk2TP
         Hpe8I6wvJR93wyFjfpUcy1efEpSi6QtKiPsdHUIz94+qZq/soFGNK1ESJatlPPIuJRT/
         UjtCL1MFSURNip8GRaUN/Ij48kYQSK/3S7MWme4tKvRODfiMxc2PQs0RextHkXhEySEu
         Q+RqjQFyemA11JbUstVFGLk867ddfwm8DF/sH7jwMPjBrqODtkYHiVjvnUSmVvcJnOiQ
         B/b8Q6uu/L2nRYM6xb8XsgXSk5DvdK08QGnZtDxaAGJL8nJDkcpjZwR0k9EuC/SvEIHC
         zAgw==
X-Gm-Message-State: AOAM530DnDNgDfb3HGWvlPHH6jwp2BbbufZo6lkbmm68kgF9FdUCgQJH
        W2Oa/BXHHSdgV2TlTcSm4iaj0Qz2JPV7Pvfbclw=
X-Google-Smtp-Source: ABdhPJxzh0Zb0Nux3f2gz0cdh0pFdmncuMubQc2aD60/G5zIhcfwbELlmAPGN453ktwZC25dCFYcajmc0cRx9LSnuEA=
X-Received: by 2002:aa7:d5c6:: with SMTP id d6mr6020346eds.290.1622831091631;
 Fri, 04 Jun 2021 11:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011405510.2148@eggly.anvils> <CAHbLzkrUcNhGDmPstSNHhwbdoo3z2B=v-zb7__M3RqHL-Ct-EA@mail.gmail.com>
 <alpine.LSU.2.11.2106031923410.12760@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2106031923410.12760@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Jun 2021 11:24:38 -0700
Message-ID: <CAHbLzkoLnzyXra9MXmVVAkB5wdhSe-6j7TVunHXqHt6Bpzz7NA@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm/thp: try_to_unmap() use TTU_SYNC for safe DEBUG_VM splitting
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 7:45 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 3 Jun 2021, Yang Shi wrote:
> > On Tue, Jun 1, 2021 at 2:07 PM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > Instead of abandoning the unsafe VM_BUG_ON_PAGE(), and the ones that
> > > follow, use PVMW_SYNC in try_to_unmap_one() in this case: adding TTU_SYNC
> > > to the options, and passing that from unmap_page() when CONFIG_DEBUG_VM=y.
> > > It could be passed in the non-debug case too, but that would sometimes add
> > > a little overhead, whereas it's rare for this race to result in failure.
> >
> > The above statement makes me feel this patch is just to relieve the
> > VM_BUG_ON, but my patch already changed it to VM_WARN, the race sounds
> > acceptable (at least not fatal) and the splitting code can handle the
> > failure case as well. So I'm wondering if we still need this patch or
> > not if it is just used to close the race when CONFIG_DEBUG_VM=y.
>
> I do agree that your 1/2 (what I'm calling 6.1/7) BUG->WARN patch
> is the most important of them; but it didn't get marked for stable,
> and has got placed behind conflicting mods never intended for stable.

Sorry for not marking it for stable. I do have no any objection to
having it in stable, just forgot to cc stable. :-(

>
> And a lot of the descriptions had been written in terms of the prior
> situation, with VM BUG there: it was easier to keep describing that way.

Understood.

>
> Whether your fix makes mine redundant is arguable (Wang Yugui thinks
> not).  It's easier to argue that it makes the racy ones (like this)
> redundant, than the persistent ones (like vma_address or pvm_walk).

The point is if we just close the race for DEBUG_VM case, it doesn't
sound worth it to me IMHO. How's about making it for !DEBUG_VM anyway?
How big the overhead could be? It looks like the heavy lifting (tlb
shootdown and page free) is done after pmd lock is released so it
should not block pvmw for a long time.

>
> Since I know of at least one customer who wants all these fixes in 5.10
> longterm, I'm fighting to get them that far at least.  But the further
> back they go, the less effort I'll make to backport them - will fall
> back to porting your BUG->WARN only.
>
> Hugh
