Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1B322DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhBWPkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232813AbhBWPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614094726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mEc8q6U0PvZdpT9f0rmyiAzpeP08z6HF0GSvezKfJ4M=;
        b=YM705sqy+c+JLALBQsOLifvJZckEcEAFs308XTSI7jUhM6tQsjaYjhUkifXmro6le9Nuri
        zAn7ZnxMX8wJvciUT9mhtOa/MF0Y/Jt6k4lf8ID0ubGa/C1Vx6UkML77vcDA07WQMUw9s1
        N3OfddGOGXgKg+w4hypzwaFEpUCXfBk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-Kn4K54LNN4WZDybizophOg-1; Tue, 23 Feb 2021 10:38:43 -0500
X-MC-Unique: Kn4K54LNN4WZDybizophOg-1
Received: by mail-qt1-f197.google.com with SMTP id h13so6374964qti.21
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mEc8q6U0PvZdpT9f0rmyiAzpeP08z6HF0GSvezKfJ4M=;
        b=Pj318g4Yh7jhiBQtZ6AzRDshMcp5xpTZeDogvOwmnBS00lhF3Ynt7tjLOaSz7PQajp
         747p/TGWGcNEMBj67YpcNSL9Dqq79urJrOLB1Y+PzBLpzz1os4Bm505WqMtLQZ+Z9V22
         U+9J7nON5apzKxKO0m17EDRgyRVpNIFj5OhCYeKvf3i+HXVX8eYnmremOWwLrZbnc1Nj
         /0gNSA7ASb+GNgeOEPgLJ3GZYIr/HGix04mOp/gR4IacheYiNhzJw6CAx2ETnl+G4hPO
         r5jwmiTD1Z+nWRvMv6LqMoGbuNQ7hELXjnAg7EJXi5G/mnaIMl7d1qdjMdwOdz6TxDnl
         iSJg==
X-Gm-Message-State: AOAM531au/EaPAMZqeS0+iWRB36n0CET7FEO2pJEv4WSBD4iQ1mo1wb/
        RRW8AaJeng1ep3A/h/VAAZkwZ+t5TwsOchrYyjP5bFr+sSJtVmoeNDZ47yKj/eBYkuz1gVPO2Kn
        mGQOBWaIUrn2eXKsrxLYi1PBA
X-Received: by 2002:ac8:100c:: with SMTP id z12mr25023837qti.57.1614094723046;
        Tue, 23 Feb 2021 07:38:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2ox3wfwlm8jigspxM3yikHGpDC4/LFO1zOj6cnc9AkQazrG31gnHBzf4415QMybfSERLkIg==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr25023799qti.57.1614094722794;
        Tue, 23 Feb 2021 07:38:42 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id y15sm308813qth.52.2021.02.23.07.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:38:42 -0800 (PST)
Date:   Tue, 23 Feb 2021 10:38:40 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v7 4/6] userfaultfd: add UFFDIO_CONTINUE ioctl
Message-ID: <20210223153840.GB154711@xz-x1>
References: <20210219004824.2899045-1-axelrasmussen@google.com>
 <20210219004824.2899045-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219004824.2899045-5-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 04:48:22PM -0800, Axel Rasmussen wrote:
> @@ -4645,8 +4646,18 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	spinlock_t *ptl;
>  	int ret;
>  	struct page *page;
> +	int writable;
>  
> -	if (!*pagep) {
> +	mapping = dst_vma->vm_file->f_mapping;
> +	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> +
> +	if (is_continue) {
> +		ret = -EFAULT;
> +		page = find_lock_page(mapping, idx);
> +		*pagep = NULL;

Why set *pagep to NULL?  Shouldn't it be NULL always?.. If that's the case,
maybe WARN_ON_ONCE(*pagep) suite more.

Otherwise the patch looks good to me.

Thanks,

-- 
Peter Xu

