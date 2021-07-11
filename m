Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92AC3C3D96
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 17:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhGKPWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 11:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235260AbhGKPWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 11:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626016783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVLQSSVZMa29eXDLbZRNRu9i/Q2N8Rhb8JQW5C0mFIQ=;
        b=ViY2r/HjOJtW4+mAtaOFT0um3dGnaZSuC2MWL5b5PvJxumhO5KHjf7McXa7RuZMlsCYD5t
        dYapg9IaNq14ZV70mS6qJ39cLIsjQfYMxJlHt60/bkX5Eeovhc3d0l4WyXpemTmXhmXtXz
        mwQx/tufJ1HznKBj35CmuEL56hKBD6U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-pEbQkXfeO6yo6nunqJdROQ-1; Sun, 11 Jul 2021 11:19:42 -0400
X-MC-Unique: pEbQkXfeO6yo6nunqJdROQ-1
Received: by mail-qv1-f72.google.com with SMTP id q2-20020ad45ca20000b02902b1554c2318so11746048qvh.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 08:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SVLQSSVZMa29eXDLbZRNRu9i/Q2N8Rhb8JQW5C0mFIQ=;
        b=sUmuaDBvi9pPN8kd/b6BrR81xH3QU4BZg93IzRgVdFPffNIMHcuyBccN0tSlqHUTyY
         SPvF8IFpe6J33Za3t1IiyJ2X+uUMwPFl5n1wQKAeawlkvS2PwtAIZ660PyH3qmsyq4n5
         k4cSkfPlBpmCAYswLuEOVnTl0yuBywBAS76LimM77XbI5KsJ24XGtg9VdGLdtxpr8LIg
         xgzpFq6L4tUQDily1+tvTIWGKjhlIfP9mSCDAPHt0UFP0VTGLUbLYy6PZMqKhrwVHO6b
         qrDi30ZxBmYL2YrB15o1HXpySiQuk2XVaTdtVtMv915zO9DSyKK+oMqQ4Rso2a4dR19J
         p64A==
X-Gm-Message-State: AOAM533Nn7H/GU+zMRq+R87+g6SfyVZdtsdmVkc12xRkMo9GbWYj0xXF
        8llrMJCloXi0piqOk5PzOvdQz79Y8bT/utsUHWKj6GhP5mtvOEySJkpWOgLn7pTIYLfggSb9TLX
        PoJvdup3u2PV1rhkmI3Du9l3+
X-Received: by 2002:a05:620a:1094:: with SMTP id g20mr47027070qkk.379.1626016781843;
        Sun, 11 Jul 2021 08:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDE1w443JAga5r+iNrYjc3GVvclER+9WP0ID4G+FJ8gotKtuN0jpfrAjE4iFCjX/1zTCqYLw==
X-Received: by 2002:a05:620a:1094:: with SMTP id g20mr47027059qkk.379.1626016781684;
        Sun, 11 Jul 2021 08:19:41 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id x15sm5264384qkm.66.2021.07.11.08.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 08:19:41 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH v1 2/3] locking/lockdep: Unify the return values of
 check_wait_context()
To:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
References: <20210711141430.896595-1-sxwjean@me.com>
 <20210711141430.896595-2-sxwjean@me.com>
Message-ID: <0e48f59d-a8fd-936c-c57f-976632f9cead@redhat.com>
Date:   Sun, 11 Jul 2021 11:19:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210711141430.896595-2-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/21 10:14 AM, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
>
> Unity the return values of check_wait_context() as check_prev_add(),
"Unify"?
> check_irq_usage(), etc. 1 means no bug, 0 means there is a bug.
>
> The return values of print_lock_invalid_wait_context() are unnecessary,
> remove them.
>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>   kernel/locking/lockdep.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index bf1c00c881e4..8b50da42f2c6 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4635,16 +4635,16 @@ static inline short task_wait_context(struct task_struct *curr)
>   	return LD_WAIT_MAX;
>   }
>   
> -static int
> +static void
>   print_lock_invalid_wait_context(struct task_struct *curr,
>   				struct held_lock *hlock)
>   {
>   	short curr_inner;
>   
>   	if (!debug_locks_off())
> -		return 0;
> +		return;
>   	if (debug_locks_silent)
> -		return 0;
> +		return;
>   
>   	pr_warn("\n");
>   	pr_warn("=============================\n");
> @@ -4664,8 +4664,6 @@ print_lock_invalid_wait_context(struct task_struct *curr,
>   
>   	pr_warn("stack backtrace:\n");
>   	dump_stack();
> -
> -	return 0;
>   }
>   
>   /*
> @@ -4691,7 +4689,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
>   	int depth;
>   
>   	if (!next_inner || next->trylock)
> -		return 0;
> +		return 1;
>   
>   	if (!next_outer)
>   		next_outer = next_inner;
> @@ -4723,10 +4721,12 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
>   		}
>   	}
>   
> -	if (next_outer > curr_inner)
> -		return print_lock_invalid_wait_context(curr, next);
> +	if (next_outer > curr_inner) {
> +		print_lock_invalid_wait_context(curr, next);
> +		return 0;
> +	}
>   
> -	return 0;
> +	return 1;
>   }
>   
>   #else /* CONFIG_PROVE_LOCKING */
> @@ -4962,7 +4962,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>   #endif
>   	hlock->pin_count = pin_count;
>   
> -	if (check_wait_context(curr, hlock))
> +	if (!check_wait_context(curr, hlock))
>   		return 0;
>   
>   	/* Initialize the lock usage bit */

There is also another check_wait_context() in the "#else 
CONFIG_PROVE_LOCKING" path that needs to be kept in sync. For clarity, 
maybe you should state the meaning of the return value in the comment 
above the function.

Cheers,
Longman

check_wait_context

