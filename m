Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799B03A0835
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhFIAUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhFIAUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:20:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAFB861351;
        Wed,  9 Jun 2021 00:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623197904;
        bh=zoZQCa3hwPolKgshUpp1Gt3IouzsGtd/uZN730lmPu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vt9lOuEzbBe83l+G3U9F9okXpHkFJFXn4c/gleturogPX2v24pPv9d67oIgY8mlfN
         cPdHqnoZiXyaPsvogwB+oIrLObR93orIBLFK49vCTnT4ZT0lN5ZOpZ65sxVO/umnIi
         NTayE0L2f3qYHQCHDeqJ9Qe8gwsk6wXQHbG3n0YZaKJjmKM5tWfTeavCWvIWJFRnQR
         0OJzX+ntiGupacehSnlpIp/SnRtndHxSkWYv00DFQoVMl6e4gwWbtJvXfDCjU/DKVu
         aKdYngeQX6UxPZW1rY2OTOV7tlln79XtH6nuMGnRKhAMjULL3dhdNbU+bTi9loBunz
         lGPZx5H5tR5hA==
Date:   Wed, 9 Jun 2021 09:18:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] lib: Fix spelling mistakes in header files
Message-Id: <20210609091821.32b82ba464f6f9aecc3a7d59@kernel.org>
In-Reply-To: <20210608021932.12581-2-thunder.leizhen@huawei.com>
References: <20210608021932.12581-1-thunder.leizhen@huawei.com>
        <20210608021932.12581-2-thunder.leizhen@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 10:19:32 +0800
Zhen Lei <thunder.leizhen@huawei.com> wrote:

> Fix some spelling mistakes in comments found by "codespell":
> Hoever ==> However
> poiter ==> pointer
> representaion ==> representation
> uppon ==> upon
> independend ==> independent
> aquired ==> acquired
> mis-match ==> mismatch
> scrach ==> scratch
> struture ==> structure
> Analagous ==> Analogous
> interation ==> iteration
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  include/linux/bootconfig.h      | 2 +-

Looks good to me for the bootconfig.h.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

>  include/linux/cpumask.h         | 2 +-
>  include/linux/debugobjects.h    | 2 +-
>  include/linux/lru_cache.h       | 8 ++++----
>  include/linux/nodemask.h        | 6 +++---
>  include/linux/percpu-refcount.h | 2 +-
>  include/linux/scatterlist.h     | 2 +-
>  7 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index 2696eb0fc149..3dc0b7ed4b58 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -165,7 +165,7 @@ static inline struct xbc_node * __init xbc_find_node(const char *key)
>   * is stroed to @anode and @value. If the @node doesn't have @key node,
>   * it does nothing.
>   * Note that even if the found key node has only one value (not array)
> - * this executes block once. Hoever, if the found key node has no value
> + * this executes block once. However, if the found key node has no value
>   * (key-only node), this does nothing. So don't use this for testing the
>   * key-value pair existence.
>   */
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index bfc4690de4f4..f3689a52bfd0 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -259,7 +259,7 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
>  /**
>   * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
>   * @cpu: the (optionally unsigned) integer iterator
> - * @mask: the cpumask poiter
> + * @mask: the cpumask pointer
>   * @start: the start location
>   *
>   * The implementation does not assume any bit in @mask is set (including @start).
> diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
> index 8d2dde23e9fb..32444686b6ff 100644
> --- a/include/linux/debugobjects.h
> +++ b/include/linux/debugobjects.h
> @@ -18,7 +18,7 @@ enum debug_obj_state {
>  struct debug_obj_descr;
>  
>  /**
> - * struct debug_obj - representaion of an tracked object
> + * struct debug_obj - representation of an tracked object
>   * @node:	hlist node to link the object into the tracker list
>   * @state:	tracked object state
>   * @astate:	current active state
> diff --git a/include/linux/lru_cache.h b/include/linux/lru_cache.h
> index 429d67d815ce..f65c6734be3c 100644
> --- a/include/linux/lru_cache.h
> +++ b/include/linux/lru_cache.h
> @@ -32,7 +32,7 @@ This header file (and its .c file; kernel-doc of functions see there)
>    Because of this later property, it is called "lru_cache".
>    As it actually Tracks Objects in an Active SeT, we could also call it
>    toast (incidentally that is what may happen to the data on the
> -  backend storage uppon next resync, if we don't get it right).
> +  backend storage upon next resync, if we don't get it right).
>  
>  What for?
>  
> @@ -152,7 +152,7 @@ struct lc_element {
>  	 * for paranoia, and for "lc_element_to_index" */
>  	unsigned lc_index;
>  	/* if we want to track a larger set of objects,
> -	 * it needs to become arch independend u64 */
> +	 * it needs to become arch independent u64 */
>  	unsigned lc_number;
>  	/* special label when on free list */
>  #define LC_FREE (~0U)
> @@ -263,7 +263,7 @@ extern void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char
>   *
>   * Allows (expects) the set to be "dirty".  Note that the reference counts and
>   * order on the active and lru lists may still change.  Used to serialize
> - * changing transactions.  Returns true if we aquired the lock.
> + * changing transactions.  Returns true if we acquired the lock.
>   */
>  static inline int lc_try_lock_for_transaction(struct lru_cache *lc)
>  {
> @@ -275,7 +275,7 @@ static inline int lc_try_lock_for_transaction(struct lru_cache *lc)
>   * @lc: the lru cache to operate on
>   *
>   * Note that the reference counts and order on the active and lru lists may
> - * still change.  Only works on a "clean" set.  Returns true if we aquired the
> + * still change.  Only works on a "clean" set.  Returns true if we acquired the
>   * lock, which means there are no pending changes, and any further attempt to
>   * change the set will not succeed until the next lc_unlock().
>   */
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index ac398e143c9a..cfa21b78b8d5 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -119,7 +119,7 @@ static inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
>   * The inline keyword gives the compiler room to decide to inline, or
>   * not inline a function as it sees best.  However, as these functions
>   * are called in both __init and non-__init functions, if they are not
> - * inlined we will end up with a section mis-match error (of the type of
> + * inlined we will end up with a section mismatch error (of the type of
>   * freeable items not being freed).  So we must use __always_inline here
>   * to fix the problem.  If other functions in the future also end up in
>   * this situation they will also need to be annotated as __always_inline
> @@ -515,7 +515,7 @@ static inline int node_random(const nodemask_t *mask)
>  #define for_each_online_node(node) for_each_node_state(node, N_ONLINE)
>  
>  /*
> - * For nodemask scrach area.
> + * For nodemask scratch area.
>   * NODEMASK_ALLOC(type, name) allocates an object with a specified type and
>   * name.
>   */
> @@ -528,7 +528,7 @@ static inline int node_random(const nodemask_t *mask)
>  #define NODEMASK_FREE(m)			do {} while (0)
>  #endif
>  
> -/* A example struture for using NODEMASK_ALLOC, used in mempolicy. */
> +/* A example structure for using NODEMASK_ALLOC, used in mempolicy. */
>  struct nodemask_scratch {
>  	nodemask_t	mask1;
>  	nodemask_t	mask2;
> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index 16c35a728b4c..ae16a9856305 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -213,7 +213,7 @@ static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>   * percpu_ref_get - increment a percpu refcount
>   * @ref: percpu_ref to get
>   *
> - * Analagous to atomic_long_inc().
> + * Analogous to atomic_long_inc().
>   *
>   * This function is safe to call as long as @ref is between init and exit.
>   */
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 6f70572b2938..ecf87484814f 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -474,7 +474,7 @@ sg_page_iter_dma_address(struct sg_dma_page_iter *dma_iter)
>   * Iterates over sg entries mapping page-by-page.  On each successful
>   * iteration, @miter->page points to the mapped page and
>   * @miter->length bytes of data can be accessed at @miter->addr.  As
> - * long as an interation is enclosed between start and stop, the user
> + * long as an iteration is enclosed between start and stop, the user
>   * is free to choose control structure and when to stop.
>   *
>   * @miter->consumed is set to @miter->length on each iteration.  It
> -- 
> 2.25.1
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
