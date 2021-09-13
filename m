Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0AB409C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347286AbhIMShR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241450AbhIMShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631558158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ScHcN8dLaumVNUqatliuYwE9cKX9b+BGBYhfk+zY8Jg=;
        b=S5Jgwrtm7QywN3E7+kXSxyxHIXCed/iPUUYoN90TkSkE52Ze+NXRjRyR8sCNo0O7jDb0z1
        qGFcx5jn2JstM+eAPTKjXLUgY9lWu+Dg0qY+wokuIVhQziL6xvgtkdTJ+ox8Zw8r/Sn844
        BPXcYXgJobXbIwdfqqD8NHLCRAYOnqU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398--UDtBZbrO_qDOIn4cNKg8A-1; Mon, 13 Sep 2021 14:35:57 -0400
X-MC-Unique: -UDtBZbrO_qDOIn4cNKg8A-1
Received: by mail-ed1-f70.google.com with SMTP id s15-20020a056402520f00b003cad788f1f6so5354541edd.22
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ScHcN8dLaumVNUqatliuYwE9cKX9b+BGBYhfk+zY8Jg=;
        b=Ke6GqlF86VZEm0+93EANW3jbHQ6bfHC/eOW4ADNM4Fg/ANxsZAdiLyeFYK7NmfC+RD
         LjHsc7vSAj95oRUzTMNjBDSo6eVa5FKVKPBxgAmwOL1XGuHER0XzESM4HW3ipHkTHms5
         684c8L0Igq8orksS29n+mXmxbNZM5UaiJYsvIq0KbTlnXHK2D5uN+TsQjhN8PC62GWR2
         LAE5UHbyHfSwC413ZWHcetUX9DdnK59LVz6MjW0oKWjcauXX7sCcYeWUK/GgiRpA2aV8
         Jl5a2hbnLUHpnE/2oznN8JswwGXl8muWRLkw8FavnSkSAdQwJsRX4FWGkN3jqJvTKwFp
         SMSg==
X-Gm-Message-State: AOAM531n1L+HKeN8D4sd4ZBvgVPU3NsxUmbvG9eE48rrCK6jUHBVbVgt
        2AJxiX6eAmJdytdlUuW1Jfhrj1gswf8LfAz2vovMwIl0dGhScliWGk0anQPJewBz4f+F7Z/nj9t
        FQT2LAJ87jBUqqcQPYbp84vIL
X-Received: by 2002:a05:6402:186:: with SMTP id r6mr14397453edv.37.1631558155169;
        Mon, 13 Sep 2021 11:35:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfyw0ATWgIXoWJXFVBnp8QaQsJtvhjjjhWFxN1Vg7ZJVpr0Wea9ho+vNOhg2FYNgJBj/GnFg==
X-Received: by 2002:a05:6402:186:: with SMTP id r6mr14397426edv.37.1631558154925;
        Mon, 13 Sep 2021 11:35:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b5sm3861308ejq.56.2021.09.13.11.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 11:35:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] x86: sgx_vepc: extract sgx_vepc_remove_page
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org, jarkko@kernel.org,
        dave.hansen@linux.intel.com, yang.zhong@intel.com
References: <20210913131153.1202354-1-pbonzini@redhat.com>
 <20210913131153.1202354-2-pbonzini@redhat.com>
 <dc628588-3030-6c05-0ba4-d8fc6629c0d2@intel.com>
 <8105a379-195e-8c9b-5e06-f981f254707f@redhat.com>
 <06db5a41-3485-9141-10b5-56ca57ed1792@intel.com>
 <34632ea9-42d3-fdfa-ae47-e208751ab090@redhat.com>
 <480cf917-7301-4227-e1c4-728b52537f46@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b595588-eb98-6d30-dc50-794fc396bf7e@redhat.com>
Date:   Mon, 13 Sep 2021 20:35:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <480cf917-7301-4227-e1c4-728b52537f46@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/21 17:29, Dave Hansen wrote:
> On 9/13/21 8:14 AM, Paolo Bonzini wrote:
>> On 13/09/21 16:55, Dave Hansen wrote:
>>>> By "Windows startup" I mean even after guest reboot.  Because another
>>>> process could sneak in and steal your EPC pages between a close() and an
>>>> open(), I'd like to have a way to EREMOVE the pages while keeping them
>>>> assigned to the specific vEPC instance, i.e.*without*  going through
>>>> sgx_vepc_free_page().
>>> Oh, so you want fresh EPC state for the guest, but you're concerned that
>>> the previous guest might have left them in a bad state.  The current
>>> method of getting a new vepc instance (which guarantees fresh state) has
>>> some other downsides.
>>>
>>> Can't another process steal pages via sgxd and reclaim at any time?
>>
>> vEPC pages never call sgx_mark_page_reclaimable, don't they?
> 
> Oh, I was just looking that they were on the SGX LRU.  You might be right.
> But, we certainly don't want the fact that they are unreclaimable today
> to be part of the ABI.  It's more of a bug than a feature.

Sure, that's fine.

>>> What's the extra concern here about going through a close()/open()
>>> cycle?  Performance?
>>
>> Apart from reclaiming, /dev/sgx_vepc might disappear between the first
>> open() and subsequent ones.
> 
> Aside from it being rm'd, I don't think that's possible.
> 

Being rm'd would be a possibility in principle, and it would be ugly for 
it to cause issues on running VMs.  Also I'd like for it to be able to 
pass /dev/sgx_vepc in via a file descriptor, and run QEMU in a chroot or 
a mount namespace.  Alternatively, with seccomp it may be possible to 
sandbox a running QEMU process in such a way that open() is forbidden at 
runtime (all hotplug is done via file descriptor passing); it is not yet 
possible, but it is a goal.

Paolo

