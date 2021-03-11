Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D89336E80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhCKJJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhCKJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:09:13 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43315C061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:09:13 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id x29so13279468pgk.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mCTW04T6FDAWe0y3Y8uvQz02hfd4dMHzD/jXKV5ni0E=;
        b=Y/r8l2GZWPIzxtFqFbqp+HB+jA7JeWZF1hQD73NXfYnjF7SBJAfx7VeoK/MbgtuJ+U
         /nBBJotqN2Mf403kEiXPK8qB0HtHD4oVOQdAxqrVeKM/nu+s/VuXYV2gBCN4W6HX8uUd
         vrlV2K+JzGTmxQ8VNsMRMYR0xV1FySxGdV/tAsHBP6a9Xyqf59Dr/rvMS/pCQ+oMIKrm
         id/jvwgp6/1c/a6VOGgI7xfYp90v/9KaF9LCFSevI00Yja48jSe7n/pfx2xds0CdvsS8
         VdmbKG4CLJuM6nK+lyVt5r5YTVtHvHQzI+p8VOlhWeuwc9FCEFFJLYVMrFQUcSzY1eiQ
         0vrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCTW04T6FDAWe0y3Y8uvQz02hfd4dMHzD/jXKV5ni0E=;
        b=L0TQbXfZ/oAwta2oEyqyrg6pMDGgLGnnTr0rtJD5Vv0EGTYu1pU6XTW3IFIas2tzIQ
         JvNV4Re5L5gUO38sBaPebMO6XOrs/sp4m19CLfC+eYWPlrDQOgBu0hdQtSeX9Uo1vgjd
         XFG/QMKe0yB160rw1bO7JLYS5oZprSjC0tIZCSMsiE0seH0mLYic3WEbMPDNhXJNrleY
         4MqzsMSVDSP6N2ygYGGBM8XAQwj7Q+jF+F8Oj2vRM+zxjXU2sNfyLabs3r5G+QpH0tGa
         IqYazYjpD7XocakSvWj0A7pmdR4uhQlqYAt4SaJtCjXEZO/TwyjfKdSzeTNLspPptYwz
         CJiA==
X-Gm-Message-State: AOAM533n9wzdoHyAeFPiRqARZuVNsYLg+3nlaLJ7Sb7XvKmBJ/HcvdaA
        k6ZG9ohnQkPjn/Ui2OWvOcmYwMTJSyUoMa4rDgVaTA==
X-Google-Smtp-Source: ABdhPJy8F/wYop3dZx7C28eOxSytt+4LbTA89Xyq6VmeWP+d2mbk9yMNhz3RbMDYqCmWI6x0q8mz5dNpU7Fue42Xc3E=
X-Received: by 2002:aa7:910c:0:b029:1ed:ef1:81b with SMTP id
 12-20020aa7910c0000b02901ed0ef1081bmr6861804pfh.49.1615453752720; Thu, 11 Mar
 2021 01:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-10-songmuchun@bytedance.com> <YEjoozshsvKeMAAu@dhcp22.suse.cz>
 <CAMZfGtV1Fp1RiQ64c9RrMmZ+=EwjGRHjwL8Wx3Q0YRWbbKF6xg@mail.gmail.com> <YEnbBPviwU6N2RzK@dhcp22.suse.cz>
In-Reply-To: <YEnbBPviwU6N2RzK@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 17:08:34 +0800
Message-ID: <CAMZfGtW5uHYiA_1an3W-jEmemsoN3Org7JwieeE2V271wh9X-A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v18 9/9] mm: hugetlb: optimize the code
 with the help of the compiler
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
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 4:55 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 11-03-21 15:33:20, Muchun Song wrote:
> > On Wed, Mar 10, 2021 at 11:41 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 08-03-21 18:28:07, Muchun Song wrote:
> > > > When the "struct page size" crosses page boundaries we cannot
> > > > make use of this feature. Let free_vmemmap_pages_per_hpage()
> > > > return zero if that is the case, most of the functions can be
> > > > optimized away.
> > >
> > > I am confused. Don't you check for this in early_hugetlb_free_vmemmap_param already?
> >
> > Right.
> >
> > > Why do we need any runtime checks?
> >
> > If the size of the struct page is not power of 2, compiler can think
> > is_hugetlb_free_vmemmap_enabled() always return false. So
> > the code snippet of this user can be optimized away.
> >
> > E.g.
> >
> > if (is_hugetlb_free_vmemmap_enabled())
> >         /* do something */
> >
> > The compiler can drop "/* do something */" directly, because
> > it knows is_hugetlb_free_vmemmap_enabled() always returns
> > false.
>
> OK, so this is a micro-optimization to generate a better code?

Right.

> Is this measurable to warrant more code?

I have disassembled the code to confirm this behavior.
I know this is not the hot path. But it actually can decrease
the code size.

Thanks.

> --
> Michal Hocko
> SUSE Labs
