Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD8130C619
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhBBQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:38:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236571AbhBBQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612283495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j3do6G/cRzzTnfGlcwvIh6nfAaKFLXcCzXnlUiVuVi8=;
        b=OReCIzoepwTQXw9DfbOJPbZAyRYa6sXtPTkW+Mb4k9uoJ7eKNwnnex9Mx21QoS519ksunX
        JIqOexQAQZFlLjHpPpTGo7Ny3peIxT9b5vlxTZ4h7DBTxvCUjlKFXaMqO23dOtrnWoMIEV
        12rWpzSM1U4clRGDQBBA1HU9QcMnbNk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-izVjUYyxMaeDyGWRcpeopQ-1; Tue, 02 Feb 2021 11:31:32 -0500
X-MC-Unique: izVjUYyxMaeDyGWRcpeopQ-1
Received: by mail-qt1-f197.google.com with SMTP id h8so14649980qtj.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j3do6G/cRzzTnfGlcwvIh6nfAaKFLXcCzXnlUiVuVi8=;
        b=MCA1ctYRNdqYTOj8Zf5yM+Q4obOSS32auehMqKdS/FJdgcx3Guy0aiL1IbHLx6O/kl
         THQCe8+E+9BZl6PaVWnvOu0GAoUrE/XU9ReKbaXTwv+EUWxYXsCJTP5pJhC5CfZqADpz
         LnqfHNlgzNAzgdF6PhdKeu7R0zCxhOlhdh7BoIBVTyuUr738D+gw31BxYKWkvgdQdkGM
         RqTDV5hpUquLSFHFdj5MGHtxOOTINq8a6UyIGD3Rnx+yizPhccODOAdXyeMkI34vlNU6
         4C/HUyKB4mmgmMIBcFirYaFzxfHir9L9HzKOvl8XrYBouzVWicPRTCJ5RuCdX1oGxKij
         lEEg==
X-Gm-Message-State: AOAM531s4oDbnhsmF7fmzNrUm2MmfN179GIqBkC6z3YvEsjuiF8qHj6m
        H3zHO53m58Q97uPgrDndsiwROxZnkvMEyYlrgB7EFqsCwWjM4hknfPbn7w8RkXeuUWyj48ebNWN
        ey/Y91Th11LMYcUl+uwnjNiMf
X-Received: by 2002:ac8:76d2:: with SMTP id q18mr14791628qtr.254.1612283491791;
        Tue, 02 Feb 2021 08:31:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzElKvb/Cp4HnoqVbqtprLiE1qRJjvo9fZaPjgqJAejLHflPDRX6ewXqBLwqhRb+622AbD0tA==
X-Received: by 2002:ac8:76d2:: with SMTP id q18mr14791599qtr.254.1612283491512;
        Tue, 02 Feb 2021 08:31:31 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id q92sm16336081qtd.92.2021.02.02.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:31:29 -0800 (PST)
Date:   Tue, 2 Feb 2021 11:31:27 -0500
From:   Peter Xu <peterx@redhat.com>
To:     20200918161902.GX8409@ziepe.ca
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20210202163127.GD6468@xz-x1>
References: <27564187-4a08-f187-5a84-3df50009f6ca@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27564187-4a08-f187-5a84-3df50009f6ca@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 04:40:33PM +0200, Gal Pressman wrote:
> Hi Peter & Jason,

Hi, Gal, Jason,

> 
> It seems the hugetlb part was overlooked?
> We're testing if the RDMA fork MADV_DONTFORK stuff can be removed on appropriate
> kernels, but our tests still fail due to lacking explicit huge pages support [1].

I didn't think it high priority only because I think most hugetlbfs users
should be using it shared, but maybe I'm wrong..  Then it got lost indeed.

But I definitely agree it should better be there.

> 
> Peter, was it left unchanged on purpose?
> Are you planning to submit the hugetlb changes as well?
> 
> [1] https://github.com/linux-rdma/rdma-core/pull/883#issuecomment-770398171
> 

I'll prepare a fix soon and post it.  Thanks,

-- 
Peter Xu

