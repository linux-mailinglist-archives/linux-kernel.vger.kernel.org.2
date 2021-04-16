Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C963618F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 06:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhDPEnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 00:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhDPEnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 00:43:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FA7861152;
        Fri, 16 Apr 2021 04:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618548177;
        bh=4hdUt+EDEa/QUCWdkHyC/ffQXQkj9XGd5bdPb0nZqGI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RNNe76AAteWei9QEDSL1+ENgDEJidm7Scx0Nb9Fw6YLe6E3uthLjhZOlN8AkQawCo
         ZA6hax7FBKFVQOgw4NMNqmUEnQZFMiKWRK00jPFL+7Ma3F7QFwwGTU3dnMwIGLMAPM
         kCe/spG4cTm8k7j6pd3G68MQHQm3B3T3G9izCZAAZLz0btelgxzH1O7l8sYLkMWNT/
         Z8pfsZprZJLYT8dIZDL19ohTcVmRZxjaV6ye5G7J4pisc210LpvtjFQav7dYWGXGjN
         LzAlloF6mXhz+8IKecok97GDGZmsC6OLJdnkP8okaH7Ocf4iL9ToGbVFujqYCdVZOS
         U1gVdCgxBxtdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D68475C013E; Thu, 15 Apr 2021 21:42:56 -0700 (PDT)
Date:   Thu, 15 Apr 2021 21:42:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Roman Gushchin <guro@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [RFC PATCH] percpu_ref: Make percpu_ref_tryget*() ACQUIRE
 operations
Message-ID: <20210416044256.GE4212@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210413024703.2745636-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413024703.2745636-1-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:47:03AM +0800, Huang Ying wrote:
> One typical use case of percpu_ref_tryget() family functions is as
> follows,
> 
>   if (percpu_ref_tryget(&p->ref)) {
> 	  /* Operate on the other fields of *p */
>   }
> 
> The refcount needs to be checked before operating on the other fields
> of the data structure (*p), otherwise, the values gotten from the
> other fields may be invalid or inconsistent.  To guarantee the correct
> memory ordering, percpu_ref_tryget*() needs to be the ACQUIRE
> operations.

I am not seeing the need for this.

If __ref_is_percpu() returns true, then the overall count must be non-zero
and there will be an RCU grace period between now and the time that this
count becomes zero.  For the calls to __ref_is_percpu() enclosed within
rcu_read_lock() and rcu_read_unlock(), the grace period will provide
the needed ordering.  (See the comment header for the synchronize_rcu()
function.)

Otherwise, when __ref_is_percpu() returns false, its caller does a
value-returning atomic read-modify-write operation, which provides
full ordering.

Either way, the required acquire semantics (and more) are already
provided, and in particular, this analysis covers the percpu_ref_tryget()
you call out above.

Or am I missing something subtle here?

							Thanx, Paul

> This function implements that via using smp_load_acquire() in
> __ref_is_percpu() to read the percpu pointer.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/percpu-refcount.h | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index 16c35a728b4c..9838f7ea4bf1 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -165,13 +165,13 @@ static inline bool __ref_is_percpu(struct percpu_ref *ref,
>  	 * !__PERCPU_REF_ATOMIC, which may be set asynchronously, and then
>  	 * used as a pointer.  If the compiler generates a separate fetch
>  	 * when using it as a pointer, __PERCPU_REF_ATOMIC may be set in
> -	 * between contaminating the pointer value, meaning that
> -	 * READ_ONCE() is required when fetching it.
> +	 * between contaminating the pointer value, smp_load_acquire()
> +	 * will prevent this.
>  	 *
> -	 * The dependency ordering from the READ_ONCE() pairs
> +	 * The dependency ordering from the smp_load_acquire() pairs
>  	 * with smp_store_release() in __percpu_ref_switch_to_percpu().
>  	 */
> -	percpu_ptr = READ_ONCE(ref->percpu_count_ptr);
> +	percpu_ptr = smp_load_acquire(&ref->percpu_count_ptr);
>  
>  	/*
>  	 * Theoretically, the following could test just ATOMIC; however,
> @@ -231,6 +231,9 @@ static inline void percpu_ref_get(struct percpu_ref *ref)
>   * Returns %true on success; %false on failure.
>   *
>   * This function is safe to call as long as @ref is between init and exit.
> + *
> + * This function is an ACQUIRE operation, that is, all memory operations
> + * after will appear to happen after checking the refcount.
>   */
>  static inline bool percpu_ref_tryget_many(struct percpu_ref *ref,
>  					  unsigned long nr)
> @@ -260,6 +263,9 @@ static inline bool percpu_ref_tryget_many(struct percpu_ref *ref,
>   * Returns %true on success; %false on failure.
>   *
>   * This function is safe to call as long as @ref is between init and exit.
> + *
> + * This function is an ACQUIRE operation, that is, all memory operations
> + * after will appear to happen after checking the refcount.
>   */
>  static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>  {
> @@ -280,6 +286,9 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>   * percpu_ref_tryget_live().
>   *
>   * This function is safe to call as long as @ref is between init and exit.
> + *
> + * This function is an ACQUIRE operation, that is, all memory operations
> + * after will appear to happen after checking the refcount.
>   */
>  static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
>  {
> -- 
> 2.30.2
> 
