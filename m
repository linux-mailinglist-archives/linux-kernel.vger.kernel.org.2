Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA642F800
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbhJOQWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236612AbhJOQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634314812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VijdsXGYZXIuQVGhgyd6z4TeUAcY/gniSUxkqB23NkQ=;
        b=ix6JsRp7n6ZhbCi/I7+WIKPwSMNgoU5W3jG53cKqBMiVzK8Dg6F2f4IVzox2zQEXsy0i3p
        K+46Fo01ufa3otdB7fwwlUx8b2Go9vC4VB+Q3C5HzYP1LiHSCNzSe5P/e1/PMN3cujdn9/
        E+fVSP0v+C3tx7T4jdsOL+vcpWBt4gQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-JAyyQZyFMSKmMv4YHKUcPA-1; Fri, 15 Oct 2021 12:20:11 -0400
X-MC-Unique: JAyyQZyFMSKmMv4YHKUcPA-1
Received: by mail-ed1-f70.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so8678875edi.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VijdsXGYZXIuQVGhgyd6z4TeUAcY/gniSUxkqB23NkQ=;
        b=C+yp5+l31xXDaajdFnKPnqUOStUFp9C7/szaivqHSjOaZ1VZav7qDIOSYP65vxLlDg
         McMtlA+WYpnSdFVja+HQkGmPHRy2HFgktEZT3G8I5/WCK7vd8i4iuLtTFT3tRIBp7X5q
         /qg6YPR99e3NQxEv2PiYosWbAM/4BPzG1AwQQ+NhmiRyrSEfdE8mmMpOUoXxO5hvtzgv
         P2XmMxEG3VvfPlK6QN0CXOMA4geaS0UjMZYgJ+Digee6O5QENrLP2j/VPfbnvPACoX2S
         DvMQaqx27zkmcLkl1Wpn3zqWQXnVtODFUiEhW/2g36GDeTY2hhwOJCW0F44KE67mfOhA
         3Xmg==
X-Gm-Message-State: AOAM5301t/MgadKOILj98MHRFAetvlNGk+HJlWz9EO4Gm012PO9SdHEU
        DNWUqtug5Dt4wAV4iiKIrz+U/mspYD+ErsyfEqj/3cZV6n8U7luhwbW3Mkh4Ib/+ba2oApE2IWy
        9U/GRgPqBDM8x/CelGrpZZpjM
X-Received: by 2002:a17:906:3cb:: with SMTP id c11mr8327366eja.404.1634314810263;
        Fri, 15 Oct 2021 09:20:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBVYrr2vS+OzCzI+by6Scd6aT1g7vGP+twnvDDl36AMTUWL47LqIE8yh4nEdeHlJHZYgYWLg==
X-Received: by 2002:a17:906:3cb:: with SMTP id c11mr8327338eja.404.1634314810051;
        Fri, 15 Oct 2021 09:20:10 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id lb12sm4516614ejc.28.2021.10.15.09.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:20:09 -0700 (PDT)
Message-ID: <e69cac02-87e0-e477-46cd-e94cacb1f5dc@redhat.com>
Date:   Fri, 15 Oct 2021 18:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] selftests: KVM: use dirty logging to check if page stats
 work correctly
Content-Language: en-US
To:     Ben Gardon <bgardon@google.com>, Mingwei Zhang <mizhang@google.com>
Cc:     kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Peter Xu <peterx@redhat.com>, Ben Gardon <bgorden@google.com>
References: <20210823051622.312890-1-mizhang@google.com>
 <CANgfPd9RR+a675MgLuyy6g-Ab-4jSHVV+mwxJnwOHCiC6KgAhA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CANgfPd9RR+a675MgLuyy6g-Ab-4jSHVV+mwxJnwOHCiC6KgAhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/21 23:36, Ben Gardon wrote:
>> +#ifdef __x86_64__
>> +       TEST_ASSERT(get_page_stats(X86_PAGE_SIZE_4K) != 0,
>> +                   "4K page is zero");
>> +       if (p->backing_src == VM_MEM_SRC_ANONYMOUS_THP)
>> +               TEST_ASSERT(get_page_stats(X86_PAGE_SIZE_2M) != 0,
>> +                           "2M page is zero");
>> +       if (p->backing_src == VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB)
>> +               TEST_ASSERT(get_page_stats(X86_PAGE_SIZE_1G) != 0,
>> +                           "1G page is zero");
>> +#endif
> This check is correct, but it misses some cases. It'd be worth going
> back to ensure that all relevant backing src types are handled here.
> For example, this misses VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB.
> 
> We could also be more precise by asserting that the counts are at
> least some value or total to some value. THP introduces some flakiness
> but one way or another the mapping counts at this point should total
> up to account for the expected size of guest memory.
> 

I am worried about flakiness here.  I would prefer to have just a check 
that _some_ pagesize is nonzero.

Also even for 1GB hugetlbfs not all processors support gigabyte pages, 
so for those the stat would be 0.

Finally, please use the binary statistics interface, so that the test 
does not require root.

Paolo

