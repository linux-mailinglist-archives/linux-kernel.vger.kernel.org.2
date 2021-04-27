Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD436BC7A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 02:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhD0AKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 20:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhD0AKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 20:10:07 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC49AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 17:09:23 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id f12so43026602qtf.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 17:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASbelm9S4yPS4xWMqCvASfjkulblCpeK5M5qQRrljEU=;
        b=Je/gY+2BmbAhU/jLay+7xG82NGKtAaAgFNfic53VapjebG9Xc/WaSOrs9ay8U/NhWn
         0iQe5DLr4mVuBW/4Hk30sq3KTqNnZyOwmZ35s3t+FrNJEXzY0idFtjmzMpINq99iF0f7
         1hHxAcQC1gNvZSSzgEtp/xobDG4TvzFw0vtlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASbelm9S4yPS4xWMqCvASfjkulblCpeK5M5qQRrljEU=;
        b=HNWciplyW5cm1DuXd31ImD4xTUiiqjX9QXc5fQzc2lysswBL5eulo7G/LI67khZpax
         X+mD64aMQFJQMmawGlLfmjGJ96fT3ffIrtGp2gTBO7TCPLCXAtX85EqcM5RKnGQezKXA
         76sg+UGAnsEURF0M8lFv2DMmSzzoI3mkZamqlccUFURjYucH9ZtjW0qS19rwemHtLoVP
         YM+16yYDWAUp3ccqCQZ7RYtBAy1R+SXvIj1BiTYwJWDHqzxv9HFtfwDFSreOS6reRXer
         GRZFe+GHP9uYrEUg08SK7cAuI8A8NVc9xX+OJchsPXBC//9wc7fTaMKia+4mq1XOliaP
         qL5A==
X-Gm-Message-State: AOAM531fUiNIMPz5pSMCI54FeX9eSqBgIpIx6l4cxtTlPqDcC7vptvL2
        ZyYjUf/RP93eTNSa4ho9Dh8XtIzBlEDPL7H45rI=
X-Google-Smtp-Source: ABdhPJzYYVbDzkwP1j64JRJ4JesWIj9Np4hK4nua2AtVgg1J8wHVBnhbJLqB3hi8ainUdcLmAURe8w==
X-Received: by 2002:ac8:4e53:: with SMTP id e19mr19131950qtw.248.1619482162958;
        Mon, 26 Apr 2021 17:09:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1d8c])
        by smtp.gmail.com with ESMTPSA id f2sm1629076qkm.84.2021.04.26.17.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 17:09:22 -0700 (PDT)
Date:   Tue, 27 Apr 2021 01:09:20 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Alexander Sosna <alexander@sosna.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM casualties by enforcing memcg limits
Message-ID: <YIdWMC/iAdanDjLh@chrisdown.name>
References: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ea6db5cc-f862-7c4b-d872-acb29c2d8193@sosna.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Alexander Sosna writes:
>Before this commit memory cgroup limits were not enforced during
>allocation.  If a process within a cgroup tries to allocates more
>memory than allowed, the kernel will not prevent the allocation even if
>OVERCOMMIT_NEVER is set.  Than the OOM killer is activated to kill
>processes in the corresponding cgroup.

Unresolvable cgroup overages are indifferent to vm.overcommit_memory, since 
exceeding memory.max is not overcommitment, it's just a natural consequence of 
the fact that allocation and reclaim are not atomic processes. Overcommitment, 
on the other hand, is about the bounds of available memory at the global 
resource level.

>This behavior is not to be expected
>when setting OVERCOMMIT_NEVER (vm.overcommit_memory = 2) and it is a huge
>problem for applications assuming that the kernel will deny an allocation
>if not enough memory is available, like PostgreSQL.  To prevent this a
>check is implemented to not allow a process to allocate more memory than
>limited by it's cgroup.  This means a process will not be killed while
>accessing pages but will receive errors on memory allocation as
>appropriate.  This gives programs a chance to handle memory allocation
>failures gracefully instead of being reaped.

We don't guarantee that vm.overcommit_memory 2 means "no OOM killer". It can 
still happen for a bunch of reasons, so I really hope PostgreSQL isn't relying 
on that.

Could you please be more clear about the "huge problem" being solved here? I'm 
not seeing it.

>Signed-off-by: Alexander Sosna <alexander@sosna.de>
>
>diff --git a/mm/util.c b/mm/util.c
>index a8bf17f18a81..c84b83c532c6 100644
>--- a/mm/util.c
>+++ b/mm/util.c
>@@ -853,6 +853,7 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
>  *
>  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
>  * Additional code 2002 Jul 20 by Robert Love.
>+ * Code to enforce memory cgroup limits added 2021 by Alexander Sosna.
>  *
>  * cap_sys_admin is 1 if the process has admin privileges, 0 otherwise.
>  *
>@@ -891,6 +892,34 @@ int __vm_enough_memory(struct mm_struct *mm, long
>pages, int cap_sys_admin)
> 		long reserve = sysctl_user_reserve_kbytes >> (PAGE_SHIFT - 10);
>
> 		allowed -= min_t(long, mm->total_vm / 32, reserve);
>+
>+#ifdef CONFIG_MEMCG
>+		/*
>+		 * If we are in a memory cgroup we also evaluate if the cgroup
>+		 * has enough memory to allocate a new virtual mapping.

This comment confuses me further, I'm afraid. You're talking about virtual 
mappings, but then checking memory.max, which is about allocated pages.

>+		 * This is how we can keep processes from exceeding their
>+		 * limits and also prevent that the OOM killer must be
>+		 * awakened.  This gives programs a chance to handle memory
>+		 * allocation failures gracefully and not being reaped.
>+		 * In the current version mem_cgroup_get_max() is used which
>+		 * allows the processes to exceeded their memory limits if
>+		 * enough SWAP is available.  If this is not intended we could
>+		 * use READ_ONCE(memcg->memory.max) instead.
>+		 *
>+		 * This code is only reached if sysctl_overcommit_memory equals
>+		 * OVERCOMMIT_NEVER, both other options are handled above.
>+		 */
>+		{
>+			struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
>+
>+			if (memcg) {
>+				long available = mem_cgroup_get_max(memcg)
>+						- mem_cgroup_size(memcg);
>+
>+				allowed = min_t(long, available, allowed);
>+			}
>+		}
>+#endif
> 	}
>
> 	if (percpu_counter_read_positive(&vm_committed_as) < allowed)
>
