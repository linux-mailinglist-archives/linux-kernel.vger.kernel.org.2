Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3A64047DD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhIIJik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhIIJij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631180249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hnkexf1NKYb40g+6TkQdOP3IQclUoy40kRSjUx+uIvA=;
        b=hQIfrsI707PfLetJIqESt7B5r96kcs3fDPhtXTkb0s6rZgtVXTwq0lm4sDa6Uw4z5Qipr9
        PE1yxiVJVMreiVmaF/Xzpma2+M4WZyzSQN81PPwr58AW4PIo12NoOM8Cu/fEOoeYGOX9lS
        sqQsrN+WZK0CMjSTxotWPPNKlGRH8p4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-cRhcgTiDOgeIEhDWCVB4YQ-1; Thu, 09 Sep 2021 05:37:28 -0400
X-MC-Unique: cRhcgTiDOgeIEhDWCVB4YQ-1
Received: by mail-wr1-f71.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so319306wrn.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 02:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hnkexf1NKYb40g+6TkQdOP3IQclUoy40kRSjUx+uIvA=;
        b=JRCOWWhKmIV4SwRH12FPiWFAMY+EzIRnnKN5j8AIhDb84GwpcSsuEHZmzBLAqDuMI1
         MdH9cO5AzfyuwJMmLuEDavfvjAEk2Pc3MHJQKl2aE4wDxZIdCbRO859AE6ZWZE+Ln4fr
         0X5npaB9qZbSRhW+XP1kmkjpincAY/sdF37ZjWOEOFdpycQtWaHX6dSwTVIt9G9Hh++O
         uuMCFkRi0PZM7tU78JdQvaGPKLeEGThnGslpWlZpfMSu3et7GfNn+e/P1Y6wi9NdwMQh
         kk/JZBelrwY3arhwbpnLD0rdNaBp9ynbJXGRJ82HoBK1aDyg6KzIjiQihsfV41JFK97v
         u1TA==
X-Gm-Message-State: AOAM531YW3bSFPpPpi2BKqHbUMdigy1HdyhOzT+oTIfuB2UpBX20wPJL
        j7L54+nhJJoLf4Yi1BJw4fMogfXeRjMjG1GLXRJaPLDwtX3iOzqTjkyiKNwZ1srejEj0R0CMU8y
        JBhNESH2iGHYaZ1qqXp8tRmvAmxm3AqW/TpOOo8jtISPy10bRYtEFWIt338FrGR8yGqJfyvwK
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr2391662wrw.415.1631180247669;
        Thu, 09 Sep 2021 02:37:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyw9mD23GM/fVmSY5IxO44E1JTTn0UPY3nvEIN2Je0FgRPEhyt+8enfuilutzpX3DJ5JoacDg==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr2391637wrw.415.1631180247410;
        Thu, 09 Sep 2021 02:37:27 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23fe4.dip0.t-ipconnect.de. [79.242.63.228])
        by smtp.gmail.com with ESMTPSA id a10sm1250078wrd.51.2021.09.09.02.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 02:37:26 -0700 (PDT)
To:     Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
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
 <efdab0d6-199a-1bb8-79bf-ea0a5b94c093@redhat.com>
 <f9cc811d-2932-845d-da0e-eea493981d11@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
Message-ID: <924b4672-0e52-56fb-22a9-b02d8c3ecccf@redhat.com>
Date:   Thu, 9 Sep 2021 11:37:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f9cc811d-2932-845d-da0e-eea493981d11@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.21 11:07, Vlastimil Babka wrote:
> On 9/9/21 10:56, David Hildenbrand wrote:
>> On 09.09.21 00:42, John Hubbard wrote:
>>> On 9/7/21 2:56 AM, David Hildenbrand wrote:
>>> ...
>>>>> If this can be handled gracefully, then I'd rather go with VM_WARN_ON.
>>>>> Maybe even WARN_ON_ONCE?
>>>>>
>>>>
>>>> I think either VM_BUG_ON() or VM_WARN_ON() -- compiling the runtime
>>>> checks out -- should be good
>>>> enough.
>>>>
>>>> I'd just go with VM_BUG_ON(), because anybody messing with
>>>> __isolate_free_page() should clearly spot
>>>> that we expect the current handling. But no strong opinion.
>>>>
>>>
>>> If in doubt, WARN*() should be preferred over BUG*(). There's a pretty long
>>> history of "don't kill the machine unless you have to" emails about this, let
>>> me dig up one...OK, maybe not the best example, but the tip of the iceberg:
>>
>> Please note the subtle difference between BUG_ON and VM_BUG_ON. We expect
>> VM_BUG_ON to be compiled out on any production system. So it's really only a
>> mean to identify things that really shouldn't be like that during
>> debugging/testing.
> 
> IIRC Fedora used to have CONFIG_DEBUG_VM enabled, did it change?

Excellent question. Apparently you are right. Fortunately it's not a 
distro to use in production ;)

In kernel-ark:

redhat/configs/fedora/generic/CONFIG_DEBUG_VM:CONFIG_DEBUG_VM=y

While for ARK (rhel-next so to say)

redhat/configs/ark/generic/CONFIG_DEBUG_VM:# CONFIG_DEBUG_VM is not set

So yes, the VM_WARN_ON would then be preferred in that case. But it's 
something that should never ever happen unless reviewers and developers 
really mess up, so I don't actually would sleep over that. We have other 
WARN... that can trigger more easily.

> 
>> Using WARN... instead of VM_BUG_ON is even worse for production systems.
>> There are distros that set panic_on_warn, essentially converting WARN...
>> into BUG...
> 
> Uh, does any distro really do that?

Apparently, so I was told by Greg a year ago or so when wanting to add 
WARN_ON(). The advisory is to us pr_warn_once() instead. I rememebr it 
was a debian based distro.



-- 
Thanks,

David / dhildenb

