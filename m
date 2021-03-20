Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E62D342E63
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 17:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCTQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 12:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhCTQcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 12:32:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5060161944;
        Sat, 20 Mar 2021 16:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616257958;
        bh=Bl8G1B2SSUB12O7P9gYaeP6Qr+D8nLA7fC0tOMa56nM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pdm+IlCZPt2t0IVKks5H0qWalupAigJeOR8ZAdo0+W1DtWi1KPYuepKOOZMfYbDEe
         N+Bbra1Ll95QtzAX7cTnuh58I/o3wtH6zyx9BIOprHyO+SL+XyKEkncKobqfKESA9v
         ZPjIFy3HrtIG4XT72bU5ZpWjtx6mNAgbcgAVBa1Q=
Date:   Sat, 20 Mar 2021 09:32:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bui Quang Minh <minhquangbui99@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH] userfaultfd: Write protect when virtual memory range
 has no page table entry
Message-Id: <20210320093237.c369eba59a0e5f452109c4ef@linux-foundation.org>
In-Reply-To: <20210319152428.52683-1-minhquangbui99@gmail.com>
References: <20210319152428.52683-1-minhquangbui99@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 22:24:28 +0700 Bui Quang Minh <minhquangbui99@gmail.com> wrote:

> userfaultfd_writeprotect() use change_protection() to clear write bit in
> page table entries (pte/pmd). So, later write to this virtual address
> range causes a page fault, which is then handled by userspace program.
> However, change_protection() has no effect when there is no page table
> entries associated with that virtual memory range (a newly mapped memory
> range). As a result, later access to that memory range causes allocating a
> page table entry with write bit still set (due to VM_WRITE flag in
> vma->vm_flags).
> 
> Add checks for VM_UFFD_WP in vma->vm_flags when allocating new page table
> entry in missing page table entry page fault path.

This sounds like a pretty significant bug?

Would it be possible to add a test to
tools/testing/selftests/vm/userfaultfd.c to check for this?  It should
fail without your patch and succeed with it.

Thanks.
