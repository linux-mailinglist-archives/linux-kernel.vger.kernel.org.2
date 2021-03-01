Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173F83280A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhCAOXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233151AbhCAOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614608455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0P/L7vyhbk0Jakxn5ixVUmN+55ZNwUUNhVXiDSCjXM=;
        b=ievEKSA4s+9BIjRBhSij2Cgws/wWanjbCqaH9DVtSSASkgwJ0wx+XCrMmDr5amOew7yo5Y
        Ymcit7ivbe/Wu1K92DJLaQW5vaYeO67Y2fSc9gWPGgt+tM2k5bCTZR+R3j3uPyOf3ND+mh
        PTY2ETZO670pyktte/EUwpvA+rKh9y0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-4IrMaLcMPPGYC-QsXfbvWw-1; Mon, 01 Mar 2021 09:20:54 -0500
X-MC-Unique: 4IrMaLcMPPGYC-QsXfbvWw-1
Received: by mail-qv1-f70.google.com with SMTP id o14so1404606qvn.18
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k0P/L7vyhbk0Jakxn5ixVUmN+55ZNwUUNhVXiDSCjXM=;
        b=rk80uuW9ZtnChWuOeg9AWPFTkx4QDChuq2RNXw0EvIVB+aaRAJnICBnnGV46OyMPnd
         LCeiEw4cexti/hFrRDC58a7ueFFDG6cxVtJx4Vb2xQMaQVKDgEzVruz5qKxxaAVAnAo2
         m8WCUU4890SWDzNhhtKGYvptZvcRs401UgxyTRagku4DVIj5vCuONChcvCcnZseTfymi
         dpwx0/loO25ztH5FNpvg4DuEJokjHY6Yl+YFvpt5hUJq0CVggcB5kefhzoiQb7vtxCSL
         IuVQP6vcLx+/hTgcwZoMHlDnWYVuc7Z8kBO1QKCo9wTFkNl0to6eYlDeOM9P7Frchx/I
         vzNA==
X-Gm-Message-State: AOAM531crSjT5yFGRXy5brWlHuJpJkIH+YBASt1OnRRa8JP1BsaBnqmr
        oc8nMyR296fpvE6Gw+780EavcJA1tkv9YgYUL0gIvjdY34V+t4EL7Y1R8moSdgd//vtY5mbaDMK
        y6x30maw4RwUnqPHF7sOrVWslEDSkCBKfeDCdlsN3Eo28CWoY7xhihJecvZiaPOlNCj6FucRZLw
        ==
X-Received: by 2002:a37:8806:: with SMTP id k6mr14528858qkd.339.1614608452926;
        Mon, 01 Mar 2021 06:20:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzY4ABWGsP46BTB5l94tjQhB4j4ZpPbXjRNgvNmUEIPT+LbysCIH6FnNTtHut6WPCL+EwmMvQ==
X-Received: by 2002:a37:8806:: with SMTP id k6mr14528809qkd.339.1614608452444;
        Mon, 01 Mar 2021 06:20:52 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id p66sm12464588qkd.57.2021.03.01.06.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:20:51 -0800 (PST)
Date:   Mon, 1 Mar 2021 09:20:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 0/4] hugetlb: Disable huge pmd unshare for uffd-wp
Message-ID: <20210301142049.GB397383@xz-x1>
References: <20210218230633.15028-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218230633.15028-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 06:06:29PM -0500, Peter Xu wrote:
> v4:
> - fix build for sparc by removing extra line in patch 1 [Mike]
> - pick Mike's r-b for patch 4
> 
> v3:
> - patch 4:
>   - fix build failure for !CMA and/or !HUGETLBFS [Axel]
>   - Fix mmu notifier range to use start/end [Mike]
> - add more r-bs
> 
> v2:
> - patch 4: move hugetlb_unshare_all_pmds() into mm/hugetlb.c, so it can be used
>   even outside userfaultfd.c
> 
> This series tries to disable huge pmd unshare of hugetlbfs backed memory for
> uffd-wp.  Although uffd-wp of hugetlbfs is still during rfc stage, the idea of
> this series may be needed for multiple tasks (Axel's uffd minor fault series,
> and Mike's soft dirty series), so I picked it out from the larger series.
> 
> References works:
> 
> Uffd shmem+hugetlbfs rfc:
> https://lore.kernel.org/lkml/20210115170907.24498-1-peterx@redhat.com/
> 
> Uffd minor mode for hugetlbfs:
> https://lore.kernel.org/lkml/20210212215403.3457686-1-axelrasmussen@google.com/
> 
> Soft dirty for hugetlbfs:
> https://lore.kernel.org/lkml/20210211000322.159437-1-mike.kravetz@oracle.com/

Andrew/Mike,

Do you have any further comment on this series?

Thanks,

-- 
Peter Xu

