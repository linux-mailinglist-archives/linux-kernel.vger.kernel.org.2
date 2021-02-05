Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A928831171C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhBEX26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232620AbhBEO2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612541134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JoM62AWSDevjens3EGjD01RZCxIT1WEOEpSFlKtGj24=;
        b=JvWIw5ofG0aKMZplHyD5DfjQDfKn8S4LXm49BDoTYB1XYmECDfvqvsY8i6mr25ba9KSDIe
        tseaJd630r+HEPkJdGe6zwL9ozX1UHpfjMm/ijyy+K5aPiX3L3+GPmI0YVkP7AZeXVDhtj
        MNHA2I39T/t2HUZK+wRmbUff05AaGWQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-3RiUaQ6-OyWvAkeC8yoVRw-1; Fri, 05 Feb 2021 11:05:33 -0500
X-MC-Unique: 3RiUaQ6-OyWvAkeC8yoVRw-1
Received: by mail-qt1-f198.google.com with SMTP id o14so5568986qtp.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JoM62AWSDevjens3EGjD01RZCxIT1WEOEpSFlKtGj24=;
        b=aPxeQcs0Q+9DwIZFh0N8Pep0L3/39ihT7rm9k3K1462v9Qy4CadcVlvRyxlpdkAkM0
         yJsVMglamBY9CIBM4zX9tHxgRM1OVw7BsvwSYWkVzwIRi6iYN2MooVZdFGlc4L8Rm4M7
         ZLRqFdGH63Q+foOOa2IDUOicdsgfFxxSOiIxE5GOCA5KDD6HLZF99hbVroF8DGFzgy38
         SXaeL1yDvNCL4YTTx600HDwZVfmt0jHh4MowQ5BmOJqx2ltPWnkkyvsS7olpQ0jY8tjR
         uTB6Z7vS+gVkwoBh3bO64emXCNHo/8tFg6FhYpctFGHYuUIPANY2cpNgN38F6838UMaT
         blDQ==
X-Gm-Message-State: AOAM533YGVQTSk/N8xlIDrHr9zGzvcEDqP8lDlKlNtgobAAMRrOSCYuH
        NVltHGBXQmoUWy0Rj6oWv7ZDVxe4z95MzCV/MZv7i49yPxRSIMJ5VZr7hS/+aFhAWkx1CfFa/rB
        H9LKUXRmDKPpl/skJie03joet
X-Received: by 2002:a37:b346:: with SMTP id c67mr5077317qkf.212.1612541132732;
        Fri, 05 Feb 2021 08:05:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQM80RYsZTBhWjWiOiR1RHPvEgAzVUDDgbkzNLvCUyrFrGIeU8bK80LifWphXArYXXlDyxcA==
X-Received: by 2002:a37:b346:: with SMTP id c67mr5077289qkf.212.1612541132526;
        Fri, 05 Feb 2021 08:05:32 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id o10sm8653688qtg.37.2021.02.05.08.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:05:31 -0800 (PST)
Date:   Fri, 5 Feb 2021 11:05:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/4] hugetlb: Do early cow when page pinned on src mm
Message-ID: <20210205160530.GZ6468@xz-x1>
References: <20210204145033.136755-1-peterx@redhat.com>
 <20210204145033.136755-5-peterx@redhat.com>
 <d45d4ce3-f386-708b-0f7a-4950df6721d9@oracle.com>
 <20210205014328.GW6468@xz-x1>
 <4344397d-cf08-b502-d5ff-76f19e778dfe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4344397d-cf08-b502-d5ff-76f19e778dfe@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:11:24PM -0800, Mike Kravetz wrote:

[...]

> >>> @@ -3787,7 +3803,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >>>  		dst_entry = huge_ptep_get(dst_pte);
> >>>  		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
> >>>  			continue;
> >>> -
> >>> +again:
> >>>  		dst_ptl = huge_pte_lock(h, dst, dst_pte);
> >>>  		src_ptl = huge_pte_lockptr(h, src, src_pte);
> >>>  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> > 
> > Side question: Mike, do you know why we need this lock_nested()?  Could the src
> > lock be taken due to any reason already?  It confused me when I read the chunk.
> 
> I see that it was added with commit 4647875819aa.  That was when huge pages
> used the single per-mm ptl.  Lockdep seemed to complain about taking
> &mm->page_table_lock twice.   Certainly, source and destination mm can not
> be the same.  Right?

Right, at least that's my understanding..

> I do not have the full history, but it 'looks' like
> lockdep might have been confused and this was added to keep it quiet.
> 
> BTW - Copy page range for 'normal' pages has the same spin_lock_nested().

Yes.  I'll need to take the same lock in v3, so I think I'll just follow.

Thanks,

-- 
Peter Xu

