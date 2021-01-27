Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0817E30553E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhA0IGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:06:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231911AbhA0IDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:03:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED20920756;
        Wed, 27 Jan 2021 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611733959;
        bh=Tv+8y3pzWOHQkpR7Hs5hm5r5DosoTs5SyOgTkiddGHs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZLPBWbOUAdOHMPEoSwF7KtfjQYE2wJtn/7k3Bxd26KW9RHbAyfv1qUwzd5vT6n12W
         w1wGGebrYPmJhNBi/NOhv9uquUI8zULSDvRfVSi7PRk9NZ646lVmde6SdIB/SwAl8p
         70RtrTXtspXp6RIHreqDfCkMW2UPOey7BEehAYpnQiYCjsCCNwIMNPYcerKnv3ki4l
         tS3XseuWB8NOkzkfPk+hGQDh3NYdjRaRwcMSVcfEolbClP+W2dkn6tTE4L7g2y8VAZ
         AkaYkg3gS8mcZBHJT49dRFGEgsN8l9JtKuv4SYs7ruHpQw4HYACPb5p5hW6qMIj/f1
         UD5yoLiN9UX8w==
Received: by mail-lf1-f52.google.com with SMTP id p21so1325621lfu.11;
        Tue, 26 Jan 2021 23:52:38 -0800 (PST)
X-Gm-Message-State: AOAM532Jm1jZMe56OqU5rHQSI/fHaJGBpkXaz3SYlkvT13Y3NwECJX42
        JmBRWciBth0f9srESlX446A7z6it/EmUcvne0W0=
X-Google-Smtp-Source: ABdhPJy0vzzTa8tPz7BihHnETMHW4VOoner3DlexSXYzwwBiLgRdzOTa7biZMZ4cBO/OO2xwH6haTVe7HcWoFCBJlQY=
X-Received: by 2002:ac2:4436:: with SMTP id w22mr4276748lfl.41.1611733957044;
 Tue, 26 Jan 2021 23:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20210126181420.19223-1-david@redhat.com> <20210126182648.GR6332@kernel.org>
In-Reply-To: <20210126182648.GR6332@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 27 Jan 2021 15:52:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRsqZ4DTvZm2V9VRKP_f6u-p5aupCjrvuGy_7m8tiQQVQ@mail.gmail.com>
Message-ID: <CAJF2gTRsqZ4DTvZm2V9VRKP_f6u-p5aupCjrvuGy_7m8tiQQVQ@mail.gmail.com>
Subject: Re: [PATCH v1] csky: use free_initmem_default() in free_initmem()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-csky@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Mike,

It's under test:
https://gitlab.com/c-sky/buildroot/-/pipelines/247353584

kernel:
https://github.com/c-sky/csky-linux/commit/9d986b01feb991ded3fb8c1f8153a0c80ea84b9c

On Wed, Jan 27, 2021 at 2:26 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Tue, Jan 26, 2021 at 07:14:20PM +0100, David Hildenbrand wrote:
> > The existing code is essentially
> > free_initmem_default()->free_reserved_area() without poisoning.
> >
> > Note that existing code missed to update the managed page count of the
> > zone.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Guo Ren <guoren@kernel.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >
> > Not compile tested as documentation on how to get
> >       https://gitlab.com/c-sky/buildroot
> > running, especially with a custom kernel, is a bit sparse.
>
> You can pick a cross-compiler from here:
>
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
>
> > ---
> >  arch/csky/mm/init.c | 17 +----------------
> >  1 file changed, 1 insertion(+), 16 deletions(-)
> >
> > diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
> > index 81e4e5e78f38..894050a8ce09 100644
> > --- a/arch/csky/mm/init.c
> > +++ b/arch/csky/mm/init.c
> > @@ -110,24 +110,9 @@ void __init mem_init(void)
> >       mem_init_print_info(NULL);
> >  }
> >
> > -extern char __init_begin[], __init_end[];
> > -
> >  void free_initmem(void)
> >  {
> > -     unsigned long addr;
> > -
> > -     addr = (unsigned long) &__init_begin;
> > -
> > -     while (addr < (unsigned long) &__init_end) {
> > -             ClearPageReserved(virt_to_page(addr));
> > -             init_page_count(virt_to_page(addr));
> > -             free_page(addr);
> > -             totalram_pages_inc();
> > -             addr += PAGE_SIZE;
> > -     }
> > -
> > -     pr_info("Freeing unused kernel memory: %dk freed\n",
> > -     ((unsigned int)&__init_end - (unsigned int)&__init_begin) >> 10);
> > +     free_initmem_default(-1);
> >  }
> >
> >  void pgd_init(unsigned long *p)
> > --
> > 2.29.2
> >
>
> --
> Sincerely yours,
> Mike.



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
