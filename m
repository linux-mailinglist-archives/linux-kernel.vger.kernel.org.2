Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7601032A3CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382530AbhCBJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:39:39 -0500
Received: from vmi485042.contaboserver.net ([161.97.139.209]:38110 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1837942AbhCBJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:15:42 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Mar 2021 04:15:41 EST
Received: by gentwo.de (Postfix, from userid 1001)
        id C7556B00C98; Tue,  2 Mar 2021 10:14:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C5F01B00C5F;
        Tue,  2 Mar 2021 10:14:53 +0100 (CET)
Date:   Tue, 2 Mar 2021 10:14:53 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Pekka Enberg <penberg@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/3] mm/slub: Use percpu partial free counter
In-Reply-To: <1597061872-58724-4-git-send-email-xlpang@linux.alibaba.com>
Message-ID: <alpine.DEB.2.22.394.2103021012010.860725@gentwo.de>
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com> <1597061872-58724-4-git-send-email-xlpang@linux.alibaba.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020, Xunlei Pang wrote:

>
> diff --git a/mm/slab.h b/mm/slab.h
> index c85e2fa..a709a70 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -616,7 +616,7 @@ struct kmem_cache_node {
>  #ifdef CONFIG_SLUB
>  	unsigned long nr_partial;
>  	struct list_head partial;
> -	atomic_long_t partial_free_objs;
> +	atomic_long_t __percpu *partial_free_objs;

A percpu counter is never atomic. Just use unsigned long and use this_cpu
operations for this thing. That should cut down further on the overhead.

> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1775,11 +1775,21 @@ static void discard_slab(struct kmem_cache *s, struct page *page)
>  /*
>   * Management of partially allocated slabs.
>   */
> +static inline long get_partial_free(struct kmem_cache_node *n)
> +{
> +	long nr = 0;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		nr += atomic_long_read(per_cpu_ptr(n->partial_free_objs, cpu));

this_cpu_read(*n->partial_free_objs)

>  static inline void
>  __update_partial_free(struct kmem_cache_node *n, long delta)
>  {
> -	atomic_long_add(delta, &n->partial_free_objs);
> +	atomic_long_add(delta, this_cpu_ptr(n->partial_free_objs));

this_cpu_add()

and so on.
