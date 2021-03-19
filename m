Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA40341C15
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCSMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhCSMQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:16:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BCCC061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 05:16:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso4759982pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=affLRntRZcInzHgZqXHL31AIW6roXMHiPl+j3xoyydw=;
        b=Wwr3uymKFr1n+YOBEyGZs0UOSJMaYAZ56KTR7KZVL7k18g5qAOBt+YgiJoL8G92Uv7
         t5ZSkP2F51JdFVKcgvsGhdWRS7lBXt+T83x/JmFbldKB7GuiA6oVMRQVllzP+A/nlfkY
         6OcwpsxZjmDLyHA/jJjRsthgxYbLCRaPfUTWLfYy0qtmxHxEYx3++3yEzCHb5ZFIPP1Y
         FpwnGU/AiT/7tJroR5E+LgvNyPu96pkAcyTaIqSrz1CHc4HSrezFYQysVJOjCSLEPuTm
         n4wgQWBO10IbmJMFeSAGIs16rA6lAm7o93XYLQCZp76IUd9q9ZtS/iK9+4fEbZan6bVK
         WWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=affLRntRZcInzHgZqXHL31AIW6roXMHiPl+j3xoyydw=;
        b=dCf6du4m6Ea35uLm3CKFrTC9JD7NkCsENPVV8Py3tZl9mQAP6RBnwK+J7I4dkOoUQ+
         U1zKCsfj2A1Ulgvq20wxYpU5xekpj3kfuaN1mVCc67jOkKf20YsL26AhIRENCt9Wi4WM
         /Lq0qX3A2jZFiCt5OqiSIRll8FIA9TCDSI6mcut9xMoK0kO9xaJfdtk+bmRhF51dfFwG
         RCsy7gdqT9u6BjSN9Gr5XDLM8psRxcaCZkzpIWs7dgiRY6SU2TnLBDEcedgkUHg0OZgm
         q+4m6qTcXSo5MvnP2qJ93UAcHJkHKyJG+batnHdMSARkJzT6RsBSRoLMCQFm8tNACde1
         GUdw==
X-Gm-Message-State: AOAM532gTJdGo/jVWvL/lB9IX3VyTVTzmzVaaena/tT5SXVcCAuBDGem
        RiUCdUpnlBxarDd+lRKTGSkVhYu+4J0dXKvJB0JfFA==
X-Google-Smtp-Source: ABdhPJwrqbdyuQfn4t1x4h3FwSP0uWjg3FdAAnwpfMkicRuHl1UB8RVx3Ukwq3U6YKkcOX2CFsmx8BMA4NisJmIyh6E=
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr9339151pjv.229.1616156194913;
 Fri, 19 Mar 2021 05:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210315092015.35396-1-songmuchun@bytedance.com>
 <20210315092015.35396-8-songmuchun@bytedance.com> <20210319085948.GA5695@linux>
In-Reply-To: <20210319085948.GA5695@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 19 Mar 2021 20:15:58 +0800
Message-ID: <CAMZfGtXAgcJQp59AVuieqLT+1Qb3RGQmFK-SGNZH-T6K83Y=HQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v19 7/8] mm: hugetlb: add a kernel
 parameter hugetlb_free_vmemmap
To:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 4:59 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Mar 15, 2021 at 05:20:14PM +0800, Muchun Song wrote:
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/gfp.h>
> >  #include <linux/kcore.h>
> >  #include <linux/bootmem_info.h>
> > +#include <linux/hugetlb.h>
> >
> >  #include <asm/processor.h>
> >  #include <asm/bios_ebda.h>
> > @@ -1557,7 +1558,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> >  {
> >       int err;
> >
> > -     if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> > +     if ((is_hugetlb_free_vmemmap_enabled()  && !altmap) ||
> > +         end - start < PAGES_PER_SECTION * sizeof(struct page))
> >               err = vmemmap_populate_basepages(start, end, node, NULL);
> >       else if (boot_cpu_has(X86_FEATURE_PSE))
> >               err = vmemmap_populate_hugepages(start, end, node, altmap);
>
> I've been thinking about this some more.
>
> Assume you opt-in the hugetlb-vmemmap feature, and assume you pass a valid altmap
> to vmemmap_populate.
> This will lead to use populating the vmemmap array with hugepages.

Right.

>
> What if then, a HugeTLB gets allocated and falls within that memory range (backed
> by hugetpages)?

I am not sure whether we can allocate the HugeTLB pages from there.
Will only device memory pass a valid altmap parameter to
vmemmap_populate()? If yes, can we allocate HugeTLB pages from
device memory? Sorry, I am not an expert on this.


> AFAIK, this will get us in trouble as currently the code can only operate on memory
> backed by PAGE_SIZE pages, right?
>
> I cannot remember, but I do not think nothing prevents that from happening?
> Am I missing anything?

Maybe David H is more familiar with this.

Hi David,

Do you have some suggestions on this?

Thanks.


>
> --
> Oscar Salvador
> SUSE L3
