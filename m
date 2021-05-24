Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872B238E09E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhEXFRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhEXFRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:17:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A430CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:16:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s4so12480223plg.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=rxCIp0pv5uzxsSEr1xQGI8fGMXNRFQKrxxPclrqJINI=;
        b=H3T5RdUbHndkki97jgA4nVhBjEEWQyyfl7aVBK/d6D/yOdmpLQF+fMLzYcO+qLubJ4
         LEOkZQ92FgX5WhfORD6urCVyafvdN0YtcTpjWXXoHeHckZ1d1ieihz/t5B+IXf5oCa8b
         b9SwjEViYuvKfqPDPYIarML/8XnHzDHHEwgjncNAlyQQrBOVA3cv9bQAGwHO5zIiuEEJ
         YsnntP1oVrCMGURYe7nPaOM8bQ0n3fQ7yUya/rCt1p5HWIX3/aDWMV7gyknsWrSrKxxK
         0oVsofKonccvP/w+iozzVOxYU16aPFAy2DoWL94W3Zm2dUzLsfmGr3+/0/eMkfhZ4AYo
         O5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=rxCIp0pv5uzxsSEr1xQGI8fGMXNRFQKrxxPclrqJINI=;
        b=bUymnHwqO8Zy7Nd5LgNSTgrT80mTDEoh5TV1/B1rUeIJwzRF18pdV4sAFMuk7cZ5Q5
         LdCh4w4xTup+pdzOLQGDN0+9MGFuQmAS24u1f5TNhq8iw5S8OZWEbNpIc/TWRqDR/yRf
         bB92CPBdVZstwGRGPMxyLNLMcEjh8hGHHh3bGwpssYijmI97opHk2d9xPwI7cC+bdND6
         jaoplkxPtgMXo/UPDM4Iai8uvAhvIHiq6+jpQOglxM1CamG9kGFtCol3ndTBQYA3emvH
         k9h3sAbpz4WOlF2p0XNDF4LKgLL/dfNlLUnj49ULAbo4yllbAYCR/3rDhoK7AtCvfmLP
         ixrw==
X-Gm-Message-State: AOAM532kLgqCNXCJRTT9Fw0Cbo3uxLnvOgmAdh2x3F/SJ3BnhJ6GY342
        M/pJy7eq9ZzCLoobKa2Q+MSmvQ==
X-Google-Smtp-Source: ABdhPJxRfVirUtpZaiSODig2PF5VCXVnshQE2jz+Nv61ptEy7AEI4urI1Zx8B1y7W0JFTBGptjsZQg==
X-Received: by 2002:a17:90b:19d3:: with SMTP id nm19mr23271171pjb.215.1621833373231;
        Sun, 23 May 2021 22:16:13 -0700 (PDT)
Received: from [2620:15c:17:3:9016:8a6d:7de4:aa23] ([2620:15c:17:3:9016:8a6d:7de4:aa23])
        by smtp.gmail.com with ESMTPSA id x187sm4511284pfc.104.2021.05.23.22.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 22:16:12 -0700 (PDT)
Date:   Sun, 23 May 2021 22:16:11 -0700 (PDT)
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
Subject: Re: [RFC Patch v2 2/4] mm/mempolicy: unify the preprocessing for
 mbind and set_mempolicy
In-Reply-To: <1621499404-67756-3-git-send-email-feng.tang@intel.com>
Message-ID: <7a58082-eb68-744c-93b7-1a688b3b27a@google.com>
References: <1621499404-67756-1-git-send-email-feng.tang@intel.com> <1621499404-67756-3-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021, Feng Tang wrote:

> Currently the kernel_mbind() and kernel_set_mempolicy() do almost
> the same operation for parameter sanity check and preprocessing.
> 
> Add a macro to unify the code to reduce the redundancy, and make
> it easier for changing the pre-processing code in future.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/mempolicy.c | 46 +++++++++++++++++++---------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 1964cca..0f5bf60 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1460,25 +1460,29 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
>  	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
>  }
>  
> +#define MPOL_PRE_PROCESS() \

This should be extracted to helper function returning bool, not a macro.

> +	 \
> +	nodemask_t nodes; \
> +	int err; \
> +	unsigned short mode_flags; \
> +	mode_flags = mode & MPOL_MODE_FLAGS; \
> +	mode &= ~MPOL_MODE_FLAGS; \
> +	if (mode >= MPOL_MAX) \
> +		return -EINVAL; \
> +	if ((mode_flags & MPOL_F_STATIC_NODES) && \
> +		(mode_flags & MPOL_F_RELATIVE_NODES)) \
> +		return -EINVAL; \
> +	err = get_nodes(&nodes, nmask, maxnode); \
> +	if (err) \
> +		return err;
> +
>  static long kernel_mbind(unsigned long start, unsigned long len,
>  			 unsigned long mode, const unsigned long __user *nmask,
>  			 unsigned long maxnode, unsigned int flags)
>  {
> -	nodemask_t nodes;
> -	int err;
> -	unsigned short mode_flags;
> +	MPOL_PRE_PROCESS();
>  
>  	start = untagged_addr(start);
> -	mode_flags = mode & MPOL_MODE_FLAGS;
> -	mode &= ~MPOL_MODE_FLAGS;
> -	if (mode >= MPOL_MAX)
> -		return -EINVAL;
> -	if ((mode_flags & MPOL_F_STATIC_NODES) &&
> -	    (mode_flags & MPOL_F_RELATIVE_NODES))
> -		return -EINVAL;
> -	err = get_nodes(&nodes, nmask, maxnode);
> -	if (err)
> -		return err;
>  	return do_mbind(start, len, mode, mode_flags, &nodes, flags);
>  }
>  
> @@ -1493,20 +1497,8 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
>  static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
>  				 unsigned long maxnode)
>  {
> -	int err;
> -	nodemask_t nodes;
> -	unsigned short flags;
> -
> -	flags = mode & MPOL_MODE_FLAGS;
> -	mode &= ~MPOL_MODE_FLAGS;
> -	if ((unsigned int)mode >= MPOL_MAX)
> -		return -EINVAL;
> -	if ((flags & MPOL_F_STATIC_NODES) && (flags & MPOL_F_RELATIVE_NODES))
> -		return -EINVAL;
> -	err = get_nodes(&nodes, nmask, maxnode);
> -	if (err)
> -		return err;
> -	return do_set_mempolicy(mode, flags, &nodes);
> +	MPOL_PRE_PROCESS();
> +	return do_set_mempolicy(mode, mode_flags, &nodes);
>  }
>  
>  SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
> -- 
> 2.7.4
> 
> 
