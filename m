Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDA315694
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhBITNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhBIRyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:54:46 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB3C061756
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 09:54:25 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id t63so18867727qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 09:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9+ng8YEwm0gPQtsRFld/mxm+Fr3CGlj9BZPkVB+K7CI=;
        b=SiiYWvq3kwM29M+A2s0UXd+EpWKLGodGENnjAWHjohMWHEIh3DjSHs3auOIhTEh3fE
         5UHtKScTQfiwGlHM5fOgxhKO5M3b+b7ylOleFCcD48y890/RMY5DyJOB8i72VUF0hvxZ
         x3Vp4GqLvuDgLfJF1ly0h7A8UAtWpUP1lpYiAPheNmFHkk1hy2NaJRH0ilwAzkookv+N
         nzs7c3o/i8Qgdcw9MakcDzQdks8sLyrvDE8C4o3CzZbnHPMk2FVprTRYqA+Mifl2eVe9
         f8zZ4tVf/NnXpkqSuhC9QBISa3prfl6jxo61qOMa3rQfDm8ocUrhpqdCEL+P7meiZSZ5
         3PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9+ng8YEwm0gPQtsRFld/mxm+Fr3CGlj9BZPkVB+K7CI=;
        b=UDuBKi5vcL7P82trN6/QCo6M/60R0vLqdFzjX0LV2GSeR9ec7N9rkRzNcJn58kSB4Z
         b+z90IxgXvtwOv4kyxUF/LBXS0CzYGILRXkRL7CuJOfB/XTEhNxucDU+CSfHp0sUIM1E
         WvWsQ9BdaXsmzUzFQdUXbWvzibZdLQI2d1NBNEEYGZBd/6ksPCGIT8afzQ9ZxxuQYSat
         BZcsMrgjBrZrjxwYIiLh5m7Hu6AsVmIIugdOI1JYTjijUlWdK64/eANmV0VcFatGyAOg
         bOrwfuIV/OkEfEBWRaM/kSJglxaSzikn01qminHhdWzP4z+ftXZ4/zjkhzhdq0+z+l3C
         8QSA==
X-Gm-Message-State: AOAM532kLA5r/j6CINfh+K9H+IQ6OuyhSSSPNxjpOzzDtze0zHuiucw1
        O7ZtbX4jWwOdjBBmzwmWleow1Q==
X-Google-Smtp-Source: ABdhPJz/ygAfORSfsYQ9FwLVeqQLrsveP/Z/O4JB/psB2/yW/3QE/X3GV64Xufljyk3tGqL8vgtMMg==
X-Received: by 2002:a37:4394:: with SMTP id q142mr22152586qka.113.1612893265097;
        Tue, 09 Feb 2021 09:54:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id z25sm7111539qkz.33.2021.02.09.09.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:54:24 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9XDU-005XYP-5F; Tue, 09 Feb 2021 13:54:24 -0400
Date:   Tue, 9 Feb 2021 13:54:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirill Shutemov <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gal Pressman <galpress@amazon.com>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 5/5] hugetlb: Do early cow when page pinned on src mm
Message-ID: <20210209175424.GK4718@ziepe.ca>
References: <20210209030229.84991-1-peterx@redhat.com>
 <20210209030229.84991-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209030229.84991-6-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 10:02:29PM -0500, Peter Xu wrote:
> This is the last missing piece of the COW-during-fork effort when there're
> pinned pages found.  One can reference 70e806e4e645 ("mm: Do early cow for
> pinned pages during fork() for ptes", 2020-09-27) for more information, since
> we do similar things here rather than pte this time, but just for hugetlb.
> 
> Note that after Jason's recent work on 57efa1fe5957 ("mm/gup: prevent gup_fast
> from racing with COW during fork", 2020-12-15) which is safer and easier to
> understand, we're safe now within the whole copy_page_range() against gup-fast,
> we don't need the wr-protect trick that proposed in 70e806e4e645 anymore.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 62 insertions(+), 4 deletions(-)

Didn't check every hugetlbfs detail, but looks reasonable

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
