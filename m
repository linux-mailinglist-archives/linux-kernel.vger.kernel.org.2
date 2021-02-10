Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF74317437
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhBJXTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhBJXSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:18:16 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18963C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:17:36 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id o193so3538449qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pvzBLzuUN3dC3Meck84dtvamYug02/uWoNAd2vuIlPw=;
        b=LnAhhZAcjBbe2PDzz7862JnfK5LxIO+60i0EKD0KDKz7s9HABmOblaFNhZTUV95vQ3
         TcpqQGbbR6j8YnR1u48ozRKREc9GR4REzg5lFNe+kdgPgDvdrcLmz2deN0izTXw3QuUf
         CKyhoUazx10m4WzbeTW77xpOInKqOMQ7CZZmeYD6FJvFu6C+mD+/iqcr/2pidKc0Rnf7
         Jqk0eHarHTXWC9Ze7H0NC0qbrN3xGiI28tIAu5vOpCKf9qh2y/Y6FHQpJgn5a2omapVU
         xzuMi8DlLmhVFvqnvrlfvplkDzanCmmL9lY5FHEnYjX8v1QLa51LV3+MmFVbTpVtEgZS
         vvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pvzBLzuUN3dC3Meck84dtvamYug02/uWoNAd2vuIlPw=;
        b=ezJu5XLzz8DJ4U6j4GRM8mIJEkQDYsVqZbIX2/to315cGB8b614TYgKRcwPfPB5JU5
         ZviwcbwyntDI8UF6drv3HXGHP9qghNdqaLMrC69S64966X7Xx1wOsWFr75X59o2QDT9p
         K7zMP3A0nnWV1W7eRsErgcUyJqtU6gv3cobd1qu6jwljHtDYbM2Md1y3sE3T+CtGMIwL
         LuzeskXj7KBL3N+6qQIGkRYh0PjyCevpYKTUdaKEdxcBnkl1wgIMdarlByUhWz/XjUle
         PidlcIn7bGjy2f5A9nnOpYq9iN+mSwTzXUBh0FJqayotXcH4qa0+sZc9n7Hj/Si60TX8
         y/3g==
X-Gm-Message-State: AOAM531cdxRK6QcpqAA35M4FKYXZOKNXcE+MIbHrhm1t7p+e5CnIy4bb
        7sk1/uS8EqJ0scL4WWMghF+N2A==
X-Google-Smtp-Source: ABdhPJyaU4n/wmBj/Fq8bDuOMNR3xhmXrfFN0BiPQEns2xCAk/uD0k5Fsy15pBBnyBYamD9xuF/xGg==
X-Received: by 2002:a37:484f:: with SMTP id v76mr5717061qka.312.1612999055416;
        Wed, 10 Feb 2021 15:17:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id t128sm2549683qka.46.2021.02.10.15.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:17:35 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9yjm-006HMP-FB; Wed, 10 Feb 2021 19:17:34 -0400
Date:   Wed, 10 Feb 2021 19:17:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 4/4] RDMA/umem: batch page unpin in __ib_umem_release()
Message-ID: <20210210231734.GS4718@ziepe.ca>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
 <20210205204127.29441-5-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205204127.29441-5-joao.m.martins@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 08:41:27PM +0000, Joao Martins wrote:
> Use the newly added unpin_user_page_range_dirty_lock()
> for more quickly unpinning a consecutive range of pages
> represented as compound pages. This will also calculate
> number of pages to unpin (for the tail pages which matching
> head page) and thus batch the refcount update.
> 
> Running a test program which calls mr reg/unreg on a 1G in size
> and measures cost of both operations together (in a guest using rxe)
> with THP and hugetlbfs:
> 
> Before:
> 590 rounds in 5.003 sec: 8480.335 usec / round
> 6898 rounds in 60.001 sec: 8698.367 usec / round
> 
> After:
> 2688 rounds in 5.002 sec: 1860.786 usec / round
> 32517 rounds in 60.001 sec: 1845.225 usec / round
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/infiniband/core/umem.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Would best for this to go through Andrew's tree

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

4x improvement is pretty good!

Jason
