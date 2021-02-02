Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9109930C74B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhBBRQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbhBBROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:14:09 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D61C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:13:29 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id a1so10205970qvd.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v2kYB3a8N+U6pJPO13PFP2mzAbH5g3SIInxbpBCXrwA=;
        b=Lwi+XbDCr6TCrZEfpzQKqD6YwszIXqYUbUeJZN60nrjvPZkfnT7iVB6KJ1vo4MF/Ju
         BZzirkaxpCMJLL1xX+ftJ34uLSaX5K/55x8NaDotG8vl2yecqSXSshokgGwBQuaBJ1yA
         jovx7euuIa8/vBcU9r1Stobl1uBJHPyPH+4GqBdW1njAEd+BHvopKwNLYeohLA0biKn5
         jQ9dSYghv+4HZ7Kd44JQxkKD80YfJ5VZn2hfzsFcGzlv+V78TujbN0Ue7NkZmkuLES5M
         QQR6WZJm+t+LWWVARCxhWDEztR49U47UGHBPRNBZ48YlVTfFv84r6G/EUfsq9F0th5Dr
         fpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v2kYB3a8N+U6pJPO13PFP2mzAbH5g3SIInxbpBCXrwA=;
        b=rgIBHPeBmYP8gSXKuj3Gn9k9IS5F7y/Yae1IV1+CTP6EkFrPKsAlo35o4DVFSB26RN
         C8Y/EKm1SDSDCQ5IkNi08LKF17lnJWeLx3LwMTArM6oibU3tfS0/LVB9rCze/ynzCGGm
         40rupcOKAI6y7shZOscKrrOY03rZ7oEn5MkKpct1GuisCOZNvebou5Kev1VAlK0DupxS
         PlV2vnxRAaxs85Fv2qpaQ+swPHMq27ibY9HVe/UzMagwjt6mN5KJ5/PAG0IKSy+uweQm
         7KcuVty5S2g3vEInfwrs+kwfJeThNvJejX1bMJdryi7KKnSJnF7/ubl3mSbkKeU3Dw4q
         QWvg==
X-Gm-Message-State: AOAM530sHLcwdPFtF4A60WW6SI78tbLlnJKxVMBtHdDSLSmdhUeDyPag
        CM/WKJpZqaitkkP+EzVLBUbZ6g==
X-Google-Smtp-Source: ABdhPJytq6oFwGR7z/VXKwcEPeyLad3Giz139CxUfM41nvnIvBbiNtEKgEhOj/c8qwXZly87/hhlVg==
X-Received: by 2002:a05:6214:32e:: with SMTP id j14mr21389150qvu.13.1612286009003;
        Tue, 02 Feb 2021 09:13:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id x49sm17798341qth.95.2021.02.02.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:13:28 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l6zF1-002cUu-Ek; Tue, 02 Feb 2021 13:13:27 -0400
Date:   Tue, 2 Feb 2021 13:13:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     20200918161902.GX8409@ziepe.ca,
        Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Zhang, Wei" <wzam@amazon.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20210202171327.GN4718@ziepe.ca>
References: <27564187-4a08-f187-5a84-3df50009f6ca@amazon.com>
 <20210202163127.GD6468@xz-x1>
 <20210202164420.GL4718@ziepe.ca>
 <20210202170536.GE6468@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202170536.GE6468@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 12:05:36PM -0500, Peter Xu wrote:

> > Gal, you could also MADV_DONTFORK this range if you are explicitly
> > allocating them via special mmap.
> 
> Yeah I wanted to mention this one too but I just forgot when reply: the issue
> thread previously pasted smells like some people would like to drop
> MADV_DONTFORK, but if it's able to still be applied I don't know why
> not..

I want to drop the MADV_DONTFORK for dynamic data memory allocated by
the application layers (eg with malloc) without knowledge of how they
will be used.

This case is a buffer internal to the communication system that we
know at allocation time how it will be used; so an explicit,
deliberate, MADV_DONTFORK is fine

Jason
