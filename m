Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEAD32A086
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381218AbhCBEWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376879AbhCBAbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:31:18 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3BC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 16:30:37 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d11so12846939qtx.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 16:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V5XRDKSRTrEzosp2UPBuDbx+QrXytxwidYKwqNZIiyA=;
        b=nHrLjjBAe/3VmMhIwWkmvCfPxva/KxsUqCBKVYw97cGXjOOxpbi1MmLYy4Yu59rKuM
         moyAxZ2T02rg9oYMq+VbUoWpNdp11tiYW2Dq9/ojq5asLVfIcJmwhNhhZBebwVH6REX3
         sA6H4f7MHkF3nXNr+qSGOFx3LqbTlfly6QvWQR/P49zCQXCmFTXGL5Vw3SVEurX7PAfJ
         E3tK53s4789WHWwmVRHUdURIzzB9bMsb1Ht2rwgR8G4++lUljnuE+q/5ygk2uOsVPGmx
         nmxdk2ByOpFYKvFo0kV5FW47iOHbWsKguzxXB/24RbTB0Kieit7yB4WCgG8IXYHCPJ7A
         zuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V5XRDKSRTrEzosp2UPBuDbx+QrXytxwidYKwqNZIiyA=;
        b=M9n9DkYX++/kUshMuZvp+JQFREOJn4J+6XH9lmN31QaNDPNqaFw3vyCeFK7YDY1sVO
         4xEMZ0MOgYSoY/p2+qu3KYHsz7jRkU/UVfBusmMz1aa855Nk/iPPQacZw1x22U0vYHiL
         lEh4UMx5jk0CNgSh5EYBVFRypH+wQ+ysFjWDJ506saglXuyULgx+Wrz3Cu7Ghe0F8phc
         9JhPOmwMBurhm8Y3NPvDSUZrsI0sAZxA6L1T37bLkE53S3eDx7duPrAXbVBJeAuR4gfe
         dXw3OfgFu4ItCfPcnYFcn2NDrr96/1uIYWDwQ7Vn2uiveH+CuRt2coRzMmu0/1ACMze5
         8vPg==
X-Gm-Message-State: AOAM532X7gTeXUxCu2hci13tNxrfVMNA7Rm22gIj2FH1Z+bF7H/CRn2a
        h4SvZMU7aRBYGvtQ15uSqbs03g==
X-Google-Smtp-Source: ABdhPJxOPKZVP7ySV7Nl5PCX8Mm1Snf9yWKNbiUIb/lAB5iulEQyPv0Ag8tJVE7enAoFDrealZeA8g==
X-Received: by 2002:a05:622a:8a:: with SMTP id o10mr16147445qtw.9.1614645037015;
        Mon, 01 Mar 2021 16:30:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id l29sm5928848qtu.35.2021.03.01.16.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 16:30:36 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lGsvr-003KNN-RN; Mon, 01 Mar 2021 20:30:35 -0400
Date:   Mon, 1 Mar 2021 20:30:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 0/5] mm/hugetlb: Early cow on fork, and a few cleanups
Message-ID: <20210302003035.GE444867@ziepe.ca>
References: <20210217233547.93892-1-peterx@redhat.com>
 <20210301141151.GA397383@xz-x1>
 <20210301162846.c1f684a5662d37bbec3f1892@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301162846.c1f684a5662d37bbec3f1892@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:28:46PM -0800, Andrew Morton wrote:
> On Mon, 1 Mar 2021 09:11:51 -0500 Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, Feb 17, 2021 at 06:35:42PM -0500, Peter Xu wrote:
> > > v5:
> > > - patch 4: change "int cow" into "bool cow"
> > > - collect r-bs for Jason
> > 
> > Andrew,
> > 
> > I just noticed 5.12-rc1 has released; is this series still possible to make it
> > for 5.12, or needs to wait for 5.13?
> > 
> 
> It has taken a while to settle down.  What is the case for
> fast-tracking it into 5.12?

IIRC hugetlb users and fork and DMA will get the unexpected VA
corruption that triggered all this work.

Jason
