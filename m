Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959C2394214
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhE1LpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:45:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33008 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhE1LpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:45:01 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DBB6218B3;
        Fri, 28 May 2021 11:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622202206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9s7qI6fPmWwhDVK9qhBrtaB5fZd7wpN4H+FoavsyRvU=;
        b=XWiSlIDB6KkoR49po06mLRto3/A32EMGCudYyxt10YqwFLf/nNuCI+9vl6XcPRGI6Na2EW
        93UTaQG4cXtleSCkIkQ8D03/S5792juPugf+d/aXIrlsqCtE9IevyKrcXnymMWQpB3fT4p
        f5V1Mwzxb5BxSYKDTwbp8DyaYmGrqu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622202206;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9s7qI6fPmWwhDVK9qhBrtaB5fZd7wpN4H+FoavsyRvU=;
        b=a8tqcbBTFQ/74aCA0n5xh+ioMuH7uHviKJG4bNNebDFhd2MB0tubODn0lARVsaFUI9bS99
        trbr9A4Q4z64giBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 167D211A98;
        Fri, 28 May 2021 11:43:26 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 20L8BF7XsGAvEAAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Fri, 28 May 2021 11:43:26 +0000
Subject: Re: [PATCH 5/6] mm/page_alloc: Limit the number of pages on PCP lists
 when reclaim is active
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <20210525080119.5455-6-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e839f84f-0cc2-2e6a-70c8-99c0d6b8ddf8@suse.cz>
Date:   Fri, 28 May 2021 13:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525080119.5455-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 10:01 AM, Mel Gorman wrote:
> When kswapd is active then direct reclaim is potentially active. In
> either case, it is possible that a zone would be balanced if pages were
> not trapped on PCP lists. Instead of draining remote pages, simply limit
> the size of the PCP lists while kswapd is active.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
