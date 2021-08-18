Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F8E3EFF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhHRIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238500AbhHRIpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629276277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9LtWbaLwq6kJjM9ZOZwycFMBsFtGptd3p5wovzjNweE=;
        b=ZJu2BdqGbedwRHvFmmE18mwqLjNTJtjiMXwo0V4E5cYRAA1qOIsDS+oyvGTQriGjrNUmuv
        G2kPzAa5GSeHJsiFaSbnJzoBvT7kMErpAvn89ewvtKqD4ZqHTMNkkUWE2cA1yZIy3IWZJp
        EWmaVuP+NSp9Sy2yYiVbMR9p8cJvoR8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-6bWBhUjCO_qi0-klC_6Zlg-1; Wed, 18 Aug 2021 04:44:36 -0400
X-MC-Unique: 6bWBhUjCO_qi0-klC_6Zlg-1
Received: by mail-wm1-f72.google.com with SMTP id z186-20020a1c7ec30000b02902e6a27a9962so1992668wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9LtWbaLwq6kJjM9ZOZwycFMBsFtGptd3p5wovzjNweE=;
        b=CijGgKBnM0FRog4nMXkkDdZ24FffErg0jtjOvkyGU8AVQRm2jndHc66uKbpQHageoH
         9k1Ivku7Vf0ocsrGV65V+rPfQL/SHQ51ZGRGRUCzfQ5L/u6oZQF3MCTvAQP720K3mnZJ
         UkJ+/7PlLbARy9JoErCHrHdIpcc0Y9daCx033D14RUkMKMrNTMWYPGHl5NuPpCYfQzFO
         9OfgIAIpSPud5TL2CfRqVP13JYp16gjo85j85BNaAoIpcw+nr3GW4hWh4kI3FZnwM0k2
         8+riNaqsH/d1EpdxSBJP5CtCDK22L4wvmNuJdlvHH5TfyH0VOdG11QN+kgyBJ1QrXjfb
         7goA==
X-Gm-Message-State: AOAM5301wDtRGi2Z0/9Ng/eSEatB1rrPn9HbRYjIkcJbfNsEl9zKxy0+
        qtvG0iddMa9kh1iQ9SbfHyXMy9U+rCF69Lb1Dd9Y0XbvVFgejQsEuhIeYuxYvtYPEWdMMiHffzN
        WO3z07z8LQkHk5tcfpokmsPteiGiAk9rFaXE41Ax01wYZTdobnGqbOVAcTSyZApSh6tvgc8nq
X-Received: by 2002:a5d:4447:: with SMTP id x7mr9712626wrr.198.1629276275517;
        Wed, 18 Aug 2021 01:44:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/D+WUy8PsPz3S65vrEk1dvRI5wYhxcrZuVh6VwHswDCxOH96ASRcWtuHLW1Yfs9Ecc7X0nA==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr9712609wrr.198.1629276275340;
        Wed, 18 Aug 2021 01:44:35 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6417.dip0.t-ipconnect.de. [91.12.100.23])
        by smtp.gmail.com with ESMTPSA id n188sm3452655wmn.48.2021.08.18.01.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:44:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: s390: gaccess: Cleanup access to guest frames
To:     Janosch Frank <frankja@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        kvm@vger.kernel.org, borntraeger@de.ibm.com,
        imbrenda@linux.ibm.com, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     cohuck@redhat.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210816150718.3063877-1-scgl@linux.ibm.com>
 <20210816150718.3063877-2-scgl@linux.ibm.com>
 <d11128bb-18f6-5210-6f42-74a89d8edcf7@redhat.com>
 <584ca757-4eb4-491e-a4cd-7bc60fb04b61@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0c800ed3-cc60-9c13-c0a7-8ba302365ccb@redhat.com>
Date:   Wed, 18 Aug 2021 10:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <584ca757-4eb4-491e-a4cd-7bc60fb04b61@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.21 10:06, Janosch Frank wrote:
> On 8/18/21 9:54 AM, David Hildenbrand wrote:
>> On 16.08.21 17:07, Janis Schoetterl-Glausch wrote:
>>> Introduce a helper function for guest frame access.
>>> Rewrite the calculation of the gpa and the length of the segment
>>> to be more readable.
>>>
>>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> [...]
>>> -	unsigned long _len, gpa;
>>> +	unsigned long gpa;
>>> +	unsigned int seg;
>>>    	int rc = 0;
>>>    
>>>    	while (len && !rc) {
>>>    		gpa = kvm_s390_real_to_abs(vcpu, gra);
>>> -		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
>>> -		if (mode)
>>> -			rc = write_guest_abs(vcpu, gpa, data, _len);
>>> -		else
>>> -			rc = read_guest_abs(vcpu, gpa, data, _len);
>>> -		len -= _len;
>>> -		gra += _len;
>>> -		data += _len;
>>> +		seg = min(PAGE_SIZE - offset_in_page(gpa), len);
>>
>> What does "seg" mean? I certainly know when "len" means -- which is also
>> what the function eats.
> 
> What does "_len" mean especially in contrast to "len"?
> 
> "seg" is used in the common kvm guest access functions so it's at least
> consistent although I share the sentiment that it's not a great name for
> the length we access inside the page.
> 
> Originally I suggested "len_in_page" if you have a better name I'd
> expect we'll both be happy to discuss it :-)

Similar code I encountered in other places uses "len" vs "cur_len" or 
"total_len" vs. "cur_len". I agree that everything is better than "len" 
vs. "_len".

I just cannot come up with a proper word for "seg" that would make 
sense. "Segment" ? Maybe my uneducated mind is missing some important 
English words that just fit perfectly here.

Anyhow, just my 2 cents, you maintain this code :)

-- 
Thanks,

David / dhildenb

