Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965B734ACAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCZQmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:42:31 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:47252 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhCZQmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:42:11 -0400
Date:   Fri, 26 Mar 2021 16:42:04 +0000
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: page_alloc: ignore init_on_free=1 for page alloc
Message-ID: <20210326164204.29da5808@sf>
In-Reply-To: <CA+fCnZeC8AWearU9CQaYrFM-ZCUaQpX1e7vBkRMNtqqf_=ucGA@mail.gmail.com>
References: <20210326112650.307890-1-slyfox@gentoo.org>
        <4e23d404-5125-6c9c-4aa7-5eff0fa1ba33@redhat.com>
        <CA+fCnZeC8AWearU9CQaYrFM-ZCUaQpX1e7vBkRMNtqqf_=ucGA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 16:00:34 +0100
Andrey Konovalov <andreyknvl@gmail.com> wrote:

> On Fri, Mar 26, 2021 at 2:49 PM David Hildenbrand <david@redhat.com> wrote:
> >  
> > > I observed use of poisoned pages as the crash on ia64 booted with
> > > init_on_free=1 init_on_alloc=1 (CONFIG_PAGE_POISONING=y config).
> > > There pmd page contained 0xaaaaaaaa poison pages and led to early crash.
> > >
> > > The change drops the assumption that init_on_free=1 guarantees free
> > > pages to contain zeros.
> > >
> > > Alternative would be to make interaction between runtime poisoning and
> > > sanitizing options and build-time debug flags like CONFIG_PAGE_POISONING
> > > more coherent. I took the simpler path.
> > >  
> >
> > I thought latest work be Vlastimil tried to tackle that. To me, it feels
> > like page_poison=on  and init_on_free=1 should bail out and disable one
> > of both things. Having both at the same time doesn't sound helpful.  
> 
> This is exactly how it works, see init_mem_debugging_and_hardening().
> 
> Sergei, could you elaborate more on what kind of crash this patch is
> trying to fix? Where does it happen and why?

Yeah, I see I misinterpreted page_poison=on handling and misled you all.
Something else poisons a page when it should have not. I'll answer in more
detail to Vlastimil's email upthread and will provide more detail of the
unexpected poisoning I see.

-- 

  Sergei
