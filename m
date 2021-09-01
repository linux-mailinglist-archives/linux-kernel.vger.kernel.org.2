Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FA23FE045
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhIAQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhIAQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:45:54 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD5C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 09:44:57 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id v2so3919893ilg.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R7Sk3P8j5ScZTGwYI1mISrJQGvsgBEtX8AD0e8lzenQ=;
        b=GrkKOtrmtUvJeYQhpbv1yAevxuANhF0rqts51AEIuhEqw+V+TYD0tfOaROr6EPdZ4a
         sMByVrTzaQ0XnAdOsLyFmfsfNNvqkst9JQJEzVtX+/G5SeAFRWj5L07DT5l5ENHlNJA5
         v+pitdp2YGQ0+2uDei/5oWcl8jQ01183gfbBOsDrT0pb1AJhv/6SXyl+9f+GBaTnL11t
         528boCcXCBUt/Acabjm2DTeFSgj31USnHTED80+WSW+EG3Z4VtrtO+dxJXXcD78nNYo0
         /qzjPDAEdUIuNCCf+oq9iuPwuvs7Z+sBj9zdm6+dZ8EnK3dlJMEx9eHl+v/fQQOacaIU
         FHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R7Sk3P8j5ScZTGwYI1mISrJQGvsgBEtX8AD0e8lzenQ=;
        b=Zlgj3SezSVIbfL0CYYrYFJRf+lcpUf1FcARpWEaC3RCyJgtBGeAOK6DHESpmv+4wE9
         xbDl2y3579O+6a6LglnSCppheC+9x4IooHSuL1+nSmUB9BzkUFeo1Npo1nNiKi2BT+Uj
         jfUO8vxAbpjUUdCUFUsvW1yoG6iWvMR8SeAZhq2EsRR9HY46xSPmlNhZ+53N0l1rXOGp
         uoEnlONLwjDnwurHX/Hd1ER+pImpTn8GaMAwkz6qZtpg2k/gdO/0n6a6cFSWyLn52jas
         bDrHeh/ZTntDw9Io0e9CDPXeuN4aTuKF5IHYl6fQcEK8qMalPwB6CE1WccHMEKJnfWvX
         nxAg==
X-Gm-Message-State: AOAM530pbb2AsgHGIBrlzqk7Mxlppz4AjdZNp/yx0528iHVeaYo0Qq5T
        h0JeOhZnssADw0C/UD9ikM0=
X-Google-Smtp-Source: ABdhPJwO6DxADYsMXObMkpFLVpRkOvxS/j/b6P8dKvgIJX7yVjfoICsjEjHeinL/Km+I4ArsitsKrg==
X-Received: by 2002:a05:6e02:f91:: with SMTP id v17mr322252ilo.0.1630514697270;
        Wed, 01 Sep 2021 09:44:57 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id r16sm17351ile.66.2021.09.01.09.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 09:44:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2FBF127C005B;
        Wed,  1 Sep 2021 12:44:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 01 Sep 2021 12:44:56 -0400
X-ME-Sender: <xms:Bq4vYfz2NH1zarBJEyLkO_NTTuvpMLUZk101ZN9woCsC7bIgEVkHSA>
    <xme:Bq4vYXStuWWKaPwaiPe0b4hKG_Ws1G8Vf7bGUBPXJUyA3JJJk97UmPcZ_YL_c4Ny_
    wLCmGPeSi6aoGtvQQ>
X-ME-Received: <xmr:Bq4vYZVqNZhWZHkCxO3CgNAJVOs5irWjy-2jBVISvYpKCLAwtXklP_vGan3scw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfeg
    vdegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Bq4vYZirv4jtLKNQ6U2Ask8d8O6934oV0GSd0ZbnJKOs5kDD4QA3Ew>
    <xmx:Bq4vYRBkKqrDZkKefEov6ZIg5GAy_bkSnI62gUFUpmdOgOdh8t9OgA>
    <xmx:Bq4vYSKXmSkhcpZah4myHKMMFbloHS-FOP4KmFBlYABksi8VVzf6AQ>
    <xmx:B64vYT0T_klhqs1XiFVtA_c7RwBnwc2OGN7rUDufjlX-lukJI4hdGA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 12:44:54 -0400 (EDT)
Date:   Thu, 2 Sep 2021 00:43:45 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] lockdep: Let lock_is_held_type() detect recursive read
 as read
Message-ID: <YS+twcAQ9uivowDS@boqun-archlinux>
References: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 06:22:55PM +0200, Sebastian Andrzej Siewior wrote:
> lock_is_held_type(, 1) detects acquired read locks. It only recognized
> locks acquired with lock_acquire_shared(). Read locks acquired with
> lock_acquire_shared_recursive() are not recognized because a `2' is
> stored as the read value.
> 
> Rework the check to additionally recognise lock's read value one and two
> as a read held lock.
> 
> Fixes: e918188611f07 ("locking: More accurate annotations for read_lock()")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> On a related note: What exactly means read_lock_is_recursive() in terms
> of recursive locking? The second items mentions QRW locks. Does this
> mean that a pending WRITER blocks further READER from acquiring the
> lock?
> 

If a reader is recursive, then a pending writer doesn't block the
recursive reader, otherwise, a pending write blocks the reader. IOW, a
pending writer blocks non-recursive readers but not recursive readers.

In most case for a lock, all the readers are either recursive or
non-recursive, but queued rwlock is a little different, readers in the
interrupt are recursive while readers in normal context are not. So
lockdep needs to handle them differently.

However, one special case is that in the selftest cases for lockdep, we
want to make all read_lock() recursive (for the purpose of testing),
that's why read_lock_is_recursive() has a force_read_lock_recursive bit.

Does the above make things answer your question?

Regards,
Boqun

>  kernel/locking/lockdep.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index f15df3fd7c5a6..39f98454a8827 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5366,7 +5366,9 @@ int __lock_is_held(const struct lockdep_map *lock, int read)
>  		struct held_lock *hlock = curr->held_locks + i;
>  
>  		if (match_held_lock(hlock, lock)) {
> -			if (read == -1 || hlock->read == read)
> +			if (read == -1 ||
> +			    (read == 0 && hlock->read == 0) ||
> +			    (read == 1 && hlock->read > 0))
>  				return LOCK_STATE_HELD;
>  
>  			return LOCK_STATE_NOT_HELD;
> -- 
> 2.33.0
> 
