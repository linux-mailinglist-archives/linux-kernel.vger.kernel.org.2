Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6B031E9B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhBRMYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:24:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232996AbhBRKrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:47:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 827E864DF0;
        Thu, 18 Feb 2021 10:46:29 +0000 (UTC)
Date:   Thu, 18 Feb 2021 10:46:26 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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
Subject: Re: [PATCH RESEND] mm, kasan: don't poison boot memory
Message-ID: <20210218104626.GA12761@arm.com>
References: <8d79640cdab4608c454310881b6c771e856dbd2e.1613595522.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d79640cdab4608c454310881b6c771e856dbd2e.1613595522.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 09:59:24PM +0100, Andrey Konovalov wrote:
> During boot, all non-reserved memblock memory is exposed to the buddy
> allocator. Poisoning all that memory with KASAN lengthens boot time,
> especially on systems with large amount of RAM. This patch makes
> page_alloc to not call kasan_free_pages() on all new memory.
> 
> __free_pages_core() is used when exposing fresh memory during system
> boot and when onlining memory during hotplug. This patch adds a new
> FPI_SKIP_KASAN_POISON flag and passes it to __free_pages_ok() through
> free_pages_prepare() from __free_pages_core().
> 
> This has little impact on KASAN memory tracking.
> 
> Assuming that there are no references to newly exposed pages before they
> are ever allocated, there won't be any intended (but buggy) accesses to
> that memory that KASAN would normally detect.
> 
> However, with this patch, KASAN stops detecting wild and large
> out-of-bounds accesses that happen to land on a fresh memory page that
> was never allocated. This is taken as an acceptable trade-off.
> 
> All memory allocated normally when the boot is over keeps getting
> poisoned as usual.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

The approach looks fine to me. If you don't like the trade-off, I think
you could still leave the kasan poisoning in if CONFIG_DEBUG_KERNEL.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Just curious, have you noticed any issue booting a KASAN_SW_TAGS-enabled
kernel on a system with sufficiently large RAM? Is the boot slow-down
significant?

For MTE, we could look at optimising the poisoning code for page size to
use STGM or DC GZVA but I don't think we can make it unnoticeable for
large systems (especially with DC GZVA, that's like zeroing the whole
RAM at boot).

-- 
Catalin
