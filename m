Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD739458B77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhKVJb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:31:59 -0500
Received: from gentwo.de ([161.97.139.209]:50146 "EHLO gentwo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239021AbhKVJbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:31:55 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Nov 2021 04:31:54 EST
Received: by gentwo.de (Postfix, from userid 1001)
        id 646C5B003B1; Mon, 22 Nov 2021 10:22:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 62F82B002E6;
        Mon, 22 Nov 2021 10:22:28 +0100 (CET)
Date:   Mon, 22 Nov 2021 10:22:28 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Rustam Kovhaev <rkovhaev@gmail.com>
cc:     vbabka@suse.cz, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, corbet@lwn.net,
        djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, dvyukov@google.com
Subject: Re: [PATCH v4] slob: add size header to all allocations
In-Reply-To: <20211122013026.909933-1-rkovhaev@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de>
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz> <20211122013026.909933-1-rkovhaev@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021, Rustam Kovhaev wrote:

> Let's prepend both kmalloc() and kmem_cache_alloc() allocations with the
> size header.
> It simplifies the slab API and guarantees that both kmem_cache_alloc()
> and kmalloc() memory could be freed by kfree().
>
> meminfo right after the system boot, x86-64 on xfs, without the patch:
> Slab:              34700 kB
>
> the same, with the patch:
> Slab:              35752 kB

> +#define SLOB_HDR_SIZE max(ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN)

Ok that is up to 128 bytes on some architectues. Mostly 32 or 64 bytes.

> @@ -307,6 +303,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
>  	unsigned long flags;
>  	bool _unused;
>
> +	size += SLOB_HDR_SIZE;

And every object now has this overhead? 128 bytes extra in extreme cases
per object?


> -	if (size < PAGE_SIZE - minalign) {
> -		int align = minalign;
> +	if (size < PAGE_SIZE - SLOB_HDR_SIZE) {
> +		int align = SLOB_HDR_SIZE;

And the object is also aligned to 128 bytes boundaries on some
architectures.

So a 4 byte object occupies 256 bytes in SLOB?

SLOB will no longer be a low memory overhead allocator then.


