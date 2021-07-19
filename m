Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9533CEDDB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357315AbhGSTuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358922AbhGSTcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626725568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FI9WwX0wcExs79cKeg3MMrdW0EBSFQQcNQYgqECOIAA=;
        b=ZiYehIR+KDrpeuOtON78rQwqBhLtqhauL4Oci7OMfZeL3MnOM0qKdSzD/i73v3Dd/JA5Wr
        njyB+rUSp0DvY/zXv8ZugS/DAjXG0RY3Hn6G4BOdTJbJIL4rSW0djBxcKcIMwXyYOGyh2B
        SzhZpBstRZ/hluI8h8VR2mHg6StFi1s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-6bobyUlgMBeIfd22PETO1Q-1; Mon, 19 Jul 2021 16:12:47 -0400
X-MC-Unique: 6bobyUlgMBeIfd22PETO1Q-1
Received: by mail-qk1-f200.google.com with SMTP id f203-20020a379cd40000b02903b861bec838so15691073qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 13:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FI9WwX0wcExs79cKeg3MMrdW0EBSFQQcNQYgqECOIAA=;
        b=NzwYUVvKwwmLUhbogOfjB86ldcTGzdLX+GGMr+M1CZA3aqtf064s3wtqNhV6thnTbS
         jeurzKZutlURp8erf7oKF4CdeKglavimWnkjhCNblEhl3YF2jkkE4dAyT62GcLkqf3Ua
         +44NeMvOvxHhpbwszJqIYf5dbwmfP8wzXGkiSssqCDYVXeDG9/vpokMllbcz68NoRj+i
         xwb/+lK7wrxKO3PxXjRGfU/nW4nhi48SpR91etwZcr1eIZKE8M4RYdZROqXbMSiCUQtK
         SIBO/FP/S/WCYD7kC+9Z9yKFVV/IyAQSdBVBWbQk0hrRkQM1ls5th+Ke7rzf66aPWYyu
         dKjA==
X-Gm-Message-State: AOAM530qG+oCaahtm9Bzmr7INfRy2vqPFBQ1TbsxG5V2ioY75goNEknh
        ix7Ymi3iCbxsSsPGQ5OKyPKHvxXM85Z9P4pcjF3YE8xfwuJL2Bbpq4c6MVe6D/dxO7th6B1yHZb
        Qhee9GDPngW6+eEiJLopGsLHD
X-Received: by 2002:ad4:4690:: with SMTP id bq16mr26378805qvb.23.1626725566851;
        Mon, 19 Jul 2021 13:12:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+rYmSDiBVy4tlVU0gkJtGNs9l7kA/aHowBz43PA8lQIe3UKnJmsJfnMmZ0zqAUsH2mFReoA==
X-Received: by 2002:ad4:4690:: with SMTP id bq16mr26378779qvb.23.1626725566623;
        Mon, 19 Jul 2021 13:12:46 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id j2sm6335256qtn.46.2021.07.19.13.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 13:12:46 -0700 (PDT)
Date:   Mon, 19 Jul 2021 16:12:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v5 00/26] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <YPXcvJ6TEzALyb/v@t490s>
References: <20210715201422.211004-1-peterx@redhat.com>
 <251ed5e3-d898-efdc-ca5c-7b047dc80cb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <251ed5e3-d898-efdc-ca5c-7b047dc80cb4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 09:21:18PM +0200, David Hildenbrand wrote:
> Hi Peter,

Hi, David,

> 
> I just stumbled over copy_page_range() optimization
> 
> 	/*
> 	 * Don't copy ptes where a page fault will fill them correctly.
> 	 * Fork becomes much lighter when there are big shared or private
> 	 * readonly mappings. The tradeoff is that copy_page_range is more
> 	 * efficient than faulting.
> 	 */
> 	if (!(src_vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP)) &&
> 	    !src_vma->anon_vma)
> 		return 0;
> 
> IIUC, that means you'll not copy the WP bits for shmem and,
> therefore, lose them during fork.

Good point.

I think the fix shouldn't be hard - we can also skip this if dst_vma->vm_flags
has VM_UFFD_WP set (that means UFFD_FEATURE_EVENT_FORK is enabled too).  But
I'll check a bit into page copy later to make sure it works (maybe I'll add a
small test case too).

Thanks!

-- 
Peter Xu

