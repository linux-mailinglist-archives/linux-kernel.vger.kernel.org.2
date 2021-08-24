Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631B83F5F37
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbhHXNdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237566AbhHXNdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:33:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C14761027;
        Tue, 24 Aug 2021 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629811985;
        bh=oITe/jUwpv9uwAfzTp34OY4XM2xlLHAdToE8Y67MrUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyd7XyESr7DjEar83gnmbRvjvpgtjKFGGW9El2hVGwcTOJm7PPCYwCBTdYVqpYLcm
         uegptsUdy3DN6rF0zpdTiHNmhVrS016seiuE35uBYGdVcRqRuVCjpbApgrhT2vIg7q
         664QU0hkQla59MJa0RAO+wrl8DUcET2sThn4WltEjxUzb9h6Ddr4FnD0lzscDSuDFA
         U4FiYclmCeTerznuOey4fFD6KoocUb4DSVQqeFkQfHV67k7bNzjg2IdRJcDj6F9CGB
         OlleWmAPlC4Xs38Tk/cLYilOPFnHodV9bl34kGAgD6f5iDNdceW/e5q7nWqfqVZGff
         D8O2+TeirN7dw==
Date:   Tue, 24 Aug 2021 16:32:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] x86/mm: write protect (most) page tables
Message-ID: <YST1CrR8i+bhuUtm@kernel.org>
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-5-rppt@kernel.org>
 <1cccc2b6-8b5b-4aee-483d-f10e64a248a5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cccc2b6-8b5b-4aee-483d-f10e64a248a5@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 04:50:10PM -0700, Dave Hansen wrote:
> On 8/23/21 6:25 AM, Mike Rapoport wrote:
> 
> I'm also cringing a bit at hacking this into the page allocator.   A
> *lot* of what you're trying to do with getting large allocations out and
> splitting them up is done very well today by the slab allocators.  It
> might take some rearrangement of 'struct page' metadata to be more slab
> friendly, but it does seem like a close enough fit to warrant investigating.

I did this at the page allocator level in a hope that (1) it would be
possible to use such cache for allocations if different orders and (2)
having a global cache of unmapped pages will utilize memory more
efficiently and will reduce direct map fragmentation.
And slab allocators may be the users of the cache at page allocator level.

For the single use case of page tables, slabs may work, but in more general
case I don't see them as a good fit.

I'll take a closer look to using slab anyway, maybe it'll work out.

-- 
Sincerely yours,
Mike.
