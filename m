Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7593B6A15
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 23:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbhF1VUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 17:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233305AbhF1VUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 17:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624915104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnhvoDTmuhs9KIxjvKpzhhBCSacIZCBGXUwbPjFZJ9A=;
        b=ASo4IE9n8mVC4Q1N6Ni5MH5IMpIomiKonjS4MyGx9bUiiTcIcIIqvufnsMzQ6gZaOQ7CXv
        UKVBcK22SuVZZt9/titoswQIjPVP/wg99hE0d1uQn/EVSZl3PDvRDrA2ze9CczaFuCxAgh
        pp5jFqhawZrdZm4CWknZC626bN2Q4DA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-uE8nLGAYOGSJxct-upcC1w-1; Mon, 28 Jun 2021 17:17:35 -0400
X-MC-Unique: uE8nLGAYOGSJxct-upcC1w-1
Received: by mail-qt1-f197.google.com with SMTP id u18-20020a05622a1992b029024f5f5d3a48so8621577qtc.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 14:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RnhvoDTmuhs9KIxjvKpzhhBCSacIZCBGXUwbPjFZJ9A=;
        b=B1tjtY5jtxrD4SXqEkJsJvymG6Qknfg+IMs8R8CA4ci7sUZwEg1cGNJV98Z/3cj4Z7
         uZX94DfC5FmYwlKw3pKiUzfBaOSYj2yADOoESqEsiW87mAd8rtolSkfC8oksRd3kMYCD
         3BVVngoq5/1Th8XVMGMd47j3RnG+6pUR6SAb4bcELs2UbccdghKip5WCDFTNCZ0JnMXk
         X98ZY6GOd96np9vxc1pj+JgKiysEA0ktdFfgPdkgXWCePiMzmkenXNn35tYFmZF3SsH5
         XMW7gBTsaKuhz4GNqYxX6xSZDzsxALDH2a1ttPcjJkeFmA7A0OBC+uJfKI0fbC7jVdJ4
         1VHg==
X-Gm-Message-State: AOAM530F/3CjlUSmFea1xlRxeZj7lcSe9BSdIQyD6pRSLxPoTevXH5/w
        ASguw1W+q1YgTCQH1tCKFk/HwBbVr9DVGIPK2xdKs5VqmbqaQxSFKzNy11zgOry2VwNrKw0pJss
        MVs3GBENVXr/5UR+BIXUDPZSM
X-Received: by 2002:a05:622a:89:: with SMTP id o9mr22936120qtw.339.1624915054724;
        Mon, 28 Jun 2021 14:17:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaQ4xRxOWn2waVjZ2cksSsPDcFUIRKevd/nNXal2hzdtcneOwui5G7YEsqQsQ1hwGpednx8w==
X-Received: by 2002:a05:622a:89:: with SMTP id o9mr22936109qtw.339.1624915054533;
        Mon, 28 Jun 2021 14:17:34 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id x7sm10924237qke.62.2021.06.28.14.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 14:17:33 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] locking/lockdep: Fix meaningless usages output of lock
 classes
To:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
References: <20210628151708.138524-1-sxwjean@me.com>
Message-ID: <8fc00823-9d42-2178-784a-af33cc34b168@redhat.com>
Date:   Mon, 28 Jun 2021 17:17:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210628151708.138524-1-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 11:17 AM, Xiongwei Song wrote:
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
With this patch, CONFIG_LOCKDEP without CONFIG_PROVE_LOCKING will make 
/proc/lockdep displays just the list of lock classes with their 
associated lock keys. I think it is worth explicitly saying that in the 
commit log.
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>   kernel/locking/lockdep_proc.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
> index 806978314496..a1ec2652d492 100644
> --- a/kernel/locking/lockdep_proc.c
> +++ b/kernel/locking/lockdep_proc.c
> @@ -70,23 +70,25 @@ static int l_show(struct seq_file *m, void *v)
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
>   	}
>   	seq_puts(m, "\n");

Maybe you can remove the blank lines in this case by moving the last 
seq_puts() inside the if loop. The blank lines are not really needed 
without the associated locks_after information.

Cheers,
Longman

