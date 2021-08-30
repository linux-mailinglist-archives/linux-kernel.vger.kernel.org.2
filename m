Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8C3FB3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhH3KMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:12:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57548 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhH3KMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:12:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18FE122113;
        Mon, 30 Aug 2021 10:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630318289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJ1hz0iq6S45sTbD6okU7tBzH0QgE93nbBtJ8pDyR4U=;
        b=m+yizlBkxYFIBtEZmki4vWFvhuKLTglJPAZNV4Z5e9y5Rw/kDsPSMhqjCrwgZpzePo81rQ
        2lu9BbAIElOjHhf550UkPSNIIdw4vPgmVBzLXTtGdAO7RdxBytgmaERfVE1HL5lXgOcx8q
        qPP7RtPulx7k3SGiNimxaCTCY+/3XQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630318289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJ1hz0iq6S45sTbD6okU7tBzH0QgE93nbBtJ8pDyR4U=;
        b=7V1sCrVl5hoCrIRMc6CwEaBt9wbAwalLV2AGcIiKGzl/s0rgZNYOoMIbCdOt6U6x6yGw7v
        HspC6Pe9JbRLLgBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D303513670;
        Mon, 30 Aug 2021 10:11:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EIAzMtCuLGHpQQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Mon, 30 Aug 2021 10:11:28 +0000
Message-ID: <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
Date:   Mon, 30 Aug 2021 12:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
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
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
In-Reply-To: <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/21 01:04, Mike Kravetz wrote:
> On 8/27/21 10:22 AM, Vlastimil Babka wrote:
> I 'may' have been over stressing the system with all CPUs doing file
> reads to fill the page cache with clean pages.  I certainly need to
> spend some more debug/analysis time on this.

Hm that *could* play a role, as these will allow reclaim to make progress, but
also the reclaimed pages might be stolen immediately and compaction will return
COMPACT_SKIPPED and in should_compact_retry() we might go through this code path:

        /*      
         * compaction was skipped because there are not enough order-0 pages
         * to work with, so we retry only if it looks like reclaim can help.
         */
        if (compaction_needs_reclaim(compact_result)) {
                ret = compaction_zonelist_suitable(ac, order, alloc_flags);
                goto out;
        }       

where compaction_zonelist_suitable() will return true because it appears
reclaim can free pages to allow progress. And there are no max retries
applied for this case.
With the reclaim and compaction tracepoints it should be possible to
confirm this scenario.
