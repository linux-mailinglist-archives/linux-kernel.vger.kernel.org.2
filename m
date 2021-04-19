Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05582363C05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbhDSHAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDSHAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:00:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFBCC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:00:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b17so23600077pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dk2/9Hs4gCeLuOk2z2sMzsyg1GMNTelWF08Mrd5lMC0=;
        b=d9obWs3erdjaKB6VgVfN7hy1egp8tivwn9bXkq7q5F9jJtVaDnpFTJBSxhhLTA2Pg/
         H3p+JIDvhuA8XTUFOEH3XjXsalKtje4qi1sWp1KUxwrNWGXEZIgp/rKJdVlfLg6CpOK0
         DeDP/CDWmNG28XBcCkoK5hBnHhYphWZmpB/evs5MEj6WQ5A78FjgBMP2XResZ/rQCn1f
         eUKbq7JMHCBCpq5BSs7GVjBZnzb5zED/TYDhb9OIJnbnI6wx00uPnLoaDZYGjA4ShELz
         kDu7y5cZZgMXdXKRKfwDMW8yy2njA6WgI14Dmc6warh3kGmqgoBx6rE2A06olC2TOekZ
         pwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dk2/9Hs4gCeLuOk2z2sMzsyg1GMNTelWF08Mrd5lMC0=;
        b=cJ0nKlE3osBnXOEWBFqAtRh1b6+fDK4katYyWyGUUmaiyAOmuxPE19lvG7zCqn3jiG
         pRiB3rCn8YjMoDnTCVWEU+WXz86zyOZft8w4/ZC/ahftD7WbamYgprC8GiCTmUftvsO+
         hy411tD7Yifv6YI8HZH7wERTo+YglB4Q/tjH7pRZgc2jQVseB+1GY1kGAO45YnVLR5KM
         kAID0frOmvCMp4ErWJ2+Z/9k0eftaB88fS+RvgiNQkv91I8aG8JToL+S//OluBnq8HvN
         l0u4fkBQUOpOZssqyuww16iyOsVoqUc1k+zrtxwLtRmMcFlAiZ9Pn4fv944opZS5m2ee
         bLaA==
X-Gm-Message-State: AOAM530Ldb8sw2izYzm616yt971fVOuyr4dVXZtcFuYjILAIot/P3Zre
        eLedV2IzQqx6oOB9BMfCqCQ=
X-Google-Smtp-Source: ABdhPJxJgy8WLzl6Rfn3UohRDC8bRZXk1wE5VqtWIe0usLH93JizsWl45G9idOtRf9D3ibdrbUPLJw==
X-Received: by 2002:a05:6a00:856:b029:208:f11c:231f with SMTP id q22-20020a056a000856b0290208f11c231fmr18143818pfk.25.1618815621154;
        Mon, 19 Apr 2021 00:00:21 -0700 (PDT)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id y24sm10449927pjp.26.2021.04.19.00.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:00:20 -0700 (PDT)
Date:   Mon, 19 Apr 2021 17:00:16 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Josh Snyder <joshs@netflix.com>
Subject: Re: [PATCH] delayacct: clear right task's flag after blkio completes
Message-ID: <20210419070016.GB8178@balbir-desktop>
References: <20210414083720.24083-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414083720.24083-1-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 04:37:20PM +0800, Yafang Shao wrote:
> When I was implementing a latency analyze tool by using task->delays and
> other things, I found there's issue in delayacct. The issue is it should
> clear the target's flag instead of current's in delayacct_blkio_end().
> 
> When I git blame delayacct, I found there're some similar issues we have
> fixed in delayacct_blkio_end().
> 'Commit c96f5471ce7d ("delayacct: Account blkio completion on the correct task")'
> fixed the issue that it should account blkio completion on the target
> task instead of current.
> 'Commit b512719f771a ("delayacct: fix crash in delayacct_blkio_end() after delayacct init failure")'
> fixed the issue that it should check target task's delays instead of
> current task'. It seems that delayacct_blkio_{begin, end} are error prone.
> So I introduce a new paratmeter - the target task 'p' into these helpers,
> after that change, the callsite will specifilly set the right task, which
> should make it less error prone.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Josh Snyder <joshs@netflix.com>
> ---
>  include/linux/delayacct.h | 20 ++++++++++----------
>  mm/memory.c               |  8 ++++----
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
> index 2d3bdcccf5eb..21651f946751 100644
> --- a/include/linux/delayacct.h
> +++ b/include/linux/delayacct.h
> @@ -82,16 +82,16 @@ static inline int delayacct_is_task_waiting_on_io(struct task_struct *p)
>  		return 0;
>  }
>  
> -static inline void delayacct_set_flag(int flag)
> +static inline void delayacct_set_flag(struct task_struct *p, int flag)
>  {
> -	if (current->delays)
> -		current->delays->flags |= flag;
> +	if (p->delays)
> +		p->delays->flags |= flag;
>  }
>  
> -static inline void delayacct_clear_flag(int flag)
> +static inline void delayacct_clear_flag(struct task_struct *p, int flag)
>  {
> -	if (current->delays)
> -		current->delays->flags &= ~flag;
> +	if (p->delays)
> +		p->delays->flags &= ~flag;
>  }
>  
>  static inline void delayacct_tsk_init(struct task_struct *tsk)
> @@ -114,7 +114,7 @@ static inline void delayacct_tsk_free(struct task_struct *tsk)
>  
>  static inline void delayacct_blkio_start(void)
>  {
> -	delayacct_set_flag(DELAYACCT_PF_BLKIO);
> +	delayacct_set_flag(current, DELAYACCT_PF_BLKIO);
>  	if (current->delays)
>  		__delayacct_blkio_start();
>  }
> @@ -123,7 +123,7 @@ static inline void delayacct_blkio_end(struct task_struct *p)
>  {
>  	if (p->delays)
>  		__delayacct_blkio_end(p);
> -	delayacct_clear_flag(DELAYACCT_PF_BLKIO);
> +	delayacct_clear_flag(p, DELAYACCT_PF_BLKIO);
>  }
>  
>  static inline int delayacct_add_tsk(struct taskstats *d,
> @@ -166,9 +166,9 @@ static inline void delayacct_thrashing_end(void)
>  }
>  
>  #else
> -static inline void delayacct_set_flag(int flag)
> +static inline void delayacct_set_flag(struct task_struct *p, int flag)
>  {}
> -static inline void delayacct_clear_flag(int flag)
> +static inline void delayacct_clear_flag(struct task_struct *p, int flag)
>  {}
>  static inline void delayacct_init(void)
>  {}
> diff --git a/mm/memory.c b/mm/memory.c
> index 550405fc3b5e..a013d32a6611 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3296,7 +3296,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	}
>  
>  
> -	delayacct_set_flag(DELAYACCT_PF_SWAPIN);
> +	delayacct_set_flag(current, DELAYACCT_PF_SWAPIN);
>  	page = lookup_swap_cache(entry, vma, vmf->address);
>  	swapcache = page;
>  
> @@ -3347,7 +3347,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  					vmf->address, &vmf->ptl);
>  			if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
>  				ret = VM_FAULT_OOM;
> -			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
> +			delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
>  			goto unlock;
>  		}
>  
> @@ -3361,13 +3361,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		 * owner processes (which may be unknown at hwpoison time)
>  		 */
>  		ret = VM_FAULT_HWPOISON;
> -		delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
> +		delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
>  		goto out_release;
>  	}
>  
>  	locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
>  
> -	delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
> +	delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
>  	if (!locked) {
>  		ret |= VM_FAULT_RETRY;
>  		goto out_release;

Acked-by: Balbir Singh <bsingharora@gmail.com>

The changes seem reasonable to me. I don't maintain a git tree, Andrew can we
please queue them up in your tree?

Balbir Singh.
