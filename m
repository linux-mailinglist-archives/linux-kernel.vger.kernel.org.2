Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAE23A9E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhFPOvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234104AbhFPOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623854942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lzfT7nwHoU5WPP8h4erJ5hjlDHgEXSMcpZPBsWspfB8=;
        b=eijK4TJ1IyiZcBkQovvMOmp8YvV7ZHewJAwrR2dJ7W+JFPhMk+ppEjqssPK0PhX2sjszqQ
        McgU+fmq2qfr8maaNgimjjoH4UurdnanARLdFc2Bm9EbU4IgWLZImMAm5k0caP0o5dY2MU
        m5qIJfxwxUg4p1w7ANQJrWuMhajq2QQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-LHKai5mIPK26c0zh8pklGg-1; Wed, 16 Jun 2021 10:49:01 -0400
X-MC-Unique: LHKai5mIPK26c0zh8pklGg-1
Received: by mail-wr1-f72.google.com with SMTP id u16-20020a5d51500000b029011a6a17cf62so1078603wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lzfT7nwHoU5WPP8h4erJ5hjlDHgEXSMcpZPBsWspfB8=;
        b=uUpAZ/n7ULjG+LBIh55OmhI+aVxfGz3AbJ7lLWYvt3r3SJlSgBy4zKxOi+UOhDrEE2
         p9PLvP9Q+goShm9PbSK/Y3jA4v/1As2cEddbjnFcRkprRBvomSHe4mkZkuHAgLvKp2ss
         LKBf45s2Wr524TOYLr8u25y3AxfZcEzqBrn/IEvHRfKHCo5lCWUyCH758QxeyAnQzt6Z
         1bmtsXnaLFqwGz06sS0RQNCC5N5hdelQK08M1Tts3PwthyLiu295vwu3CnZuJ+wxwHU0
         TCEdUqyFAg3dwec3Eiy/lL9TwLD93fXNHz289gecOJbkCzd56C3CTH9n8xwqZLeeAhGW
         4NQg==
X-Gm-Message-State: AOAM5311ttb1g6AzIZhXz901BRdCQblGb5oaTRbInaahrJ6YKZUXBhvs
        ODCL8BO6Kg8+K//fNJUagxHoaVjzQhG7I11bznPGiyd/fg0A0ILdBHDaZ+oF4uNe/DU7s9PVuhj
        7Dv4cWjDfuKivZQ98wA3ieqUi
X-Received: by 2002:a1c:9a4b:: with SMTP id c72mr9868159wme.103.1623854940087;
        Wed, 16 Jun 2021 07:49:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQHxtYA6RO575unHRv4XD0A04xWGqDoDcaHhKv9Ck0+3Xb+6laZNs9Wd/POdNPmVt+AG4F/w==
X-Received: by 2002:a1c:9a4b:: with SMTP id c72mr9868144wme.103.1623854939929;
        Wed, 16 Jun 2021 07:48:59 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id y189sm2057298wmy.25.2021.06.16.07.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:48:59 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/lockdep: unlikely bfs error check
To:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
References: <20210616144210.278662-1-sxwjean@me.com>
Message-ID: <a341e1f1-39a5-dca3-9454-8eabe085928b@redhat.com>
Date:   Wed, 16 Jun 2021 10:48:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210616144210.278662-1-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 10:42 AM, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
>
> The error from graph walk is small probability event, so unlikely
> bfs_error can improve performance a little bit.
>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>   kernel/locking/lockdep.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 074fd6418c20..af8c9203cd3e 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2646,7 +2646,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
>   	bfs_init_rootb(&this, prev);
>   
>   	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, usage_skip, NULL);
> -	if (bfs_error(ret)) {
> +	if (unlikely(bfs_error(ret))) {
>   		print_bfs_bug(ret);
>   		return 0;
>   	}
> @@ -2664,7 +2664,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
>   	bfs_init_root(&that, next);
>   
>   	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
> -	if (bfs_error(ret)) {
> +	if (unlikely(bfs_error(ret))) {
>   		print_bfs_bug(ret);
>   		return 0;
>   	}
> @@ -2679,7 +2679,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
>   	backward_mask = original_mask(target_entry1->class->usage_mask);
>   
>   	ret = find_usage_backwards(&this, backward_mask, &target_entry);
> -	if (bfs_error(ret)) {
> +	if (unlikely(bfs_error(ret))) {
>   		print_bfs_bug(ret);
>   		return 0;
>   	}
> @@ -2998,7 +2998,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
>   	 * Is the <prev> -> <next> link redundant?
>   	 */
>   	ret = check_redundant(prev, next);
> -	if (bfs_error(ret))
> +	if (unlikely(bfs_error(ret)))
>   		return 0;
>   	else if (ret == BFS_RMATCH)
>   		return 2;
> @@ -3911,7 +3911,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
>   
>   	bfs_init_root(&root, this);
>   	ret = find_usage_forwards(&root, usage_mask, &target_entry);
> -	if (bfs_error(ret)) {
> +	if (unlikely(bfs_error(ret))) {
>   		print_bfs_bug(ret);
>   		return 0;
>   	}
> @@ -3946,7 +3946,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
>   
>   	bfs_init_rootb(&root, this);
>   	ret = find_usage_backwards(&root, usage_mask, &target_entry);
> -	if (bfs_error(ret)) {
> +	if (unlikely(bfs_error(ret))) {
>   		print_bfs_bug(ret);
>   		return 0;
>   	}

I think it is better to put the unlikely() directly into the bfs_error() 
inline function instead of sprinkling it all over the place.

Cheers,
Longman

