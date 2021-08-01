Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E4B3DCD78
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhHATt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhHATtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:49:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9265E60F48;
        Sun,  1 Aug 2021 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627847357;
        bh=NTAguXKSk7YmzRLIg8c4guzvhTisx0c9C03a7Nlyj0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YOoCmi2lFdEaPtaYD77vZpRAJf2VVhXEelHOrQjZnwTuHmEANlsEWHa7qsVv9OGH8
         CGDu7AxTpCDyR+YmCJ9k77b+6YOgTJY16BAynxC8wnyLZT7DMjaCKoDudJcH4ztoj4
         /hGHSFfDBsTSKnv0otaLCFi95EH3O8zY+QH1txas=
Date:   Sun, 1 Aug 2021 12:49:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Ken Chen <kenchen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH v1] mm, hugepages: add mremap() support for hugepage
 backed vma
Message-Id: <20210801124917.ca6fce3972866dc738bfcb7b@linux-foundation.org>
In-Reply-To: <20210730221522.524256-1-almasrymina@google.com>
References: <20210730221522.524256-1-almasrymina@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 15:15:22 -0700 Mina Almasry <almasrymina@google.com> wrote:

> Support mremap() for hugepage backed vma segment by simply repositioning
> page table entries. The page table entries are repositioned to the new
> virtual address on mremap().
> 
> Hugetlb mremap() support is of course generic; my motivating use case
> is a library (hugepage_text), which reloads the ELF text of executables
> in hugepages. This significantly increases the execution performance of
> said executables.
> 
> Restricts the mremap operation on hugepages to up to the size of the
> original mapping as the underlying hugetlb reservation is not yet
> capable of handling remapping to a larger size.
> 
> Tested with a simple mmap/mremap test case, roughly:
> 
> void* haddr = mmap(NULL, size, PROT_READ | PROT_WRITE | PROT_EXEC,
> 		MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> 
> void* taddr = mmap(NULL, size, PROT_NONE,
> 		MAP_HUGETLB | MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> 
> void* raddr = mremap(haddr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, taddr);

Could we please get testing for this added into tools/testing/selftests/?
