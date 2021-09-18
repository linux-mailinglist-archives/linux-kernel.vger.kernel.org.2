Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2845410495
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241986AbhIRHFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbhIRHFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:05:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB99C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:03:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so10909942pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=A4v+dkQ3nEwk7aTsenjY7jfV6CXN9c6u3qns+dC7Kv4=;
        b=ERI0SGBrOyrT3lrOReuSQdqCybdiK86t32tM8gdxIhAiiQ6X+AK9pfdMlL8maNyDmi
         OtiJHJ/eSj/Snk7D+P4n4vFyDvkJIJqC5A0ws7Nns0da+WmuW7YLrGsOW1GJ6mle8HZ0
         fiXigC+7w6UCeO6VoMWmqdKGr7AYN1IPKzaB9YfixfTORcMwN8xf+n8Hs5ZB/YqDM5I0
         lHQwNIFFIwLZlW51j1G+hPXhtrX9Jf09R/Vqs0u9NbWm9gcUywB8sTs9B/vCNoYdIAao
         gxPzckbC+t+iGRsSlHgeM8tusi2k2uHGbqMedAPa/NQp3/FxZLUW5j8dG0JinrM+JYQ3
         PP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A4v+dkQ3nEwk7aTsenjY7jfV6CXN9c6u3qns+dC7Kv4=;
        b=xdjI1CUTgao6HVQD44GrNK/feVvufXWhchAR5KZyoDKJh4s0g5NnL1Qc7AFO9XflgX
         GoRNa2Ysq24Rzigff9Odw9ToxGoNH+RJnPGjoeDhNJZU6CIGd7BmBfbJP/xW+6wxS5dM
         j18lpkDrQwiD2U8Bbm5UsNCC6qSq7965nF5OWSXU2fnH/xKNLy1NylWSa1oQnJNwHDrO
         OB9NsFqcMlZTiQtdtXyQ+irekzV+UaR8mOP+NlcPFjnv4IcfrGrkgXBeFjtAcOf8ZRTC
         JzDDw2RMQaU01Xdfogxz76uA1GKYyneib3XtoRSr7x09jYCdW37/EXUob20F+1Nq0utg
         tLFg==
X-Gm-Message-State: AOAM530M2HTk7Du4yQgQCP6k9E+wpiUC2ao3+Fa4t6PYBcMFEmNGkz7Q
        T/hTA8wDU8cYT/APUq4xzb4So+wAE/xJ+y5X
X-Google-Smtp-Source: ABdhPJx8cInDy0dtT23KUsIM8c6tjSIu4iqF07ReQBQINQvuqUza+FVFbeCPz3bqBl04C+pULzfONg==
X-Received: by 2002:a17:902:b188:b029:11b:1549:da31 with SMTP id s8-20020a170902b188b029011b1549da31mr13110506plr.7.1631948616933;
        Sat, 18 Sep 2021 00:03:36 -0700 (PDT)
Received: from [192.168.30.17] ([173.248.225.217])
        by smtp.gmail.com with ESMTPSA id fh3sm12185158pjb.8.2021.09.18.00.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 00:03:36 -0700 (PDT)
Subject: Re: [PATCH] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
To:     John Hubbard <jhubbard@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210917061432.323777-1-o451686892@gmail.com>
 <871r5nptt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <89a06743-b37a-b85a-1c04-5d863a1d2cb4@gmail.com>
 <3cf9bb7f-618e-4e4b-32d6-4d3c207b9a9a@nvidia.com>
From:   Weizhao Ouyang <o451686892@gmail.com>
Message-ID: <b4123610-bddf-03b9-2190-7b0cda55b57c@gmail.com>
Date:   Sat, 18 Sep 2021 15:03:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3cf9bb7f-618e-4e4b-32d6-4d3c207b9a9a@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/18 08:30, John Hubbard wrote:
> On 9/17/21 02:48, Weizhao Ouyang wrote:
> ...
>>>>   const struct trace_print_flags pageflag_names[] = {
>>> Good catch!  Thanks!
>>>
>>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>>
>>> It may be better to use BUILD_BUG_ON() to capture similar issue earlier?
>>
>> How about move migrate_reason_names into mm/page_owner.c and make it size uninitialized(get rid of MR_TYPES).
>> Then use BUILD_BUG_ON(ARRAY_SIZE(migrate_reason_names != MR_TYPES)) to check it?
>>
> A couple more thoughts:
>
> 1) From a naming and location point of view, migrate_reason_names[]
> really doesn't want to be located in page_owner.c.

Commit 7cd12b4abfd2 ("mm, page_owner: track and print last migrate reason")
imported migrate_reason_names for page owner in mm/debug.c, and it only used
by page_owner.c now, maybe it's not so sensitive or we can rename it.

> 2) There are actually three places to synchronize, not two. And in fact,
> sure enough, the MR_CONTIG_RANGE is already drifting out of synch: it
> has a string of "cma" in mm/debug.c, versus "contig_range" in
> include/trace/events/migrate.h.

Yes, "cma" is out of synch after commit 310253514bbf ("mm/migrate: rename
migration reason MR_CMA to MR_CONTIG_RANGE"). Update it to "contig_range" in
migrate_reason_names can fix up it.

> So...is it possible to use the macro and enums in
> include/trace/events/migrate.h, to define the connection between
> migrate_reason and a string, everywhere?

As for synchronization, tracepoint use TRACE_DEFINE_ENUM() macro to map enums.
In general, this kind of synch between subsystem and trace event subsystem is
mostly conscious. So it more likes that include/linux/migrate.h is connected to
include/trace/events/migrate.h and migrate_reason_names, the others hasn't
relationship except same reason string.
 
Anyway, I didn't find a simply way the build the "everywhere" relationship behind
the packaged TRACE_DEFINE_ENUM , what do you think.

Thanks,
Weizhao


