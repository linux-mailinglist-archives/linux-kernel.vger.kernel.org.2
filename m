Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A156E3155B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 19:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhBISM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 13:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhBIRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:46:44 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50837C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 09:46:03 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id s77so18809842qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 09:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tMqPI82kkBgQ3fPNbSKT8wVf7q5F/oWYwtgg/dqkVBQ=;
        b=lMNGgPZ+1bUQbZ33J0aazroPRv7kpeHHMCvi1KWrzmlryAaeCtDIGU/rqY20wU1jsf
         DQuFTT0osOX2LhRgDffRnH/uqvrMabZuD1w98LUFloz7EE9Y3KFVJEBAhYvpmHi8YUP+
         C2gSpvZGq8nzGIftw/P1hFDBEwxdhwGdwtMGlko1N34vDzMwV76pPoA75SGQ3RrXhJ8w
         GfSxfhLOxOnsH+frqCM2+B1bMuuo1M/9L1asR06jDFRioR4vsaui0xKUo3ERRxI+nAus
         PO79EVDFmfGBOV61J/DApaQBIVqwSRmWujdVXtKy5aJWH1KbMRSwqTGsLfW+4JVvMKxj
         dgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tMqPI82kkBgQ3fPNbSKT8wVf7q5F/oWYwtgg/dqkVBQ=;
        b=GaMRfdunzmpyVhXFyCyPg9HsExoaOdxWRmG+qOaAY5iHYAjT+/N0YXCyrhuMHnXsaG
         QeNkYxMu32LMtFgCUCzZChB29Ccu6+ITyOJUXCcheD/kULuSa1Fqxby/K1tnZ8Gx+Wrj
         TB1K1eaN8nNVKAKA7b/GH1T/62n0bf73yt7+pC2V3VwkA8jXXvibM20IXInNDRk905Lc
         p938pMAmB7/raEJvcgbSJT4xCQKqUt4vPcBBxDB9Vd5G6gAre5DXF/Z4BikRSOerwpen
         f48GUphOWi5s1iQiYuSER+z2d6UPmg3+yyKemJ1uMpUcPRhNXqoW9WCrYo+6Z++3KpQY
         F/2g==
X-Gm-Message-State: AOAM531mR8JAebMCZR9wwyXp4dFjjyDb9aS1+yDsn17xGv214RM8Ik8c
        ptDt0SCXgKjuNO/cFMSHlsrOAQ==
X-Google-Smtp-Source: ABdhPJzK2Jnef7RkQ+XCMrN8q3/bDaApl16efYMNW8XutOGURUDnIxzaFOjd1XaepGro6ha6N5fL+Q==
X-Received: by 2002:a05:620a:ec9:: with SMTP id x9mr22807783qkm.333.1612892762624;
        Tue, 09 Feb 2021 09:46:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id c17sm6919395qtn.71.2021.02.09.09.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:46:02 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9X5N-005XP6-Hn; Tue, 09 Feb 2021 13:46:01 -0400
Date:   Tue, 9 Feb 2021 13:46:01 -0400
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
        Andrew Morton <akpm@linux-foundation.org>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v4 4/5] mm: Use is_cow_mapping() across tree where proper
Message-ID: <20210209174601.GJ4718@ziepe.ca>
References: <20210209030229.84991-1-peterx@redhat.com>
 <20210209030229.84991-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209030229.84991-5-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 10:02:28PM -0500, Peter Xu wrote:
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 71ccec5c3817..620700f05ff4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3733,15 +3733,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  	pte_t *src_pte, *dst_pte, entry, dst_entry;
>  	struct page *ptepage;
>  	unsigned long addr;
> -	int cow;
> +	int cow = is_cow_mapping(vma->vm_flags);

int should be bool

Otherwise looks fine to me 

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
