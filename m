Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E3366420
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 05:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhDUDmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 23:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhDUDmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 23:42:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598A7C06138B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 20:42:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h11so9734286pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 20:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUmL888r4a+LpYSIBfs7CscY/g54lCVXYOagGpbPjVM=;
        b=Dc4Xe0xBbbGif9Gf3Rrn0GjZTgrU4YJB9/diduYpGSilOKnqXHUVIOuVuCYmz6C7Ly
         C0RiXXAJt+u5gtoqTx1oRhtMkru/P9kG8F6hfQLPSo/j99da+9NRQVokSgPt2wgSp/nL
         Qq9zRfpS2wQDKLkJDGc7lSUbJnQeb9EB7iv6Jj1+Gc6Vo3+gWw2rkNrn6gsiADQWDK7D
         tDmGYbpcgm71y32RH9mKhFwkr1L/K3Tlumc2K5RszcAm+wDKB3A+1LWpE99Zm6+fhlUH
         LVeFXy/tytc7OclmyaEAt9IppxoIQtfjlmcKJhrj6Ceu1GDwBNzriQTD/n3DWUBdnszo
         VhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUmL888r4a+LpYSIBfs7CscY/g54lCVXYOagGpbPjVM=;
        b=BdlbHjNUlRDtYz/cH2xi3vW6zgVf0/TNnPJfjBoywoPOuUuf/K26Qli1W+LG5W55Pz
         jWtSsE7jXhbquaGt6+FqYtryElVxNqORZ1ox2bskUcAO+amvUw2s2h/44Juozyc6ofos
         cv1q2GJdipAzPQ4rzpf6UFBz47erWL57/1ZKKGkQBQL7LlqodegGW9WYxnk73V14iKxp
         BczKnl5VlDWce+PAMOpL6O+MutBQpQp2usmK712SyvFLc8ncq0xFavDmfV7T/vLwyJIs
         ZQppO1W2ggKCLWQ+sMUAPV21PpqNhX8i8ptc/0IeqCv0d6pdRU/+AWnsLJZbnq760g2B
         pcdg==
X-Gm-Message-State: AOAM531uUaMhCGi4hzGzFByovpmKIJZHyzmrg3LBa9CtkNebNsHmzzY9
        nSXLj7zbK14zaaeaA1g0cXAuvrY5U9kVrfhoVM5xzQ==
X-Google-Smtp-Source: ABdhPJwajsmOj71PAdasi8LGZGfzGOdU6MTMZV7UrToOFpR0HiSfxiN5qVjxoFmHWPGV0b5F01P9EIp4uzY5N+VRPNM=
X-Received: by 2002:aa7:9af7:0:b029:264:b19e:ac9c with SMTP id
 y23-20020aa79af70000b0290264b19eac9cmr4284965pfp.59.1618976521815; Tue, 20
 Apr 2021 20:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210415084005.25049-1-songmuchun@bytedance.com>
 <20210415084005.25049-9-songmuchun@bytedance.com> <YH6udU5rKmDcx5dY@localhost.localdomain>
In-Reply-To: <YH6udU5rKmDcx5dY@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 21 Apr 2021 11:41:24 +0800
Message-ID: <CAMZfGtXmDhkCWateAR0q_EgRPDmGh_=D-6UuhMd+Si6=TDvghQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v20 8/9] mm: memory_hotplug: disable
 memmap_on_memory when hugetlb_free_vmemmap enabled
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 6:35 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Apr 15, 2021 at 04:40:04PM +0800, Muchun Song wrote:
> >  bool mhp_supports_memmap_on_memory(unsigned long size)
> >  {
> > +     bool supported;
> >       unsigned long nr_vmemmap_pages = size / PAGE_SIZE;
> >       unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
> >       unsigned long remaining_size = size - vmemmap_size;
> > @@ -1011,11 +1012,18 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
> >        *       altmap as an alternative source of memory, and we do not exactly
> >        *       populate a single PMD.
> >        */
> > -     return memmap_on_memory &&
> > -            IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
> > -            size == memory_block_size_bytes() &&
> > -            IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> > -            IS_ALIGNED(remaining_size, pageblock_nr_pages << PAGE_SHIFT);
> > +     supported = memmap_on_memory &&
> > +                 IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
> > +                 size == memory_block_size_bytes() &&
> > +                 IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> > +                 IS_ALIGNED(remaining_size, pageblock_nr_pages << PAGE_SHIFT);
> > +
> > +     if (supported && is_hugetlb_free_vmemmap_enabled()) {
> > +             pr_info("Cannot enable memory_hotplug.memmap_on_memory, it is not compatible with hugetlb_free_vmemmap\n");
> > +             supported = false;
> > +     }
>
> I would not print anything and rather have
>
> return memmap_on_memory &&
>        !is_hugetlb_free_vmemmap_enabled &&
>        IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
>        size == memory_block_size_bytes() &&
>        IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
>        IS_ALIGNED(remaining_size, pageblock_nr_pages << PAGE_SHIFT);

OK. Will do.

>
> Documentation/admin-guide/kernel-parameters.txt already provides an
> explanation on memory_hotplug.memmap_on_memory parameter that states
> that the feature cannot be enabled when using hugetlb-vmemmap
> optimization.
>
> Users can always check whether the feature is enabled via
> /sys/modules/memory_hotplug/parameters/memmap_on_memory.

If memory_hotplug.memmap_on_memory is enabled

    $ cat /sys/module/memory_hotplug/parameters/memmap_on_memory
    $ Y

If memory_hotplug.memmap_on_memory is disabled

    $ cat /sys/module/memory_hotplug/parameters/memmap_on_memory
    $ N

>
> Also, I did not check if it is, but if not, the fact about hugetlb-vmemmmap vs
> hotplug-vmemmap should also be called out in the hugetlb-vmemmap kernel
> parameter.

Make sense. I will update the doc.

Thanks.

>
> Thanks
>
> --
> Oscar Salvador
> SUSE L3
