Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1856B4111CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhITJQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhITJQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:16:19 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D56C061766
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 02:14:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f129so16678534pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LWSCYEWJX2JBlRRFgmVEzcm5wBIbmnQM2030wXUM5lg=;
        b=X0RMsNLfBKlcPUtEqra8Vua+G5VEhY5cD0UAkxXJw4kajUW/CjLm+TtNaoO+QAkzjR
         UjXdaOzo7RwNcbtbewqfk1URygMaEXtiEXUh+hHhgreRpyaPqaaaaX7RpQo0LVPgpgaa
         /gUsB6hkq8ssjZSfE9BFE0jfHmF60FzJ7e3Klth/PSnfZ/SlSbdwxaiUv0fsa+NItIxc
         IcIr6XZS9IKnjCfTjpRQzzOQbGZcddSMNQDhg6NNgM2+UhURhh2OiGYoNqsxN810/oFJ
         u+X6JzOVABO1Rm1lSH+P5bg2oAdr7xAmLEenQcgNgZi7nWCY1KtY8gjaM99E11rm1oiC
         zeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LWSCYEWJX2JBlRRFgmVEzcm5wBIbmnQM2030wXUM5lg=;
        b=g1XdlSgcJE/S2ot3yUJpgQ3PMY9Pa/Tmo1NxsrUWNnzIV9qH05Uz8+PFl0QoTZa/jc
         9KtOOtQzxZA5FcUGhF5hsmVNXgDUVTYWuRXhWEw+kX0M4JR+QluY401HyzmGmqbG1kH7
         TLxTi85KLBbfNgP958JNwSfMXa8RNES9LUVL8djBBZAhiQAX2ii+crGxGzSg4rGHTFnC
         91vv59CMsHUqvlW+F7VVeecevdBMX60rIpyncHY7WXSJtR+klTB0U4tGFiHfaRI5G5es
         g65jmbT0I4mlrYc/82j5MA20egGf3u7W+YWsyjQ+6FzUL9/Bi+UKVVvRcS5TFqXbCI52
         VJjw==
X-Gm-Message-State: AOAM530u4J4F47Qel5N8TsVe9NXlbxj1SuT2fTWJ96sowH5MrLx7yjEx
        xBv57rxViWEa9T67kRhTj0ahzWF5ij01YmM5
X-Google-Smtp-Source: ABdhPJzrsqpHKJQVypLMMnz7M/9djwWUWvrB4nqHCl3qNzhPlkvyUcPUEtbyMoEmUvsUmBFXL2SjXw==
X-Received: by 2002:a05:6a00:1245:b029:30f:2098:fcf4 with SMTP id u5-20020a056a001245b029030f2098fcf4mr24275858pfi.66.1632129292226;
        Mon, 20 Sep 2021 02:14:52 -0700 (PDT)
Received: from owniadeMacBook-Pro.local ([103.97.201.31])
        by smtp.gmail.com with ESMTPSA id x71sm7916698pfc.146.2021.09.20.02.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 02:14:51 -0700 (PDT)
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
 <b4123610-bddf-03b9-2190-7b0cda55b57c@gmail.com>
 <cec9a286-f7b6-c80a-c518-480db65152fc@nvidia.com>
From:   Weizhao Ouyang <o451686892@gmail.com>
Message-ID: <c597ee80-2266-5345-16ba-c8c96cc5b341@gmail.com>
Date:   Mon, 20 Sep 2021 17:14:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cec9a286-f7b6-c80a-c518-480db65152fc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/19 13:38, John Hubbard wrote:
> On 9/18/21 00:03, Weizhao Ouyang wrote:
> ...
>>   Anyway, I didn't find a simply way the build the "everywhere" relationship behind
>> the packaged TRACE_DEFINE_ENUM , what do you think.
>>
> It's actually pretty easy, unless I'm unknowingly violating some rule
> here. But I did review tracing a bit before diving in, and I think this
> is reasonable.
>
> The trace macros EM(), EMe(), and MIGRATE_REASON are flexible enough to
> get whatever you want, out of them. So, the trace header can be the one
> location for the definition of the enum-to-string mapping.
>
> The key is to move the enum to a common header file that both the trace
> system (trace/events/migrate.h) and the migrate header
> (include/linux/migrate.h) can include. Fortunately, that's already been
> started for enum migrate_mode: there is migrate_mode.h.
>
> So it all works approximately like this, below. (I'll attach a
> white-space-correct diff that you can apply directly, too). I've
> compiled tested and rebooted with it, but haven't checked much more
> than that yet.

Thanks for your detailed patch! Yeah, if we move the enum migrate_reason to
another header file it will attach it easily. The previous mail I said the
tricky point is that we build the "everywhere relationship" on the basis of
maintaining the original file structure, sorry for the confusing misleading.
I think we should not change a lot for a slight synchronization.

For now we can just apply the update in migrate_reason_name(maybe leave a
comment to notify) on this patch, I will send v2 patch soon include the "cma"
update. As for the trace_event synchronization, we can figure out a more
generic implementation in the future, so that other subsystem can use it to
catch a string info from its trace event header.

Thanks,
Weizhao
