Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732B83B306B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhFXNs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFXNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:48:54 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB248C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 06:46:35 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id g22so8243675iom.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a9KALi4Q0j9NQDn38Zn125Upiw5tfdm6x6aVj537r44=;
        b=d1wt/Z1zzlI1vpplfic6XsSKvtk0aC3zrWwPb3PYg9V6FI24gGMjVnkJV1gOVDks42
         t+bC9p8H4x4eBgbwCjpCuA5rEtRv77NxCB3NMKYMzHOjbqJDAUOIqRDPMRVszGVLDVIf
         mryiyPGeRje/DMNN+RAE2i14wH2KdweCPSQGvkMB1gXPak9XIGrgeTioD3JKHsyn606W
         R++Q3Eg2pT6TPBkQw1U9ZtGEgcZ/FiYtQVWayH5fvT5/K2z+V8mVuC09YHntXJk4E0ne
         7DWBAJxgpGhhnDdW3ViyqbY0coBJIduaZyjafSh5VCHopjEaaPqCgPQrI1nk0aLcDCjv
         jUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a9KALi4Q0j9NQDn38Zn125Upiw5tfdm6x6aVj537r44=;
        b=uenRaUKBe+MZEktQU+OgvN1UIeiv96zSIJxBoUBGSMB0Rk2mDQKk4lge1AsFEqLeVW
         pLX1Mve1bi1X8uxZ/yheLekaTtwivfTv1H0FMUyGjQ9rYlKh7MkKOx+yK8EtBqyKdzVZ
         e913mgny6dmQN2sTxqeRU+V071vwJg8J2rOyHL083DCUuybPB+AU6Qf47NhrPmBr21F0
         gPPOaEeRd6zc9BV2fCXA7bPVhmnyzv8oK8DC5AOTHyxXb0uaJnpHqhx76IsVuf/k1FLV
         jJFVRniKI7xS3daH63CPQIvyDVz4bj20tYu5iTqHRQDounxidy3+gIcxqNuMa5ubSdz+
         Iuew==
X-Gm-Message-State: AOAM531pyoyL8qDT+Oev1SU5Bmj03aJtU6eVR+uYdt303eL084dtFOhx
        ELR9LSHoIoaf0osIDPlxUj8=
X-Google-Smtp-Source: ABdhPJzr3GXRVhGB1PAy4fWRfrWyyDIYM32Nl6oHaOSynj4ICv27ADomHA9aI5Pl+itwEdnL/2kwQA==
X-Received: by 2002:a5d:914f:: with SMTP id y15mr4254636ioq.196.1624542395343;
        Thu, 24 Jun 2021 06:46:35 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d10sm1990272ilc.71.2021.06.24.06.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 06:46:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5D3F027C0054;
        Thu, 24 Jun 2021 09:46:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 24 Jun 2021 09:46:33 -0400
X-ME-Sender: <xms:uIzUYK4gyqqQhhFSEHCg38LyLb27MfNL4tiEuox2JX-Vro12keETTg>
    <xme:uIzUYD5ayp0VZAd__I4SMmeaOspJijv4ghGjUF_1ZrZKYSXhGITjdiL2VFkLsqyRN
    fvUCgNHP2YWBfdhVA>
X-ME-Received: <xmr:uIzUYJd4xOjUAvInEgjQUqdeBw25OQiMT3XjJMz5VgDeBoEYAhIj5hwN66t1mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeghedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvleeigedugfegveejhfejveeuve
    eiteejieekvdfgjeefudehfefhgfegvdegjeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:uIzUYHJuFgLmEkjDjOpUhz4-9XSy1YIhjaUPDIZJ6gqtLg1_jgwExQ>
    <xmx:uIzUYOI2I_ShyED_Kz7MtNhg6nbQb0aYk3f0A2aSSKXa8L4i2I1-Fw>
    <xmx:uIzUYIwGjKvGZkPOFtwOiO7PJrhh91-SmaRd-6O7zROnGhWmPNSB5A>
    <xmx:uYzUYG8N2at6ahDEXDPoggOEU874DJ5J1EARoTMmquXNwhYBkQ8drA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jun 2021 09:46:32 -0400 (EDT)
Date:   Thu, 24 Jun 2021 21:45:49 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Xiongwei Song <sxwjean@me.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH v2 3/3] locking/lockdep: Print possible warning after
 counting deps
Message-ID: <YNSMjZmuuuphg+aa@boqun-archlinux>
References: <20210618145534.438816-1-sxwjean@me.com>
 <20210618145534.438816-4-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618145534.438816-4-sxwjean@me.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 10:55:34PM +0800, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> The graph walk might hit error when counting dependencies. Once the
> return value is negative, print a warning to reminder users.
> 
> However, lockdep_unlock() would be called twice if we call print_bfs_bug()
> directly in __lockdep_count_*_deps(), so as the suggestion from Boqun:
> "
> Here print_bfs_bug() will eventually call debug_locks_off_graph_unlock()
> to release the graph lock, and the caller (lockdep_count_fowards_deps())
> will also call graph_unlock() afterwards, and that means we unlock
> *twice* if a BFS error happens... although in that case, lockdep should
> stop working so messing up with the graph lock may not hurt anything,
> but still, I don't think we want to do that.
> 
> So probably you can open-code __lockdep_count_forward_deps() into
> lockdep_count_forwards_deps(), and call print_bfs_bug() or
> graph_unlock() accordingly. The body of __lockdep_count_forward_deps()
> is really small, so I think it's OK to open-code it into its caller.
> "
> we put the code in __lockdep_count_*_deps() into lockdep_count_*_deps().
> 
> Suggested-by: Waiman Long <longman@redhat.com>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thanks!

Regards,
Boqun

> ---
>  kernel/locking/lockdep.c | 45 +++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index cb94097014d8..c29453b1df50 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2024,55 +2024,52 @@ static bool noop_count(struct lock_list *entry, void *data)
>  	return false;
>  }
>  
> -static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
> -{
> -	unsigned long  count = 0;
> -	struct lock_list *target_entry;
> -
> -	__bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
> -
> -	return count;
> -}
>  unsigned long lockdep_count_forward_deps(struct lock_class *class)
>  {
> -	unsigned long ret, flags;
> +	unsigned long count = 0, flags;
>  	struct lock_list this;
> +	struct lock_list *target_entry;
> +	enum bfs_result result;
>  
>  	__bfs_init_root(&this, class);
>  
>  	raw_local_irq_save(flags);
>  	lockdep_lock();
> -	ret = __lockdep_count_forward_deps(&this);
> -	lockdep_unlock();
> -	raw_local_irq_restore(flags);
>  
> -	return ret;
> -}
> +	result = __bfs_forwards(&this, (void *)&count, noop_count, NULL, &target_entry);
>  
> -static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
> -{
> -	unsigned long  count = 0;
> -	struct lock_list *target_entry;
> +	if (bfs_error(result))
> +		print_bfs_bug(result);
> +	else
> +		lockdep_unlock();
>  
> -	__bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
> +	raw_local_irq_restore(flags);
>  
>  	return count;
>  }
>  
>  unsigned long lockdep_count_backward_deps(struct lock_class *class)
>  {
> -	unsigned long ret, flags;
> +	unsigned long  count = 0, flags;
>  	struct lock_list this;
> +	struct lock_list *target_entry;
> +	enum bfs_result result;
>  
>  	__bfs_init_root(&this, class);
>  
>  	raw_local_irq_save(flags);
>  	lockdep_lock();
> -	ret = __lockdep_count_backward_deps(&this);
> -	lockdep_unlock();
> +
> +	result = __bfs_backwards(&this, (void *)&count, noop_count, NULL, &target_entry);
> +
> +	if (bfs_error(result))
> +		print_bfs_bug(result);
> +	else
> +		lockdep_unlock();
> +
>  	raw_local_irq_restore(flags);
>  
> -	return ret;
> +	return count;
>  }
>  
>  /*
> -- 
> 2.30.2
> 
