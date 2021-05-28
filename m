Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5273941B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhE1LVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:21:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40890 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhE1LVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:21:21 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 046451FD2F;
        Fri, 28 May 2021 11:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622200786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLMJxJYpMmRjq971tcymb5HaqU6rvz49VUg3ot6Bqks=;
        b=N9qH3OC3FNKCfO/Nfg6bKxfB6g3bN/E3Ch0wUEvpvVA3oinwZ9fToEuroP11fYBH2GgpfW
        yQASqxGvy01ww+hiZCvXIqQZiO6uZ0hblxOkIRLZPCp1X7/+kerWyvI/MCRllPJbPXmhRm
        rPypG9TbF47r9jZoVPuyyDAedxct1H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622200786;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLMJxJYpMmRjq971tcymb5HaqU6rvz49VUg3ot6Bqks=;
        b=G+ST+qC4G8Zt6f5Gabr30bKDIgzNz6WM0r3ty/wn+S5See96z+Zxo6s4NaUFpA4UrIWLUI
        IfqMEI8LhWOUkXDA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id E603311A98;
        Fri, 28 May 2021 11:19:45 +0000 (UTC)
Subject: Re: [PATCH 4/6] mm/page_alloc: Scale the number of pages that are
 batch freed
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <20210525080119.5455-5-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c7e5a4e7-43df-0f49-d297-1b4621221ca1@suse.cz>
Date:   Fri, 28 May 2021 13:19:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525080119.5455-5-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 10:01 AM, Mel Gorman wrote:
> When a task is freeing a large number of order-0 pages, it may acquire
> the zone->lock multiple times freeing pages in batches. This may
> unnecessarily contend on the zone lock when freeing very large number
> of pages. This patch adapts the size of the batch based on the recent
> pattern to scale the batch size for subsequent frees.
> 
> As the machines I used were not large enough to test this are not large
> enough to illustrate a problem, a debugging patch shows patterns like
> the following (slightly editted for clarity)
> 
> Baseline vanilla kernel
>   time-unmap-14426   [...] free_pcppages_bulk: free   63 count  378 high  378
>   time-unmap-14426   [...] free_pcppages_bulk: free   63 count  378 high  378
>   time-unmap-14426   [...] free_pcppages_bulk: free   63 count  378 high  378
>   time-unmap-14426   [...] free_pcppages_bulk: free   63 count  378 high  378
>   time-unmap-14426   [...] free_pcppages_bulk: free   63 count  378 high  378
> 
> With patches
>   time-unmap-7724    [...] free_pcppages_bulk: free  126 count  814 high  814
>   time-unmap-7724    [...] free_pcppages_bulk: free  252 count  814 high  814
>   time-unmap-7724    [...] free_pcppages_bulk: free  504 count  814 high  814
>   time-unmap-7724    [...] free_pcppages_bulk: free  751 count  814 high  814
>   time-unmap-7724    [...] free_pcppages_bulk: free  751 count  814 high  814
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
