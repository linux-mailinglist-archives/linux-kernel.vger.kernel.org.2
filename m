Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEB632A085
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381210AbhCBEWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376589AbhCBA3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:29:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98E9560200;
        Tue,  2 Mar 2021 00:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614644928;
        bh=q+Ro9LOC5Ynp2Uu+csSjVDOIngShUyzhG+fjXt+r0oI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CQm0Mvsq+50Lq6EefU+3+op0jJRkvpkFVknHHUlCFTsXR6NaHBvdTnMIO3JztTVsA
         XRaZ/o4ncZ3h9vwqpZDu8XVnjdxO8d2w/mM41Z1W0uJ+M6NzX1q/sf1ZY51BRGBH5F
         Z2Bh6TtSvRNYVzK8EaTfvEsJqZYtvE/5YLtABQf8=
Date:   Mon, 1 Mar 2021 16:28:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 0/5] mm/hugetlb: Early cow on fork, and a few
 cleanups
Message-Id: <20210301162846.c1f684a5662d37bbec3f1892@linux-foundation.org>
In-Reply-To: <20210301141151.GA397383@xz-x1>
References: <20210217233547.93892-1-peterx@redhat.com>
        <20210301141151.GA397383@xz-x1>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 09:11:51 -0500 Peter Xu <peterx@redhat.com> wrote:

> On Wed, Feb 17, 2021 at 06:35:42PM -0500, Peter Xu wrote:
> > v5:
> > - patch 4: change "int cow" into "bool cow"
> > - collect r-bs for Jason
> 
> Andrew,
> 
> I just noticed 5.12-rc1 has released; is this series still possible to make it
> for 5.12, or needs to wait for 5.13?
> 

It has taken a while to settle down.  What is the case for
fast-tracking it into 5.12?
