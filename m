Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1272B3A9EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbhFPPNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234487AbhFPPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623856287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZxUEjRwiwgHqyR2F3BW6G7NyAEgsYXGF3uEzPrF+/E=;
        b=apqYlEsNmw293o18ASIhLFv8mcDkq0UgOjJjpha2eFk4gxy6sRmbTDoyviUMWknd3RRbiA
        Kqxc9Cbbynh2fN2a/BMjLGWgfJ7K08n10gzn4/ZK2Y6Ncvq8FTzt0gwROgq+9b0JuKqn87
        5gzO39VFBOQJ7QKX4dwioqP8WjZJw9U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-kN5VhkmbMSiDN7JvcrRoBw-1; Wed, 16 Jun 2021 11:11:26 -0400
X-MC-Unique: kN5VhkmbMSiDN7JvcrRoBw-1
Received: by mail-wr1-f72.google.com with SMTP id t10-20020a5d49ca0000b029011a61d5c96bso1398577wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bZxUEjRwiwgHqyR2F3BW6G7NyAEgsYXGF3uEzPrF+/E=;
        b=hurlk9ahMerwAJ00CRbyNsK6pHyz/dlbvEhFFQ8WAEs/ZP3tCMpv+mjTNUNFcEWyzB
         ngXm/6pKUKva7Amy9KH6xQ4X22/xsWCU1htJS9LiUgfRfjzE6+zeWLu75ly9f5utQ2tA
         KpQc5HO+TuUSfYyXAR9sAUJXumdqzBQAX3RcpnzzZRGfZ8aRbuFz2mRPWnAYHAVOIfZC
         EolnENl5WGuvP7/detGTw8o6IYMlSpW15eXbts1Ot7x19qea0r25mKxvoZgszctmCkX8
         eMJSCXioCWrWadmqIX5ke4zZcROptpHafuKuuPk6DHobKUXxoRGZaX955MG1zeCWWqvb
         XOeQ==
X-Gm-Message-State: AOAM531JYYio70pb7IHQbvbxH6O9uzK5qNNXMANLuIOiAfmHZdEFCrrP
        qwfEG5rwCZ6gFDGPJPA0cQG5Gho7tc6vqMgFblN69VtSbhYr/ge6oQH/1JJls4A7aWL1VSLtPnA
        9ZJNpZK5h6akF+URoVRu0moG+
X-Received: by 2002:a05:6000:1049:: with SMTP id c9mr5943588wrx.416.1623856284933;
        Wed, 16 Jun 2021 08:11:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+nMyxmYpSqMsQbiLXXQKmNYd5s/zwpJJceUIxYnC+pglzsSM1lkGAy6ZhBJF/pwntlf2vxw==
X-Received: by 2002:a05:6000:1049:: with SMTP id c9mr5943572wrx.416.1623856284801;
        Wed, 16 Jun 2021 08:11:24 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id s21sm3058579wmh.9.2021.06.16.08.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 08:11:23 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/lockdep: unlikely bfs error check
To:     Xiongwei Song <sxwjean@me.com>, Waiman Long <llong@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
References: <20210616144210.278662-1-sxwjean@me.com>
 <a341e1f1-39a5-dca3-9454-8eabe085928b@redhat.com>
 <BF7CB29B-0B34-4462-B793-732C1EF9DC40@me.com>
Message-ID: <9c60a4a9-c241-73de-57b5-c5fc45720677@redhat.com>
Date:   Wed, 16 Jun 2021 11:11:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <BF7CB29B-0B34-4462-B793-732C1EF9DC40@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 10:59 AM, Xiongwei Song wrote:
>
>> On Jun 16, 2021, at 10:48 PM, Waiman Long <llong@redhat.com> wrote:
>>
>> On 6/16/21 10:42 AM, Xiongwei Song wrote:
>>> From: Xiongwei Song <sxwjean@gmail.com>
>>>
>>> The error from graph walk is small probability event, so unlikely
>>> bfs_error can improve performance a little bit.
>>>
>>> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
>>> ---
>>>   kernel/locking/lockdep.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>> index 074fd6418c20..af8c9203cd3e 100644
>>> --- a/kernel/locking/lockdep.c
>>> +++ b/kernel/locking/lockdep.c
>>> @@ -2646,7 +2646,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
>>>   	bfs_init_rootb(&this, prev);
>>>     	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, usage_skip, NULL);
>>> -	if (bfs_error(ret)) {
>>> +	if (unlikely(bfs_error(ret))) {
>>>   		print_bfs_bug(ret);
>>>   		return 0;
>>>   	}
>>> @@ -2664,7 +2664,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
>>>   	bfs_init_root(&that, next);
>>>     	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
>>> -	if (bfs_error(ret)) {
>>> +	if (unlikely(bfs_error(ret))) {
>>>   		print_bfs_bug(ret);
>>>   		return 0;
>>>   	}
>>> @@ -2679,7 +2679,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
>>>   	backward_mask = original_mask(target_entry1->class->usage_mask);
>>>     	ret = find_usage_backwards(&this, backward_mask, &target_entry);
>>> -	if (bfs_error(ret)) {
>>> +	if (unlikely(bfs_error(ret))) {
>>>   		print_bfs_bug(ret);
>>>   		return 0;
>>>   	}
>>> @@ -2998,7 +2998,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
>>>   	 * Is the <prev> -> <next> link redundant?
>>>   	 */
>>>   	ret = check_redundant(prev, next);
>>> -	if (bfs_error(ret))
>>> +	if (unlikely(bfs_error(ret)))
>>>   		return 0;
>>>   	else if (ret == BFS_RMATCH)
>>>   		return 2;
>>> @@ -3911,7 +3911,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
>>>     	bfs_init_root(&root, this);
>>>   	ret = find_usage_forwards(&root, usage_mask, &target_entry);
>>> -	if (bfs_error(ret)) {
>>> +	if (unlikely(bfs_error(ret))) {
>>>   		print_bfs_bug(ret);
>>>   		return 0;
>>>   	}
>>> @@ -3946,7 +3946,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
>>>     	bfs_init_rootb(&root, this);
>>>   	ret = find_usage_backwards(&root, usage_mask, &target_entry);
>>> -	if (bfs_error(ret)) {
>>> +	if (unlikely(bfs_error(ret))) {
>>>   		print_bfs_bug(ret);
>>>   		return 0;
>>>   	}
>> I think it is better to put the unlikely() directly into the bfs_error() inline function instead of sprinkling it all over the place.
> Sounds good. Thank you for the suggestion. I will update the patch.

Another nit. It is a bit odd that sent out two patches separately though 
they do seem to have a bit of dependency. I think you should post them 
as a 2-patch series.

Cheers,
Longman

