Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC0342A52
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 05:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCTEFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 00:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTEFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 00:05:20 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D01BC061761
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 21:05:20 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b18so16432877qte.21
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 21:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MEqC6ND18f4uwCsg8PPVWMozf20ktbFfNKIjRayWFO0=;
        b=NIKXYG/RsuJnMyNHvqF7tnxKhcVoSDiqmPW+ZlhZtZ5jGoQIYxuSs8p2n23MfmIIZA
         JQ9rolZMIkRv2LOIBB1leKBmazwJgUeqIz4QvsD5vNGDMecfCIh1VHGB9Dw/6ioxByOD
         N+pReeldiKfNQeWcgLUps/j1vwqNDpkGOhZfIrs+Dp6lC1VGp3QBOHPL4J2TqTM+r/3h
         4TPZ9u35WukhcIQ6uv0Xsp4+u4Giwu6HygmtcAjgnfHa6LUuVuEqwGyJTVXo0dSaBiGP
         AZVDpnpyMz63+Mf4QNbtRKhcdVG2jFHfboHxLnoyJo5EcdS11VFfOKmKvm46uiO44LP2
         B+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MEqC6ND18f4uwCsg8PPVWMozf20ktbFfNKIjRayWFO0=;
        b=V/hC19UYgOflCXlmnYnEYKhr40kmFkhA/RpIht0RLhw6sWu/bqqHR6YKy6ZWvD3WuS
         LeNdDITen0BZ8e4EhuglWQA67hV6WyywuaV2wYh+27vQ3Pj76Twg2CDyAE+aGkEnnFFR
         MuxNYVYcReDFXjdDU2OpRKZxW2nVGJHSKfLLXZohABsOirH1EBVzv11VyjI/rTGhkSeH
         MALl3Bf9DjI92XH3f3xjE0tnNUTQiG5LEGZXVRnIXbqvibf44PNzT64eKbzoZf1nqqGz
         Kev0Y82vFlx5fzqFJGOIeFv93yi6qfyp6r+IuMj0EDgyAtdVddsTP6HjXKmxAtCYcV8U
         p9YA==
X-Gm-Message-State: AOAM532iCEvqICs16V5lENt2/dYM/qnNp8lRnpbpmjuIVojl5Fzd83fi
        CfSLvFGL5l9CeBMksffdOHS5nzt0go8a
X-Google-Smtp-Source: ABdhPJxHyEYhUNSnHZwiqkOA7JsVxIg3O8auDaAGmgRwFkhTvF83gN65N9zAcBslomWDJ8ZmBvcSOa6eCsBw
X-Received: from gthelen2.svl.corp.google.com ([2620:15c:2cd:202:39de:1aa5:57c4:5867])
 (user=gthelen job=sendgmr) by 2002:a0c:bdaf:: with SMTP id
 n47mr12191600qvg.48.1616213119212; Fri, 19 Mar 2021 21:05:19 -0700 (PDT)
Date:   Fri, 19 Mar 2021 21:05:17 -0700
In-Reply-To: <20210305000002.D171810D@viggo.jf.intel.com>
Message-Id: <xr93v99mmpvm.fsf@gthelen2.svl.corp.google.com>
Mime-Version: 1.0
References: <20210304235949.7922C1C3@viggo.jf.intel.com> <20210305000002.D171810D@viggo.jf.intel.com>
Subject: Re: [PATCH 07/10] mm/vmscan: add helper for querying ability to age
 anonymous pages
From:   Greg Thelen <gthelen@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        rientjes@google.com, ying.huang@intel.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Anonymous pages are kept on their own LRU(s).  These lists could
> theoretically always be scanned and maintained.  But, without swap,
> there is currently nothing the kernel can *do* with the results of a
> scanned, sorted LRU for anonymous pages.
>
> A check for '!total_swap_pages' currently serves as a valid check as
> to whether anonymous LRUs should be maintained.  However, another
> method will be added shortly: page demotion.
>
> Abstract out the 'total_swap_pages' checks into a helper, give it a
> logically significant name, and check for the possibility of page
> demotion.

Reviewed-by: Greg Thelen <gthelen@google.com>

> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
> ---
>
>  b/mm/vmscan.c |   28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff -puN mm/vmscan.c~mm-vmscan-anon-can-be-aged mm/vmscan.c
> --- a/mm/vmscan.c~mm-vmscan-anon-can-be-aged	2021-03-04 15:35:58.935806422 -0800
> +++ b/mm/vmscan.c	2021-03-04 15:35:58.942806422 -0800
> @@ -2517,6 +2517,26 @@ out:
>  	}
>  }
>  
> +/*
> + * Anonymous LRU management is a waste if there is
> + * ultimately no way to reclaim the memory.
> + */
> +bool anon_should_be_aged(struct lruvec *lruvec)

Should this be static?

> +{
> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> +
> +	/* Aging the anon LRU is valuable if swap is present: */
> +	if (total_swap_pages > 0)
> +		return true;
> +
> +	/* Also valuable if anon pages can be demoted: */
> +	if (next_demotion_node(pgdat->node_id) >= 0)
> +		return true;
> +
> +	/* No way to reclaim anon pages.  Should not age anon LRUs: */
> +	return false;
> +}
> +
>  static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  {
>  	unsigned long nr[NR_LRU_LISTS];
> @@ -2626,7 +2646,8 @@ static void shrink_lruvec(struct lruvec
>  	 * Even if we did not try to evict anon pages at all, we want to
>  	 * rebalance the anon lru active/inactive ratio.
>  	 */
> -	if (total_swap_pages && inactive_is_low(lruvec, LRU_INACTIVE_ANON))
> +	if (anon_should_be_aged(lruvec) &&
> +	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
>  		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
>  				   sc, LRU_ACTIVE_ANON);
>  }
> @@ -3455,10 +3476,11 @@ static void age_active_anon(struct pglis
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
>  
> -	if (!total_swap_pages)
> +	lruvec = mem_cgroup_lruvec(NULL, pgdat);
> +
> +	if (!anon_should_be_aged(lruvec))
>  		return;
>  
> -	lruvec = mem_cgroup_lruvec(NULL, pgdat);
>  	if (!inactive_is_low(lruvec, LRU_INACTIVE_ANON))
>  		return;
>  
> _
