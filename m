Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D081396E74
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhFAIDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233127AbhFAIDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622534488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mKeAx83Wo1F8/mxxn7eN4daLltVvzFFfCCvCnjwWhw=;
        b=IDBHXsFGfqMk5VA7aOAYQHWenZJDKQiyKZxFqVC/H1/HYNRmPZlp//R1kQjOUHYrTl5FaP
        tUC0LFnZj/XgjW1ROKIrE0hM/dtexkkpJEG1E2baPPBCc6PnAsSU16NMU+YhK88/w2V4G0
        vyFyBvcZhmkRigJ5wh2lzz1pPGVhCE4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-4GEfehpjOXWhaqAqdnsXqQ-1; Tue, 01 Jun 2021 04:01:27 -0400
X-MC-Unique: 4GEfehpjOXWhaqAqdnsXqQ-1
Received: by mail-wm1-f70.google.com with SMTP id z25-20020a1c4c190000b029019f15b0657dso269969wmf.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8mKeAx83Wo1F8/mxxn7eN4daLltVvzFFfCCvCnjwWhw=;
        b=EEbO3d4BqKPXEMd/+CdcCcTa8ak/y8zi1pEtCaNjfRUIoy5v7Amj+G1iWZ96uVxE2d
         LJgpAWgK0aCZsYIjpBgJm02Z4H2MWUn7G5nlLLqQy3weQ1i49JsvDCdNApFWez0MfnFy
         Z0QOWLDSvGcsAECt1j9eBoC+CnGp4Y2bQXIw4EWhnYsCphu9dTxyBLDIdfL1m8qKrIYe
         CfkkS4gTaoDJv2eVJrJnT4oS1RUgG+ex/8razOwcWnk8ae+3uxHzQ6WaZ1Xu17/IhG13
         xu3SnxNNaxHbogFpCtw182rff6kFimKoruof3+mV7n0zWi/myrPuDeqYKnkv9vk9mBCZ
         w6jw==
X-Gm-Message-State: AOAM531bZrE6rK4RfdQtFdIS3+3K/BFxYKO34Jo8MNcrV1I0bcNKv5fO
        HnJTZWy0tYhotj8WP1s8vcJoMKGyyOFJe8UPVguchDwBCsKiyeUYZ1Eg0KpNBey1gevIvFnVvjL
        6gGdp1QCfRIdfcQRgYUMJkZDK
X-Received: by 2002:a7b:c006:: with SMTP id c6mr3192723wmb.11.1622534486376;
        Tue, 01 Jun 2021 01:01:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwccKvTwuROehgW3RRKPGdNxD6nFp8lVriIFHjp5RHZwx/0OZRvWmnzuZaMgiV0bJqxs+lwhw==
X-Received: by 2002:a7b:c006:: with SMTP id c6mr3192696wmb.11.1622534486126;
        Tue, 01 Jun 2021 01:01:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69ce.dip0.t-ipconnect.de. [91.12.105.206])
        by smtp.gmail.com with ESMTPSA id v18sm2650277wro.18.2021.06.01.01.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:01:25 -0700 (PDT)
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.h.duyck@linux.intel.com,
        akpm@linux-foundation.org, shan.gavin@gmail.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210601033319.100737-1-gshan@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to
 MAX_ORDER
Message-ID: <76516781-6a70-f2b0-f3e3-da999c84350f@redhat.com>
Date:   Tue, 1 Jun 2021 10:01:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210601033319.100737-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.21 05:33, Gavin Shan wrote:
> The PAGE_REPORTING_MIN_ORDER is equal to @pageblock_order, taken as
> minimal order (threshold) to trigger page reporting. The page reporting
> is never triggered with the following configurations and settings on
> aarch64. In the particular scenario, the page reporting won't be triggered
> until the largest (2 ^ (MAX_ORDER-1)) free area is achieved from the
> page freeing. The condition is very hard, or even impossible to be met.
> 
>    CONFIG_ARM64_PAGE_SHIFT:              16
>    CONFIG_HUGETLB_PAGE:                  Y
>    CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
>    pageblock_order:                      13
>    CONFIG_FORCE_MAX_ZONEORDER:           14
>    MAX_ORDER:                            14
> 
> The issue can be reproduced in VM, running kernel with above configurations
> and settings. The 'memhog' is used inside the VM to access 512MB anonymous
> area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.
> 
>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          \
>    -accel kvm -machine virt,gic-version=host                        \
>    -cpu host -smp 8,sockets=2,cores=4,threads=1 -m 4096M,maxmem=64G \
>    -object memory-backend-ram,id=mem0,size=2048M                    \
>    -object memory-backend-ram,id=mem1,size=2048M                    \
>    -numa node,nodeid=0,cpus=0-3,memdev=mem0                         \
>    -numa node,nodeid=1,cpus=4-7,memdev=mem1                         \
>      :                                                              \
>    -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
> 
> This tries to fix the issue by adjusting the threshold to the smaller value
> of @pageblock_order and (MAX_ORDER/2). With this applied, the QEMU's RSS
> drops after 'memhog' exits.

IIRC, we use pageblock_order to

a) Reduce the free page reporting overhead. Reporting on small chunks 
can make us report constantly with little system activity.

b) Avoid splitting THP in the hypervisor, avoiding downgraded VM 
performance.

c) Avoid affecting creation of pageblock_order pages while hinting is 
active. I think there are cases where "temporary pulling sub-pageblock 
pages" can negatively affect creation of pageblock_order pages. 
Concurrent compaction would be one of these cases.

The monstrosity called aarch64 64k is really special in that sense, 
because a) does not apply because pageblocks are just very big, b) does 
sometimes not apply because either our VM isn't backed by (rare) 512MB 
THP or uses 4k with 2MB THP and c) similarly doesn't apply in smallish 
VMs because we don't really happen to create 512MB THP either way.


For example, going on x86-64 from reporting 2MB to something like 32KB 
is absolutely undesired.

I think if we want to go down that path (and I am not 100% sure yet if 
we want to), we really want to treat only the special case in a special 
way. Note that even when doing it only for aarch64 with 64k, you will 
still end up splitting THP in a hypervisor if it uses 64k base pages 
(b)) and can affect creation of THP, for example, when compacting (c), 
so there is a negative side to that.

-- 
Thanks,

David / dhildenb

