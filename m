Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BFD3A3A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 05:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhFKD04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 23:26:56 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:38521 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFKD0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 23:26:54 -0400
Received: by mail-pf1-f180.google.com with SMTP id z26so3301432pfj.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 20:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7AeKnAwYLMBGaOYXVe0aYJA8bYJeJ8yHr06kQ7H8lQk=;
        b=z1JaIyy3oBxQ0LvjmKJujrq4DLvCIXj/kORRhsaXg4FQ8DyRctogXMzDi8qjXDfQX5
         IKsP3vuoBpAqtIx3s5bdvnzUpIeeRRCbXmx3P8ROeTxD7Dj/Jsy/Avdbww6VSx59/K8D
         iUPh4Py7w8IqPQcntjuuQaevgG3LPszKolcGImKdWcGlHAGZvrh9vJi6CKUQyWfJ1Yyd
         PU0ZfLbagM3GP8lnH/ORNOcrYGlxxaQVN8yeSkskSY/x04RGUCBjKjf8uLNop7r5Cuvd
         VoonSIU6JwPPUN4NZcJsNZkFcvSQA0jSfJz5BDjQV9nO4B+v1YUvTluAk8VZv0XVnw1r
         n8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AeKnAwYLMBGaOYXVe0aYJA8bYJeJ8yHr06kQ7H8lQk=;
        b=YL8/rrLOtS2no3l05UkG2R2jQmrP9TXF4Q4BFuKRHCz+VHC2rcFydrAY8sUvD+OZXJ
         YMj5kAK4PBnGZOwSZA0+3VToKYQmjLkBqt4fmCafQUPMGdWbAkRtOVlaya5mUR/ULncQ
         hXKhH9B8FVK1eszcKl4Bq66PbKW28LyTQHWVMHBlPpn6SDehVKQxgchlqeHNPsbyrcKl
         Yy/cYKODPlvW0IQZcFoKOlAmgCyoXbE3eYj/HA8pVJKaQUIUbwqkCMkU4e6YumHwlLUl
         MQjxI7rJjPN0Kcp8/FHGAF/B16+22EH5CATOewPgkm+1GYRSs86XkRYSk0LDXZOqwn7C
         rh7w==
X-Gm-Message-State: AOAM532Aqzvwn2y/7FIr57HO2aI434Udy4+DnhvZbON7+WrFoXLgZ2XK
        cxrHyLBW4FKAx0x6BJ/qPLA90/uhyVyNicANmIVpXw==
X-Google-Smtp-Source: ABdhPJyG1SmyYhbDe27LGm31FcQiX4uFLQqmV5JyJlZX78C2tXhJbU2v24B9Q5YXghs5rIB++Fm1LCjVeqLZ1wrr7og=
X-Received: by 2002:a65:5288:: with SMTP id y8mr1489206pgp.31.1623381824894;
 Thu, 10 Jun 2021 20:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210609121310.62229-1-songmuchun@bytedance.com> <d4fa211e-e896-e1da-017e-dafd120d3583@oracle.com>
In-Reply-To: <d4fa211e-e896-e1da-017e-dafd120d3583@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Jun 2021 11:23:07 +0800
Message-ID: <CAMZfGtW_oSv+Wz7ztwAdZfs2PVEsZtTmszD33vwQht=241CZPg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/5] Split huge PMD mapping of vmemmap pages
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 5:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 6/9/21 5:13 AM, Muchun Song wrote:
> > In order to reduce the difficulty of code review in series[1]. We disable
> > huge PMD mapping of vmemmap pages when that feature is enabled. In this
> > series, we do not disable huge PMD mapping of vmemmap pages anymore. We
> > will split huge PMD mapping when needed.
>
> Thank you Muchun!
>
> Adding this functionality should reduce the decisions a sys admin needs
> to make WRT vmemmap reduction for hugetlb pages.  There should be no
> downside to enabling vmemmap reduction as moving from PMD to PTE mapping
> happens 'on demand' as hugetlb pages are added to the pool.

Agree.

>
> I just want to clarify something for myself and possibly other
> reviewers.   At hugetlb page allocation time, we move to PTE mappings.
> When hugetlb pages are freed from the pool we do not attempt coalasce
> and move back to a PMD mapping.  Correct?  I am not suggesting we do
> this and I suspect it is much more complex.  Just want to make sure I
> understand the functionality of this series.

Totally right. Coalescing is very complex. So I do not do this in this
series.

>
> BTW - Just before you sent this series I had worked up a version of
> hugetlb page demote [2] with vmemmap optimizations.  That code will need
> to be reworked.  However, if we never coalesce and move back to PMD
> mappings it might make that effort easier.
>
> [2] https://lore.kernel.org/linux-mm/20210309001855.142453-1-mike.kravetz@oracle.com/

I've not looked at this deeply. I will go take a look.

Thanks Mike.

> --
> Mike Kravetz
