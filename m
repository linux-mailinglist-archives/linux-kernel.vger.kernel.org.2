Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F38336679E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbhDUJHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhDUJHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:07:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58CCC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h15so10455895pfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+iHXh65iVvo4np4Gau+UG0A6fVjF6OF4qe3iW5dlBQ=;
        b=cKRTNiweZv1CB+TmPXTHEuk/D3q6KRWbOYv26a5/nnRcbXbBa4sRinHzaZqlDw8IPK
         V26zl43Ll4ob/dxArZPWyA4qOpnJxPJk8DjZuABCkaNyS8O8ZsjefM98zQ/WDfNoXHjw
         I9Y4Jb7szrqvY1AsKwIGCc+RpKJHRvfXrbtzOpClqU2kr3qEvAJAWqK7aiwM4w7pEYAc
         N9/GDBfvk/vlEZcV/aayCTXvn5DmtTALGlTwJ2lRrwaZkNLn5ePUmFlVzUMAmu4Dvv9t
         LOWZ6CH+NAODFuCCxob1MO+H9YWAbW1/x6xFI+jX3V8c4KE39RF6vvG/gEqKUp5c5WK6
         f8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+iHXh65iVvo4np4Gau+UG0A6fVjF6OF4qe3iW5dlBQ=;
        b=BaTD40MuUC1nziaI5kjNvL2G+3yw2rgPDT58gScpUSYg++GsIACGo9s18waC3VPGGj
         U61ln2UkyVhk9At7M8gztU+KCHSuh+xOOODatCE6Ul30s2gX2zdP7IhH2dOSivInwdjw
         IRXqYBFUR9vO5wIrKCaA1GpcXL5L/b/mSEDjgN7IVe9U51UOH0Y1VHh0vW37VR+f/RtK
         T37PxVHYGBd0Wuf3kynhxTIckO3yzZ2+ZPBMn7AvJGueR+tQE24yjj0vAJA4LK5Kb/bJ
         Ica+3ACgzyrHwufomL2waaeb+DkxFZKdWAdRngqoa1fbuwlpSfedESYn7HRRAjJJ7nUl
         xBgw==
X-Gm-Message-State: AOAM533aE1l0cGr64jKZ/rjgJQtsAZa0csBtPU6pzNmIIIAdF/BMl/r9
        My/+obDc06E3pgI7Bp9DYfP8SnPQd/SGvIQaqHvkjQ==
X-Google-Smtp-Source: ABdhPJzKNN7n6cCYVH22d3weYBRKCJ+tLw5cB/f+qRUy/RycEPUVGIGD6d0QfahjlqPmJZLfex7L+sVrp7mhdjHX1iA=
X-Received: by 2002:a63:1665:: with SMTP id 37mr21367832pgw.31.1618996017511;
 Wed, 21 Apr 2021 02:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210415084005.25049-1-songmuchun@bytedance.com>
 <20210415084005.25049-9-songmuchun@bytedance.com> <YH6udU5rKmDcx5dY@localhost.localdomain>
 <CAMZfGtXmDhkCWateAR0q_EgRPDmGh_=D-6UuhMd+Si6=TDvghQ@mail.gmail.com> <20210421073346.GA22456@linux>
In-Reply-To: <20210421073346.GA22456@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 21 Apr 2021 17:06:20 +0800
Message-ID: <CAMZfGtWLkYPbz3F-QSNYLOgfwdcTA7iJxG6uvVLCoFtjaBt6nw@mail.gmail.com>
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

On Wed, Apr 21, 2021 at 3:33 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Apr 21, 2021 at 11:41:24AM +0800, Muchun Song wrote:
> > > Documentation/admin-guide/kernel-parameters.txt already provides an
> > > explanation on memory_hotplug.memmap_on_memory parameter that states
> > > that the feature cannot be enabled when using hugetlb-vmemmap
> > > optimization.
> > >
> > > Users can always check whether the feature is enabled via
> > > /sys/modules/memory_hotplug/parameters/memmap_on_memory.
>
> Heh, I realized this is not completely true.
> Users can check whether the feature is __enabled__ by checking the sys fs,
> but although it is enabled, it might not be effective.

Right. I have done the test.

>
> This might be due to a different number of reasons, vmemmap does not fully
> span a PMD, the size we want to add spans more than a single memory block, etc.

Agree. Thanks for your explanations.

>
> That is what
>
> "Note that even when enabled, there are a few cases where the feature is not
>  effective."
>
> is supposed to mean.
>
> Anyway, I did not change my opionion on this.
>
> Thanks
>
> --
> Oscar Salvador
> SUSE L3
