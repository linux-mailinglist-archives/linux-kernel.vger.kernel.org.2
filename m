Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD741790A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbhIXQrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245680AbhIXQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632501929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ig1qXwYYJ1Io94fZ4ATHrf6EpK7gmAjJE8Ln9sGX3Dc=;
        b=WIyEKP51Ga3N/0d+WwLdkTRLKEx+qOpj8EcSJ9tqZawnC3uEf9Y9tN2ipmznY0zJyAiHid
        rTVTXHfK5tWQJaH1ED18TfgVzGvm1ad0phHHM4Sk8CkhGKvC1B6QmDHnTExgWFsIClgQod
        cwUrTboRpIB4gmcQOOryKCJbaAxUTfc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-iyhM27qfMUyGh2Q2nXXH5w-1; Fri, 24 Sep 2021 12:45:28 -0400
X-MC-Unique: iyhM27qfMUyGh2Q2nXXH5w-1
Received: by mail-wr1-f69.google.com with SMTP id r9-20020a5d4989000000b0015d0fbb8823so8551930wrq.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 09:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ig1qXwYYJ1Io94fZ4ATHrf6EpK7gmAjJE8Ln9sGX3Dc=;
        b=yT49kNn8069J6gh+bMZOjn0FdSzXqPf712+Wqr1YJYoS6XL4gHEEfWxLZzQQ4iye5s
         ndNVuPwH9zexzxRRrMMt5uPh1yNzUIMIYYo/mBqQnzmd1sT4dqwnU4yJde/FqgxC3C/C
         FlyI8qtiPD91vRAjF1vs/avFgeM3YApuBuh7U95rWk7CegqbwwLFysbGARLeXXwjEzbG
         WZUb753Lldw4SI/cxCAHiAgYCZLLTkFDBLqwcnZ7eFboUiI0Xz1yEfLyuciwM4nr2Iq3
         kXmZTtlXhYpxMti++kfI0Jc2ckqJFEqdIv3/jdoy6wTspwdXTQBed0g/CKluwi3Da5XG
         rAbQ==
X-Gm-Message-State: AOAM530NnODS9Hc1Y0m/9Ey5nGn7gVVvDVpW1XaGZMhxRkWcv5e4Htnp
        IBdk3VC1XyeRXrkPhzPtjiEndwW++m4rt9KIaZ0300Ogt2x4204SvMskUGEoIQNxyjfnxMy0FiH
        Vi5ACiUM9UM6mLQICcES6VJwU
X-Received: by 2002:a1c:2d6:: with SMTP id 205mr3152498wmc.101.1632501927431;
        Fri, 24 Sep 2021 09:45:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeK/CEJNWF7tmBJ+3orunp2QGfRYrewO5FXWod4Yzr5bcOJj4rTxMbuz+PsEwYoPXBuHf2sA==
X-Received: by 2002:a1c:2d6:: with SMTP id 205mr3152471wmc.101.1632501927167;
        Fri, 24 Sep 2021 09:45:27 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61fc.dip0.t-ipconnect.de. [91.12.97.252])
        by smtp.gmail.com with ESMTPSA id l26sm12837674wmi.25.2021.09.24.09.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 09:45:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] mm/migrate: optimize hotplug-time demotion order
 updates
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, oliver.sang@intel.com, ying.huang@intel.com,
        mhocko@suse.com, weixugc@google.com, osalvador@suse.de,
        rientjes@google.com, dan.j.williams@intel.com, gthelen@google.com,
        yang.shi@linux.alibaba.com, akpm@linux-foundation.org
References: <20210924161251.093CCD06@davehans-spike.ostc.intel.com>
 <20210924161253.D7673E31@davehans-spike.ostc.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3d9eb91d-eb2c-84e7-fd79-a860bfda7be7@redhat.com>
Date:   Fri, 24 Sep 2021 18:45:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210924161253.D7673E31@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.21 18:12, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> == tl;dr ==
> 
> Automatic demotion opted for a simple, lazy approach to handling
> hotplug events.  This noticeably slows down memory hotplug[1].
> Optimize away updates to the demotion order when memory hotplug
> events should have no effect.
> 
> This has no effect on CPU hotplug.  There is no known problem on
> the CPU side and any work there will be in a separate series.
> 
> == Background ==
> 
> Automatic demotion is a memory migration strategy to ensure that
> new allocations have room in faster memory tiers on tiered memory
> systems.  The kernel maintains an array (node_demotion[]) to
> drive these migrations.
> 
> The node_demotion[] path is calculated by starting at nodes with
> CPUs and then "walking" to nodes with memory.  Only hotplug
> events which online or offline a node with memory (N_ONLINE) or
> CPUs (N_CPU) will actually affect the migration order.
> 
> == Problem ==
> 
> However, the current code is lazy.  It completely regenerates the
> migration order on *any* CPU or memory hotplug event.  The logic
> was that these events are extremely rare and that the overhead
> from indiscriminate order regeneration is minimal.
> 
> Part of the update logic involves a synchronize_rcu(), which is a
> pretty big hammer.  Its overhead was large enough to be detected
> by some 0day tests that watch memory hotplug performance[1].
> 
> == Solution ==
> 
> Add a new helper (node_demotion_topo_changed()) which can
> differentiate between superfluous and impactful hotplug events.
> Skip the expensive update operation for superfluous events.
> 
> == Aside: Locking ==
> 
> It took me a few moments to declare the locking to be safe enough
> for node_demotion_topo_changed() to work.  It all hinges on the
> memory hotplug lock:
> 
> During memory hotplug events, 'mem_hotplug_lock' is held for
> write.  This ensures that two memory hotplug events can not be
> called simultaneously.
> 
> CPU hotplug has a similar lock (cpuhp_state_mutex) which also
> provides mutual exclusion between CPU hotplug events.  In
> addition, the demotion code acquire and hold the mem_hotplug_lock
> for read during its CPU hotplug handlers.  This provides mutual
> exclusion between the demotion memory hotplug callbacks and the
> CPU hotplug callbacks.
> 
> This effectively allows treating the migration target generation
> code to act as if it is single-threaded.
> 
> 1. https://lore.kernel.org/all/20210905135932.GE15026@xsang-OptiPlex-9020/
> 
> Fixes: 884a6e5d1f93 ("mm/migrate: update node demotion order on hotplug events")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   b/mm/migrate.c |   12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff -puN mm/migrate.c~faster-node-order mm/migrate.c
> --- a/mm/migrate.c~faster-node-order	2021-09-24 09:12:30.988377798 -0700
> +++ b/mm/migrate.c	2021-09-24 09:12:30.988377798 -0700
> @@ -3239,8 +3239,18 @@ static int migration_offline_cpu(unsigne
>    * set_migration_target_nodes().
>    */
>   static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> -						 unsigned long action, void *arg)
> +						 unsigned long action, void *_arg)
>   {
> +	struct memory_notify *arg = _arg;
> +
> +	/*
> +	 * Only update the node migration order when a node is
> +	 * changing status, like online->offline.  This avoids
> +	 * the overhead of synchronize_rcu() in most cases.
> +	 */
> +	if (arg->status_change_nid < 0)
> +		return notifier_from_errno(0);
> +
>   	switch (action) {
>   	case MEM_GOING_OFFLINE:
>   		/*
> _
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

