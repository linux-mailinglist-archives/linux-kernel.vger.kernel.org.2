Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFC36AA3A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 03:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhDZBQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 21:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhDZBQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:16:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7566C061760
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 18:15:31 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso4194181pjg.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 18:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=zu1tvaF/aGOCv1iAh1BOxPzQNHj2L/j6d+DdJvsoiAc=;
        b=XZmisxmKvnaeGLCOxrJra5jpdVFpPUsBGH5NSR3g0JWh2RAeWvZSewUe2Gpk5XzJxF
         hAbvuVE/HFIDWSklE7NIC2NRdgEL4p5sEF1IQ0UkEDsKOqdszZ2n4wexrW3cod5rpGHs
         R9DkZe+ni8Q0JTa+vayM5b2zAzVUvE38/8xchX+BX3UuUHRUUD+Kj1NwY+PjxenDUu+Y
         pE+a99NUh+p59s/yrs94pUymkJoruptGBfMuWQB1X3/aC68LSuGMx5ZabdhMnW0IFEpq
         kJhbpcCoVc3X42bgKoZchc7Kb+HTPoaaFONpSVZewJhhIzDD5hvNLD4EebwJkb6cI+St
         Pg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=zu1tvaF/aGOCv1iAh1BOxPzQNHj2L/j6d+DdJvsoiAc=;
        b=ZgTfNXndZlpCUrMC0fMhuybabVZfVdWpU09HvWgqYmaUCN6n/v/NdYFR6lFfyBI3/u
         IYplP0g65TSw3tO8ogd7DdbpyjpBM4EBkc6m18mciz1yt5jZYrKUkk194I5Xp+w9Ldf9
         30EHy0WXI+4r3m8pSaqNSGrLmGLkYaiEfIs9LRjgdZG1BheVIi/s8ZFgkhVgnhgHsbnW
         f0jKzEqBI35DQnrkav1CYy7PCbUCQHFtaQQCWpTUr97wIkLrH6G1qcGeDR04wtEinpX8
         xV9DFbp9/ePP2u68wnwsYBUXv1ae+QmSXTp9ZseJ4Pjb8Wus59zeE+bbltwR+fF6XHHQ
         ulzA==
X-Gm-Message-State: AOAM532aOc5aDEIuusWuFq0GBVLXWI8jCf4wfyxaWX1mAwIh35cd/vvQ
        +RV2Xj5H9K8sjDhjntQ1o7SQkg==
X-Google-Smtp-Source: ABdhPJy+r40r/3pW+j5fLUQ/aMJ3Cn33sVjNff185pYOomtv6VfIxCbNZmkspwGyNYta+kjV97OuQQ==
X-Received: by 2002:a17:903:304b:b029:eb:4cf:8321 with SMTP id u11-20020a170903304bb02900eb04cf8321mr15873865pla.40.1619399730738;
        Sun, 25 Apr 2021 18:15:30 -0700 (PDT)
Received: from [2620:15c:17:3:f93a:1c09:9070:93a7] ([2620:15c:17:3:f93a:1c09:9070:93a7])
        by smtp.gmail.com with ESMTPSA id 1sm9993254pjx.46.2021.04.25.18.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 18:15:29 -0700 (PDT)
Date:   Sun, 25 Apr 2021 18:15:28 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     chukaiping <chukaiping@baidu.com>
cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nigupta@nvidia.com,
        bhe@redhat.com, khalid.aziz@oracle.com, iamjoonsoo.kim@lge.com,
        mateusznosek0@gmail.com, sh_def@163.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/compaction:let proactive compaction order
 configurable
In-Reply-To: <1619313662-30356-1-git-send-email-chukaiping@baidu.com>
Message-ID: <f941268c-b91-594b-5de3-05fc418fbd0@google.com>
References: <1619313662-30356-1-git-send-email-chukaiping@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Apr 2021, chukaiping wrote:

> Currently the proactive compaction order is fixed to
> COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
> normal 4KB memory, but it's too high for the machines with small
> normal memory, for example the machines with most memory configured
> as 1GB hugetlbfs huge pages. In these machines the max order of
> free pages is often below 9, and it's always below 9 even with hard
> compaction. This will lead to proactive compaction be triggered very
> frequently. In these machines we only care about order of 3 or 4.
> This patch export the oder to proc and let it configurable
> by user, and the default value is still COMPACTION_HPAGE_ORDER.
> 

As asked in the review of the v1 of the patch, why is this not a userspace 
policy decision?  If you are interested in order-3 or order-4 
fragmentation, for whatever reason, you could periodically check 
/proc/buddyinfo and manually invoke compaction on the system.

In other words, why does this need to live in the kernel?

> Signed-off-by: chukaiping <chukaiping@baidu.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> 
> Changes in v3:
>     - change the min value of compaction_order to 1 because the fragmentation
>       index of order 0 is always 0
>     - move the definition of max_buddy_zone into #ifdef CONFIG_COMPACTION
> 
> Changes in v2:
>     - fix the compile error in ia64 and powerpc, move the initialization
>       of sysctl_compaction_order to kcompactd_init because 
>       COMPACTION_HPAGE_ORDER is a variable in these architectures
>     - change the hard coded max order number from 10 to MAX_ORDER - 1
> 
>  include/linux/compaction.h |    1 +
>  kernel/sysctl.c            |   10 ++++++++++
>  mm/compaction.c            |    9 ++++++---
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index ed4070e..151ccd1 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -83,6 +83,7 @@ static inline unsigned long compact_gap(unsigned int order)
>  #ifdef CONFIG_COMPACTION
>  extern int sysctl_compact_memory;
>  extern unsigned int sysctl_compaction_proactiveness;
> +extern unsigned int sysctl_compaction_order;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos);
>  extern int sysctl_extfrag_threshold;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 62fbd09..e50f7d2 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -196,6 +196,7 @@ enum sysctl_writes_mode {
>  #endif /* CONFIG_SCHED_DEBUG */
>  
>  #ifdef CONFIG_COMPACTION
> +static int max_buddy_zone = MAX_ORDER - 1;
>  static int min_extfrag_threshold;
>  static int max_extfrag_threshold = 1000;
>  #endif
> @@ -2871,6 +2872,15 @@ int proc_do_static_key(struct ctl_table *table, int write,
>  		.extra2		= &one_hundred,
>  	},
>  	{
> +		.procname       = "compaction_order",
> +		.data           = &sysctl_compaction_order,
> +		.maxlen         = sizeof(sysctl_compaction_order),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec_minmax,
> +		.extra1         = SYSCTL_ONE,
> +		.extra2         = &max_buddy_zone,
> +	},
> +	{
>  		.procname	= "extfrag_threshold",
>  		.data		= &sysctl_extfrag_threshold,
>  		.maxlen		= sizeof(int),
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e04f447..70c0acd 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1925,16 +1925,16 @@ static bool kswapd_is_running(pg_data_t *pgdat)
>  
>  /*
>   * A zone's fragmentation score is the external fragmentation wrt to the
> - * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
> + * sysctl_compaction_order. It returns a value in the range [0, 100].
>   */
>  static unsigned int fragmentation_score_zone(struct zone *zone)
>  {
> -	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
> +	return extfrag_for_order(zone, sysctl_compaction_order);
>  }
>  
>  /*
>   * A weighted zone's fragmentation score is the external fragmentation
> - * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
> + * wrt to the sysctl_compaction_order scaled by the zone's size. It
>   * returns a value in the range [0, 100].
>   *
>   * The scaling factor ensures that proactive compaction focuses on larger
> @@ -2666,6 +2666,7 @@ static void compact_nodes(void)
>   * background. It takes values in the range [0, 100].
>   */
>  unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
> +unsigned int __read_mostly sysctl_compaction_order;
>  
>  /*
>   * This is the entry point for compacting all nodes via
> @@ -2958,6 +2959,8 @@ static int __init kcompactd_init(void)
>  	int nid;
>  	int ret;
>  
> +	sysctl_compaction_order = COMPACTION_HPAGE_ORDER;
> +
>  	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>  					"mm/compaction:online",
>  					kcompactd_cpu_online, NULL);
> -- 
> 1.7.1
> 
> 
