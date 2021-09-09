Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F289140476B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhIII6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232065AbhIII6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631177818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Liyit1fZs4HtPW9fq/QHYKo0y2hDYRFoca/MDgNxk68=;
        b=amLvhMej1yhmZ57Kq73+CumsUbH3qhgTw4O7+oEyDyfd9OnU+rPJm+5laz9S4QR0bG1I/K
        fyTrhD3r5EDvRJ0XZiYBtehrkbd10NfPb66j1XUfBPkhicpWkk/U8rfgbrofFjyo5J8TLB
        0884Zme8p0n/JzO2SWBqSFPfYF81kQk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-7qObJ9nzOYCJwnLcjJbtag-1; Thu, 09 Sep 2021 04:56:57 -0400
X-MC-Unique: 7qObJ9nzOYCJwnLcjJbtag-1
Received: by mail-wm1-f70.google.com with SMTP id w25-20020a1cf6190000b0290252505ddd56so504153wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 01:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Liyit1fZs4HtPW9fq/QHYKo0y2hDYRFoca/MDgNxk68=;
        b=kKqNJIdyeGHNvBC1dQN5oib9UE0YVCmVOoshd/UN+ejBqqe456d2J56VJ9fK3bA/Z3
         7U3oltcxSLz1sIURs7UyWR2a55NCeeSgJItdjcDMLKVCKshl5jSGGUabGPlsN8m+OtfZ
         78hQ0Yhj+wFkY37HIg2sQaL+MBEgSrARx11/zd9p6XyXh6+3fVT3c3CQCDXBXnzOxtZ1
         jT/L8hGQr548TWaWlr+6WQmEWCZVAP0ahge6nLKfdmiQ8Q1rPLbWPCmxuuxiGPHhA4lD
         N++01aKtDFhhe/IabZzSzQ9OOuqbZgeUZKETOTpN9vcEvsnrZTtKRCKuHzIKcj/hkk5k
         +q3w==
X-Gm-Message-State: AOAM530AlpxXqRxH94s7YKkgrD/zoRefuE14snhwST8HQS0eh/mir7rg
        mzSSb/0WfAWmEduY5ZHftQis9enIu/xFiS9OSoFEb+ftHaXr98KyoA9fMOhQuz0e5hZIyzw5SMB
        D4kAwEVSX2VL6LtR0zpPFra+yVmTAmAxRnuYcZl5dwt9lJPOqHExws+hUyAxjLnTiVbORhhmW
X-Received: by 2002:a7b:c959:: with SMTP id i25mr1785619wml.55.1631177816678;
        Thu, 09 Sep 2021 01:56:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIKTQh8R6XWF4427CqE/HyWw/W0UYpYxbC/9ygvsBIHbeLbAGS5T8tINP+A29RFg+mzToWrA==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr1785595wml.55.1631177816408;
        Thu, 09 Sep 2021 01:56:56 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23fe4.dip0.t-ipconnect.de. [79.242.63.228])
        by smtp.gmail.com with ESMTPSA id n20sm904818wms.15.2021.09.09.01.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 01:56:55 -0700 (PDT)
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
To:     John Hubbard <jhubbard@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
 <2d06db75-5c26-8fe2-6883-ac99056a9894@redhat.com>
 <b0a2947b-360a-40c2-03e4-f0f67845f4c3@huawei.com>
 <c60dc5e2-6f19-3be8-56be-555033cc9ca4@redhat.com>
 <b4615b3c-8217-9f32-39c7-b91c9ec3cccb@suse.cz>
 <80cfffdc-227e-c045-be74-1c08fb62c1e3@redhat.com>
 <febcceaa-7d94-c3a3-c683-7a8694981b47@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <efdab0d6-199a-1bb8-79bf-ea0a5b94c093@redhat.com>
Date:   Thu, 9 Sep 2021 10:56:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <febcceaa-7d94-c3a3-c683-7a8694981b47@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.21 00:42, John Hubbard wrote:
> On 9/7/21 2:56 AM, David Hildenbrand wrote:
> ...
>>> If this can be handled gracefully, then I'd rather go with VM_WARN_ON.
>>> Maybe even WARN_ON_ONCE?
>>>
>>
>> I think either VM_BUG_ON() or VM_WARN_ON() -- compiling the runtime checks out -- should be good
>> enough.
>>
>> I'd just go with VM_BUG_ON(), because anybody messing with __isolate_free_page() should clearly spot
>> that we expect the current handling. But no strong opinion.
>>
> 
> If in doubt, WARN*() should be preferred over BUG*(). There's a pretty long
> history of "don't kill the machine unless you have to" emails about this, let
> me dig up one...OK, maybe not the best example, but the tip of the iceberg:

Please note the subtle difference between BUG_ON and VM_BUG_ON. We 
expect VM_BUG_ON to be compiled out on any production system. So it's 
really only a mean to identify things that really shouldn't be like that 
during debugging/testing.

Using WARN... instead of VM_BUG_ON is even worse for production systems. 
There are distros that set panic_on_warn, essentially converting WARN... 
into BUG...

-- 
Thanks,

David / dhildenb

