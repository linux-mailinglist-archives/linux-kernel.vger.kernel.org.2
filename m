Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9863831E478
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBRDWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhBRDWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:22:08 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E28C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:21:28 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o38so279102pgm.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/0vhCGqZobTKO2GQ0rt7p/n6rY/SemZLd3m5aOtodk=;
        b=h0gF7phehAUTclXF2zVnETIMlzuvMwmxARNGTmSM+Z0oVQYO2ZiGZ2fYxXloP2Wefh
         eiFU1xGX9kzQClc5v/M9WK0hNnnUqV0LyJGnrM8CzOjgpNV99bETQEgTAjASLw8UUsTm
         7JiiIHk0V9YyIGAB2M3VOgjQepP4J2CXidVZff4FJM6FxMd1z2pxQqeMnzD/HuEBa9/A
         kZ2C8tVLrZYZxOjlQu9VqndlyWQ31DJOOqrDu2CoKFAYdbvpPEXHWnulixaCWAAtcPAg
         V4HdAWwV+x2JqXpy6poASde1FyRVpl0+/R/rAU1MkQSZ36vNLcmAqbB9Kgg+p5VWSCk4
         nb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/0vhCGqZobTKO2GQ0rt7p/n6rY/SemZLd3m5aOtodk=;
        b=Xe2qIjE8dxPdtF1tYjzPOZO5KRUC5BQ/c05U+UfkJhCT1lgB65ZRkrhLC8lWOpYBe+
         wYHruYJBFPsag/44ZTEkIzUK0Ppo6rxxQSJI1jweU9S150AZqO7RFwNYO6UOUNYpk2qo
         8ujtv+mnqm0p4Wg/n0bBG3Te7blEGFMw1Azx0G2wi4ORIhtH8jMWQXg4d4RdXEuNWo+M
         x69Vk0xWTdmWwSDovx5hcBFJwh6t07KnVxu61Abntb5N0I7evCuBJHio2WMDTsRoEywx
         53c2Z36eS3VtdhXWkwRH9CwDAuv+pQRCkj0CmmywzAD6f+ozrwYDx7Ko8G6E/cg2UPa5
         aF6A==
X-Gm-Message-State: AOAM53206U1CjCJmjSjk6C+9jWhzF5i8rs9AaY20ufleDh+Jk/mt5QG1
        nx6DJ1wlzFRZoEQoos3tx+kQg9Xn7hjEJOQ+DeGNfQ==
X-Google-Smtp-Source: ABdhPJxemWnjMzG9prnGjQpuiQZv7eNL3cXQ1QRp1RDJ+Dv1Mmwfo7xhdP96xrBLDow3RIJUpuVpgB3LqTBT3h+jY5Y=
X-Received: by 2002:aa7:9790:0:b029:1d8:263e:cc9b with SMTP id
 o16-20020aa797900000b02901d8263ecc9bmr2488898pfp.2.1613618487969; Wed, 17 Feb
 2021 19:21:27 -0800 (PST)
MIME-Version: 1.0
References: <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz> <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz> <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz> <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz> <29cdbd0f-dbc2-1a72-15b7-55f81000fa9e@oracle.com>
 <YCzQJIeI+dj9vphw@dhcp22.suse.cz> <f956c39a-6043-6d0e-9f4c-6013f54c2768@oracle.com>
In-Reply-To: <f956c39a-6043-6d0e-9f4c-6013f54c2768@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 18 Feb 2021 11:20:51 +0800
Message-ID: <CAMZfGtWVSWN0dL+2Dm=7bPSNFyomTQYEijCdd_ThXvArsA04ug@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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

On Thu, Feb 18, 2021 at 9:00 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/17/21 12:13 AM, Michal Hocko wrote:
> > On Tue 16-02-21 11:44:34, Mike Kravetz wrote:
> > [...]
> >> If we are not going to do the allocations under the lock, then we will need
> >> to either preallocate or take the workqueue approach.
> >
> > We can still drop the lock temporarily right? As we already do before
> > calling destroy_compound_gigantic_page...
> >
>
> Yes we can.  I forgot about that.
>
> Actually, very little of what update_and_free_page does needs to be done
> under the lock.  Perhaps, just decrementing the global count and clearing
> the destructor so PageHuge() is no longer true.

Right. I have another question about using GFP flags. Michal
suggested using GFP_KERNEL instead of GFP_ATOMIC to
save reserve memory. From your last email, you suggested
using non-blocking allocation GFP flags (perhaps GFP_NOWAIT).

Hi Mike and Michal,

What is the consensus we finally reached? Thanks.
