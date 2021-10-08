Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4CC4265FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJHIfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229873AbhJHIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633681997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LWDLjYLfIQsF5wCuVEzYPdRcUsEP6b+ecuhVQm+wn8w=;
        b=IB28LEMA+GHNcXGLBXaLhv6uSXuzUBIN0HGmxanvFb12jgUnX+hzoNuCbv+8/+lE6eVtK6
        N78IwStD9yxoHeFfbrv1TnusOgGW3ACTJvHJIvJvXsC6SPk8paNnqWTX4MNIBW11MmDgLx
        iVkON2UkCLyt4Y4kCoyeGWDFig+Zb6Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-cODuENDcMuaCkTeOa9CmXg-1; Fri, 08 Oct 2021 04:33:16 -0400
X-MC-Unique: cODuENDcMuaCkTeOa9CmXg-1
Received: by mail-wr1-f69.google.com with SMTP id r21-20020adfa155000000b001608162e16dso6692461wrr.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LWDLjYLfIQsF5wCuVEzYPdRcUsEP6b+ecuhVQm+wn8w=;
        b=rdxSYrCZxgVMmhFyfcSxP/C6FCKe1RIpoOE0Sff04S0LFhTDWKLQEXe1pWQSWluVDF
         Xdyb9IDmwLMBteGVHBUKWjw49TeB9C80IqtzPRJIngKnDItyxAHkly6j0L2Wooo4fM+W
         f5vWFl9FsPKFU97zK/ZthYN9efTtWutPN1XYYrLBW0eBt/WQV4UphjF476E0d0bkgEvw
         FOaBA7EUHorhgkWj8GPi4pJnpBwNy7VhWUW7VbHJ4W7ql3DfKG4dLftSi+aqmv8GYXIN
         5wV1GA8RaI3CJ0OwpUiRFGdcN32KRwdnDF8FhaV3DVXRVkGTmPgYPCUYmJWtbFBnTPia
         t8iw==
X-Gm-Message-State: AOAM531hz0aT6A3cA/s5GZkOwhCPpIp0T4a0CGfFmf5rj9+p8SZ6ESed
        JRzkCsWwsL7S8kC5NE1OmMoOBJ0b40PqfJtLqZZSyZnq7Z6mad7NnhyYCnIt+CydJi/ptvA0+rt
        TK42F09YzWAGPCaOErDxvPlc1
X-Received: by 2002:a05:600c:214:: with SMTP id 20mr2054651wmi.190.1633681994959;
        Fri, 08 Oct 2021 01:33:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1IXlpujwJuJnsWvtfA/duexrkNA5KkPHDXn1rcjVjPRraMjzp22x+I83g1SqU49zTwT3NkQ==
X-Received: by 2002:a05:600c:214:: with SMTP id 20mr2054628wmi.190.1633681994720;
        Fri, 08 Oct 2021 01:33:14 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id a127sm9585796wme.40.2021.10.08.01.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 01:33:14 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] memory-hotplug.rst: document the "auto-movable"
 online policy
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
References: <20210930144117.23641-1-david@redhat.com>
 <20210930144117.23641-4-david@redhat.com> <YVzvYmf4xWC1DORO@kernel.org>
 <4bab9000-0b49-a852-d574-1c8b2fe10de1@redhat.com>
 <YV6jpoVERotn/New@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <09027675-5737-a076-7616-277aeb38427c@redhat.com>
Date:   Fri, 8 Oct 2021 10:33:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YV6jpoVERotn/New@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> It's essentially ignored with the auto-movable policy for memory hotplugged
>> after boot (!MEMBLOCK_HOTPLUG). That's why only the description of
>> "contig-zones" below describes how it interacts with the ``movable_node``,
>> and we make it clear here that it's restricted to the "contig-zones" policy
>> as well.
>>
>> <details>
>> Bare metal, where we care about reliably unplugging hotplugged memory
>> usually configures auto-onlining to "online_movable": for example, that's
>> the case on RHEL. auto-movable doesn't make too much sense for bare metal:
>> the nature of "movable_node" is to essentially online anything that might
>> get hotunplugged MOVABLE, especially after hotplugging memory and rebooting:
>> that is highly dangerous especially in virtualized environments.
>>
>> "auto-movable" is valuable in virtualized environments, where we add memory
>> via:
>> * add_memory_driver_managed() like virtio-mem, whereby such memory is
>>    never part of the firmware provided memory-map, so the policy is
>>    always in control even after a reboot.
>> * Hotplugged virtual DIMMs, such as provided by x86-64/arm64, whereby we
>>    don't include these DIMMs in the firmware-provided memory map, but
>>    ACPI code adds them after early boot, making it behave similar to
>>    add_memory_driver_managed() -- the policy is always in control even
>>    after a reboot.
>> </details>
>   
> Do you want to put it somewhere in Documentation/ ?
> It's already written anyway ;-)
> 

I'll add to the "auto-movable" description:

"This policy ignores the ``movable_node`` kernel command line parameter 
and isn't really applicable in environments that require it (e.g., bare 
metal with hotunpluggable nodes) where hotplugged memory might be 
exposed via the firmware-provided memory map early during boot to the 
system instead of getting detected, added and onlined later during boot 
(such as done by virito-mem or by some hypervisors implementing emulated 
DIMMs)."

Thanks Mike!

-- 
Thanks,

David / dhildenb

