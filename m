Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01B4097D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245661AbhIMPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:52:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38106 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhIMPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:52:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B579C21F34;
        Mon, 13 Sep 2021 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631548242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+eyk10XtROXLts0BsM53ESJTU6x6wdPA46RKx5foHiI=;
        b=A81Fjnx62iAN1magonQFZvuCwH43fJ6m1MZXiPGdtAXyKPi+1GiHzXFeZNAHC1iyxZMi3o
        ROCuVtdmZtxJUqa+Ak7iAOsqG2PGcL7+PkYPknJ/uK91C8HW55+04zl0GvoAZ9g59HtbRu
        wF9UdRKedIC5xaqcC2Gi1UM0o7OIZ0w=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4045DA3B94;
        Mon, 13 Sep 2021 15:50:42 +0000 (UTC)
Date:   Mon, 13 Sep 2021 17:50:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Hillf Danton <hdanton@sina.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
Message-ID: <YT9zUaPofENSMQHg@dhcp22.suse.cz>
References: <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
 <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
 <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
 <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
 <20210907085001.3773-1-hdanton@sina.com>
 <6c42bed7-d4dd-e5eb-5a74-24cf64bf52d3@oracle.com>
 <YTn196em42sDsXs+@dhcp22.suse.cz>
 <71f855ac-ff61-1eed-454f-909c0e4210b2@suse.cz>
 <YTsVT74kAgpAD17s@dhcp22.suse.cz>
 <2519e0f8-98ee-6bad-3895-ac733635e5b0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2519e0f8-98ee-6bad-3895-ac733635e5b0@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-09-21 17:11:05, Mike Kravetz wrote:
[...]
> @@ -5064,8 +5068,18 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
>  	if (did_some_progress > 0 &&
>  			should_compact_retry(ac, order, alloc_flags,
>  				compact_result, &compact_priority,
> -				&compaction_retries))
> +				&compaction_retries)) {
> +		/*
> +		 * In one pathological case, pages can be stolen immediately
> +		 * after reclaimed.  It looks like we are making progress, and
> +		 * compaction_retries is not incremented.  This could cause
> +		 * an indefinite number of retries.  Cap the number of retries
> +		 * for costly orders.
> +		 */
> +		if (max_tries && tries > max_tries)
> +			goto nopage;
>  		goto retry;
> +	}

I do not think this is a good approach. We do not want to play with
retries numbers. If we want to go with a minimal change for now then the
compaction feedback mechanism should track the number of reclaimed pages
to satisfy watermarks and if that grows beyond reasonable (proportionaly
to the request size) then simply give up rather than keep trying again
and again.

-- 
Michal Hocko
SUSE Labs
