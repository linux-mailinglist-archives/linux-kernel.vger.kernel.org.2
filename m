Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95A330FCC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbhBDT2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:28:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239788AbhBDT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612466761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mrXfoleW43Kru8LZe88JDUmZYGkv58CStfALhpAxQ7A=;
        b=hO3G73cpXbqGDHSkgTfQ0K13lGrlA0yLr5XZQNNZZSMcbFRF+he5CHXm3PGAUGFyP64HlT
        ZiRgLK/yoKrPXRnZJ+BelF9u45onCdqdixLN7TquLDpCG94B8WzRUgJnLYNLZ0NuqI48sO
        jZkoMBEt7HA36G97/N6E9XCeRUKkVRA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-Zjkbz4aQN7u4-doRSysf4g-1; Thu, 04 Feb 2021 14:25:59 -0500
X-MC-Unique: Zjkbz4aQN7u4-doRSysf4g-1
Received: by mail-qt1-f199.google.com with SMTP id g14so3401628qtu.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 11:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mrXfoleW43Kru8LZe88JDUmZYGkv58CStfALhpAxQ7A=;
        b=OjGSxI65T+poQtsYFcxb2tpRLgtRbFplw8ebCNZOY+KYZvlN42QMnq39KVN3FFe/+c
         CyiZwq15Z0hZeAp7PPMWXhgDTXVDuAQdIUG3htsQmAAR4LvS5HdeTN5xIZdfAXqboBs3
         iCllmJ09rmMZlxG7t2DH0SDA3u2A0rDE8GTSFLhSBXPMwz03GnnF3Zbxzvd8vYVTwfU6
         OA0P25kJliybDBGElpXleRwlHRdjA/IEdwuLs2jn8G+63cdJIYuLH6ajFhheUJBDQpVD
         8XmGlOuUlByGpc5oMVAToANCcQ9rKKbwM8BQlDrVFkwaPEvTejIBHmbIT1bGnwLqjIoj
         zn6w==
X-Gm-Message-State: AOAM533rqY3uGpiuqwvBooO3Ewi1goPSLt6rIAPVY2P5qHo/mwhdP3WT
        iJZ+Ef3pefoH9kOZs9Amw++7TKD44e0a6RBN/ysn1RfQA4L+TF7CuTNPA1EQnitF4aWlW1Hr2/g
        Wp3+B0zJhQNk9wk1ornhwYI9g
X-Received: by 2002:aed:2de2:: with SMTP id i89mr1096079qtd.73.1612466759079;
        Thu, 04 Feb 2021 11:25:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHBPmrMI4hBIdREL5/gfYUdIIDOO1gtkcvtCDlpRQ5P2X9TDlkWmpE0XGg3RPocO3JRdxpyA==
X-Received: by 2002:aed:2de2:: with SMTP id i89mr1096067qtd.73.1612466758892;
        Thu, 04 Feb 2021 11:25:58 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 2sm5165227qtt.24.2021.02.04.11.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:25:58 -0800 (PST)
Date:   Thu, 4 Feb 2021 14:25:56 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [PATCH v2 3/4] mm: Introduce page_needs_cow_for_dma() for
 deciding whether cow
Message-ID: <20210204192556.GT6468@xz-x1>
References: <20210204145033.136755-1-peterx@redhat.com>
 <20210204145033.136755-4-peterx@redhat.com>
 <CAHk-=wiP8fB7R70h5MqDUFu2=nVHytsrdDKmQHmQTeYbyhifrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiP8fB7R70h5MqDUFu2=nVHytsrdDKmQHmQTeYbyhifrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:54:37AM -0800, Linus Torvalds wrote:
> On Thu, Feb 4, 2021 at 6:50 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1291,6 +1291,27 @@ static inline bool page_maybe_dma_pinned(struct page *page)
> >                 GUP_PIN_COUNTING_BIAS;
> >  }
> >
> > +static inline bool is_cow_mapping(vm_flags_t flags)
> > +{
> > +       return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> > +}
> 
> Oh, and I just realized: moving this to <linux/mm.h> means that this
> patch could/should also get rid of
> 
>  - manual copy of this in mm/hugetlb.c:
> 
>         cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> 
>  - private #define for the same thing in fs/proc/task_mmu.c
> 
>     #define is_cow_mapping(flags) (((flags) & (VM_SHARED |
> VM_MAYWRITE)) == VM_MAYWRITE)
> 
>  - manual copy in drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c:
> 
>         bool is_cow_mapping =
>                 (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> 
> I guess it could be a later cleanup patch too, but maybe best done in
> this series just to not forget about it.

Will do in v3 if there is.  Or I'll post a standalone patch to not disturb Gal
just in case he's kicked a test.  Thanks,

-- 
Peter Xu

