Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F326412F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhIUHdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhIUHdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:33:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA1AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:31:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso1366553pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iT/A7saFWdSRDEDmu/VTK8EiZ0qLpHBdaDox0oesTUg=;
        b=gDTXZuETD2SrveG2tnn6mLAaK2DRY8v2YdE0Z7B0hKnnlfXnZ2hk+2wW1OwZ6x56xY
         Y88fiHi8iF1Pvxk0TsSR868FvnZHjFX2O8cprwraKRVgxBbl2gNM75eQl/KJds7yp5MB
         gtMYE8OXZHyykH7gCNkTCRBUnJfNHxLwWADCy5nmfn6g0DHgahBiLssTYUlTBM3PkYzA
         rKmgK+CnKGmPz1MoGpNQxlDx+Bz501MppVqPuNLFyLxXIG2A9URiJjn2oGOgLi2h4hX8
         39vGn15EYJG+HwqLZ6mGFgdH18p7vIwqga5bVekEViFweHBDFnt0tR9cmrgiIn6Yb/8K
         mQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iT/A7saFWdSRDEDmu/VTK8EiZ0qLpHBdaDox0oesTUg=;
        b=Q7aFLRyrTiCWusUrbQLcmVahFOX8ujOqkyA+Ztwu+7s/BF9a6BPy4W5WCjtOCe4zrw
         i738C6MXdaeVAUBFCum2qtyqkAWclxaWatjxjG48sz7LIbdtpYIB690nJsxtnvO32H/X
         haXwjkXScX+sbNRp/B9lHVlehPJUgUvM3eGpAbhMcs4Sg4EyGlqsZZ6K8udn9QLfRBk+
         63oaAFxxrFvH+GzNfqHmUildVs7jnlSqOY4sZqhHN2srXtBz0FOUsw3CEkJnd3/1xGhh
         TLrPxNon+F8z2B0SqqEtGBM+/OTnb8WiI2NlPfmSHa0TiO4JyPWQ3AfVbvbFTt4oi8vg
         h0yw==
X-Gm-Message-State: AOAM531vb4yRKty1AlkpxQU5W1WzQoelfU+4P5gZ4Tw+QdrEpk8wKR2+
        2oMSGZ7oeO8KRf13qA2bhIM=
X-Google-Smtp-Source: ABdhPJyPWVA16UxUHFcNGd2HYDeNHwaIxj84SZUFfQ+9V5Vht1lQ67OKECMEgHpldsZweSXbpYRE4w==
X-Received: by 2002:a17:903:4094:b0:13c:86b0:3050 with SMTP id z20-20020a170903409400b0013c86b03050mr26129372plc.58.1632209491760;
        Tue, 21 Sep 2021 00:31:31 -0700 (PDT)
Received: from owniadeMacBook-Pro.local ([103.97.201.31])
        by smtp.gmail.com with ESMTPSA id g19sm1568094pjl.25.2021.09.21.00.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 00:31:31 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>, Wei Xu <weixugc@google.com>
References: <20210921064553.293905-1-o451686892@gmail.com>
 <20210921064553.293905-3-o451686892@gmail.com>
 <87mto676fq.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Weizhao Ouyang <o451686892@gmail.com>
Message-ID: <d57aaff2-b154-4462-1a7d-3d288ebabb6a@gmail.com>
Date:   Tue, 21 Sep 2021 15:31:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87mto676fq.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/21 15:07, Huang, Ying wrote:
> Weizhao Ouyang <o451686892@gmail.com> writes:
>
>> Sync up MR_DEMOTION to migrate_reason_names and add a synch prompt.
>>
>> Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")
>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> ---
>>  include/linux/migrate.h | 6 +++++-
>>  mm/debug.c              | 1 +
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index 326250996b4e..c8077e936691 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -19,6 +19,11 @@ struct migration_target_control;
>>   */
>>  #define MIGRATEPAGE_SUCCESS		0
>>  
>> +/*
>> + * Keep sync with:
>> + * - macro MIGRATE_REASON in include/trace/events/migrate.h
>> + * - migrate_reason_names[MR_TYPES] in mm/debug.c
>> + */
>>  enum migrate_reason {
>>  	MR_COMPACTION,
>>  	MR_MEMORY_FAILURE,
>> @@ -32,7 +37,6 @@ enum migrate_reason {
>>  	MR_TYPES
>>  };
>>  
>> -/* In mm/debug.c; also keep sync with include/trace/events/migrate.h */
>>  extern const char *migrate_reason_names[MR_TYPES];
>>  
>>  #ifdef CONFIG_MIGRATION
>> diff --git a/mm/debug.c b/mm/debug.c
>> index e61037cded98..fae0f81ad831 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -26,6 +26,7 @@ const char *migrate_reason_names[MR_TYPES] = {
>>  	"numa_misplaced",
>>  	"contig_range",
>>  	"longterm_pin",
>> +	"demotion",
>>  };
>>  
>>  const struct trace_print_flags pageflag_names[] = {
> Can we add BUILD_BUG_ON() somewhere to capture at least some
> synchronization issue?

Hi Huang, we discussed this in the v1 thread with you and John, seems you
missed it. Now we just add a comment to do the synchronization, and we can
figure out a more general way to use strings which in trace_events straight.

Thanks,
Weizhao
