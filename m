Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95DF33372E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhCJIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:21:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230437AbhCJIUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615364451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bghe3IBXWRcmWBizADZMdloUyJIWOP+IKjTdfFF6DRY=;
        b=ERmUSzOeewLJUpzBGJjGFBdQWIvl5pWlzjqQihXw+KHkbrRVpQYjixxmfr0PpHDcuIsSCl
        2eTYtRz1Pae3IVDzp6FDVlw32szGWmSBQjXDpInMkaahracKjeLXXjDRSEp1TF5RjQOxS3
        usP1oWYT5r07rKWy7iaPn35YZfSC2SY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-DxM81C5nPCyMx0fWFeShag-1; Wed, 10 Mar 2021 03:20:44 -0500
X-MC-Unique: DxM81C5nPCyMx0fWFeShag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D85D41842145;
        Wed, 10 Mar 2021 08:20:42 +0000 (UTC)
Received: from [10.36.114.87] (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6710F10013C1;
        Wed, 10 Mar 2021 08:20:41 +0000 (UTC)
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
To:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Jason Baron <jbaron@akamai.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz> <YEefLYiX6rF3Uk4E@google.com>
 <YEh4doXvyuRl5BDB@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5f0e17f2-b161-f0f1-65a4-a7b3af4d2cce@redhat.com>
Date:   Wed, 10 Mar 2021 09:20:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEh4doXvyuRl5BDB@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.21 08:42, Minchan Kim wrote:
> On Tue, Mar 09, 2021 at 08:15:41AM -0800, Minchan Kim wrote:
> 
> < snip >
> 
>>> [...]
>>>> +void dump_migrate_failure_pages(struct list_head *page_list)
>>>> +{
>>>> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
>>>> +			"migrate failure");
>>>> +	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
>>>> +			alloc_contig_ratelimit()) {
>>>> +		struct page *page;
>>>> +
>>>> +		WARN(1, "failed callstack");
>>>> +		list_for_each_entry(page, page_list, lru)
>>>> +			dump_page(page, "migration failure");
>>>> +	}
>>>
>>> Apart from the above, do we have to warn for something that is a
>>> debugging aid? A similar concern wrt dump_page which uses pr_warn and
>>
>> Make sense.
>>
>>> page owner is using even pr_alert.
>>> Would it make sense to add a loglevel parameter both into __dump_page
>>> and dump_page_owner?
>>
>> Let me try it.
> 
> I looked though them and made first draft to clean them up.
> 
> It's bigger than my initial expectaion because there are many callsites
> to use dump_page and stack_trace_print inconsistent loglevel.
> Since it's not a specific problem for this work, I'd like to deal with
> it as separate patchset since I don't want to be stuck on here for my
> initial goal.

Why the need to rush regarding your series?

If it will clean up your patch significantly, then I think doing the 
cleanups first is the proper way to go.

I really don't get why this is a real problem.


-- 
Thanks,

David / dhildenb

