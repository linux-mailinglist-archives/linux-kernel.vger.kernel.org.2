Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C37D312560
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhBGPdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbhBGPdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612711895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9wMc0Nwk/ptxsKes013Q7zDZE4xfkXHgPlyBiz6rcU=;
        b=EhAwirGPejp9EjmurDdjRdMgu0trXKz2fRlCjNAo1FUJxvvfYr/p8pw9GGEAP1+8Vfpa60
        NGqWTwQRi0TUnNWZQYp4cLmQjXHD1ZX7bk5ELvq9YLKEWvSBdMH/bsgHFs+n/tZQC5h/pd
        RyfmxNUD3sZ16JoamOQ1tIXgxk30O38=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-EckW5evlMM-E10hnAxONmQ-1; Sun, 07 Feb 2021 10:31:34 -0500
X-MC-Unique: EckW5evlMM-E10hnAxONmQ-1
Received: by mail-qk1-f198.google.com with SMTP id r15so1297090qke.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 07:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O9wMc0Nwk/ptxsKes013Q7zDZE4xfkXHgPlyBiz6rcU=;
        b=MiTO6LcAEIlQVo2c6mFEDxi8e0tRp/homPDoW21FkbSeWY4pCVQzZt+c7c8T87uzBK
         hRpOtky76OVwtEjyIAHlHeN2BOS5UbEq1wvjLUHRXCCPCj4yxgO1dqbubVA21C0hzw0q
         cVhVmj+qHW/3H2whEGy7pETRy86ZhXFCGWRQV0OjIQBxAoOaXSScuPRJgqjVByggGqLj
         LB3JVw5OsUWSYvA9xHqJeTSZ3RueNc95L5dD/+9H2yTa+flh3QwpEI+LEIrWwTZaEFuR
         Wy4yAfU1g9wFAKN8jXfPairx0OGhdOOohJ4MTDQOH+OBMw3JSai/ileS27U4Yr3M/g/k
         uWYQ==
X-Gm-Message-State: AOAM531BBjlGSceMpM6/awItq0+UQ1DTIDfqO4vrZxSqD1ozfXoBatag
        GzBMxfqSWyXYfRwQUoet1BtBFbmO6MLIq3O/ylBUPIcvB/Yd5cR78Oy4RBK3hdCGiJILLydzkcp
        zZICQmf2qifdMk3p25yLKcix0
X-Received: by 2002:ad4:4f83:: with SMTP id em3mr12578854qvb.28.1612711893548;
        Sun, 07 Feb 2021 07:31:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZa3e25KJ1KDCo+IfZwNJ1A6Dcdg67juAmeKNVHXNzDBavVj6TePsRdVWpAD5Xav7+h5elSQ==
X-Received: by 2002:ad4:4f83:: with SMTP id em3mr12578837qvb.28.1612711893328;
        Sun, 07 Feb 2021 07:31:33 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id j124sm14143814qkf.113.2021.02.07.07.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:31:32 -0800 (PST)
Date:   Sun, 7 Feb 2021 10:31:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     "Zhang, Wei" <wzam@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/4] hugetlb: Do early cow when page pinned on src mm
Message-ID: <20210207153130.GH3195@xz-x1>
References: <20210204145033.136755-1-peterx@redhat.com>
 <20210204145033.136755-5-peterx@redhat.com>
 <329ADC08-552E-423B-9230-99643B81C14A@amazon.com>
 <20210205155114.GY6468@xz-x1>
 <10d5cdce-4748-1b9e-b433-6f3d1bde63db@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10d5cdce-4748-1b9e-b433-6f3d1bde63db@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 11:09:29AM +0200, Gal Pressman wrote:
> On 05/02/2021 17:51, Peter Xu wrote:
> > On Fri, Feb 05, 2021 at 02:58:33PM +0000, Zhang, Wei wrote:
> >> Hi Peter,
> > 
> > Hi, Wei,
> > 
> >>
> >> Gal and I worked together. We tested the patch v2 and can confirm it is working as intended.
> >>
> >> Thank you very much for your quick response!
> > 
> > My thanks too on the quick testing!  Sorry that I'll need to post v3; please
> > feel free to hold off the testing until I got some r-bs with the new version.
> 
> BTW, it might already be fixed in v3, but I encountered a compilation warning
> with this series:
> 
> mm/memory.c: In function ‘copy_present_page’:
> mm/memory.c:800:20: warning: unused variable ‘src_mm’ [-Wunused-variable]
>   struct mm_struct *src_mm = src_vma->vm_mm;
>                     ^~~~~~

Not yet, thanks for raising this, Gal.  I'll wait for some more review feedback
on v3 and send a new version with it fixed.

-- 
Peter Xu

