Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125C03E46D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhHINlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233726AbhHINlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:41:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44C6661019;
        Mon,  9 Aug 2021 13:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628516453;
        bh=hT7LUl3BDmjtvsjoYEQ5DHDr/BtZa9AQp0ujIPii340=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQsOmkydIdMNDmfU+DkCy5nVJ1jbouiKpyDAKSxVnrgVi6JSNN+CFjgcc0sc65V/2
         Tqit//6GaJbd0ZPlX20Ylck6+41Rt2I8Dcl/qwVhakVWJRizzmoDJJ5T0cDL/AIcTM
         Fjne9nL4yvUeLrncuSI5LN7OlXkcQ2Z+im6C2vrkQLDuclxsC0HOJfHSRcituoVn6s
         XF5iKdvbh43BeI/ddHWdBh+cnVrlfaufVSKogeuBpEKTsP+QPq3yYjYvS/UTcx5FFn
         XBdOolAJGggBZ8ZRcPt/5bDQ6re2nrVrVXLmXYnpNJMs2uiaCLWQZEcburCNyiDWHf
         bCUXyZ32sVWmQ==
Date:   Mon, 9 Aug 2021 14:40:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        boqun.feng@gmail.com, wanghaibin.wang@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/qspinlock: Fix typo of lock word transition in
 the uncontended case
Message-ID: <20210809134047.GB1207@willie-the-truck>
References: <20210715030847.2038-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715030847.2038-1-yuzenghui@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:08:47AM +0800, Zenghui Yu wrote:
> If the queue head is the only one in the queue and nobody is concurrently
> setting PENDING bit, the uncontended transition should be n,0,0 -> 0,0,1.
> 
> Fix the typo.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  kernel/locking/qspinlock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index cbff6ba53d56..591835415698 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -355,7 +355,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	 * If we observe contention, there is a concurrent locker.
>  	 *
>  	 * Undo and queue; our setting of PENDING might have made the
> -	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
> +	 * n,0,0 -> 0,0,1 transition fail and it will now be waiting
>  	 * on @next to become !NULL.
>  	 */

I think this is an important typo fix as you're right that we don't
transition directly from having a waitqueue installed in the tail straight
to an unlocked state.

Acked-by: Will Deacon <will@kernel.org>

Then again, I acked the patch introducing this comment so what do I know?

Will
