Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CDF442A52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhKBJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhKBJ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635845087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Is5x4qunizskcubykNuexE0rm+el3szUQ1h1UP1TOd8=;
        b=f5Uk3s2BxgM5tPLSusZcmpc7Z5UO5MYRWbmvj3z85wcvRRu2SVPl3+w+AHNktSu9pjVd6m
        gnwXPi0rmLjBnwgN6yc7yntDP0ybkPkIB9adeRVMOdA9ZtaTTWx9GOXZYpNa4ZLFn6odRU
        7LLxaTFcLneEBBV5MY+ZCVeWIcBxH7Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-QqnZ5n2MOX-nuPKykdSExg-1; Tue, 02 Nov 2021 05:24:46 -0400
X-MC-Unique: QqnZ5n2MOX-nuPKykdSExg-1
Received: by mail-wr1-f72.google.com with SMTP id j12-20020adf910c000000b0015e4260febdso7243409wrj.20
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 02:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Is5x4qunizskcubykNuexE0rm+el3szUQ1h1UP1TOd8=;
        b=Gs+zb0iUL7gfbnWxy+9eI7cAOcTr4IwtBMffg06I9VcSx77EPH9Oe6WFkobaeuylnl
         mrgmY4AwfnO/zGCOcy1tTZPXVtWa4MWuN8FkHko0/DU5an++L6/fIzd1eJV9DPnNr8rz
         6sh0QXX8GbB2+7J/62gIiFlpdDAzH8nEk8ZPusFL96O4qv9bm6RaThPh8w7Vq+YaSNPx
         kvKAK2ZUQ1qIqxDdvXDo+Av6qESU5NmAqehJbB+h1+xKSNvQmqnfM4/0YM+I0Ed30zQo
         za20l8fC6wnYLGuU47W+MpAI5wv8F2PaD7EV06HfTPmxTuY6GnXdrA9+Os/xZMn3Jl/O
         byXg==
X-Gm-Message-State: AOAM532AR5Q4c60btHgteBEZ/q83A0NKGwhvie5RkHFL0h1l4HctmwZc
        j4G5/GCvC768jP8erThwtFxHUO2duZ1gqjBdxmixKKb4W7FbIvkMzF2zTQA0IDZS2IMnaS/w99r
        86xXd8wmB/qUJDF8LAwV1vIZY
X-Received: by 2002:adf:c604:: with SMTP id n4mr44318063wrg.202.1635845085001;
        Tue, 02 Nov 2021 02:24:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0fGQ3DEwyi8rkMHH3dWnFdffOx2xdXnyQCeUm6PEHTWPpSxAA5u0XtJ73kJCG3Hgbf97vUQ==
X-Received: by 2002:adf:c604:: with SMTP id n4mr44318038wrg.202.1635845084800;
        Tue, 02 Nov 2021 02:24:44 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6810.dip0.t-ipconnect.de. [91.12.104.16])
        by smtp.gmail.com with ESMTPSA id p13sm2193869wmi.0.2021.11.02.02.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 02:24:44 -0700 (PDT)
Message-ID: <b2e4a611-45a6-732a-a6d3-6042afd2af6e@redhat.com>
Date:   Tue, 2 Nov 2021 10:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Oscar Salvador <OSalvador@suse.com>
References: <20211101201312.11589-1-amakhalov@vmware.com>
 <YYDtDkGNylpAgPIS@dhcp22.suse.cz>
 <7136c959-63ff-b866-b8e4-f311e0454492@redhat.com>
 <C69EF2FE-DFF6-492E-AD40-97A53739C3EC@vmware.com>
 <YYD/FkpAk5IvmOux@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: fix panic in __alloc_pages
In-Reply-To: <YYD/FkpAk5IvmOux@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> In add_memory_resource() we hotplug the new node if required and set it
>>> online. Memory might get onlined later, via online_pages().
>>
>> You are correct. In case of memory hot add, it is true. But in case of adding
>> CPU with memoryless node, try_node_online() will be called only during CPU
>> onlining, see cpu_up().
>>
>> Is there any reason why try_online_node() resides in cpu_up() and not in add_cpu()?
>> I think it would be correct to online node during the CPU hot add to align with
>> memory hot add.
> 
> I am not familiar with cpu hotplug, but this doesn't seem to be anything
> new so how come this became problem only now?

So IIUC, the issue is that we have a node

a) That has no memory
b) That is offline

This node will get onlined when onlining the CPU as Alexey says. Yet we
have some code that stumbles over the node and goes ahead trying to use
the pgdat -- that code is broken.


If we take a look at build_zonelists() we indeed skip any
!node_online(node). Any other code should do the same. If the node is
not online, it shall be ignored because we might not even have a pgdat
yet -- see hotadd_new_pgdat(). Without node_online(), the pgdat might be
stale or non-existant.


The node onlining logic when onlining a CPU sounds bogus as well: Let's
take a look at try_offline_node(). It checks that:
1) That no memory is *present*
2) That no CPU is *present*

We should online the node when adding the CPU ("present"), not when
onlining the CPU.

-- 
Thanks,

David / dhildenb

