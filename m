Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6DE305061
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhA0EEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhA0DC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:02:57 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F76C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:10:24 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d15so391480qtw.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4v1/VsnWd7cCCScK14wU43pHTF0mwW1R+KHNpMyduoM=;
        b=QtgkYDjdrXnX3O2BFxjAklfiousu1Sl+iOeoc4yAzZYkzrVEDYbJ0qQjZgocH+2YK2
         BTpQU7A7m7npijAh4Oz3Jn6GrLOO/+s0tPyOjVsGyzUunp2NfSqFvkqb+J2Gg0+RMYfw
         1l13jM6V4e+nYSHXkq4138OiRIfKGWpnAhsOE/kh2SA1wjp6V+C9gqvAsiB56JGyegZ8
         TQv0+B9vZZuqzCBe9qjQ3baTKVjk/t63qRe9P7wDWWywMapEiOYkWmV7z0q12PeBN1X+
         VaHM/ZMdw0aTMpjZw4UaYhbzqU6viC5SmBsvGp7m03sDjlcsCaoj0khA9SHgYuuZvIKI
         ucng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4v1/VsnWd7cCCScK14wU43pHTF0mwW1R+KHNpMyduoM=;
        b=OFu4Ek71o3W0smpBpGJkLhDKI6gPcR3L9N7HGKka+gGd8MVam8mkeQ0/eIDHoup0/y
         vvfo17gafW0LGXzhqfNgTlamHt3TGIhe7QcIq0n8q5Qm54qTA4Eyxxg8ie7fJfia+Myd
         9/yzJwGWwW7D/lvfzGSarzICLzRwGx/Tsxv2vPqyJQ3+nPqoSbWqlGOwZktT4aTnSEMk
         lhHPUcjGBHEk5DNmJSeQSo1/QdC5s/dwRG35FWml+CU4LIrDSin4V2mtHtePQBP7U7qW
         eGt3uurTCbCMa15DINZjf7rUbEPkn4gakUglXpbwPWEN4fZrxutLgAiNSTCzEc/h9x7c
         pU3A==
X-Gm-Message-State: AOAM5313bvDcoZIvF4lA9jVapHplJUMswjciC1qi9TqxLLbF8z0KgXeg
        PE5/7ieTHbC0MGr9Leoqrtnxjg==
X-Google-Smtp-Source: ABdhPJwivhDVE44NS/6qidVgdRbB9DEIkPCwS6n93fVGJYIt5UiZwyEjF0M7IWPJK7sxbEzxD9X3nA==
X-Received: by 2002:ac8:718f:: with SMTP id w15mr7950345qto.179.1611713424170;
        Tue, 26 Jan 2021 18:10:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id p23sm455107qtu.4.2021.01.26.18.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 18:10:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l4aHn-007JtW-3N; Tue, 26 Jan 2021 22:10:23 -0400
Date:   Tue, 26 Jan 2021 22:10:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 2/2] mm/hugetlb: refactor subpage recording
Message-ID: <20210127021023.GC4605@ziepe.ca>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-3-joao.m.martins@oracle.com>
 <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
 <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
 <4d3914e9-f448-8a86-9fc6-e71cec581115@oracle.com>
 <20210127000730.GB4605@ziepe.ca>
 <f1fc1543-72fa-44f2-50fc-0220abfdc484@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1fc1543-72fa-44f2-50fc-0220abfdc484@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 05:58:53PM -0800, Mike Kravetz wrote:

> As pointed out by Joao, you can also see the differences in pfn_to_page
> for CONFIG_SPARSE_VMEMMAP and CONFIG_SPARSEMEM.  The only time we might
> have issues is with CONFIG_SPARSEMEM.  I would bet CONFIG_SPARSE_VMEMMAP
> is far more common.

I think it is fine to have a different pfn_to_page, it should just be
illegal to combine pages into a compound if their tail pages are not
linear in the map.

Matt's folio work might present an option to audit the whole mm for
this pattern and provide some folio_next_tail_page() accessor that
does the fast thing - but I question the value of such a project for a
2008 era PPC platform with 16GB pages (seriously?) that may be using
VMEMMAP today anyhow??

Maybe others know of more modern use cases

Jason
