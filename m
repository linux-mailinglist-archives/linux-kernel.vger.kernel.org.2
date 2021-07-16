Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9FB3CBE05
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 22:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhGPUxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 16:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhGPUxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 16:53:10 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EC8C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 13:50:13 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ck17so5224960qvb.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 13:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=eP+vdjS8P2oSI7HEDS+oh3O0Y+BLb63u8Xg1Z86gM8g=;
        b=OyZEvDSzk2JzXO1WlOoiW9zJM0/OC3IPYXIxFo7A1ItTKDB7ZkYWs6Z0LNEDzV0wP7
         an2p0lafJ7R9/5GOEoUxx5Wv0KlatzZ9CYV3rmS+L/a/zpw1jlBEggj25yOGpnVt0+oh
         EvepArkPWyoYKLYU+SlIEbaEji7vbAdaUXBCLxfQyr0487znAEYX9qEmGTmYQz/UqSJr
         LOAgxeypTy0xCyTrlf6kvHmbzA4hMxzYGl6WmAlFO0Oeiwq98cSF6VBK3Un4xq0mq6M1
         LCY57MDqkIqbLVf1IieX34spfe6AD4tfqsIO3oafpmk3Uq/qh78j7mSFT5yKpyORO8Mi
         u02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=eP+vdjS8P2oSI7HEDS+oh3O0Y+BLb63u8Xg1Z86gM8g=;
        b=onAB/V62tVpOxgPCdmKOCxbHuneEw5faZafHrP0weHUIfXGOHHLJAsbaJMh7JLOyzh
         zr8yr3QuMlGc9td9WELMPqstdk3q/Cn2RDog71YyW5Z7EG+QlquSIlmCB9sCwSvlk9vs
         qjNgq/DLk9p0KNTC0Qx3SDml4hnSw6N8YtadOT96Lp/8tLbUM+VKltTkYr8K27LNdv25
         cFLNNeA5IpDpNztShDUnbc4IBRjsRUDXPN0fzLxEdIOsDAEAyWb4jIi8osT+j1s9R9Rs
         zQP9HlyPTBQeSgqSSld9tx69h/ab7gLEI8YZJ1LuB6Fn5++7kTPAss8xj5/Ezu68OhRY
         hMkQ==
X-Gm-Message-State: AOAM532IMVI2ZRySFD+saewpwlWlJP6zk+8PYVLP9lCgX9RVEc+XW5ex
        wWAhWH75pUwa2zVDnJnTNxiSLA==
X-Google-Smtp-Source: ABdhPJxrik1zpDcx7wkwM7ODO9toNtzWr4VKncewI3Idid0KpMjorJgVg1Yumldacapk6mpiT/b5vw==
X-Received: by 2002:a0c:d845:: with SMTP id i5mr12130743qvj.32.1626468612726;
        Fri, 16 Jul 2021 13:50:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c16sm3591087qtv.32.2021.07.16.13.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:50:12 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:50:10 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
cc:     akpm@linux-foundation.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: KSM: fix data types
In-Reply-To: <20210716055800.GA255851@asus>
Message-ID: <181bd7fd-dcb6-3dea-305c-5764603d7d45@google.com>
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

Compiling with CONFIG_MEMORY_HOTREMOVE=y would show why.

Search for where ksm_run is used: in one place there's
	wait_on_bit(&ksm_run, ilog2(KSM_RUN_OFFLINE), TASK_UNINTERRUPTIBLE);
and wait_on_bit() operates on unsigned long *word.

Before that wait while offlining, yes, ksm_run used to be an unsigned int.

But there's nothing to be fixed by changing it to unsigned int now.
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
