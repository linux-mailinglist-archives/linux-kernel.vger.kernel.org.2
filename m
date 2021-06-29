Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06B3B73B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhF2OFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229705AbhF2OE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624975351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iA1uo0m3sRct3Ya71uX6YiW4SUGH49yF4PP2R0fN0DM=;
        b=QFXKsUxdKTHmPgAqXqK2z80su8U9Fx/wRQzer2ngXZaXNAOdIJXINSTr72e5R9hjdprb2R
        S5+fAvQHFGdCzbz9DbfcLfvSdEqd/OSgl7mc5dApWmxP3f0W0MtWBNRDKoYy8fxe23aQjX
        cl0JPPV1dHlgxg6D6VbfFPlzdxE3pD0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-AME1K1NcMpqQ4JOu7Wng8g-1; Tue, 29 Jun 2021 10:02:30 -0400
X-MC-Unique: AME1K1NcMpqQ4JOu7Wng8g-1
Received: by mail-qv1-f69.google.com with SMTP id m11-20020ad45dcb0000b029027aeaa8ae9dso20609301qvh.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iA1uo0m3sRct3Ya71uX6YiW4SUGH49yF4PP2R0fN0DM=;
        b=An2nTS9jAdJ8R0ViyueNYwK2XCtO5Rb+gzq1Lry5aMEnB2835s1NOBeXKtXtZyTzAG
         ioEDAl5QuvPS+GhDIvhLleBF95TxYDVQmhxB7jelefs4QJsdMv/eiVT37pUELjW96IiQ
         ct+R8PD2FqUBau9mFR4G7uidMn3qKjqdNTpZQYxvHesKdcIwBQBsJWg5wkf1pYAy3fNf
         sL5EysftsZxvePuHGlchAhCNgAFRsjRfdrODye4h/bze3MRXOti9ixbrlvPqkeDs3Qvv
         GwEk2eCpXVkHbcgx3T1AIY85T0U42n/J0SC/aKcCHCiAfjWnL96I991pD0dWhWDUlliw
         HG3Q==
X-Gm-Message-State: AOAM530leebueegq1D+Xk8yrl9rxUEsI3ysA75esAKH2MMdEfN8sPsV3
        CIYvgjKXLlCQIv3Rl12VoAy204o0mXkobRVMhWBd0IP4KwsMJoOj4KnmtQm+vkDKM47s6a5AUNa
        ST3Qo/R8Rz4VtuYgN+nKLY6NG
X-Received: by 2002:a05:622a:1303:: with SMTP id v3mr26966770qtk.185.1624975348070;
        Tue, 29 Jun 2021 07:02:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5aUIa157O43a3R30+j360nkztWUIajRUk0/xl0gtkHD2sMdcQzwjcjmRiLRu3RQG8tU5fLQ==
X-Received: by 2002:a05:622a:1303:: with SMTP id v3mr26966616qtk.185.1624975346443;
        Tue, 29 Jun 2021 07:02:26 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id m189sm11926860qkd.107.2021.06.29.07.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 07:02:25 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3] locking/lockdep: Fix meaningless usages output of lock
 classes
To:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
References: <20210629135916.308210-1-sxwjean@me.com>
Message-ID: <0894c552-41f1-a9dc-a319-67233c751a1f@redhat.com>
Date:   Tue, 29 Jun 2021 10:02:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210629135916.308210-1-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/21 9:59 AM, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
>
> When enabling CONFIG_LOCK_STAT, then CONFIG_LOCKDEP is forcedly enabled.
> We can get output from /proc/lockdep, which currently includes usages of
> lock classes. But the usages are meaningless, see the output below:
>
> / # cat /proc/lockdep
> all lock classes:
> ffffffff9af63350 ....: cgroup_mutex
>
> ffffffff9af54eb8 ....: (console_sem).lock
>
> ffffffff9af54e60 ....: console_lock
>
> ffffffff9ae74c38 ....: console_owner_lock
>
> ffffffff9ae74c80 ....: console_owner
>
> ffffffff9ae66e60 ....: cpu_hotplug_lock
>
> Only one usage context for each lock, this is because each usage is only
> changed in mark_lock() that is in CONFIG_PROVE_LOCKING defined section,
> however in the test situation, it's not.
>
> The fix is to move the usages reading and seq_print from
> CONFIG_PROVE_LOCKING undefined setcion to its defined section. Also,
> locks_after list of lock_class is empty when CONFIG_PROVE_LOCKING
> undefined, so do the same thing as what have done for usages of lock
> classes.
>
> With this patch with CONFIG_PROVE_LOCKING undefined, we can get the
> results below:
>
> / # cat /proc/lockdep
> all lock classes:
> ffffffff85163290: cgroup_mutex
> ffffffff85154dd8: (console_sem).lock
> ffffffff85154d80: console_lock
> ffffffff85074b58: console_owner_lock
> ffffffff85074ba0: console_owner
> ffffffff85066d60: cpu_hotplug_lock
>
> a class key and the relevant class name each line.
>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>
> v3: Improve commit log. Thank Longman very much for the comments.
> v2: https://lkml.org/lkml/2021/6/28/1549
>
> ---
>   kernel/locking/lockdep_proc.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
> index 806978314496..b8d9a050c337 100644
> --- a/kernel/locking/lockdep_proc.c
> +++ b/kernel/locking/lockdep_proc.c
> @@ -70,26 +70,28 @@ static int l_show(struct seq_file *m, void *v)
>   #ifdef CONFIG_DEBUG_LOCKDEP
>   	seq_printf(m, " OPS:%8ld", debug_class_ops_read(class));
>   #endif
> -#ifdef CONFIG_PROVE_LOCKING
> -	seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
> -	seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
> -#endif
> +	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
> +		seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
> +		seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
>   
> -	get_usage_chars(class, usage);
> -	seq_printf(m, " %s", usage);
> +		get_usage_chars(class, usage);
> +		seq_printf(m, " %s", usage);
> +	}
>   
>   	seq_printf(m, ": ");
>   	print_name(m, class);
>   	seq_puts(m, "\n");
>   
> -	list_for_each_entry(entry, &class->locks_after, entry) {
> -		if (entry->distance == 1) {
> -			seq_printf(m, " -> [%p] ", entry->class->key);
> -			print_name(m, entry->class);
> -			seq_puts(m, "\n");
> +	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
> +		list_for_each_entry(entry, &class->locks_after, entry) {
> +			if (entry->distance == 1) {
> +				seq_printf(m, " -> [%p] ", entry->class->key);
> +				print_name(m, entry->class);
> +				seq_puts(m, "\n");
> +			}
>   		}
> +		seq_puts(m, "\n");
>   	}
> -	seq_puts(m, "\n");
>   
>   	return 0;
>   }

Looks good to me.

Acked-by: Waiman Long <longman@redhat.com>

