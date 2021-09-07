Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F233402696
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbhIGJ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235095AbhIGJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631008584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZix3g89yH38VBI/+aNMJk3dvjLYvV1IblN/1ztVbHc=;
        b=ShaiAbl4NSGRmZ1qwrKJy5F2bW0Tkzh7C96YClu/bRqDnoyT+rBEnQTmpZGbkb6u8yaFHi
        ds1mE5CxBUXM/29uw/mRrnFmrIgo3kORCR0nEtZNZWOfy82Dcz85Bbtyqq2tkEa6JIIoyW
        0RzIIK9qHq6HK8JChcv0UbwiTn332wk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-xHDr36jhOuyVn0zG6X5GOg-1; Tue, 07 Sep 2021 05:56:23 -0400
X-MC-Unique: xHDr36jhOuyVn0zG6X5GOg-1
Received: by mail-wr1-f69.google.com with SMTP id d10-20020adffbca000000b00157bc86d94eso1924516wrs.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 02:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WZix3g89yH38VBI/+aNMJk3dvjLYvV1IblN/1ztVbHc=;
        b=jOs8S4VbK0uR1YvGR1sKy4tIpCw8xYA7vw81CxXdCLxTUXgq/YGcQXFGtsQ4Z/f3Rf
         8azwfGoJNQit6s4EX5YdAZmXAMak5Oo5CCP0dqsd54Z4K1f9y9rhcBYYu8tp8EPgpBsy
         ba5ibN4l/ugiuv4T3vGoWWkJ5BViVHqVK5+ZwxJZR556Fs+boF3ptcpzxNPFOEjShy8n
         r7c67geNXGWDdweCqUDtiMJcAxmvVtxKPZ/9I3zxmVdYqxSmE7+7+qoiBObK7TH0Z9o8
         W9NjuP0RTbx1H2pymDNZH4neMpsksUJvfE9HPBzph/W63z5nj+f1UadHRI2LFNQtN8dc
         xcYw==
X-Gm-Message-State: AOAM531kqKMFv8tx4kFN52okcKz9kbRWO6dr7lcsEDU44AYMRfglmFW7
        tgjctjKCm1AHuXQ7k3QUoynTQI5SiqNPzQA8kgNKxD8dMwJNCiJ1v3pms9GEzQv187lDaphPkUy
        SVF8Vx2ijyDXLUAiLXb0x9wc/ka6m3q9+8Lyh9QMRfMQK24vxjzW7CDBpD2TxOYJT/4FsUroo
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr3105730wmk.180.1631008582393;
        Tue, 07 Sep 2021 02:56:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwvf9pfG2k28UQz3mTfSELrqKrfnBOyxpBncA+3AC0xy5VsgXwaFkm8y5VTwZ7gkbGJY19tA==
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr3105693wmk.180.1631008581995;
        Tue, 07 Sep 2021 02:56:21 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23fca.dip0.t-ipconnect.de. [79.242.63.202])
        by smtp.gmail.com with ESMTPSA id v62sm1886533wme.21.2021.09.07.02.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 02:56:21 -0700 (PDT)
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
To:     Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
 <2d06db75-5c26-8fe2-6883-ac99056a9894@redhat.com>
 <b0a2947b-360a-40c2-03e4-f0f67845f4c3@huawei.com>
 <c60dc5e2-6f19-3be8-56be-555033cc9ca4@redhat.com>
 <b4615b3c-8217-9f32-39c7-b91c9ec3cccb@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <80cfffdc-227e-c045-be74-1c08fb62c1e3@redhat.com>
Date:   Tue, 7 Sep 2021 11:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b4615b3c-8217-9f32-39c7-b91c9ec3cccb@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.21 10:08, Vlastimil Babka wrote:
> On 9/6/21 14:49, David Hildenbrand wrote:
>> On 06.09.21 14:45, Miaohe Lin wrote:
>>> On 2021/9/6 20:11, David Hildenbrand wrote:
>>>> On 06.09.21 14:02, David Hildenbrand wrote:
>>>>> On 04.09.21 11:18, Miaohe Lin wrote:
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>>>
>>>>
>>>> To make the confusion perfect (sorry) :D I tripple-checked:
>>>>
>>>> In unset_migratetype_isolate() we check that is_migrate_isolate_page(page) holds, otherwise we return.
>>>>
>>>> We call __isolate_free_page() only for such pages.
>>>>
>>>> __isolate_free_page() won't perform watermark checks on is_migrate_isolate().
>>>>
>>>> Consequently, __isolate_free_page() should never fail when called from unset_migratetype_isolate()
>>>>
>>>> If that's correct then we  could instead maybe add a VM_BUG_ON() and a comment why this can't fail.
>>>>
>>>>
>>>> Makes sense or am I missing something?
>>>
>>> I think you're right. __isolate_free_page() should never fail when called from unset_migratetype_isolate()
>>> as explained by you. But it might be too fragile to reply on the failure conditions of __isolate_free_page().
>>> If that changes, VM_BUG_ON() here might trigger unexpectedly. Or am I just over-worried as failure conditions
>>> of __isolate_free_page() can hardly change?
>>
>> Maybe
>>
>> isolated_page = !!__isolate_free_page(page, order);
>> /*
>>    * Isolating a free page in an isolated pageblock is expected to always
>>    * work as watermarks don't apply here.
>>    */
>> VM_BUG_ON(isolated_page);
>>
>>
>> VM_BUG_ON() allows us to detect any issues when testing. Combined with
>> the comment it tells everybody messing with __isolate_free_page() what
>> we expect in this function.
>>
>> In production system, we would handle it gracefully.
> 
> If this can be handled gracefully, then I'd rather go with VM_WARN_ON.
> Maybe even WARN_ON_ONCE?
> 

I think either VM_BUG_ON() or VM_WARN_ON() -- compiling the runtime 
checks out -- should be good enough.

I'd just go with VM_BUG_ON(), because anybody messing with 
__isolate_free_page() should clearly spot that we expect the current 
handling. But no strong opinion.

-- 
Thanks,

David / dhildenb

