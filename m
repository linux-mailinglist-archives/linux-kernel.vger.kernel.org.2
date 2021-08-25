Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3233F7B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbhHYR2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242258AbhHYR2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629912444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXaz0tPc7fZtJBb/dPevEF5ap0GWQE6Dpk8ZPpRNA/I=;
        b=WiIS/AD0e850d6Qbu5WFDBUsR1tKIj8amCunegNvGqTOUq0HJNTix4N/QCW7AK9wyWnDIM
        4jFnrZSyDDGVs9KVyRyDYt7bj36kqNRBTvsAwpH0yYQl/VCux5qKGkF9hfmWEbvmbsKTF5
        5TQz47SklMHVhC5SKHPopkwXVDAFqUQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-0em9idgiPmis4nOL4gPGGw-1; Wed, 25 Aug 2021 13:27:23 -0400
X-MC-Unique: 0em9idgiPmis4nOL4gPGGw-1
Received: by mail-wr1-f71.google.com with SMTP id z15-20020adff74f000000b001577d70c98dso78770wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AXaz0tPc7fZtJBb/dPevEF5ap0GWQE6Dpk8ZPpRNA/I=;
        b=Gf6zgd2Kwn0wxLvMZiK158te26mVZheihGZE0FMCtLgPo2B0Bbd7sx95UoQ7feCrCY
         6WKcMZcDYQtvNP7a++99X8FfY3pjgXk0kIA+ebcr0rgPFKLR6DdSfrxtEBF4GRzOgDGH
         8x0qIkwnGPqu1JYox5l2gkhzIAy/SX7iMZ5pJwbIqZTqk66FXFpivkn7QrZ3f8jXgFYs
         H5IXGkTRxvIvATMdfbakXoeBKgNXX3SG2bQxsdajFX89ceJvv54/Nshvk2eLytUIerqH
         55Fz+DFfvBqBHpsdn9c1T2x0a5onNjLM5dF0YPI9HwVHm/T0JfCqRv0xAAOrMQHdt7iR
         /snQ==
X-Gm-Message-State: AOAM53150lPTfdJJ8Af5gpMyXZ6+ns4wtIgOn+xkApCWSv1QahZX5d0N
        wMeGwitQ6Pu5SyI2nfiZyh6Ci/SUa7/xMN2gEzRArD+Ut2vFrYqZSo7VgIBV9qWgOOowtng04sS
        JNb6i88kP1Gbk7uXErb8/c2PF
X-Received: by 2002:a05:6000:1375:: with SMTP id q21mr22001452wrz.41.1629912441873;
        Wed, 25 Aug 2021 10:27:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzstO6fv4t/9anZzviPu7bKujAkZrZHhfA3pIWg39sTZMi/ePcEnlXG2Gdkj6lY2fgt85/EZQ==
X-Received: by 2002:a05:6000:1375:: with SMTP id q21mr22001426wrz.41.1629912441574;
        Wed, 25 Aug 2021 10:27:21 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
        by smtp.gmail.com with ESMTPSA id r129sm260673wmr.7.2021.08.25.10.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 10:27:21 -0700 (PDT)
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
 <bece6d48-57a3-e7d3-9b26-7faccfbcc7a8@redhat.com>
 <CAPcyv4h9ikp3fSaAc132DV=zrG-OJJ9-6ct8KZ3XhMZ-jbAR=Q@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] /dev/mem: disallow access to explicitly excluded
 system RAM regions
Message-ID: <e1ac08b0-a8fe-2668-9233-db85b918d7d5@redhat.com>
Date:   Wed, 25 Aug 2021 19:27:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h9ikp3fSaAc132DV=zrG-OJJ9-6ct8KZ3XhMZ-jbAR=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.21 19:07, Dan Williams wrote:
> On Wed, Aug 25, 2021 at 12:23 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 25.08.21 02:58, Dan Williams wrote:
>>> On Mon, Aug 16, 2021 at 7:25 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> virtio-mem dynamically exposes memory inside a device memory region as
>>>> system RAM to Linux, coordinating with the hypervisor which parts are
>>>> actually "plugged" and consequently usable/accessible. On the one hand, the
>>>> virtio-mem driver adds/removes whole memory blocks, creating/removing busy
>>>> IORESOURCE_SYSTEM_RAM resources, on the other hand, it logically (un)plugs
>>>> memory inside added memory blocks, dynamically either exposing them to
>>>> the buddy or hiding them from the buddy and marking them PG_offline.
>>>>
>>>> virtio-mem wants to make sure that in a sane environment, nobody
>>>> "accidentially" accesses unplugged memory inside the device managed
>>>> region. After /proc/kcore has been sanitized and /dev/kmem has been
>>>> removed, /dev/mem is the remaining interface that still allows uncontrolled
>>>> access to the device-managed region of virtio-mem devices from user
>>>> space.
>>>>
>>>> There is no known sane use case for mapping virtio-mem device memory
>>>> via /dev/mem while virtio-mem driver concurrently (un)plugs memory inside
>>>> that region. So once the driver was loaded and detected the device
>>>> along the device-managed region, we just want to disallow any access via
>>>> /dev/mem to it.
>>>>
>>>> Let's add the basic infrastructure to exclude some physical memory
>>>> regions completely from /dev/mem access, on any architecture and under
>>>> any system configuration (independent of CONFIG_STRICT_DEVMEM and
>>>> independent of "iomem=").
>>>
>>> I'm certainly on team "/dev/mem considered harmful", but this approach
>>> feels awkward. It feels wrong for being non-committal about whether
>>> CONFIG_STRICT_DEVMEM is in wide enough use that the safety can be
>>> turned on all the time, and the configuration option dropped, or there
>>> are users clinging onto /dev/mem where they expect to be able to build
>>> a debug kernel to turn all of these restrictions off, even the
>>> virtio-mem ones. This splits the difference and says some /dev/mem
>>> accesses are always disallowed for "reasons", but I could say the same
>>> thing about pmem, there's no sane reason to allow /dev/mem which has
>>> no idea about the responsibilities of properly touching pmem to get
>>> access to it.
>>
>> For virtio-mem, there is no use case *and* access could be harmful; I
>> don't even want to allow if for debugging purposes. If you want to
>> inspect virtio-mem device memory content, use /proc/kcore, which
>> performs proper synchronized access checks. Modifying random virtio-mem
>> memory via /dev/mem in a debug kernel will not be possible: if you
>> really have to play with fire, use kdb or better don't load the
>> virtio-mem driver during boot, such that the kernel won't even be making
>> use of device memory.
>>
>> I don't want people disabling CONFIG_STRICT_DEVMEM, or booting with
>> "iomem=relaxed", and "accidentally" accessing any of virtio-mem memory
>> via /dev/mem, while it gets concurrently plugged/unplugged by the
>> virtio-mem driver. Not even for debugging purposes.
> 
> That sounds more an argument that all of the existing "kernel is using
> this region" cases should become mandatory exclusions. If unloading
> the driver removes the exclusion then that's precisely
> CONFIG_IO_STRICT_DEVMEM. Why is the virtio-mem driver more special
> than any other driver that expects this integrity guarantee?

Unloading the driver will only remove exclusion if the driver can be 
unloaded cleanly -- if there is no memory added to Linux. Similar to 
force-unbinding dax/kmem without offlining memory, the whole device 
range will remain excluded.

(unloading the driver is only even implemented because there is no way 
to not implement it; there is no sane use case for virtio-mem to do that)

There are 2 things that are relevant for virtio-mem memory in regards of 
this series:

1. Kernel is currently using it (added virtio-mem memory). Don't allow 
access. Pretty much like most other things we want to exclude, I agree.

2. Kernel is currently not using it (not yet added virtio-mem memory), 
or not using it right now any more (removed virtio-mem memory). In 
contrast to other devices (DIMM, PMEM, ...) there is no sane use case 
for this memory, because the VM must not use it (as defined in the 
virtio-spec).


I care about 2) a lot because I don't want people looking at 
/proc/iomem, figuring out that there is something to map. And by the 
time they try to map it via /dev/mem, virtio-mem emoved that memory, yet 
a /dev/mem mapping happened and we have invalid memory access.

Mapping /dev/mem and accidentally being able to read/write virtio-mem 
memory has to be forbidden in sane environments. Force unloading a 
driver or preventing it from loading just to touch virtio-mem memory via 
/dev/mem is not a sane environment, someone is explicitly is asking for 
trouble, which is fine.

> 
>> We disallow mapping to some other regions independent of
>> CONFIG_STRICT_DEVMEM already, so the idea to ignore CONFIG_STRICT_DEVMEM
>> is not completely new:
>>
>> "Note that with PAT support enabled, even in this case there are
>> restrictions on /dev/mem use due to the cache aliasing requirements."
>>
>> Maybe you even want to do something similar with PMEM now that there is
>> infrastructure for it and just avoid having to deal with revoking
>> /dev/mem mappings later.
> 
> That would be like blocking writes to /dev/sda just because a
> filesytem might later be mounted on it. If the /dev/mem access is not
> actively colliding with other kernel operations what business does the
> kernel have saying no?

That the spec defines that that memory must not be read/written, because 
there might not be any memory after all anymore backing the virtio-mem 
device, or there is and the hypervisor will flag you as "malicious" and 
eventually zap the VM. That's different to most physical devices I am 
aware of.

> 
> I'm pushing on this topic because I am also considering an exclusion
> on PCI configuration access to the "DOE mailbox" since it can disrupt
> the kernel's operation, at the same time, root can go change PCI BARs
> to nonsensical values whenever it wants which is also in the category
> of "has no use case && could be harmful".

Right.

> 
>> I think there are weird debugging/educational setups [1] that still
>> require CONFIG_STRICT_DEVMEM=n even with iomem=relaxed. Take a look at
>> lib/devmem_is_allowed.c:devmem_is_allowed(), it disallows any access to
>> (what's currently added as) System RAM. It might just do what people
>> want when dealing with system RAM that doesn't suddenly vanish , so I
>> don't ultimately see why we should remove CONFIG_STRICT_DEVMEM=n.
> 
> Yes, I wanted to tease out more of your rationale on where the line
> should be drawn, I think a mostly unfettered /dev/mem mode is here to
> stay.

I could most certainly be convinced to

a) Leave CONFIG_STRICT_DEVMEM=n untouched
b) Restrict what I propose to CONFIG_STRICT_DEVMEM=y.

I could even go ahead and require CONFIG_STRICT_DEVMEM for virtio-mem.

-- 
Thanks,

David / dhildenb

