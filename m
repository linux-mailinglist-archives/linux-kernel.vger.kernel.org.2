Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FAD3F704A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhHYHX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238606AbhHYHXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629876189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7E5N/nJlshM9hA3zETY6iInStLkJCq/cd1o1HlWKF9Y=;
        b=ExMcEf+exSUI1x7x0aonFvpCjFcO54a2FoMIxBUk03SVGGlaxFWyi44mPiLTnIMgTsBh/J
        zV1avTFAMvxApftU3fLpyYHnvn3y4pjVb/f8psaYeg9J3jCCRprd4Mklcdy4UW0Bn5TeNL
        TnNCdHwHhRoO0BQsqKFsYihjbUYqTYU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-nueqrfLoNZm0qWkIcQNj1g-1; Wed, 25 Aug 2021 03:23:05 -0400
X-MC-Unique: nueqrfLoNZm0qWkIcQNj1g-1
Received: by mail-wr1-f71.google.com with SMTP id a9-20020a0560000509b029015485b95d0cso6356398wrf.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 00:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7E5N/nJlshM9hA3zETY6iInStLkJCq/cd1o1HlWKF9Y=;
        b=BWt+6D50TFvu2n3cs+UI+VOVqBC9vFd0VyZcmiGT/JaOG1xQjT0x6YDknkea3cpnhC
         15a3pmqfU4sBrzTqItoZhrFpsMvpvDNCcuP93n3iqxWCPvM7pSEUlt/+iGkN3huMTusz
         Bzf86zV8oaUWHXOYukGvy3q1/7vdmrRZ3af+3q1izjaHYRRYeEm2SwcLG9KbhtTtPH7e
         YOGAE4FzRhSsVarO9E/hnaZScoKxR/rKtvMx9dJBkXrkejmhzk5rg6yPAQhU/SLku+22
         vNEW8PjJhDR/mVX75HEtCtK6CyRxM/yoowz58Ah81uKKY6VCAA8vJGgmFNwt/FTqXW5e
         1WHg==
X-Gm-Message-State: AOAM533CzIz9rordJevig8mFPIIECteZDpDImlhAmMg6jOgSAtVdg6NB
        4fBWzWMh4Dw9FNx7M+260KnHtfGcYFEihnXNOPMJGndQS6KYaadT/ncWkJRxR43aw7SmmZiOIP9
        ktRZkKwWw3Q355Sy6WolBgS2L
X-Received: by 2002:adf:f403:: with SMTP id g3mr12011602wro.206.1629876184610;
        Wed, 25 Aug 2021 00:23:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG4aiiyDZwx8VQJaBBxxomNtCUbza9LZ3DxHopkCg74ZqORlsPbhVeFhE2GgmrA26R7Jy9CA==
X-Received: by 2002:adf:f403:: with SMTP id g3mr12011586wro.206.1629876184402;
        Wed, 25 Aug 2021 00:23:04 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
        by smtp.gmail.com with ESMTPSA id v1sm19763706wrt.93.2021.08.25.00.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 00:23:03 -0700 (PDT)
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        virtualization@lists.linux-foundation.org,
        Linux MM <linux-mm@kvack.org>
References: <20210816142505.28359-1-david@redhat.com>
 <20210816142505.28359-2-david@redhat.com>
 <CAPcyv4jfPSanWFNopzShtGiMDjwRuaci2n6hF3FCxsm1cG-ydg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] /dev/mem: disallow access to explicitly excluded
 system RAM regions
Message-ID: <bece6d48-57a3-e7d3-9b26-7faccfbcc7a8@redhat.com>
Date:   Wed, 25 Aug 2021 09:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jfPSanWFNopzShtGiMDjwRuaci2n6hF3FCxsm1cG-ydg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.21 02:58, Dan Williams wrote:
> On Mon, Aug 16, 2021 at 7:25 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> virtio-mem dynamically exposes memory inside a device memory region as
>> system RAM to Linux, coordinating with the hypervisor which parts are
>> actually "plugged" and consequently usable/accessible. On the one hand, the
>> virtio-mem driver adds/removes whole memory blocks, creating/removing busy
>> IORESOURCE_SYSTEM_RAM resources, on the other hand, it logically (un)plugs
>> memory inside added memory blocks, dynamically either exposing them to
>> the buddy or hiding them from the buddy and marking them PG_offline.
>>
>> virtio-mem wants to make sure that in a sane environment, nobody
>> "accidentially" accesses unplugged memory inside the device managed
>> region. After /proc/kcore has been sanitized and /dev/kmem has been
>> removed, /dev/mem is the remaining interface that still allows uncontrolled
>> access to the device-managed region of virtio-mem devices from user
>> space.
>>
>> There is no known sane use case for mapping virtio-mem device memory
>> via /dev/mem while virtio-mem driver concurrently (un)plugs memory inside
>> that region. So once the driver was loaded and detected the device
>> along the device-managed region, we just want to disallow any access via
>> /dev/mem to it.
>>
>> Let's add the basic infrastructure to exclude some physical memory
>> regions completely from /dev/mem access, on any architecture and under
>> any system configuration (independent of CONFIG_STRICT_DEVMEM and
>> independent of "iomem=").
> 
> I'm certainly on team "/dev/mem considered harmful", but this approach
> feels awkward. It feels wrong for being non-committal about whether
> CONFIG_STRICT_DEVMEM is in wide enough use that the safety can be
> turned on all the time, and the configuration option dropped, or there
> are users clinging onto /dev/mem where they expect to be able to build
> a debug kernel to turn all of these restrictions off, even the
> virtio-mem ones. This splits the difference and says some /dev/mem
> accesses are always disallowed for "reasons", but I could say the same
> thing about pmem, there's no sane reason to allow /dev/mem which has
> no idea about the responsibilities of properly touching pmem to get
> access to it.

For virtio-mem, there is no use case *and* access could be harmful; I 
don't even want to allow if for debugging purposes. If you want to 
inspect virtio-mem device memory content, use /proc/kcore, which 
performs proper synchronized access checks. Modifying random virtio-mem 
memory via /dev/mem in a debug kernel will not be possible: if you 
really have to play with fire, use kdb or better don't load the 
virtio-mem driver during boot, such that the kernel won't even be making 
use of device memory.

I don't want people disabling CONFIG_STRICT_DEVMEM, or booting with 
"iomem=relaxed", and "accidentally" accessing any of virtio-mem memory 
via /dev/mem, while it gets concurrently plugged/unplugged by the 
virtio-mem driver. Not even for debugging purposes.

We disallow mapping to some other regions independent of 
CONFIG_STRICT_DEVMEM already, so the idea to ignore CONFIG_STRICT_DEVMEM 
is not completely new:

"Note that with PAT support enabled, even in this case there are 
restrictions on /dev/mem use due to the cache aliasing requirements."

Maybe you even want to do something similar with PMEM now that there is 
infrastructure for it and just avoid having to deal with revoking 
/dev/mem mappings later.


I think there are weird debugging/educational setups [1] that still 
require CONFIG_STRICT_DEVMEM=n even with iomem=relaxed. Take a look at 
lib/devmem_is_allowed.c:devmem_is_allowed(), it disallows any access to 
(what's currently added as) System RAM. It might just do what people 
want when dealing with system RAM that doesn't suddenly vanish , so I 
don't ultimately see why we should remove CONFIG_STRICT_DEVMEM=n.

[1] https://bakhi.github.io/devmem/

Thanks!

-- 
Thanks,

David / dhildenb

