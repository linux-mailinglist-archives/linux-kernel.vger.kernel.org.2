Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4EF33EBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCQIw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhCQIwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:52:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0ECE364E27;
        Wed, 17 Mar 2021 08:52:28 +0000 (UTC)
Date:   Wed, 17 Mar 2021 08:52:26 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        andreyknvl@google.com, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Luis Henriques <lhenriques@suse.de>
Subject: Re: [PATCH mm] kfence: make compatible with kmemleak
Message-ID: <20210317085225.GA12269@arm.com>
References: <20210317084740.3099921-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317084740.3099921-1-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 09:47:40AM +0100, Marco Elver wrote:
> Because memblock allocations are registered with kmemleak, the KFENCE
> pool was seen by kmemleak as one large object. Later allocations through
> kfence_alloc() that were registered with kmemleak via
> slab_post_alloc_hook() would then overlap and trigger a warning.
> Therefore, once the pool is initialized, we can remove (free) it from
> kmemleak again, since it should be treated as allocator-internal and be
> seen as "free memory".
> 
> The second problem is that kmemleak is passed the rounded size, and not
> the originally requested size, which is also the size of KFENCE objects.
> To avoid kmemleak scanning past the end of an object and trigger a
> KFENCE out-of-bounds error, fix the size if it is a KFENCE object.
> 
> For simplicity, to avoid a call to kfence_ksize() in
> slab_post_alloc_hook() (and avoid new IS_ENABLED(CONFIG_DEBUG_KMEMLEAK)
> guard), just call kfence_ksize() in mm/kmemleak.c:create_object().
> 
> Reported-by: Luis Henriques <lhenriques@suse.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
