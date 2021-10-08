Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CFF426B57
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbhJHM5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230240AbhJHM5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633697749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FMmWc8lP0mifWAbwIJadUVhVPm7Gb5Eb+P29xKmImcg=;
        b=K61i7Sk2Op42cS/TTlauxXClXnyjfXaEy3+bdpnctNVFvQpAmHk+tAa5wjjd/G/f4XMpnb
        KKRvbBHanJfI9xHwD9CnWCmt1W1gIVdkSxfTbUu8uMllEQ8SuxLNyKsZ4TG3teec/vf7Hz
        80W3+SHaecI50Jxn2XytK8D7REub1EQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-WaxKNU8HNn6PBt5GudJClw-1; Fri, 08 Oct 2021 08:55:48 -0400
X-MC-Unique: WaxKNU8HNn6PBt5GudJClw-1
Received: by mail-wr1-f72.google.com with SMTP id p12-20020adfc38c000000b00160d6a7e293so4767523wrf.18
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 05:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FMmWc8lP0mifWAbwIJadUVhVPm7Gb5Eb+P29xKmImcg=;
        b=PW0JV/reO+td8KBWp7nSLm1Rj3zZkeyUGTPW/dZ9xx8zlD2398E+oOZHyYhCji1ivr
         cmk5JGQb2mvg8v51dUeBQzqXSFOEgt9wT9hanvw5wM5wr1Awv8eJA4hSomZorixxTbue
         WOjrIc2Il3dTYUueAmcTHvKbhGwuTzk4kl6I0nbLCwQaclZtAGeR163h/5aopyU+6jP4
         yiwqdhJmN7dvbbysUS9GfKFX3yu6j2QE85Ql7Ya8Bf5zXCuzhJrAMv2rbEWrvY7lWfHz
         29/bCgA6muw5JsSVDBAdp0LWVB7ham5iBNtagEyDVBDiY4qr/GbVbdFbGQ72VbQ4ZnZf
         9Fbg==
X-Gm-Message-State: AOAM532E0k5l3Q5MBygX+wO3zo5UVL3O5kRwleqUxdDomMDCt+z7z9Dj
        psmWhB7PUyYgB2JJO7K3Chl80Dcufs3iiGyA0zX/+cVq6jo32Y3chkZgRMpcqkTTjsojDL3TekT
        4PkPp+o5NmQKi2/nAyRVPCCXe
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr1822927wmh.63.1633697747235;
        Fri, 08 Oct 2021 05:55:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHJmLzWnslN0Z+MPScYs/aX2KbjkWc8epVby1UyfSSPzG/6fOO7PspP4jDvg5IMfhCG+zbzg==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr1822896wmh.63.1633697746991;
        Fri, 08 Oct 2021 05:55:46 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id k17sm2458539wrq.7.2021.10.08.05.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 05:55:46 -0700 (PDT)
To:     Vlastimil Babka <vbabka@suse.cz>, ultrachin@163.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     brookxu.cn@gmail.com, chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20211008063933.331989-1-ultrachin@163.com>
 <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
 <8f30837b-5186-e836-21bc-9964456400c1@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit time
Message-ID: <0ab1dd42-8869-5b41-3af5-e16a49335df2@redhat.com>
Date:   Fri, 8 Oct 2021 14:55:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8f30837b-5186-e836-21bc-9964456400c1@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.21 14:38, Vlastimil Babka wrote:
> On 10/8/21 10:17, David Hildenbrand wrote:
>> On 08.10.21 08:39, ultrachin@163.com wrote:
>>> From: chen xiaoguang <xiaoggchen@tencent.com>
>>>
>>> The exit time is long when program allocated big memory and
>>> the most time consuming part is free memory which takes 99.9%
>>> of the total exit time. By using async free we can save 25% of
>>> exit time.
>>>
>>> Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
>>> Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
>>> Signed-off-by: lu yihui <yihuilu@tencent.com>
>>
>> I recently discussed with Claudio if it would be possible to tear down the
>> process MM deferred, because for some use cases (secure/encrypted
>> virtualization, very large mmaps) tearing down the page tables is already
>> the much more expensive operation.
> 
> OK, but what exactly is the benefit here? The cpu time will have to be spent
> in any case, but we move it to a context that's not accounted to the exiting
> process. Is that good? Also if it's a large process and restarts
> immediately, allocating all the memory back again, it might not be available
> as it's still being freed in the background, leading to a risk of OOM?

One use case I was told is that if you have a large (secure/encrypted) 
VM and shut it down, it might take quite a long time until you can 
actually start that very VM again, because tooling assumes that the VM 
isn't shut down until the process is gone (closed all files, sockets, etc.).

I also discussed the risk of OOM with Claudio. In some cases, we don't 
care, for example, we could start the VM on a different node in the 
cluster, or there is sufficient memory available to start it on the same 
node. But there was the idea to stop the OOM killer from firing as long 
as there is still some MM getting cleaned up, which would also make 
sense to some degree.

-- 
Thanks,

David / dhildenb

