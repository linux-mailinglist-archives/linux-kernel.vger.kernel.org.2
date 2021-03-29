Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFEF34D2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhC2Ovb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhC2OvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:51:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7B2C61932;
        Mon, 29 Mar 2021 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617029460;
        bh=CNpOXw8lVzu5h03kCKJA5hVce5TYus6KlINeK8XkzRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyXqJgLhA585RYY/VmTB96DvW+AVS6g5pjyW/s0kPWCtxGKRNKNzPagUvTi3WJmwh
         BAae2KXVXBvVN977z+WjNtKN7+w1NmySHFUKNq9TzTupDUr/sQMbo2n+JVmPx2KNJ5
         1XxxT+Amj0AhNkWtyk8CTDAisij00HrdUMLcP1941mAd798wr5m/kEQQAZ7GU9Fawy
         ++R/GGmeJa1RSgmQ6qWzLm7RhwBpV9beSwiw1meQT5Fk7ohoLHHKc5I7RWnvHEWt/2
         JMMS5R8GngzNs5e/c04Czy+pLpd9aOQ+DwZmAi5BswVOvvLfgOcPYk5rxmude980tZ
         xipUAAKUybe0g==
Date:   Mon, 29 Mar 2021 15:50:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Nikitas Angelinas <nikitas.angelinas@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/mutex: initialize osq lock in
 __MUTEX_INITIALIZER()
Message-ID: <20210329145055.GC4203@willie-the-truck>
References: <YGF+hDytO8r9Iv2o@vostro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGF+hDytO8r9Iv2o@vostro>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 12:15:16AM -0700, Nikitas Angelinas wrote:
> Since __MUTEX_INITIALIZER() is used on memory that is initialized to 0
> anyway this change should not have an effect, but it seems better to
> initialize osq explicitly for completeness, as done in other macros and
> functions that initialize mutex and rwsem.
> 
> Signed-off-by: Nikitas Angelinas <nikitas.angelinas@gmail.com>
> ---
>  include/linux/mutex.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 515cff7..bff47f8 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -129,10 +129,18 @@ do {									\
>  # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
>  #endif
>  
> +#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
> +# define __OSQ_MUTEX_INITIALIZER(lockname)			\
> +		, .osq = OSQ_LOCK_UNLOCKED
> +#else
> +# define __OSQ_MUTEX_INITIALIZER(lockname)
> +#endif
> +
>  #define __MUTEX_INITIALIZER(lockname) \
>  		{ .owner = ATOMIC_LONG_INIT(0) \
>  		, .wait_lock = __SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
>  		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
> +		__OSQ_MUTEX_INITIALIZER(lockname) \

You don't need the lockname parameter for this macro.

Will
