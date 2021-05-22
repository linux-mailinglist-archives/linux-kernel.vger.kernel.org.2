Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF32C38D79A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 00:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhEVWK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 18:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhEVWK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 18:10:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA2A661182;
        Sat, 22 May 2021 22:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621721341;
        bh=fQ0aMPh12hl+5c7WBOSl31XItRi0ATmMKJSFriH63vw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wOkXc1V/JbPb5GHrwUa9gxLporsN9D101phMZvDCVmuEtJ7Zh/TA2TcRzzdfyK1n4
         9+6FMbLyjX5EUIGa2Fip8UkowFZE+y5P7L8kpIyCE2qkUMtYu3z5ZGh21mffn0Vu6n
         TfmrafZ6jBwSPw0npvfmELrgDPUXGuU2TNjvwujc=
Date:   Sat, 22 May 2021 15:09:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Message-Id: <20210522150900.39d6832a03c5f772911c5b6d@linux-foundation.org>
In-Reply-To: <20210521030156.2612074-2-nao.horiguchi@gmail.com>
References: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
        <20210521030156.2612074-2-nao.horiguchi@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 12:01:54 +0900 Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:

> There can be races when multiple CPUs consume poison from the same
> page. The first into memory_failure() atomically sets the HWPoison
> page flag and begins hunting for tasks that map this page. Eventually
> it invalidates those mappings and may send a SIGBUS to the affected
> tasks.
> 
> But while all that work is going on, other CPUs see a "success"
> return code from memory_failure() and so they believe the error
> has been handled and continue executing.
> 
> Fix by wrapping most of the internal parts of memory_failure() in
> a mutex.

We can reduce the scope of that mutex, which helps readability at least.

--- a/mm/memory-failure.c~mm-memory-failure-use-a-mutex-to-avoid-memory_failure-races-fix
+++ a/mm/memory-failure.c
@@ -1397,8 +1397,6 @@ out:
 	return rc;
 }
 
-static DEFINE_MUTEX(mf_mutex);
-
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -1425,6 +1423,7 @@ int memory_failure(unsigned long pfn, in
 	int res = 0;
 	unsigned long page_flags;
 	bool retry = true;
+	static DEFINE_MUTEX(mf_mutex);
 
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
_

