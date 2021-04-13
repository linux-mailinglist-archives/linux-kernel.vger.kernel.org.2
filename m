Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5E335E789
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348191AbhDMUSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232025AbhDMUSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618345075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F+gpcGbjpJnW75HsT83fn38nMLIN2HNyr9uneAl6PwM=;
        b=PFTzUEe7naAwv1tg/lw2jI+nZ29tD1Qv8kH/WNLzROftHVzCaQM3n/mg8j+3B3oIfJTiSH
        4tC9Ys090lFi25UN6GBpeuiqKIS+J0IyWbzKPraFlRb7/hJpaRGyxofSNGOn90AcI5SEov
        vhKGnGGXgqRPWYEykvJpx2teM8wBRyk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-zbflZkNRNpGONayBcGhnVg-1; Tue, 13 Apr 2021 16:17:53 -0400
X-MC-Unique: zbflZkNRNpGONayBcGhnVg-1
Received: by mail-qv1-f70.google.com with SMTP id m17so3911050qvk.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+gpcGbjpJnW75HsT83fn38nMLIN2HNyr9uneAl6PwM=;
        b=SLFF21xOpe58o/cyuoHOnRvX4y1ORfUQBFh1YHo07PWpyXQtIv+FYnw8WJGfBzXQvY
         tWcN/+SGYQWE2H1ZSk+wRl6JaHByA14AdO+g0hdtghtmRI43zXHtWNtK2cNib16/pAG+
         H5TovlTreEwM3IrVejEgRIQDoYMWKFk6RlM3QAUA0v7Zmb3UQlDt/haLxLtRNgEsw7uH
         JcvMh4Ivyfnin/v1RvIt+ul/XNkXe8GZq4RU1PcDW/M7hLmiqQJHSJImmya2933EkEOS
         XbWEhtZcpkFPWCnfJ4VBMNSCuMqS1kvMm35YKoYFJCbQ7GyUPVXBzYoCctx7+NiFbVJI
         yREA==
X-Gm-Message-State: AOAM533CIEvZ3WQuzgt36Lw2TtMa8IkREgwcXytZLS5CTMNmZAit7PLc
        2/k6X4o2Xi3z3eqy4nwwJqs/cyxwDYOUOd99/E02vcDKBpzRzKagWh351UaE4ZUZgYJvgpTeFyd
        MnHRbLtPMtEHQ0wsEi2Oak86c
X-Received: by 2002:ac8:7fcd:: with SMTP id b13mr31785948qtk.68.1618345072906;
        Tue, 13 Apr 2021 13:17:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm8QhI4YsPfqqtubp6A3TgshHmvxjOKTuerTRIoNikR75RHHmVPZbkbKxWJoODRS6zRKCi6Q==
X-Received: by 2002:ac8:7fcd:: with SMTP id b13mr31785923qtk.68.1618345072692;
        Tue, 13 Apr 2021 13:17:52 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id q67sm8814016qkb.89.2021.04.13.13.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:17:52 -0700 (PDT)
Date:   Tue, 13 Apr 2021 16:17:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v2 6/9] userfaultfd/selftests: create alias mappings in
 the shmem test
Message-ID: <20210413201750.GF4440@xz-x1>
References: <20210413051721.2896915-1-axelrasmussen@google.com>
 <20210413051721.2896915-7-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210413051721.2896915-7-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:17:18PM -0700, Axel Rasmussen wrote:
>  static void shmem_allocate_area(void **alloc_area)
>  {
> -	unsigned long offset =
> -		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
> +	void *area_alias = NULL;
> +	bool is_src = alloc_area == (void **)&area_src;
> +	unsigned long offset = is_src ? 0 : nr_pages * page_size;
>  
>  	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
>  			   MAP_SHARED, shm_fd, offset);
>  	if (*alloc_area == MAP_FAILED)
>  		err("mmap of memfd failed");
> +
> +	area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
> +			  MAP_SHARED, shm_fd, offset);
> +	if (area_alias == MAP_FAILED)
> +		err("mmap of memfd alias failed");
> +
> +	if (is_src)
> +		area_src_alias = area_alias;
> +	else
> +		area_dst_alias = area_alias;
> +}

It would be nice if shmem_allocate_area() could merge with
hugetlb_allocate_area() somehow, but not that urgent.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

