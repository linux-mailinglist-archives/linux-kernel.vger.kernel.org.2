Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0953733FD2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCRCYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhCRCY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:24:29 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6BAC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:24:29 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h7so3014364qtx.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KtRoYljdLC9wtNNIQKgFt5kI0MSMpD7ofw+TcTRYVTo=;
        b=JfToSI4kaBWN0qUCBE3Q9DPIPE+BeYzj516ZRCD8oSKbGgEMflIpd0jqn35vszBpcd
         yjLvJ6rOzzl7lbCJNBeS+dVViSca835sOdLEqwobmUNnPRU/e9eB8ySyuLcQdYD/1cZR
         rcR+f9zoMB6RrIC7oI9D41mj2eOo3invqQWGOFjJEC+KJDEobUPN+1rf1hN5IBr9HV7G
         2HpHXcLujlcEnnLl6UQltvehTTmen5x0F20lWJ6zwYZJoZuqyEw2h3u5NY2+43IvhwSE
         uQImVhSaRSxIUdtNz1tQttGY7vMzKJYvADyMf5yTWL/hvqNnAHjef+eEXh6PbuVkXtiF
         +27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KtRoYljdLC9wtNNIQKgFt5kI0MSMpD7ofw+TcTRYVTo=;
        b=LgzthnBskBsYS05gUIUJWTK3byr0k8EGbRMeXa7mYmpQ5K/tNRKv28zQxwtbkcUU7D
         b1I8hphfd+evOffulC1M+BDJg5EiCzTfxfy/69s487C14QVQq9pzg7qcQtywfMS5fqLI
         DKCdluwlcMfVXc86/WM4Y+AWev2xleDsD3ALm1ZB8rotHd1FaasDHubd/gRnzsfURlyX
         w+M+y9npJGMBb12eEmXncuEKgWCJDp2vk5EQAAGkwGqg6T4rIDeWVSGYdkt1GSnlp8k0
         9vmBqVK5mD62MHot3kQ8ymjR5rkInYwd4VJ3+VeXk5n37cF+XHqeHDtqOTgc/Ra1SEzq
         lt6A==
X-Gm-Message-State: AOAM531K9H1YQa68VNcH5TUcrQNeTGgyqy+agf/3gSZ7Uo+rfRZPFKt/
        8Oh2XRt7ZNzCWKATb+dYpunl6WAtI2E=
X-Google-Smtp-Source: ABdhPJyNnvqcFY+48bD8tIZhHR/XsONgsjw+gmjBccW4w0CYZ+ElnkHjDTxNhP8nn4kJO+souNTKrQ==
X-Received: by 2002:ac8:e81:: with SMTP id v1mr1821498qti.23.1616034268524;
        Wed, 17 Mar 2021 19:24:28 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c73sm780161qkg.6.2021.03.17.19.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 19:24:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 207D127C0054;
        Wed, 17 Mar 2021 22:24:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 17 Mar 2021 22:24:27 -0400
X-ME-Sender: <xms:2rlSYFuSYUqzExcTnMqNQ2mslkZ1cwQvEcE27CtRfjjdkaiz6eAjJw>
    <xme:2rlSYOcu43JQGwSmBhQAfCkItKhx8YaHd8jwGXg590-5E7eGKJdZukjZfIgwnt1xJ
    7fikgXO0Wn930KMNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefhedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:2rlSYIzaMo1CTfAIEb37Xj08UOFK1ZOPg6E8TDLsUakccelWG17S2A>
    <xmx:2rlSYMNB9PSYoNmH87-_HxbMfMLrXa80pEelsbZsMt9aHks1EStpBQ>
    <xmx:2rlSYF_2HLVQTCBlC4iSR8IuYxu5oU71aS39k45tMx014FZL6bVO-w>
    <xmx:2rlSYFxElMIH4fxCYUGLfYYsyRK5KYg1dr5kMeM5KzBkS7S3HEi76gdf_ZY>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id C8CA11080057;
        Wed, 17 Mar 2021 22:24:25 -0400 (EDT)
Date:   Thu, 18 Mar 2021 10:24:08 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 3/4] locking/ww_mutex: Treat ww_mutex_lock() like a
 trylock
Message-ID: <YFK5yBIOTiCdFLNm@boqun-archlinux>
References: <20210316153119.13802-1-longman@redhat.com>
 <20210316153119.13802-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316153119.13802-4-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

Just a question out of curiosity: how does this problem hide so long?
;-) Because IIUC, both locktorture and ww_mutex_lock have been there for
a while, so why didn't we spot this earlier?

I ask just to make sure we don't introduce the problem because of some
subtle problems in lock(dep).

Regards,
Boqun

On Tue, Mar 16, 2021 at 11:31:18AM -0400, Waiman Long wrote:
> It was found that running the ww_mutex_lock-torture test produced the
> following lockdep splat almost immediately:
> 
> [  103.892638] ======================================================
> [  103.892639] WARNING: possible circular locking dependency detected
> [  103.892641] 5.12.0-rc3-debug+ #2 Tainted: G S      W
> [  103.892643] ------------------------------------------------------
> [  103.892643] lock_torture_wr/3234 is trying to acquire lock:
> [  103.892646] ffffffffc0b35b10 (torture_ww_mutex_2.base){+.+.}-{3:3}, at: torture_ww_mutex_lock+0x316/0x720 [locktorture]
> [  103.892660]
> [  103.892660] but task is already holding lock:
> [  103.892661] ffffffffc0b35cd0 (torture_ww_mutex_0.base){+.+.}-{3:3}, at: torture_ww_mutex_lock+0x3e2/0x720 [locktorture]
> [  103.892669]
> [  103.892669] which lock already depends on the new lock.
> [  103.892669]
> [  103.892670]
> [  103.892670] the existing dependency chain (in reverse order) is:
> [  103.892671]
> [  103.892671] -> #2 (torture_ww_mutex_0.base){+.+.}-{3:3}:
> [  103.892675]        lock_acquire+0x1c5/0x830
> [  103.892682]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
> [  103.892687]        ww_mutex_lock+0x4b/0x180
> [  103.892690]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
> [  103.892694]        lock_torture_writer+0x142/0x3a0 [locktorture]
> [  103.892698]        kthread+0x35f/0x430
> [  103.892701]        ret_from_fork+0x1f/0x30
> [  103.892706]
> [  103.892706] -> #1 (torture_ww_mutex_1.base){+.+.}-{3:3}:
> [  103.892709]        lock_acquire+0x1c5/0x830
> [  103.892712]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
> [  103.892715]        ww_mutex_lock+0x4b/0x180
> [  103.892717]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
> [  103.892721]        lock_torture_writer+0x142/0x3a0 [locktorture]
> [  103.892725]        kthread+0x35f/0x430
> [  103.892727]        ret_from_fork+0x1f/0x30
> [  103.892730]
> [  103.892730] -> #0 (torture_ww_mutex_2.base){+.+.}-{3:3}:
> [  103.892733]        check_prevs_add+0x3fd/0x2470
> [  103.892736]        __lock_acquire+0x2602/0x3100
> [  103.892738]        lock_acquire+0x1c5/0x830
> [  103.892740]        __ww_mutex_lock.constprop.15+0x1d1/0x2e50
> [  103.892743]        ww_mutex_lock+0x4b/0x180
> [  103.892746]        torture_ww_mutex_lock+0x316/0x720 [locktorture]
> [  103.892749]        lock_torture_writer+0x142/0x3a0 [locktorture]
> [  103.892753]        kthread+0x35f/0x430
> [  103.892755]        ret_from_fork+0x1f/0x30
> [  103.892757]
> [  103.892757] other info that might help us debug this:
> [  103.892757]
> [  103.892758] Chain exists of:
> [  103.892758]   torture_ww_mutex_2.base --> torture_ww_mutex_1.base --> torture_ww_mutex_0.base
> [  103.892758]
> [  103.892763]  Possible unsafe locking scenario:
> [  103.892763]
> [  103.892764]        CPU0                    CPU1
> [  103.892765]        ----                    ----
> [  103.892765]   lock(torture_ww_mutex_0.base);
> [  103.892767] 				      lock(torture_ww_mutex_1.base);
> [  103.892770] 				      lock(torture_ww_mutex_0.base);
> [  103.892772]   lock(torture_ww_mutex_2.base);
> [  103.892774]
> [  103.892774]  *** DEADLOCK ***
> 
> Since ww_mutex is supposed to be deadlock-proof if used properly, such
> deadlock scenario should not happen. To avoid this false positive splat,
> treat ww_mutex_lock() like a trylock().
> 
> After applying this patch, the locktorture test can run for a long time
> without triggering the circular locking dependency splat.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/mutex.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 622ebdfcd083..bb89393cd3a2 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -946,7 +946,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>  	}
>  
>  	preempt_disable();
> -	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
> +	/*
> +	 * Treat as trylock for ww_mutex.
> +	 */
> +	mutex_acquire_nest(&lock->dep_map, subclass, !!ww_ctx, nest_lock, ip);
>  
>  	if (__mutex_trylock(lock) ||
>  	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
> -- 
> 2.18.1
> 
