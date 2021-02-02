Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E8330C669
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhBBQrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbhBBQpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:45:03 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4667C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:44:22 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a1so10151484qvd.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GHt+58lpMeN8FS8Vy0xXsKPAH5qjP5k97xDYxNly/mc=;
        b=Gqa1+92O2XoVdq5h3WJwvIe53CWAcsJ+UBuSqLqbDzVZ+B5OJ6z9mbaF+Xd1pE2kyO
         ZBiqehKbCvYFUZD45B4RDBY991mbJDTkTw5RkQDmAbLoyKorJeVh5cNFAtaJHLUDs5fh
         hbXuNCWCieD5tiGjGAu8tLxyHEkHSHRlFdIssg2sybQn6sncjLZ5zxoRlvzhpvk00wR9
         yBYD/Pf/9PSePO1vuzYkrYvFohsWUMGgVf6mpwnbvQoh1YOpAI91LkjUTXmjz5cn8grM
         ZBoH+vb74KN38ud6Zu/jDqu00YHifhJXrI3RJoW/bcaK1WRlthg4Dv3JM0ZlzfZDVymB
         EPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GHt+58lpMeN8FS8Vy0xXsKPAH5qjP5k97xDYxNly/mc=;
        b=EfrGr6t2olFPymTakYMXWv0JnzVK2PNpMhzvUjl7xiAoaHihyjGxS5NBKFcCP7qpwX
         J0sUO1JgBwzeO5TWr09l2ObrODiYPp4DiDsP9jqINWjrJQqakZzt562CDWYfREv31u2h
         9gR0CX1CyPNBMh9aiJ8TnRI3LDLWq1lloiuxjWOafroIQYuDLshbCwZ8r4JMHNRsYuui
         LksmBTEpW0w6fyFWrk8I8TY5Wg8e9LvMGSwsph/XH4gResYA1QG1W0NfSMCIhic8dIzG
         tniOwgssE+vE77wVX/3mUThU0t+bWue9skeb0Oh0TxIQz7bOQNf89oktz0t1QiQSAS7g
         xXsw==
X-Gm-Message-State: AOAM533n9Qs50BtDhk4OxCGpYIWhUr+kRMM+8jOxrBcRTXGBEzLyISIl
        2eqwf3+CcoW5za9McnKPCUV7qw==
X-Google-Smtp-Source: ABdhPJzpFtBa8bHhZ4cLgismUjbOWGsHslkWVqUIkLdMBKjip8QuQAUNewHD8Wr7QA7C49wzM3jfAQ==
X-Received: by 2002:a0c:a9c7:: with SMTP id c7mr7444088qvb.53.1612284262005;
        Tue, 02 Feb 2021 08:44:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 133sm17669457qkg.38.2021.02.02.08.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:44:21 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l6ymq-002bgU-0u; Tue, 02 Feb 2021 12:44:20 -0400
Date:   Tue, 2 Feb 2021 12:44:20 -0400
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
Message-ID: <20210202164420.GL4718@ziepe.ca>
References: <27564187-4a08-f187-5a84-3df50009f6ca@amazon.com>
 <20210202163127.GD6468@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202163127.GD6468@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 11:31:27AM -0500, Peter Xu wrote:
> On Tue, Feb 02, 2021 at 04:40:33PM +0200, Gal Pressman wrote:
> > Hi Peter & Jason,
> 
> Hi, Gal, Jason,
> 
> > 
> > It seems the hugetlb part was overlooked?
> > We're testing if the RDMA fork MADV_DONTFORK stuff can be removed on appropriate
> > kernels, but our tests still fail due to lacking explicit huge pages support [1].
> 
> I didn't think it high priority only because I think most hugetlbfs users
> should be using it shared, but maybe I'm wrong..  Then it got lost indeed.

It turns out people are doing this:

mmap(NULL, SEND_BUFF_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0)

Which makes some sense...

Gal, you could also MADV_DONTFORK this range if you are explicitly
allocating them via special mmap.

Jason
