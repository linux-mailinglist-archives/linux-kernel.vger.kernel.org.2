Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56C133B36A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhCONOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCONOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:14:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9BAC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KQZxGT3iZM0XuWdH8rSDyKf5uYuruMkEoTeToypALMc=; b=pDMzXvxYeMIiBzwuJdtRPz4Q1o
        +pbsYhAYi+TPyv5XAYYDDtvGu8pOzR/L7480DE1rCPz77xdaK3yDn8mjZ2vHXpSUIDIy2YhFPGjAs
        X8mLYfPwg1D+c8bcIS4M7Thz2twe/3klF0XM4O+PU41e+p1NqSxi6MpeEhFUFYgXV6CQKvUNMhrGq
        LFL2aGGfSaj/T546RMqV1Jd2+bereUervDdJoyiFGKTAzT/0hH4JXnhDxunojw+nriIcBGaf++Iga
        vBTU5oFGVeM5dqB+s+ksmzgj2gtyGkfH9IZjlIWXT24wZexHp9xtdTej5/M87rLfEFx0q62ySA6u6
        jZtM2KcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLn1B-00FvtE-BK; Mon, 15 Mar 2021 13:14:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F36713003D8;
        Mon, 15 Mar 2021 14:12:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E52C623CC228E; Mon, 15 Mar 2021 14:12:19 +0100 (CET)
Date:   Mon, 15 Mar 2021 14:12:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] futex: Fix irq mismatch in exit_pi_state_list()
Message-ID: <YE9dM6PB9ZpC8AfY@hirez.programming.kicks-ass.net>
References: <20210315050224.107056-1-dave@stgolabs.net>
 <20210315050224.107056-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315050224.107056-2-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 10:02:23PM -0700, Davidlohr Bueso wrote:
> The pi_mutex->wait_lock is irq safe and needs to enable local
> interrupts upon unlocking, matching it's corresponding
> raw_spin_lock_irq().
> 
> Fixes: c74aef2d06a9f (futex: Fix pi_state->owner serialization)
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  kernel/futex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 475055715371..ded7af2ba87f 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -885,7 +885,7 @@ static void exit_pi_state_list(struct task_struct *curr)
>  		 */
>  		if (head->next != next) {
>  			/* retain curr->pi_lock for the loop invariant */
> -			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
> +			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
>  			spin_unlock(&hb->lock);
>  			put_pi_state(pi_state);
>  			continue;

This seems broken, afaict we own:

  &hb->lock
  &pi_state->pi_mutex.wait_lock
  &curr->pi_lock

And we're only releasing:

  &hb->lock
  &pi_state->pi_mutex.wait_lock

Which leaves us holding:

  &curr->pi_lock

which is also an IRQ safe lock, so enabling IRQs would be BAD.

Or am I reading this wrong?
