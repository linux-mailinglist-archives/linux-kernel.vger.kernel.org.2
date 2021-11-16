Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AE6452939
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbhKPEvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:51:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244056AbhKPEvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:51:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 526E961C14;
        Tue, 16 Nov 2021 04:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637038124;
        bh=PdWkT3fEJ2JRdNOFrwV/g5qBebbyUBBaFKLRli0LTnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bcfg5PxwN4mu1S+FiPKHF85mqEJqbnLtlWXm6L4NIXoP/i8ClBRVtAup+cFM7zT/Z
         unqYPCp6C7QP7ZiNl2QSu8WpUUz+8nS2iBtmB9yOhEbNPNJaiU6BO4aycQYMY94v5L
         G5mMwOjiVRH0/Y3D/pDK+3BfV/aDNNQ8YxRdVlc0=
Date:   Mon, 15 Nov 2021 20:48:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, <jglisse@redhat.com>,
        <jhubbard@nvidia.com>, <ziy@nvidia.com>, <rcampbell@nvidia.com>,
        <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hmm.c: Allow VM_MIXEDMAP to work with
 hmm_range_fault
Message-Id: <20211115204842.78180ec7f4b0f51b538bbf55@linux-foundation.org>
In-Reply-To: <5535346.2Y9IAguWGx@nvdebian>
References: <20211104012001.2555676-1-apopple@nvidia.com>
        <20211105122557.GA2744544@nvidia.com>
        <5535346.2Y9IAguWGx@nvdebian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2021 18:58:01 +1100 Alistair Popple <apopple@nvidia.com> wrote:

> On Friday, 5 November 2021 11:25:57 PM AEDT Jason Gunthorpe wrote:
> > On Thu, Nov 04, 2021 at 12:20:01PM +1100, Alistair Popple wrote:
> > > hmm_range_fault() can be used instead of get_user_pages() for devices
> > > which allow faulting however unlike get_user_pages() it will return an
> > > error when used on a VM_MIXEDMAP range.
> > > 
> > > To make hmm_range_fault() more closely match get_user_pages() remove
> > > this restriction. This requires dealing with the !ARCH_HAS_PTE_SPECIAL
> > > case in hmm_vma_handle_pte(). Rather than replicating the logic of
> > > vm_normal_page() call it directly and do a check for the zero pfn
> > > similar to what get_user_pages() currently does.
> > > 
> > > Also add a test to hmm selftest to verify functionality.
> > 
> > Please add a fixes line
> 
> This has been the case since hmm_vma_get_pfns() was first introduced. Therefore
> the fixes line is:
> 
> Fixes: da4c3c735ea4 ("mm/hmm/mirror: helper to snapshot CPU page table")
> 
> Should I send a v2 adding that tag or does Andrew normally pick these up along
> with the Reviewed-by?

I got it.

It needed a bit of rework due to the newly-added !pte_devmap() change
in hmm_vma_handle_pte().  Please check carefully?



From: Alistair Popple <apopple@nvidia.com>
Subject: mm/hmm.c: Allow VM_MIXEDMAP to work with hmm_range_fault

hmm_range_fault() can be used instead of get_user_pages() for devices
which allow faulting however unlike get_user_pages() it will return an
error when used on a VM_MIXEDMAP range.

To make hmm_range_fault() more closely match get_user_pages() remove
this restriction. This requires dealing with the !ARCH_HAS_PTE_SPECIAL
case in hmm_vma_handle_pte(). Rather than replicating the logic of
vm_normal_page() call it directly and do a check for the zero pfn
similar to what get_user_pages() currently does.

Also add a test to hmm selftest to verify functionality.

Link: https://lkml.kernel.org/r/20211104012001.2555676-1-apopple@nvidia.com
Fixes: da4c3c735ea4 ("mm/hmm/mirror: helper to snapshot CPU page table")
Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/test_hmm.c                         |   24 +++++++++++++
 mm/hmm.c                               |    5 +-
 tools/testing/selftests/vm/hmm-tests.c |   42 +++++++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

--- a/lib/test_hmm.c~mm-hmmc-allow-vm_mixedmap-to-work-with-hmm_range_fault
+++ a/lib/test_hmm.c
@@ -1086,9 +1086,33 @@ static long dmirror_fops_unlocked_ioctl(
 	return 0;
 }
 
+static int dmirror_fops_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long addr;
+
+	for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
+		struct page *page;
+		int ret;
+
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			return -ENOMEM;
+
+		ret = vm_insert_page(vma, addr, page);
+		if (ret) {
+			__free_page(page);
+			return ret;
+		}
+		put_page(page);
+	}
+
+	return 0;
+}
+
 static const struct file_operations dmirror_fops = {
 	.open		= dmirror_fops_open,
 	.release	= dmirror_fops_release,
+	.mmap		= dmirror_fops_mmap,
 	.unlocked_ioctl = dmirror_fops_unlocked_ioctl,
 	.llseek		= default_llseek,
 	.owner		= THIS_MODULE,
--- a/mm/hmm.c~mm-hmmc-allow-vm_mixedmap-to-work-with-hmm_range_fault
+++ a/mm/hmm.c
@@ -300,7 +300,8 @@ static int hmm_vma_handle_pte(struct mm_
 	 * Since each architecture defines a struct page for the zero page, just
 	 * fall through and treat it like a normal page.
 	 */
-	if (pte_special(pte) && !pte_devmap(pte) &&
+	if (!vm_normal_page(walk->vma, addr, pte) &&
+	    !pte_devmap(pte) &&
 	    !is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
 			pte_unmap(ptep);
@@ -518,7 +519,7 @@ static int hmm_vma_walk_test(unsigned lo
 	struct hmm_range *range = hmm_vma_walk->range;
 	struct vm_area_struct *vma = walk->vma;
 
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP)) &&
+	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)) &&
 	    vma->vm_flags & VM_READ)
 		return 0;
 
--- a/tools/testing/selftests/vm/hmm-tests.c~mm-hmmc-allow-vm_mixedmap-to-work-with-hmm_range_fault
+++ a/tools/testing/selftests/vm/hmm-tests.c
@@ -1251,6 +1251,48 @@ TEST_F(hmm, anon_teardown)
 /*
  * Test memory snapshot without faulting in pages accessed by the device.
  */
+TEST_F(hmm, mixedmap)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned char *m;
+	int ret;
+
+	npages = 1;
+	size = npages << self->page_shift;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = size;
+	buffer->mirror = malloc(npages);
+	ASSERT_NE(buffer->mirror, NULL);
+
+
+	/* Reserve a range of addresses. */
+	buffer->ptr = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE,
+			   self->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Simulate a device snapshotting CPU pagetables. */
+	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device saw. */
+	m = buffer->mirror;
+	ASSERT_EQ(m[0], HMM_DMIRROR_PROT_READ);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Test memory snapshot without faulting in pages accessed by the device.
+ */
 TEST_F(hmm2, snapshot)
 {
 	struct hmm_buffer *buffer;
_


