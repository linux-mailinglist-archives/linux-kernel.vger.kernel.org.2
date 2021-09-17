Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEDC40F52E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbhIQJub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhIQJuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:50:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E34C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:49:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso9629840pji.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WqfCnFXW1pBqpEUkFm98tBUfFU7a1074L/dYXgavkKo=;
        b=MJbLs4R0uSc49AGTR7ef3oagIGcP6rAtUCHkV85uhDqEzAupYjwTjVrWhu15Sew6ZT
         2a+vvTp8E/KcbcCsxCyJ3kuS9gSZnZB1rttDEY6YRO51Fm2A6fJkrLOxGCo88ZU6NP9P
         80ddzxv7DdXH/a7TCIRgYXrgDibJhS+K6cgoOzCfkTR7gCd11p6dmAsH7U1uZYuEqO7c
         812TwiIi4OoPpOVvB99x7RWp+jatZM1vVWHQv/lFHvGqGPv9mt0SNZ51AR5CRrGTC+eg
         zCJ4EKGspsUwaJwjjkwDQ6P8C3PnxnBFeOGFLTf45TWkwQz7TcjTugpAT+GHqm2aoPSq
         kvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WqfCnFXW1pBqpEUkFm98tBUfFU7a1074L/dYXgavkKo=;
        b=SJi0608HrDh6mHLbcelSCFgkgQmIA5OURoapH6QxmsYf4PGVj+WRtpaIncHF9b1SDD
         AMWclzxu4fgCOdEFqKCds9k58wDVd2dR6+qVgwFAs1oZP+6mH/WAOtM7sX99Y49tDyH6
         E/XDxBFkxqJLXhNl6zjvfEragSFWwrSG1pko8M+doPwjF5+9q4jzJKJrIKF2rjOvpaEY
         uBFFrqjPEBP/5ExRv3EB7ls3u3ZMzMdr6VodaFFg0XI2Y3H3+GU/iMUUgVPmL12iE7Cl
         xbPyP1Ih9q00Z/3Qg+w1bVqJyea5Z9MSEl7naOCnoNEQ+gCgF3bBkDpjk3XeAXh79gBr
         WpHw==
X-Gm-Message-State: AOAM532toySFzCnWMB+W8nzTDIRaTXVJNS2aK9D6Fmy3PIe68L0l3ulj
        zq3DctAJpeixjy6pz+FgqxtIsRkBL5Z/Q/gs
X-Google-Smtp-Source: ABdhPJzpRPcQIbkoO5TPWguJ0M0FqIx8ZkxnclzmicInsnZPZ+WqmRKOtT3KszUBqviNXdIuwvehTA==
X-Received: by 2002:a17:902:680d:b0:13a:503f:f381 with SMTP id h13-20020a170902680d00b0013a503ff381mr8878825plk.30.1631872139307;
        Fri, 17 Sep 2021 02:48:59 -0700 (PDT)
Received: from [192.168.30.11] ([173.248.225.217])
        by smtp.gmail.com with ESMTPSA id z11sm6020142pff.144.2021.09.17.02.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 02:48:58 -0700 (PDT)
Subject: Re: [PATCH] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
To:     "Huang, Ying" <ying.huang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210917061432.323777-1-o451686892@gmail.com>
 <871r5nptt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Weizhao Ouyang <o451686892@gmail.com>
Message-ID: <89a06743-b37a-b85a-1c04-5d863a1d2cb4@gmail.com>
Date:   Fri, 17 Sep 2021 17:48:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <871r5nptt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you both.
On 2021/9/17 下午3:03, Huang, Ying wrote:
> Weizhao Ouyang <o451686892@gmail.com> writes:
>
>> After related migrate page updates, sync up latest migrate_reason to
>> migrate_reason_names, page_owner use it to parse the page migrate
>> reason.
>>
>> Fixes: d1e153fea2a8 ("mm/gup: migrate pinned pages out of movable zone")
>> Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")
>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>> ---
>>  mm/debug.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/debug.c b/mm/debug.c
>> index e73fe0a8ec3d..733770b0ed0c 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -25,6 +25,8 @@ const char *migrate_reason_names[MR_TYPES] = {
>>  	"mempolicy_mbind",
>>  	"numa_misplaced",
>>  	"cma",
>> +	"longterm_pin",
>> +	"demotion",
>>  };
>>  
>>  const struct trace_print_flags pageflag_names[] = {
> Good catch!  Thanks!
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>
> It may be better to use BUILD_BUG_ON() to capture similar issue earlier?

How about move migrate_reason_names into mm/page_owner.c and make it size uninitialized(get rid of MR_TYPES).
Then use BUILD_BUG_ON(ARRAY_SIZE(migrate_reason_names != MR_TYPES)) to check it?

>
> Best Regards,
> Huang, Ying
