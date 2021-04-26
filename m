Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D7936BB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhDZWGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232062AbhDZWGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619474748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNz6ov6sR6/KHiccp2YcRtHEiY21v3dtvPylvMBzUpI=;
        b=aNc27O52RbZ8GaUTMyRXLKbL/SORpT82ZGsFGN0B96BENQLegSMAdKmRiXqdFAFbpsof0s
        ROKYB2yeCM6T4ltehCI5gir7ycI9Gj9k+pIU73EV6rPJMR778Zopj+loC8dgM0Sh5fHevj
        UWM7gzk4UGqPyPOu4LoTQyRbqUAK4zg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-jqWWdtpCPWGm9ZDRe0lFHw-1; Mon, 26 Apr 2021 18:05:46 -0400
X-MC-Unique: jqWWdtpCPWGm9ZDRe0lFHw-1
Received: by mail-qv1-f69.google.com with SMTP id l19-20020a0ce5130000b02901b6795e3304so4939563qvm.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNz6ov6sR6/KHiccp2YcRtHEiY21v3dtvPylvMBzUpI=;
        b=Rc10zVsyYpicdSVNeywpgPUO0twIopXA0GvrxImKNqK6E+9tH4ayNI8KSMTpNbTy2A
         9N3FCnhnOXcwvgl0klRJfQ4Q1vbTt3JElSpP2EGdG56lVY8E5fCGm5mNIU7pf6pb5x26
         At7YdZop2wTxo0qd7FkP4Vkp1eLEQKltVsJs2ai6fciEhzNF+NKkm+/g6wiyfCxD+EdU
         opH4UKe2r3bSjYpjHLGqxFaMMpya+xzjgzp/Oykr5OTpIfUM67EkGAlY3RBochG0QoYR
         q/MR86WeksuyQ+enwtSE4F4959lcIU8whCt5HMpR5u3mA8dev30XqSCTGdTbStKoeDBd
         hM5Q==
X-Gm-Message-State: AOAM5318CnkufkKoDSMlU+NJbyU4FVfJ9/XZQlIOsovva0I8x2I/BtYf
        osiNDrUvgPx2jdaaRyqSzUgyJg7Ox8AkzeQ/lnIv5WtUG56SYnblbusGy5Vuq9QDtBSJSJNPupr
        cHCWmzq50jvWLFXyoX6HYKhZF
X-Received: by 2002:a05:620a:381:: with SMTP id q1mr4671854qkm.243.1619474746217;
        Mon, 26 Apr 2021 15:05:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfRg6ZdHzZYp29cQrm8zjslzvqyrib4coyP0WvWgvrmyIeJ84DHKeppnD4vpeUTW9kG7tEBQ==
X-Received: by 2002:a05:620a:381:: with SMTP id q1mr4671836qkm.243.1619474745960;
        Mon, 26 Apr 2021 15:05:45 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id 203sm1377590qki.11.2021.04.26.15.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 15:05:45 -0700 (PDT)
Date:   Mon, 26 Apr 2021 18:05:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 21/23] hugetlb/userfaultfd: Only drop uffd-wp special pte
 if required
Message-ID: <20210426220544.GI85002@xz-x1>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323005054.35973-1-peterx@redhat.com>
 <02712955-0552-f82a-0ab8-460d63af3519@oracle.com>
 <20210426211653.GH85002@xz-x1>
 <1419a8cb-1028-31e8-bae7-4caf79819f02@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1419a8cb-1028-31e8-bae7-4caf79819f02@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 02:36:26PM -0700, Mike Kravetz wrote:
> On 4/26/21 2:16 PM, Peter Xu wrote:
> > On Fri, Apr 23, 2021 at 01:33:08PM -0700, Mike Kravetz wrote:
> >> On 3/22/21 5:50 PM, Peter Xu wrote:
> >>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> >>> index 92710600596e..4047fa042782 100644
> >>> --- a/include/linux/hugetlb.h
> >>> +++ b/include/linux/hugetlb.h
> >>> @@ -121,14 +121,15 @@ long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
> >>>  			 unsigned long *, unsigned long *, long, unsigned int,
> >>>  			 int *);
> >>>  void unmap_hugepage_range(struct vm_area_struct *,
> >>> -			  unsigned long, unsigned long, struct page *);
> >>> +			  unsigned long, unsigned long, struct page *,
> >>> +			  unsigned long);
> >>>  void __unmap_hugepage_range_final(struct mmu_gather *tlb,
> >>>  			  struct vm_area_struct *vma,
> >>>  			  unsigned long start, unsigned long end,
> >>> -			  struct page *ref_page);
> >>> +			  struct page *ref_page, unsigned long zap_flags);
> >>>  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >>>  				unsigned long start, unsigned long end,
> >>> -				struct page *ref_page);
> >>> +				struct page *ref_page, unsigned long zap_flags);
> >>
> >> Nothing introduced with your patch, but it seems __unmap_hugepage_range_final
> >> does not need to be in the header and can be static in hugetlb.c.
> > 
> > It seems to be used in unmap_single_vma() of mm/memory.c?
> 
> Sorry, that should have been __unmap_hugepage_range.  No need for you to
> address in this series.

Ah yes; I'd rather add a patch if you won't object, since my series will touch
that definition.

> 
> >>
> >> Everything else looks good,
> >>
> >> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > 
> > Please let me know whether you want my extra paragraph in the commit message,
> > then I'll coordinate accordingly with the R-b.  Thanks!
> 
> Yes, please do add the extra paragraph.  

Will do.

-- 
Peter Xu

