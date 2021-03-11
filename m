Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD91336E97
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhCKJOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhCKJNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:13:50 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26703C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:13:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bt4so3144163pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1cMUuEgpKnm2GTf/raAO249wZsBDF+ILTqGlU7qKVk=;
        b=L7VtFArDpP7/Z4xW7M5SjIdpJsgwfDjg0ysqTp59ew+B31AX8Ig7qvdpOulPS8nVu2
         36s8kiciJuowre0qzGM49k87QlAaTvG1WmBZXZ/JaJMk3j8ll7Sue50VU7/uU/Ps217V
         MRlqmFuaX90C9lrc7Yk1jCxDVhEmgzn20lXLPRLf7Xnx9uDU+l+JMSO5HO55TkhSw6rJ
         HOlpduy43kf2+CXFzkbmlStjEz/ipIl6keCHd4azd9eV8jV25EOTpAc43oGebDww8+MW
         MCMMkt0KfgEotwnlaXaV9RybCFJsTyj2CIijAWGJnDJi4FDx2Di+YP2xfANJNLyzHVts
         nkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1cMUuEgpKnm2GTf/raAO249wZsBDF+ILTqGlU7qKVk=;
        b=fLtunpsOTekkfCLljy2NPG9vFzi6fSbrBA+B+hEaaoRvVUOxao4RRJiVZjR+A/gjse
         CmR61UB3obyZ40+M2V8Sj5n8vyhTSLByg541iQb/6b4MrJ9qa3u5UoIgdi7kXldXboNs
         p9OtSJzcu58eNZbBLIHwQ/kXTyZfh6+Fmh3fu0xYWGD/MsV6cD/C0wp3EHpR1DsYuQVC
         cPWe2erXn1qQVnPRgKPlCaFFyOfY5iNEQ/wKZyDAGW6lv3BJxNZgy2ZNXPf1n0uh2ydd
         BtRfHEYorMd7JUGGiRN5PhcoFCK7gDkAHZVe1xmAgKiUZz1HMHKPKjVwYrykJOvpHKro
         GgOA==
X-Gm-Message-State: AOAM530ntHlNP2rjUcpEH+HGO03zin/DlrEMWr68E1bvnO0qP8eWufJP
        yu+C52nubPapwWH6va538JSCltIE1bRlebvvrvJ64g==
X-Google-Smtp-Source: ABdhPJzsOK4kYPzWPl16KRujaNua+UCtyCBGX0TLmBMMt/QSKW2CamsgjBDeE/g4i+ArqAX0lsPzgIsJr2C6Y8UwQe8=
X-Received: by 2002:a17:90a:f008:: with SMTP id bt8mr8141746pjb.13.1615454029628;
 Thu, 11 Mar 2021 01:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-6-songmuchun@bytedance.com> <YEjlf/yV+hz+NksO@dhcp22.suse.cz>
 <CAMZfGtX28p-42bMCuddsYfE0AWpDbWUoLY32+4vn8L5nptNxqw@mail.gmail.com> <YEnZ0lR/sycBrRIn@dhcp22.suse.cz>
In-Reply-To: <YEnZ0lR/sycBrRIn@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 17:13:12 +0800
Message-ID: <CAMZfGtUwB=RtW=5ft5QRAOHmPQ4PNm+MQpua11CoAj4u5pWV7g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v18 5/9] mm: hugetlb: set the PageHWPoison
 to the raw error page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 4:50 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 11-03-21 14:34:04, Muchun Song wrote:
> > On Wed, Mar 10, 2021 at 11:28 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 08-03-21 18:28:03, Muchun Song wrote:
> > > > Because we reuse the first tail vmemmap page frame and remap it
> > > > with read-only, we cannot set the PageHWPosion on some tail pages.
> > > > So we can use the head[4].private (There are at least 128 struct
> > > > page structures associated with the optimized HugeTLB page, so
> > > > using head[4].private is safe) to record the real error page index
> > > > and set the raw error page PageHWPoison later.
> > >
> > > Can we have more poisoned tail pages? Also who does consume that index
> > > and set the HWPoison on the proper tail page?
> >
> > Good point. I look at the routine of memory failure closely.
> > If we do not clear the HWPoison of the head page, we cannot
> > poison another tail page.
> >
> > So we should not set the destructor of the huge page from
> > HUGETLB_PAGE_DTOR to NULL_COMPOUND_DTOR
> > before calling alloc_huge_page_vmemmap(). In this case,
> > the below check of PageHuge() always returns true.
> >
> > I need to fix this in the previous patch.
> >
> > memory_failure()
> >     if (PageHuge(page))
> >         memory_failure_hugetlb()
> >             head = compound_head(page)
> >             if (TestSetPageHWPoison(head))
> >                 return
>
> I have to say that I am not fully familiar with hwpoisoning code
> (especially after recent changes) but IIRC it does rely on hugetlb page
> dissolving. With the new code this operation can fail which is a new
> situation. Unless I am misunderstanding this can lead to a lost memory
> failure operation on other tail pages.
>
> Anyway the above answers the question why a single slot is sufficient so
> it would be great to mention that in a changelog along with the caveat
> that some pages might miss their poisoning.

OK. I will update the changelog. Thanks for your suggestions.

> --
> Michal Hocko
> SUSE Labs
