Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517C341C338
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbhI2LQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244822AbhI2LQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632914099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2UrR9+JDqwWAsQd7w1tOuz2e1wwJuSgcE9XEn53di/k=;
        b=GBe/Dibw0RIr6rU/DlVnH0F2dtnVJykjOntR4TY/aHI7wHR111OhA51MO3A72WIy+AmTeS
        daunoAmW/3ZAiNkVM6GQ9z7W2gAlVerOc6qRwVneWy3Bs1BHTFUlRMZt9iUYEqzEVac3xn
        mkla82Cs6yKW7GEQobZiM0eD9OHOF6Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-o3l8x4FoMEaoHGXUqvK7nw-1; Wed, 29 Sep 2021 07:14:57 -0400
X-MC-Unique: o3l8x4FoMEaoHGXUqvK7nw-1
Received: by mail-ed1-f72.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so2021055edi.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2UrR9+JDqwWAsQd7w1tOuz2e1wwJuSgcE9XEn53di/k=;
        b=hwUj4le7HG0Nap9ZVrREUR17lAYI5EhmIqxWbXsG6pEsbYPdV36c7r3sQVU0iaJAo6
         Opf0yLjjAVmViPi1UaCMqoUizbOahAt2rKIaItdRW260+/3+Oh1IVs53YirG8b84toOP
         YaMNNeCPq82LeghsE0c9rJuM6bFo3S5lUK4poywFjtKEq3XByP61I8suVPERVSy9cFgs
         t4n+ZtLtlcmBi/pvSvytYlnIl1jVELzSiXr1otWz9tyXS+NYsO+CX317o/MxTrXmvMvM
         Bp3ds5zI/2zUj0po0ZGQNqWNYJVh1fgJQekaVZe+qB0r3i3QtrFJ8GVcweCPIKgGpyy3
         3Dmg==
X-Gm-Message-State: AOAM532iX2gfYmiK6kXGGFLjpVB9zIMdZhouuesiVmzlj0iol9dLNb3z
        Nx0ABL52envEvunR7MQOHikXqCj2rBumhA2RcDmW9XuAAE40kxtuJ3KOOp+HAMN6nk2FYARb3ww
        +A69mmk3gKflPTwIKzipGkj86
X-Received: by 2002:a17:906:1198:: with SMTP id n24mr12815327eja.283.1632914096706;
        Wed, 29 Sep 2021 04:14:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynOCOkbL8ct1lIbFw71fO2P4GWkiUfjndIh7vD+uTq+8+C90XT21b1UbIRdt9nin8epHd/CA==
X-Received: by 2002:a17:906:1198:: with SMTP id n24mr12815311eja.283.1632914096544;
        Wed, 29 Sep 2021 04:14:56 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d22sm1245820ejk.5.2021.09.29.04.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 04:14:56 -0700 (PDT)
Message-ID: <eb14c183-ef60-2e3b-839b-617ed39a5eea@redhat.com>
Date:   Wed, 29 Sep 2021 13:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 31/31] KVM: MMU: make spte an in-out argument in
 make_spte
Content-Language: en-US
To:     David Matlack <dmatlack@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com
References: <20210924163152.289027-1-pbonzini@redhat.com>
 <20210924163152.289027-32-pbonzini@redhat.com> <YVOjSSahzJ/tf28g@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YVOjSSahzJ/tf28g@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/21 01:20, David Matlack wrote:
>>   bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>>   	       struct kvm_memory_slot *slot,
>>   	       unsigned int pte_access, gfn_t gfn, kvm_pfn_t pfn,
>> -	       u64 old_spte, bool speculative, bool can_unsync,
>> -	       bool host_writable, u64 *new_spte)
>> +	       bool speculative, bool can_unsync,
>> +	       bool host_writable, u64 *sptep)
> I'd prefer a different name since `sptep` has specific meaning
> throughout the mmu code. (It's the address of the spte in the page
> table.)
> 
> Case in point, I was going to suggest we can get rid of struct
> kvm_mmu_page since it can be derived from the sptep and then realized
> how wrong that was:).
> 
> Instead of receiving the new spte as a parameter what do you think about
> changing make_spte to return the new spte? I think that would make the
> code more readable (but won't reduce the number of arguments because
> you'd have to add wrprot).
> 

You have a point.  I've dropped this patch for now.

Paolo

