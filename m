Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA1416A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbhIXCpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233314AbhIXCpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:45:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 181AA610CB;
        Fri, 24 Sep 2021 02:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632451424;
        bh=F3QkKswuGwQOCXfk/SaqNE24XSVoy4mqskLjR596bIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NF4px9H06Hlw8rFhwiBjM+5UT5NYYROaIqe5rA0lXMeYHV596JNvS19bxrNuJ6BRc
         iUbLfYv3mjkROkmuJYuau4wv41xtutbQu3+yrXSgYoovteZJlKV/4N904TYIvHkzcY
         QgYhPsbQnRMtaW2FSXSwzshtXK4bIbaxk3WykHYE=
Date:   Thu, 23 Sep 2021 19:43:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        song@kernel.org, william.kucharski@oracle.com,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Message-Id: <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
In-Reply-To: <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
        <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
        <YUsVcEDcQ2vEzjGg@casper.infradead.org>
        <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 01:04:54 +0800 Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:

> 
> 
> > On Sep 22, 2021, at 7:37 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > On Wed, Sep 22, 2021 at 03:06:44PM +0800, Rongwei Wang wrote:
> >> Transparent huge page has supported read-only non-shmem files. The file-
> >> backed THP is collapsed by khugepaged and truncated when written (for
> >> shared libraries).
> >> 
> >> However, there is race in two possible places.
> >> 
> >> 1) multiple writers truncate the same page cache concurrently;
> >> 2) collapse_file rolls back when writer truncates the page cache;
> > 
> > As I've said before, the bug here is that somehow there is a writable fd
> > to a file with THPs.  That's what we need to track down and fix.
> Hi, Matthew
> I am not sure get your means. We know “mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs"
> Introduced file-backed THPs for DSO. It is possible {very rarely} for DSO to be opened in writeable way.
>
> ...
>
> > https://lore.kernel.org/linux-mm/YUdL3lFLFHzC80Wt@casper.infradead.org/
> All in all, what you mean is that we should solve this race at the source?

Matthew is being pretty clear here: we shouldn't be permitting
userspace to get a writeable fd for a thp-backed file.

Why are we permitting the DSO to be opened writeably?  If there's a
legitimate case for doing this then presumably "mm, thp: relax the
VM_DENYWRITE constraint on file-backed THPs: should be fixed or
reverted.

If there is no legitimate use case for returning a writeable fd for a
thp-backed file then we should fail such an attempt at open().  This
approach has back-compatibility issues which need to be thought about. 
Perhaps we should permit the open-writeably attempt to appear to
succeed, but to really return a read-only fd?

