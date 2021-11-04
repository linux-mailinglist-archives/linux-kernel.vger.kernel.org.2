Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7199E445BB2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 22:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhKDVh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 17:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231142AbhKDVhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 17:37:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D9BD610A8;
        Thu,  4 Nov 2021 21:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1636061683;
        bh=b9ieur7aNNFpZIWaMvq8mLV6GoqPCShUcilWd5TLNdk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0/IS7Ns7MQ8Lr0cS26946mUA1I8PI2l+hMkC9rmDDysMrgINx3UlugGKpcIWJRQAb
         egjnOhSagwsxpVSgpCz2O0aahA9HQwNOIFc3pXFdWPfRwajh5lL6ALm+FAtiB1mjQL
         vgOsiLH9Jg35fJE5v2JckANwndIFLdIpEA9uYVok=
Date:   Thu, 4 Nov 2021 14:34:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v4 1/4] mm/shmem: Unconditionally set pte dirty in
 mfill_atomic_install_pte
Message-Id: <20211104143440.d0056137ee07d3e96d6b56ec@linux-foundation.org>
In-Reply-To: <YVOLG3NIlj+16IUh@t490s>
References: <20210915181456.10739-1-peterx@redhat.com>
        <20210915181456.10739-2-peterx@redhat.com>
        <49fddb9a-4a52-1df-8b7c-dde2a89330bf@google.com>
        <YVI195OZ7t3i3n6t@t490s>
        <256c72c4-ac99-94fb-d76-fab08e5cf5f4@google.com>
        <YVOLG3NIlj+16IUh@t490s>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 17:37:31 -0400 Peter Xu <peterx@redhat.com> wrote:

> > How about a compromise (if you really want to continue with this patch):
> > you leave the SetPageDirty(page) in shmem_mfill_atomic_pte(), where I
> > feel a responsibility for it; but you do whatever works for you with
> > pte_mkdirty() at the mm/userfaultfd.c end?
> 
> Sure.  Duplicating dirty bit is definitely fine to me as it achieves the same
> goal as I hoped - we're still 100% clear we won't free a uffd page without
> being noticed, then that's enough to me for the goal of this patch.  I won't
> initiate that NACK myself since I still think duplicating is unnecessary no
> matter it resides in shmem or uffd code, but please go ahead doing that and
> I'll be fine with it, just in case Andrew didn't follow the details.

I think Hugh was asking you to implement this...

I guess I'll send this patch upstream.  But it does sound like Hugh
would prefer a followon patch for this kernel release which makes the
above change, please.

