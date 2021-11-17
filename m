Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C50453D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 01:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhKQAfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbhKQAfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:35:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0905A61BC1;
        Wed, 17 Nov 2021 00:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637109174;
        bh=4ehezVXpITBCHc4J+gow4tVXnCNkebvtkbiRdkXSy/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hxrfhUj7qs4e7T6mXSAD3IZWn7BS9hSEvfPE4LPSXT82ansngLJcCW7XcqxPmES2v
         nWdr8uzhGxk00DVmn9p4kHxYHMwlOQKcXgPmQ1hbA3C6ks/9K2UHmCLcTc4sip/Epk
         RF2/wwxo38PPe3CUKb5Sr/CiuEj6S8UtKEnX5ux0=
Date:   Tue, 16 Nov 2021 16:32:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Wei Xu <weixugc@google.com>,
        James Houghton <jthoughton@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hugetlb, userfaultfd: Fix reservation restore on
 userfaultfd error
Message-Id: <20211116163252.0d4643fc0593b8fcaf7aa4ac@linux-foundation.org>
In-Reply-To: <20211116235733.3774702-1-almasrymina@google.com>
References: <20211116235733.3774702-1-almasrymina@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 15:57:32 -0800 Mina Almasry <almasrymina@google.com> wrote:

> Currently in the is_continue case in hugetlb_mcopy_atomic_pte(), if we
> bail out using "goto out_release_unlock;" in the cases where idx >=
> size, or !huge_pte_none(), the code will detect that new_pagecache_page
> == false, and so call restore_reserve_on_error().
> In this case I see restore_reserve_on_error() delete the reservation,
> and the following call to remove_inode_hugepages() will increment
> h->resv_hugepages causing a 100% reproducible leak.
> 
> We should treat the is_continue case similar to adding a page into the
> pagecache and set new_pagecache_page to true, to indicate that there is
> no reservation to restore on the error path, and we need not call
> restore_reserve_on_error().
> 
> Cc: Wei Xu <weixugc@google.com>
> 
> Fixes: c7b1850dfb41 ("hugetlb: don't pass page cache pages to restore_reserve_on_error")

I added cc:stable to this.
