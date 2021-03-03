Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB30532C47D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392395AbhCDAOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353211AbhCDADq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:03:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 145A760233;
        Wed,  3 Mar 2021 23:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614813836;
        bh=YMSyNa4++ljWmknoCKqH6X9s0lAu4Qvhp/VPJBvZ/dk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2nTUbnis/jdNQaDkSQgZIYAczNTMtqPS9fU4RVMq4V6MfaZeLTm8Y8MOig85f7cIY
         /k7rfMBnm65kI3AmI5UDMW7SPPtpJjFszoqQ28M1KX+BqCBTYQYwteMAnGQb7WdiNf
         HVGLEW4b7li43GsVGKhc1UMzFoZ9IvGEG6IT+iqc=
Date:   Wed, 3 Mar 2021 15:23:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kasan, mm: fix crash with HW_TAGS and DEBUG_PAGEALLOC
Message-Id: <20210303152355.fa7c3bcb02862ceefea5ca45@linux-foundation.org>
In-Reply-To: <1aa83e48627978de8068d5e3314185f3a0d7a849.1614302398.git.andreyknvl@google.com>
References: <1aa83e48627978de8068d5e3314185f3a0d7a849.1614302398.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 02:25:37 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> Currently, kasan_free_nondeferred_pages()->kasan_free_pages() is called
> after debug_pagealloc_unmap_pages(). This causes a crash when
> debug_pagealloc is enabled, as HW_TAGS KASAN can't set tags on an
> unmapped page.
> 
> This patch puts kasan_free_nondeferred_pages() before
> debug_pagealloc_unmap_pages().
> 
> Besides fixing the crash, this also makes the annotation order consistent
> with debug_pagealloc_map_pages() preceding kasan_alloc_pages().
> 

This bug exists in 5.12, does it not?

If so, is cc:stable appropriate and if so, do we have a suitable Fixes:
commit?

Thanks.
