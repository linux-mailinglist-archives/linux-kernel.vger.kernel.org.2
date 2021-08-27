Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2973F9DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245643AbhH0RYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:24:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37274 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245623AbhH0RXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:23:43 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1ACB22050;
        Fri, 27 Aug 2021 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630084972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Phq3gAE3Q02YUXciXyQd3KSolEWrf3EqcQb0fXZluo=;
        b=DtGfX8D6eH6SnT4Czrb2tDWrtIrXpZDE4RK4F12Oh0N6H0L+dYHIAaVH6tZu6V013kEH1r
        VpCcKkaDaQFV/kDiOCQ0XyX6dQVjhlFM2GjK6sJ/ltQDId2iCxTdqmeWz8ofoKIrt7Db9A
        rGLEpGo9Tb2Pkd2WxXG97UCIjbCfiuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630084973;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Phq3gAE3Q02YUXciXyQd3KSolEWrf3EqcQb0fXZluo=;
        b=X/2ZEkiH3OVq354JJHdhd2fJB9I/YjMF8/K8gLQCFemCnUhyjFuMt+PBtBuyq8WPDbPcZs
        SvXgQSmTr9iEUtBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BF0DA13951;
        Fri, 27 Aug 2021 17:22:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EiydLWwfKWE7FwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 27 Aug 2021 17:22:52 +0000
Message-ID: <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
Date:   Fri, 27 Aug 2021 19:22:52 +0200
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
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
In-Reply-To: <10d86c18-f0cf-395f-4209-17ac71b9fc03@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 00:08, Mike Kravetz wrote:
> Add Vlastimil and Hillf,
> 
> Well, I set up a test environment on a larger system to get some
> numbers.  My 'load' on the system was filling the page cache with
> clean pages.  The thought is that these pages could easily be reclaimed.
> 
> When trying to get numbers I hit a hugetlb page allocation stall where
> __alloc_pages(__GFP_RETRY_MAYFAIL, order 9) would stall forever (or at
> least an hour).  It was very much like the symptoms addressed here:
> https://lore.kernel.org/linux-mm/20190806014744.15446-1-mike.kravetz@oracle.com/
> 
> This was on 5.14.0-rc6-next-20210820.
> 
> I'll do some more digging as this appears to be some dark corner case of
> reclaim and/or compaction.  The 'good news' is that I can reproduce
> this.

Interesting, let's see if that's some kind of new regression.

>> And the second problem would benefit from some words to help us
>> understand how much real-world hurt this causes, and how frequently.
>> And let's understand what the userspace workarounds look like, etc.
> 
> The stall above was from doing a simple 'free 1GB page' followed by
> 'allocate 512 MB pages' from userspace.

Is the allocation different in any way than the usual hugepage allocation
possible today?

> Getting out another version of this series will be delayed, as I think
> we need to address or understand this issue first.
> 

