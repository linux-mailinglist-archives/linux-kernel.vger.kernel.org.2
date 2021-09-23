Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2CD415511
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 03:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhIWBSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 21:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWBSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:18:49 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 18:17:18 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d207so16873792qkg.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 18:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rjynOJffhT5dKZbXg33caDobIejguryZTD5BPECF/xA=;
        b=pfsoalowyr641rbYQayyuG2RC5SE8NciZIBUnav78Nk6QiZrUQYNFz5m54gPojYGpl
         by+FZW02FX3puVpxA++XIf6PcuTf37jSiLNkVPq82G5Am9t0otQ0SmjgWxYr9dDfT3eS
         zuGYQe9se5F3bkN0MKMzIzlQ5xNODva2rxgbx8FA1/MOYq2O39ygbIwD6jo92H1r6hCd
         gcJtP1gKfZOoK3iTOpU6HTaIUClDoKdopWRoqX9gRAirtPL6yhKXB3kXzX0vtZT6RUj2
         2xPeBybyfvJxl4+SmQ2FGgUqoOpXf2IuBBCPoUCnzeCoiZThHPCAeV0Ao0KP9PJh7vtv
         T5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjynOJffhT5dKZbXg33caDobIejguryZTD5BPECF/xA=;
        b=P2PA5HSxo7IalM9f1wYCZ9CH2xa9AZ9l9lLtBe7ezRr/CpBtdfyA9ExWwKoyxmxxtM
         zjj64PHZi9wdsMImieBbixJzfcyFI7P1S7il9VU2/sjAFpTVvqGxSFMzQtltiAbMPZ/g
         5KZcjx9xErDeUx3uZpiFnKpZiVzG4rs+uc/StdgalnVCq4nup61vdaHD26Atr7uH4S9y
         h6LAcg1EpRl9WvY5ZazlGaUymzeo4xFEQB3TAJ3xiezXmLjUNt7IJGU8z5AFTEyqeurh
         WCskyyA2M19kzhbOi4Zf020ODio1GQ8hJg4osnb93NBX46NWX6XLmJ96xSK0gY8RB84F
         uk/Q==
X-Gm-Message-State: AOAM532G7EupqSbqzTQrHe2y1vjoL/f8k/YIuZwBnTBs+R008xK6V5gD
        1UHfyQaFTQfwcrsLe28Ayi4=
X-Google-Smtp-Source: ABdhPJwrTZi6+HbuPKS/qcOBHNL8RGFHvdh/xKc4bSoKde5APLf/VkPJ0rMvap0e8ldf15pGX+cDRw==
X-Received: by 2002:a37:4c5:: with SMTP id 188mr2417873qke.291.1632359837860;
        Wed, 22 Sep 2021 18:17:17 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 90sm2596273qte.89.2021.09.22.18.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 18:17:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2CD4A27C0060;
        Wed, 22 Sep 2021 21:17:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 22 Sep 2021 21:17:16 -0400
X-ME-Sender: <xms:m9VLYe-UacZMRdP8avbIE8amyLip7hp-L8vi8cyLedycv7WPcx0AiQ>
    <xme:m9VLYes_DS1_vdQD-I68ZcSzu5LV3htBMxCLEdRutyQpA-O2U5rb-mYP65jR_BQND
    hVns_5ZcLoM62N90w>
X-ME-Received: <xmr:m9VLYUCxFcSmCkouONfxLguCOUekxYvG2jsZBCc0Ug8xqHY2tK6cuAiZNvrJcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeikedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:m9VLYWdkXyYTGmD1RZ-bcNft8eMismJpUTT6QkFqtHbsIYC4V5DIGg>
    <xmx:m9VLYTMOCigHdUFksUT7TGlKSfEPKZOOwtYUWCbrmvbPjUBfFTPuew>
    <xmx:m9VLYQl69OZjyWpXFvzPGcj8yewIBJ2-t27t_fyNbGRYo7LHBaEl5g>
    <xmx:m9VLYe1Y9VFJ-iy3VSxJhJIBLwbvV-UHbuWJlgIZAMbkNjZunU3fxQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Sep 2021 21:17:15 -0400 (EDT)
Date:   Thu, 23 Sep 2021 09:16:51 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH] locking/rwsem: Add upgrade_read()
Message-ID: <YUvVg6OJLIqg/rUZ@boqun-archlinux>
References: <20210922193657.29461-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922193657.29461-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 03:36:57PM -0400, Waiman Long wrote:
> Currently there are about 12 instances in the kernel where an up_read()
> is immediately followed by a down_write() of the same lock. For example,
> 
>   drivers/tty/n_tty.c:		up_read(&tty->termios_rwsem);
>   drivers/tty/n_tty.c-		down_write(&tty->termios_rwsem);
> 
> Since we have already provided a downgrade_write() function, we may as
> well provide an upgrade_read() function to make the code easier to read
> and the intention clearer.
> 
> If the current task is the only reader, the upgrade can be done by a
> single atomic operation. If not, the upgrade will have to be done by a
> separate up_read() call followed by a down_write(). In the former case,
> the handoff bit is not considered and the waiter will have to wait a
> bit longer to acquire the lock.
> 
> The new upgrade_read() function returns a value of 0 for safe upgrade
> where rwsem protected data won't change. Otherwise a value of 1 is
> returned to indicate unsafe upgrade where rwsem protected data may
> change during the upgrade process.
> 
> For PREEMPT_RT, it falls back to up_read() followed by down_write()
> for simplicity.
> 
> Some uses of down_write() with long lock hold time may be changed
> to the following format in the future:
> 
> 	down_read()
> 	/* check data */
> 	if (upgrade_read()) {
> 		/* unsafe upgrade, recheck data */
> 	}
> 	/* update data */
> 	up_write();
> 
> As long as the "recheck data" and "update data" parts are relatively
> short compared with the "check data" part, this conversion may help to
> improve parallelism and reduce lock contention.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/rwsem.h  |  5 ++++
>  kernel/locking/rwsem.c | 53 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 352c6127cb90..8ece58224f25 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -207,6 +207,11 @@ extern void up_write(struct rw_semaphore *sem);
>   */
>  extern void downgrade_write(struct rw_semaphore *sem);
>  
> +/*
> + * upgrade read lock to write lock
> + */
> +extern int upgrade_read(struct rw_semaphore *sem);
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  /*
>   * nested locking. NOTE: rwsems are not allowed to recurse
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 000e8d5a2884..aeb5b0668304 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1203,6 +1203,29 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
>  	return sem;
>  }
>  
> +/*
> + * Try to upgrade read lock to write lock
> + */
> +static inline int __try_upgrade_read(struct rw_semaphore *sem)
> +{
> +	long count = atomic_long_read(&sem->count);
> +
> +	WARN_ON_ONCE(count & RWSEM_WRITER_LOCKED);
> +
> +	/*
> +	 * When upgrading from shared to exclusive ownership,
> +	 * anything inside the write-locked region cannot leak
> +	 * into the read side. Use an ACQUIRE semantics.
> +	 */
> +	if (((count & RWSEM_READER_MASK) == RWSEM_READER_BIAS) &&
> +	     atomic_long_try_cmpxchg_acquire(&sem->count, &count,
> +			count - RWSEM_READER_BIAS + RWSEM_WRITER_LOCKED)) {
> +		rwsem_set_owner(sem);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * lock for reading
>   */
> @@ -1438,6 +1461,11 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
>  	rwbase_write_downgrade(&sem->rwbase);
>  }
>  
> +static inline int __try_upgrade_read(struct rw_semaphore *sem)
> +{
> +	return 0;
> +}
> +
>  /* Debug stubs for the common API */
>  #define DEBUG_RWSEMS_WARN_ON(c, sem)
>  
> @@ -1581,6 +1609,31 @@ void downgrade_write(struct rw_semaphore *sem)
>  }
>  EXPORT_SYMBOL(downgrade_write);
>  
> +/*
> + * Upgrade read lock to write lock
> + *
> + * Return: 0 when upgrade is safe, i.e. rwsem protected data do not change;
> + *         1 when upgrade is unsafe as rwsem protected data may have changed.
> + */
> +int upgrade_read(struct rw_semaphore *sem)
> +{
> +	if (__try_upgrade_read(sem)) {
> +		rwsem_release(&sem->dep_map, _RET_IP_);
> +		rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> +		return 0;
> +	}
> +
> +	/*
> +	 * We cannot directly upgrade to the write lock, just do a regular
> +	 * up_read() and down_write() sequence. The data protected by the
> +	 * rwsem may have changed before the write lock is acquired.
> +	 */
> +	down_read(sem);
> +	up_write(sem);

Confused, the comment says up_read()+down_write(), however the code is
down_read()+up_write().

Besides, I don't like the idea that the value may have changed before
the write lock is acquired if we call it "upgrade". Maybe we want api
like down_read_upgradable(), which can be held in parallel with other
down_read() but no other down_read_upgradable(), and one can only
upgrade the read-side critical section created by
down_read_upgradable(). For implementation, that means we need to have
one extra bit for upgradable. Thoughts?

Regards,
Boqun

> +	return 1;
> +}
> +EXPORT_SYMBOL(upgrade_read);
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  
>  void down_read_nested(struct rw_semaphore *sem, int subclass)
> -- 
> 2.18.1
> 
