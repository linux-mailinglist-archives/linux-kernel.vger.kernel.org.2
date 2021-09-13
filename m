Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EE5408AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbhIMMWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbhIMMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:22:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A52C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 05:20:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631535649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=va9U/DHN0OpTdBgoqRQ22J4VTELc5Rpzm1TiWJW6QJY=;
        b=DcpoVEnTVTkyr3ydMA/99Dppf/CBEwZOguQbtlQqe6eOay3r+IHA7kCAGZVgyXKJEefptF
        m0T9SLUs3ABhRfnOJ+g7GLnHRfurZLe7a7IwVEgf5dvoU6yhSSMDRqpkQOQu5nyH+54X1/
        fX+xdkpbPhPbXtcdbtc1KgwIeZ+nEPcI9lqLuEbOhnSOywM3vzwL9wZs39hmWAo6vWRBUf
        cKPUO6VF58pshpJdhvqrGA8vnLZiXlloaMIBmcq5mIY//frmglWtBN4aUbHti6RjXgfbot
        gfRUS0TbmtIUi7Eh0xiVdv1ZK2p84Qp0Jp22/oIHiVe2BgbYpWsnvGEiAacCtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631535649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=va9U/DHN0OpTdBgoqRQ22J4VTELc5Rpzm1TiWJW6QJY=;
        b=OjrtKrYvObEoH9DQb8bUfurrCAGOFSdORchdpbpnvXY2iSFyDcrsViYYUf3f5R9SosV6/o
        y1dGv68bMwAjjOAw==
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        longman@redhat.com, bigeasy@linutronix.de, boqun.feng@gmail.com,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] locking/rwbase_rt: Lockless reader waking up a writer
In-Reply-To: <20210901222825.6313-3-dave@stgolabs.net>
References: <20210901222825.6313-1-dave@stgolabs.net>
 <20210901222825.6313-3-dave@stgolabs.net>
Date:   Mon, 13 Sep 2021 14:20:49 +0200
Message-ID: <87ilz4fyzi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01 2021 at 15:28, Davidlohr Bueso wrote:
> diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> index 4ba15088e640..3444bc709973 100644
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -141,6 +141,7 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
>  {
>  	struct rt_mutex_base *rtm = &rwb->rtmutex;
>  	struct task_struct *owner;
> +	DEFINE_WAKE_Q(wake_q);
>  
>  	raw_spin_lock_irq(&rtm->wait_lock);
>  	/*
> @@ -151,9 +152,10 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
>  	 */
>  	owner = rt_mutex_owner(rtm);
>  	if (owner)
> -		wake_up_state(owner, state);
> +		wake_q_add(&wake_q, owner);

That's broken for rw_locks. See commit 456cfbc65cd072f4f53936ee5a37eb1447a7d3ba.

Thanks,

        tglx
