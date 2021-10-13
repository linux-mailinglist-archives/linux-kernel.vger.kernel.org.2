Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1152B42B360
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbhJMD06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:26:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232807AbhJMD0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634095483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFq4tl1Jtp9nZpYEWOSTL46F9/L19MeOCUXgfSE6NU8=;
        b=jNyhX2GiQ2Ct3miGwupbtBRY9jTavEeBgpr9M3l2Vv3VtOvAwlEJogC5ysuEPeigI5ZPIv
        hamucwrK4rflA6DK68p7ZXHk7K2L8QAdMCUGmJxD1UYlDvM3f+WYfvcxdaiSKZYMSgppcu
        AM9sJSRZUbwngRUjbakbwacaDuASgpQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-7-khu9DWPjyBp53M1-aU2g-1; Tue, 12 Oct 2021 23:24:41 -0400
X-MC-Unique: 7-khu9DWPjyBp53M1-aU2g-1
Received: by mail-pg1-f199.google.com with SMTP id e6-20020a637446000000b002993ba24bbaso678948pgn.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VFq4tl1Jtp9nZpYEWOSTL46F9/L19MeOCUXgfSE6NU8=;
        b=H70XX/r7alINgh0UjW1YoTOk07ASEjmrkd3e+C94JrzFSp37/YuKGXkW1y2fNfIMFy
         dSSSZjboOT0cBnD1k4dkhKl+5SVgAmlX9ra+gcdqHmq4bKuzQifNxvYaTEi50zoCqgXu
         SB9HRFr8Ao7VUZQ0QPTczclAaKuS08TJvhVQVQZeZz9ESt0Fccp4NuoscBfWBv/T4NtX
         MPQhURIPp5EORmb7edXiGIg1+J53ebKkaKLnwL7pEmbsG7XL9BRaI36aDUu2Q1Yd6Dgy
         erqC0VHagQfEEnMq0vX2kJRCRVoT9ur+6XcJz5n5DEhsmYWDMqWAp2zyCqkmhttBFPkE
         ybGQ==
X-Gm-Message-State: AOAM531CbHiuvwlaGUhnULc+zClGq0VwuLi/7yobo7nmT72YFzxpmQwl
        2PcXSvJHCsU6GTET+I2UoD5zr0BlpYus4ZOjh4lKSQ7haTrN2V8kEt0+Y9K5qqFWen+manJ9a/p
        2Yls5n6uIHcno59DhiwO+KcrX
X-Received: by 2002:a17:90a:b117:: with SMTP id z23mr10654013pjq.74.1634095479006;
        Tue, 12 Oct 2021 20:24:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqVEIIX54ViTr9Fl25b2c2NyWmZugh7YneAkuuQyUA0cMR8iCPtZCAXhwzLevCG02Mzub8mg==
X-Received: by 2002:a17:90a:b117:: with SMTP id z23mr10653986pjq.74.1634095478670;
        Tue, 12 Oct 2021 20:24:38 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j6sm12530899pgq.0.2021.10.12.20.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 20:24:38 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:24:31 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 PATCH 0/5] Solve silent data loss caused by poisoned
 page cache (shmem/tmpfs)
Message-ID: <YWZRb9Z4YIv95ieh@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <YWZHOYgFrMYbmNA/@t490s>
 <CAHbLzkoz6Gm31Qz-u_ohR6NK2RRE5OdEkSq_3t9Cjwkqf1+a7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkoz6Gm31Qz-u_ohR6NK2RRE5OdEkSq_3t9Cjwkqf1+a7w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 08:09:24PM -0700, Yang Shi wrote:
> On Tue, Oct 12, 2021 at 7:41 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Sep 30, 2021 at 02:53:06PM -0700, Yang Shi wrote:
> > > Yang Shi (5):
> > >       mm: hwpoison: remove the unnecessary THP check
> > >       mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
> > >       mm: hwpoison: refactor refcount check handling
> > >       mm: shmem: don't truncate page if memory failure happens
> > >       mm: hwpoison: handle non-anonymous THP correctly
> >
> > Today I just noticed one more thing: unpoison path has (unpoison_memory):
> >
> >         if (page_mapping(page)) {
> >                 unpoison_pr_info("Unpoison: the hwpoison page has non-NULL mapping %#lx\n",
> >                                  pfn, &unpoison_rs);
> >                 return 0;
> >         }
> >
> > I _think_ it was used to make sure we ignore page that was not successfully
> > poisoned/offlined before (for anonymous), so raising this question up on
> > whether we should make sure e.g. shmem hwpoisoned pages still can be unpoisoned
> > for debugging purposes.
> 
> Yes, not only mapping, the refcount check is not right if page cache
> page is kept in page cache instead of being truncated after this
> series. But actually unpoison has been broken since commit
> 0ed950d1f28142ccd9a9453c60df87853530d778 ("mm,hwpoison: make
> get_hwpoison_page() call get_any_page()"). And Naoya said in the
> commit "unpoison_memory() is also unchanged because it's broken and
> need thorough fixes (will be done later)."
> 
> I do have some fixes in my tree to unblock tests and fix unpoison for
> this series (just make it work for testing). Naoya may have some ideas
> in mind and it is just a debugging feature so I don't think it must be
> fixed in this series. It could be done later. I could add a TODO
> section in the cover letter to make this more clear.

I see, that sounds good enough to me.  Thanks,

-- 
Peter Xu

