Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3503CBDE3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 22:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhGPUoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGPUoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 16:44:22 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8761CC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 13:41:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so11175714otf.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GWg7KvZek5iHgGcgjBYGZpfEqTpA91OnuHVW1dgUmyk=;
        b=P/in7RLZw4u1H7lAfXtHYVJrDzt51HXZnpV1rOttAGC0coD1XzQ4LeCMYBgI0t4SG0
         SQQQSvA6C+txH0PnhRI92ODNW0GTD33hoUUz2bx1/wuAILbzAeRhpzqzXuWsICT8+RXN
         5bk0M8rCUOBGVRHk/4uUg0aZe4/qcO/YCIEw+EwXy/gbvphsOvdWzmDnmXJiplI8K7Ow
         lqFfkke2+D2Yzxot4SU8boUYq8MUuVOssCqopUme2t7PA04p6J9SWh6tG6bu/an5pIKz
         Y2iE9SOYsfLmMP2fTwmA36kKYmmhEzwteC57dX8v+q1sf19N6KUZknnArVtXUApCcicO
         y9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=GWg7KvZek5iHgGcgjBYGZpfEqTpA91OnuHVW1dgUmyk=;
        b=YryelCWKjHQ/VZ9uO8rofG2m/k6u/fUsQpiZNmMY6KLMNRX3UN9lwnC91DYh502HAS
         /tAhfpNK1CvD0F1cl+9MorkrEKYlF/EkfUSACshlMi9zR+AX1ICc4nL3xvHIZn2HDokr
         r38QPgEeba4igt+ooAlughgWvtezc4Q6jLpsjKL5+ZiFOEN6n4b9CbnxApxk2ki54Rcc
         8ISKmCzgmkvbMD236Rqb2KAb0XxDXcd07faA5bgPATP6MIZT413fgrkE8NsfBOMPpkcz
         kIpYv3tXiF3IugCaWyjg0bWKuG1DWn9cXKpQ+LkEAnBWt0VJYDHeUce6rOCy8hrPcCeU
         GKTQ==
X-Gm-Message-State: AOAM530Wg8ukFYjc1A2CIAMg0hBBta7BK0EkJX+jo1RqeBaazIffNWAi
        Sv6ggLbFsTR13yuuEIk6b3ovvQ==
X-Google-Smtp-Source: ABdhPJzvQl8z42rkBo8kYI1UMWGkKto8Tj4Cd39VLbpPOLEaInWWqKTLgz4YDxrQf4GRp2lkr+7i6Q==
X-Received: by 2002:a9d:61d9:: with SMTP id h25mr5619563otk.81.1626468086638;
        Fri, 16 Jul 2021 13:41:26 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v8sm2154907oth.69.2021.07.16.13.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:41:26 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:41:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
cc:     akpm@linux-foundation.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: KSM: fix data types
In-Reply-To: <20210716055800.GA255851@asus>
Message-ID: <e139c727-9f5a-3b8-9136-162ce5c1de40@google.com>
References: <20210716055800.GA255851@asus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021, Zhansaya Bagdauletkyzy wrote:

> Change data types of ksm_run and ksm_stable_node_chains_prune_millisecs
> as there were a few discrepancies between the types and actual values
> that were stored:
> 1) ksm_run is declared as unsigned long but in run_store(), it is
> converted to unsigned int. Change its type to unsigned int.

NAK to that part.

Compiling with CONFIG_MEMORY_HOTREMOVE=y would show you why.

Search for where ksm_run is used: in one place
	wait_on_bit(&ksm_run, ilog2(KSM_RUN_OFFLINE), TASK_UNINTERRUPTIBLE);
and wait_on_bit() operates on an unsigned long *word.

Before that wait while offlining, yes, ksm_run used to be an unsigned int.

But there is nothing to be fixed by changing it to an unsigned int now.
Save four bytes?  Better look elsewhere if you want to save four bytes.

> 2) ksm_stable_node_chains_prune_millisecs is declared as int, but in
> stable__node_chains_prune_millisecs_store(), it can store values up to
> UINT_MAX. Change its type to unsigned int.

Ack to that part.

> 
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
> ---
> v1 -> v2:
> - merge two patches into one

Sorry, that didn't work out so well.

Hugh

> 
>  mm/ksm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 3fa9bc8a67cf..2e4bd7662e52 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -259,7 +259,7 @@ static unsigned long ksm_stable_node_chains;
>  static unsigned long ksm_stable_node_dups;
>  
>  /* Delay in pruning stale stable_node_dups in the stable_node_chains */
> -static int ksm_stable_node_chains_prune_millisecs = 2000;
> +static unsigned int ksm_stable_node_chains_prune_millisecs = 2000;
>  
>  /* Maximum number of page slots sharing a stable node */
>  static int ksm_max_page_sharing = 256;
> @@ -289,7 +289,7 @@ static int ksm_nr_node_ids = 1;
>  #define KSM_RUN_MERGE	1
>  #define KSM_RUN_UNMERGE	2
>  #define KSM_RUN_OFFLINE	4
> -static unsigned long ksm_run = KSM_RUN_STOP;
> +static unsigned int ksm_run = KSM_RUN_STOP;
>  static void wait_while_offlining(void);
>  
>  static DECLARE_WAIT_QUEUE_HEAD(ksm_thread_wait);
> @@ -2874,7 +2874,7 @@ KSM_ATTR(pages_to_scan);
>  static ssize_t run_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			char *buf)
>  {
> -	return sysfs_emit(buf, "%lu\n", ksm_run);
> +	return sysfs_emit(buf, "%u\n", ksm_run);
>  }
>  
>  static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
> @@ -3105,11 +3105,11 @@ stable_node_chains_prune_millisecs_store(struct kobject *kobj,
>  					 struct kobj_attribute *attr,
>  					 const char *buf, size_t count)
>  {
> -	unsigned long msecs;
> +	unsigned int msecs;
>  	int err;
>  
> -	err = kstrtoul(buf, 10, &msecs);
> -	if (err || msecs > UINT_MAX)
> +	err = kstrtouint(buf, 10, &msecs);
> +	if (err)
>  		return -EINVAL;
>  
>  	ksm_stable_node_chains_prune_millisecs = msecs;
> -- 
> 2.25.1
