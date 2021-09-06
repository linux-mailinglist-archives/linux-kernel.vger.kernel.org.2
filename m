Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A195401D31
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243519AbhIFOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:41:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35922 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243409AbhIFOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:41:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A88322169;
        Mon,  6 Sep 2021 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630939228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFhvnpOKr3OKxjpJTREq9p7eh5KGXFCWvrRzUPaUhm0=;
        b=dFGHE5sdH1dNgXQGg1O0NlubYKiVn/meKT/MoyTffwWzVylzr/u9DDrkehoUQq7rDfUhcx
        o22mO17uPDdyqJofXLJx7mWJTWbAXMmbNcigsE7x38wG4/+Bbe1861IM838EHa9KYH5r8d
        b0N1PPDFpZsVdSNj10aqaUaI6seCkrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630939228;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFhvnpOKr3OKxjpJTREq9p7eh5KGXFCWvrRzUPaUhm0=;
        b=vN4oeiD+BwKEbgagD2S3l00A+rhQ89C4C0jmNvaa/GV8+e/cCyKT+w6dar8yFX/iVf4aaK
        E7BOA5dRp+PVsLCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F15913C29;
        Mon,  6 Sep 2021 14:40:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IBkmGlwoNmFvYgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 06 Sep 2021 14:40:28 +0000
Message-ID: <597a7731-3692-01b9-9e71-ba265246cc1a@suse.cz>
Date:   Mon, 6 Sep 2021 16:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Hillf Danton <hdanton@sina.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
 <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
 <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
 <10d86c18-f0cf-395f-4209-17ac71b9fc03@oracle.com>
 <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
 <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
 <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
 <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 20:17, Mike Kravetz wrote:
> On 8/30/21 3:11 AM, Vlastimil Babka wrote:
>> On 8/28/21 01:04, Mike Kravetz wrote:
>>> On 8/27/21 10:22 AM, Vlastimil Babka wrote:
>>> I 'may' have been over stressing the system with all CPUs doing file
>>> reads to fill the page cache with clean pages.  I certainly need to
>>> spend some more debug/analysis time on this.
>>
>> Hm that *could* play a role, as these will allow reclaim to make progress, but
>> also the reclaimed pages might be stolen immediately and compaction will return
>> COMPACT_SKIPPED and in should_compact_retry() we might go through this code path:
>>
>>         /*      
>>          * compaction was skipped because there are not enough order-0 pages
>>          * to work with, so we retry only if it looks like reclaim can help.
>>          */
>>         if (compaction_needs_reclaim(compact_result)) {
>>                 ret = compaction_zonelist_suitable(ac, order, alloc_flags);
>>                 goto out;
>>         }       
>>
>> where compaction_zonelist_suitable() will return true because it appears
>> reclaim can free pages to allow progress. And there are no max retries
>> applied for this case.
>> With the reclaim and compaction tracepoints it should be possible to
>> confirm this scenario.
> 
> Here is some very high level information from a long stall that was
> interrupted.  This was an order 9 allocation from alloc_buddy_huge_page().
> 
> 55269.530564] __alloc_pages_slowpath: jiffies 47329325 tries 609673 cpu_tries 1   node 0 FAIL
> [55269.539893]     r_tries 25       c_tries 609647   reclaim 47325161 compact 607     
> 
> Yes, in __alloc_pages_slowpath for 47329325 jiffies before being interrupted.
> should_reclaim_retry returned true 25 times and should_compact_retry returned
> true 609647 times.
> Almost all time (47325161 jiffies) spent in __alloc_pages_direct_reclaim, and
> 607 jiffies spent in __alloc_pages_direct_compact.
> 
> Looks like both
> reclaim retries > MAX_RECLAIM_RETRIES
> and
> compaction retries > MAX_COMPACT_RETRIES
> 

Yeah AFAICS that's only possible with the scenario I suspected. I guess
we should put a limit on compact retries (maybe some multiple of
MAX_COMPACT_RETRIES) even if it thinks that reclaim could help, while
clearly it doesn't (i.e. because somebody else is stealing the page like
in your test case).
