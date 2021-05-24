Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABB038E09D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhEXFQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEXFQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:16:30 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3E0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:15:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso9713445pjx.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/EUmhL8O/6C6s2ym0jeZMd3h5j+uY9ZLba6aQ9iY5t0=;
        b=fvEmZIDKyXvyOLe5GS631DgmBBGCSuKQWAbo1zf5iQd26iAszG3JmoWJXgcGWeeQgR
         53lYlCdcQPz0ChKhF/gSUELKziE27UUdQI/0HBqaodhZrA0QIeNbVMB+RazDQzghAD9t
         Qdp4ufeXx0BYDnmVSNxwclI/rGafSZrszmbFlxbcq1SVnptG+PQl4By6YItLilCJ+cem
         QD6Mm01KEbz/tATF3JIs4pPO7Uw2oWsroImFSghMRtSvAITg8HkfAevcwBhuzSsh6Eoo
         wesuomRUgQ6iSODerJ3R7HDsQuV0BTtnVLhPRXslDUHZt2epNVnFFMsH/bRTTs0FmfRr
         z0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/EUmhL8O/6C6s2ym0jeZMd3h5j+uY9ZLba6aQ9iY5t0=;
        b=XvCXySfDnG6irRI3AUizHn5PlOwajVpZn4BgteYbphH4UPiJMDUa0H5TVklkmIkoOY
         KqJH5FKimucogjusI6yfF786gGx5VGttn94npZh14yOLRQPFz6l5/ZFPlRnKHAUSYc2w
         AQpm4MiXhUartxNRvN4ABODGwvu9MhAB74DHehi+SSm0pg6NCEVJZo7AfvrPP2ymESU3
         VhUXasORDE2/YE/Z9TWEr6mmgqhtXplJTWUMUM0LoH/grJwfXGx7dpgLblKu1CNGavSP
         HSzX07qp3YUjy5KOpSRp+jjR2D44AFo8LWXK+H5OE2GiXWnOK8JNgY8MEsMcv3EaPNL+
         5sQw==
X-Gm-Message-State: AOAM531rydyaeS6jBLjVl9GzmSXRMJudvxivzknrl2J2/I4XKS+FLGGb
        BjKZ+X2i+4XBeQlVy2sFm2GUBw==
X-Google-Smtp-Source: ABdhPJwRcRWbq8UVhU8Q8uxV+T8q9AR+Ax7DpNA9MPX19ZzG8+nBt4bd79JBqxnUdvl+w0ZffLNUEQ==
X-Received: by 2002:a17:902:d4c6:b029:ef:80f3:c543 with SMTP id o6-20020a170902d4c6b02900ef80f3c543mr23899565plg.85.1621833301829;
        Sun, 23 May 2021 22:15:01 -0700 (PDT)
Received: from [2620:15c:17:3:9016:8a6d:7de4:aa23] ([2620:15c:17:3:9016:8a6d:7de4:aa23])
        by smtp.gmail.com with ESMTPSA id s3sm10932299pgs.62.2021.05.23.22.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 22:15:01 -0700 (PDT)
Date:   Sun, 23 May 2021 22:15:00 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Feng Tang <feng.tang@intel.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [RFC Patch v2 1/4] mm/mempolicy: skip nodemask intersect check
 for 'interleave' when oom
In-Reply-To: <1621499404-67756-2-git-send-email-feng.tang@intel.com>
Message-ID: <682c92e5-ccb3-4b76-1f56-617f8e6e8f2@google.com>
References: <1621499404-67756-1-git-send-email-feng.tang@intel.com> <1621499404-67756-2-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021, Feng Tang wrote:

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d79fa29..1964cca 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2098,7 +2098,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
>   *
>   * If tsk's mempolicy is "default" [NULL], return 'true' to indicate default
>   * policy.  Otherwise, check for intersection between mask and the policy
> - * nodemask for 'bind' or 'interleave' policy.  For 'preferred' or 'local'
> + * nodemask for 'bind' policy.  For 'interleave', 'preferred' or 'local'
>   * policy, always return true since it may allocate elsewhere on fallback.
>   *
>   * Takes task_lock(tsk) to prevent freeing of its mempolicy.
> @@ -2111,29 +2111,13 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
>  
>  	if (!mask)
>  		return ret;
> +
>  	task_lock(tsk);
>  	mempolicy = tsk->mempolicy;
> -	if (!mempolicy)
> -		goto out;
> -
> -	switch (mempolicy->mode) {
> -	case MPOL_PREFERRED:
> -		/*
> -		 * MPOL_PREFERRED and MPOL_F_LOCAL are only preferred nodes to
> -		 * allocate from, they may fallback to other nodes when oom.
> -		 * Thus, it's possible for tsk to have allocated memory from
> -		 * nodes in mask.
> -		 */
> -		break;
> -	case MPOL_BIND:
> -	case MPOL_INTERLEAVE:
> +	if (mempolicy && mempolicy->mode == MPOL_BIND)
>  		ret = nodes_intersects(mempolicy->v.nodes, *mask);

If MPOL_INTERLEAVE is deemed only a suggestion, the same could be 
considered true of MPOL_BIND intersection as well, no?

> -		break;
> -	default:
> -		BUG();
> -	}
> -out:
>  	task_unlock(tsk);
> +
>  	return ret;
>  }
>  
> -- 
> 2.7.4
> 
> 
