Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913EB30FA66
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbhBDR4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbhBDR4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:56:17 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A93C061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 09:55:37 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id c18so4453713ljd.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=voNiwPhzeLAZNHX2oRQL59Hxy42wWXI9DL6jmHv2mf0=;
        b=NUI9thqKSFpWLW3nPn6698yvI2J++NtLklBNQ+xHDuLU0hK9vHDTLtOsI88z5efBKG
         8uCbzqHIDFL7NCjPcpmxpKuVrzdrJkALf3jaBFQky7nr8k1jo5+j5RhC3jzu3Fehs4lq
         k6G5sz9oPMVP3kBQajQ0ZaZP5M53dDdKmwQsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voNiwPhzeLAZNHX2oRQL59Hxy42wWXI9DL6jmHv2mf0=;
        b=cxwOn7Pwkm12ZVRVaGZINTjeQuKT6YjbMl2ViOj+7Aqj8CBd5HQ16AGDR+/UnFwmwS
         raFUMuDMouhqk/caBKr6qT+eydiuXv9L8jz6LS6mMvnbrmrtL12GLEk77c42LBSi1k5A
         7FlllxoMq5y06XiocvrnaSPItr3tWGdlMqznFVdhe8WRc0M/2FejtwL67iOqdUdgN8On
         3sutZN603WrQLrmRJavx72NmOls3vhkRSNKRFIK1XINSTzVGSXT3mAnPmM8ccZAdgbAn
         Lvi5e/NRAreavsoKReCnRHHcgHvqjV+OEerJcf280g0atsbNvFMbZLq71lbPtH/J8BWV
         Z+ZQ==
X-Gm-Message-State: AOAM532SBfk+uirlTDdObtetEkSo2XYuFQyNkWyIOpzgWcMoDs6RmcZ4
        LDZva8L8IHID0JSFhzSWJgYHOs8ebqhkfw==
X-Google-Smtp-Source: ABdhPJygUNpsYU/NRJ4SGfuixwUQ99mNQeRWAjEhWVXkz2oGz+pumeC0kMgsBO24+fRkgIHSujw/xw==
X-Received: by 2002:a2e:2ac4:: with SMTP id q187mr301709ljq.151.1612461335040;
        Thu, 04 Feb 2021 09:55:35 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id x144sm694590lff.89.2021.02.04.09.55.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 09:55:33 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id i187so5863244lfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:55:33 -0800 (PST)
X-Received: by 2002:a19:8186:: with SMTP id c128mr273214lfd.377.1612461332734;
 Thu, 04 Feb 2021 09:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20210204145033.136755-1-peterx@redhat.com> <20210204145033.136755-4-peterx@redhat.com>
In-Reply-To: <20210204145033.136755-4-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Feb 2021 09:54:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiP8fB7R70h5MqDUFu2=nVHytsrdDKmQHmQTeYbyhifrA@mail.gmail.com>
Message-ID: <CAHk-=wiP8fB7R70h5MqDUFu2=nVHytsrdDKmQHmQTeYbyhifrA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm: Introduce page_needs_cow_for_dma() for
 deciding whether cow
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        Wei Zhang <wzam@amazon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Gal Pressman <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 6:50 AM Peter Xu <peterx@redhat.com> wrote:
>
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1291,6 +1291,27 @@ static inline bool page_maybe_dma_pinned(struct page *page)
>                 GUP_PIN_COUNTING_BIAS;
>  }
>
> +static inline bool is_cow_mapping(vm_flags_t flags)
> +{
> +       return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> +}

Oh, and I just realized: moving this to <linux/mm.h> means that this
patch could/should also get rid of

 - manual copy of this in mm/hugetlb.c:

        cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;

 - private #define for the same thing in fs/proc/task_mmu.c

    #define is_cow_mapping(flags) (((flags) & (VM_SHARED |
VM_MAYWRITE)) == VM_MAYWRITE)

 - manual copy in drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c:

        bool is_cow_mapping =
                (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;

I guess it could be a later cleanup patch too, but maybe best done in
this series just to not forget about it.

               Linus
