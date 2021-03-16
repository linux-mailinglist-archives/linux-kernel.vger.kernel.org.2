Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2C33D983
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhCPQfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:35:06 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42591 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbhCPQef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:34:35 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1McYTD-1lypK129td-00d10N for <linux-kernel@vger.kernel.org>; Tue, 16 Mar
 2021 17:34:32 +0100
Received: by mail-wr1-f44.google.com with SMTP id v11so7772962wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:34:32 -0700 (PDT)
X-Gm-Message-State: AOAM531mQadahtAR4E/gfCOdlV+TVQkU0qpFfuLpWxYSTdq32R4E8ZkS
        8q3+A1KqUj9abEQotmg5gMMzx2HECyE7eWRatdU=
X-Google-Smtp-Source: ABdhPJzb9iprP4M8tU0/IT6/VJb45ZSaimIVd+80NDg8EBrdJQjoVOPX+YrkaQIT2NZuyIHCdxe+q5zWdKli+rvEJMs=
X-Received: by 2002:adf:ed87:: with SMTP id c7mr5923866wro.9.1615912472247;
 Tue, 16 Mar 2021 09:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <202103160133.UzhgY0wt-lkp@intel.com> <YFBYWjtWJrnGyiVp@linux.ibm.com>
 <CAKwvOdmMvvOYBJRZh9w8uQH1ZXZ97Gq+Rs0S4Xi0ZnWufYoxAA@mail.gmail.com>
In-Reply-To: <CAKwvOdmMvvOYBJRZh9w8uQH1ZXZ97Gq+Rs0S4Xi0ZnWufYoxAA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Mar 2021 17:34:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1UvbVh3UKE9N-ch32RZHH5bhfRuz8LN9A3gQew6V3ONA@mail.gmail.com>
Message-ID: <CAK8P3a1UvbVh3UKE9N-ch32RZHH5bhfRuz8LN9A3gQew6V3ONA@mail.gmail.com>
Subject: Re: WARNING: modpost: vmlinux.o(.text+0x74fea4): Section mismatch in
 reference from the function memblock_find_in_range_node() to the function .init.text:memblock_bottom_up()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qerm4qleW8sCKaQJZwbtII6Qz7TKe4rSxuMOVs8fFE59ma+CR99
 l+7xTS1vpQphjbPC9zsxxDIYkaCFkAu7ORAMoVz37z5pNhDhCxcOycpJSWNbA+xmU2gUjA1
 gNtBWXXrqNzlconO8VU8fTLHJttxfNv4gvV8HqzkIXQ1/b4YFbfP1P3Noj+tT5koMIpT3/9
 pDBtaR4mWI/4/lhvNOj5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zbBU9EBoh2I=:WZtyaIETJRaWjfAO0zfAuc
 +vkkvHY8HbVAo5hFK2VQv93lwYpQvsP9ZtJ2gUACRsn7U18oCF9Tmmy+GMDe87i7A5kWm9A7Z
 20euVUlwdJwpF/ITM9ZSkgmSpIF4FZdDJTUkNEaklylBBbvxcoj+XUTwNwJqisr9YgO298/pf
 VPAtVrcIgWzbolv/28QWvPnRCopwZrE8Y7D9vLQ0e03wO3U6aUJe+XbxopfkwL5NDNPCB+iHd
 6GyuC2XtVtnap5ZClBrEz5VmFrdHhAkLkVEK0rQQJsYLBfkvr+qN8t01ujAjWa1GtH1TW2kgg
 lB4pueQyeMA0HngnevqhXIEmM4rtwQ1GlS7ah7PzSHA/EdclwYr4lJuq4jXRg0g4eWxpkhyRh
 H9h9OTP+nFWI483KlMM4qWTKss8d0qMfUYKiVex3qmMQ0v9pspFLT5sCOO1QiZVGZcFQW1pfg
 DZr0F267kUrO8AE4UNldLozP90vC2zl7MbuwsJXmpvf2p5DHepEk6EPO8zj3SHQgeGCFszmSu
 d74ftK/nTjf/UM4GGd1iEeJtmcM52N8jP23BWyo9gNyqvUlJJC7tGx483xj6hJ44A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 5:23 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> On Tue, Mar 16, 2021 at 12:04 AM Mike Rapoport <rppt@linux.ibm.com> wrote:

> >
> > I don't have clang-13 setup handy so I could not check, but I think this
> > should be the fix:
>
> Thanks for taking another look:
> https://lore.kernel.org/lkml/20210225205908.GM1447004@kernel.org/
> Do we want to switch the above to the below?

The patch above is now in mainline and caused the reported problem.

> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index d13e3cd938b4..5984fff3f175 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -460,7 +460,7 @@ static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
> >  /*
> >   * Set the allocation direction to bottom-up or top-down.
> >   */
> > -static inline __init void memblock_set_bottom_up(bool enable)
> > +static inline __init_memblock void memblock_set_bottom_up(bool enable)
> >  {
> >         memblock.bottom_up = enable;
> >  }
> > @@ -470,7 +470,7 @@ static inline __init void memblock_set_bottom_up(bool enable)
> >   * if this is true, that said, memblock will allocate memory
> >   * in bottom-up direction.
> >   */
> > -static inline __init bool memblock_bottom_up(void)
> > +static inline __init_memblock bool memblock_bottom_up(void)
> >  {
> >         return memblock.bottom_up;
> >  }

I don't see the warning on my machine for some reason, but the patch
does seem correct.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

       Arnd
