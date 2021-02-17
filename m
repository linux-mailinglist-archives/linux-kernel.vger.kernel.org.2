Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D0331DFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhBQThW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232006AbhBQThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613590554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6lkoNLwaY2kbnYVognDDNLrsSmwkL+Qv8v4auisu9Y=;
        b=GClESXzJXc/Wd/N9z86UwzVMZue8oX+PvOgiMWGnsyergUrfPuaFEdh5IDg7KwnPn+Acy0
        hXKrSSp3gaNdNIMQ+P+KhVi3KNlhDbEY0Xr9YYq5CufBdNgdk13L3tamIxiUbUd9k9ROjy
        TXvayGDmLHI7P+eBAhIlgYXRveVjrOg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-StaLbmFjOcCdNe5OCGWSbw-1; Wed, 17 Feb 2021 14:35:52 -0500
X-MC-Unique: StaLbmFjOcCdNe5OCGWSbw-1
Received: by mail-qt1-f200.google.com with SMTP id o7so10861672qtw.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 11:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a6lkoNLwaY2kbnYVognDDNLrsSmwkL+Qv8v4auisu9Y=;
        b=eNIPGa6otm9Fb7fbh4kpjio1FdObGfvbj9vWm2o1XvbFYTc0M/UdoNI/QajFxUavS4
         9GeMxnPi54JUJZoCrnEQD6zlgR8W+m0w61ZEcGOu5CiXnaPCS9JJXlX6F0UGfICiJlf/
         65S0lsslErcUVT32Z6x13+pEaM/14XJCal8eFfXvx3pFkNjvxUkzYekQ0JrjckAzOnpE
         zUe8CdJVm2r9LuodlAa2Cg+7fhxsvA/70EINq8i7wcr78AUHyqBg5NBvlHZIv1Vo5gMt
         Dnxfcud0JVffjus43tU3GZJIA9a0lsOijJNjek9HzPZy7Dwm+aGvDKjDOSccdTCM0nnY
         rB/g==
X-Gm-Message-State: AOAM53377QHsc9+IlXU7N8MGiMtORKrn9iY5VqKbkmfeQNMwh2M030Qn
        Gg6kzDh0X5yRGr9LTbTVxz+IgQtm45iJP75HQbzKpOf4lYzzSqKuiGUqfi9mVLlMIYx33Fu0+4v
        FayP72pViCPXFyZXADgiSzOSI
X-Received: by 2002:a37:c17:: with SMTP id 23mr815918qkm.282.1613590552402;
        Wed, 17 Feb 2021 11:35:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTYIIg5rgOnDJUJSvEaJQTHUn7YXNS0+K5gx2PYQc1TOI5PZNuWIJYe6QRYJIwljMi/RFGQw==
X-Received: by 2002:a37:c17:: with SMTP id 23mr815897qkm.282.1613590552210;
        Wed, 17 Feb 2021 11:35:52 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 12sm1861151qtt.88.2021.02.17.11.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:35:51 -0800 (PST)
Date:   Wed, 17 Feb 2021 14:35:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, shu wang <malate_wangshu@hotmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 3/5] mm proc/task_mmu.c: add soft dirty pte checks
 for hugetlb
Message-ID: <20210217193550.GC6519@xz-x1>
References: <20210211000322.159437-1-mike.kravetz@oracle.com>
 <20210211000322.159437-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211000322.159437-4-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 04:03:20PM -0800, Mike Kravetz wrote:
> Pagemap was only using the vma flag PM_SOFT_DIRTY for hugetlb vmas.
> This is insufficient.  Check the individual pte entries.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/proc/task_mmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 602e3a52884d..829b35016aaa 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1507,6 +1507,10 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
>  		flags |= PM_SOFT_DIRTY;
>  
>  	pte = huge_ptep_get(ptep);
> +
> +	if (huge_pte_soft_dirty(pte))
> +		flags |= PM_SOFT_DIRTY;

Should this be put into pte_present() chunk below?  Since I feel like we'd need
huge_pte_swp_soft_dirty() for !pte_present().  Say, _PAGE_SOFT_DIRTY and
_PAGE_SWP_SOFT_DIRTY can be different.

> +
>  	if (pte_present(pte)) {
>  		struct page *page = pte_page(pte);
>  
> -- 
> 2.29.2
> 

-- 
Peter Xu

