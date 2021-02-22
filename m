Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754DB321434
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 11:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhBVKcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 05:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhBVKc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:32:29 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBDAC061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 02:31:49 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k22so7462045pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 02:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UWh8jduGRGu0Lvsdl9eBlyqHKjBe0P0nAH4NaZ9DMc=;
        b=CJhQTg5ewgzZcnE2MhOHrzTbe0C5iEgOrytZGTuvGqjQI+Uw34/pbKAhYfv55ZbEQ+
         3k1GnYlHjK3NlkzleMwne0BnkjHisb1fCE5MYMfn2irYh+FIKK5ZeBhC1r/gr4ou+UsQ
         9C2upnSbHxCxznvPzFE1kIpgGUj7irS2BkklgdS3tSc5tHC4pXnPdWSCPGnbaaJGIjZk
         z/n8oOfCDpuoEI15EjK00iptRmFy5EsufKXUlVyopdACbYxxWNCbmWSqyS0QQZL39Rj/
         K04D7A6saCRLnu+QLw3fVe/ammJfGSl6OwbFU82JpozB+uMI0V6xEqmTjXu8gGmgwe8c
         P3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UWh8jduGRGu0Lvsdl9eBlyqHKjBe0P0nAH4NaZ9DMc=;
        b=kXuHirvNOxdykcbpU3eveiOBmQCcw9GvWZYzR7IuyCl+aqYoB937HrwJdyOA8rsKZz
         OQleVLfDIIEk6fdMMKtjzVptESsaELPOjKI38MLSKfg9dTisVfj94kMBdRAxTkV6hpzK
         DVNMoYCc1T1+bbVtlhPTu+XufGCPWqQb6zhzvZ+ELb4hjI/EQqyorJPWidtNIEAghmWy
         VOO4YqN/qVrUSHQuA4YyLn6p0klwSHXR9B6kN4yhLp2DLMRWn3CMCfuRor6ikkkqv+Ma
         x7JNkIpLIpqcOsPVNmCBj0Gl5+KQWrDsfdqFwLc39qntCboTkU6RdXM+iuGXYcZU+AGk
         GuRg==
X-Gm-Message-State: AOAM531tXoGPpdtAJp6wb89mUVxpTS0VflyMOx8SW/pFL6dFX19TKXZR
        p3Qljh/0mFl+ZDd/qsEd8y3cAiWdkfIng/sjPqcj/g==
X-Google-Smtp-Source: ABdhPJxeUlmz8zPz9b/j2QjskVoGdhyZlrSI7oyLSmQ0kLy48DqKvUv7uDS1x5dDFWskiPN5ixGvTOLh0b8L9NlGn5M=
X-Received: by 2002:a17:90a:f18d:: with SMTP id bv13mr1625214pjb.13.1613989908932;
 Mon, 22 Feb 2021 02:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com> <YC/HRTq1MRaDWn7O@dhcp22.suse.cz>
 <CAMZfGtW-j=WizTckEWZNB2OSPkz662Vjr79Fb0he9tMD+bnT3Q@mail.gmail.com> <YDN4hhhINcn69CeV@dhcp22.suse.cz>
In-Reply-To: <YDN4hhhINcn69CeV@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 22 Feb 2021 18:31:12 +0800
Message-ID: <CAMZfGtWt3uYcCv5htRkOncJnh=4eiGXzpKsV7-Gj40m-BXcUrw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v16 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 5:25 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Sat 20-02-21 12:20:36, Muchun Song wrote:
> > On Fri, Feb 19, 2021 at 10:12 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > What about hugetlb page poisoning on HW failure (resp. soft offlining)?
> >
> > If the HW poisoned hugetlb page failed to be dissolved, the page
> > will go back to the free list with PG_HWPoison set. But the page
> > will not be used, because we will check whether the page is HW
> > poisoned when it is dequeued from the free list. If so, we will skip
> > this page.
>
> Can this lead to an under provisioned pool then? Or is there a new
> hugetlb allocated to replace the poisoned one?

Actually, no page will be allocated. Your concern is right. But without
this patch, the result does not change. e.g. The HW poisoned page
can fail to be dissolved when h->free_huge_pages is equal to
h->resv_huge_pages. But no one seems to have reported this issue so
far. Maybe this behavior needs improvement in the feature.

>
> --
> Michal Hocko
> SUSE Labs
