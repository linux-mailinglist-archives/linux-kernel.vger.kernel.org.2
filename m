Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E1C35083C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhCaUa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236546AbhCaUaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617222611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGV1jFbUJjDZ0xr5aZ9Ku/VANnkkq23LGJCjyuxNq8E=;
        b=BAkYxj9PVDU3oSRrpf1lWuoF2M2fEXjYUV13kRaniw2lINrXp5xkswnim4WfMn/dsODCVg
        JrRr7nvXYZEhbmAvqyK8Zryohz2nqnlYG7qWAx6OYjXHt/7zZQKChfOAnzkOQH1U00Zjof
        BB0unRu1E+KvMQvIIFZII+rcIP+Y4GU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-SFmNrliTM1aSmKvTY1ncug-1; Wed, 31 Mar 2021 16:30:10 -0400
X-MC-Unique: SFmNrliTM1aSmKvTY1ncug-1
Received: by mail-ej1-f71.google.com with SMTP id bg7so1332098ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iGV1jFbUJjDZ0xr5aZ9Ku/VANnkkq23LGJCjyuxNq8E=;
        b=WKVf+JS1OVm1tOzJUHbTUMH/CJn9uY1L+OLUty/DPKx7vLPj8bbGf/A4vzFYtkY7Y1
         L053/wzjDn7V03sXWa2WNbICh+BXyn5jn/qIYfHkDBfdYE01gY9m/WzlcfYA1FKVB68e
         aIUEMkMADr54QXmrQ72XD2LfCc8DjntIM63u/qkBts9xsepNAJ+XpCQfEHRNLI48t9+I
         4eR9wfJENZ1nS4A7IyyhoZM078VNa0i1KP3KAUssebnjo2MyQQxN7oNLa7GtvK6Xx94t
         upRWi9YoxOcXEUOBnEk+wWVJonIScg+G5vjfk2a5jBNC6gNNKjJ7qsRQaclWq5C5OoaU
         jsHg==
X-Gm-Message-State: AOAM532cfgHtOK3trjIMcfdsar/HVjc/7ll0VekqtDhHuJFgm3GpzKpJ
        ys0O90aydpGGCoO5uxF4BhJjdgSLNIm576j5OytdhP3h8ubrZstjh5+GG4gS28l6Jfo00qW4SlA
        o3niYbZJq9N66gFsjAGoHcB84
X-Received: by 2002:a17:906:d787:: with SMTP id pj7mr5461252ejb.257.1617222608610;
        Wed, 31 Mar 2021 13:30:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtvybwxaq/xUKBgYLNjG4mX/vnDB42i0fSfVNTPr5tTgAMfXL6m32uLgH+xDN6PSnJCPYqCg==
X-Received: by 2002:a17:906:d787:: with SMTP id pj7mr5461218ejb.257.1617222608403;
        Wed, 31 Mar 2021 13:30:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q10sm2264030eds.67.2021.03.31.13.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 13:30:07 -0700 (PDT)
Subject: Re: [PATCH 16/18] KVM: Don't take mmu_lock for range invalidation
 unless necessary
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
References: <20210326021957.1424875-1-seanjc@google.com>
 <20210326021957.1424875-17-seanjc@google.com>
 <6e7dc7d0-f5dc-85d9-1c50-d23b761b5ff3@redhat.com>
 <YGTYf9sWVIJqqswq@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fdd5bfb1-8abc-7658-b288-dc9943a6e04c@redhat.com>
Date:   Wed, 31 Mar 2021 22:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YGTYf9sWVIJqqswq@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/21 22:15, Sean Christopherson wrote:
> On Wed, Mar 31, 2021, Paolo Bonzini wrote:
>> On 26/03/21 03:19, Sean Christopherson wrote:
>>> +	/*
>>> +	 * Reset the lock used to prevent memslot updates between MMU notifier
>>> +	 * range_start and range_end.  At this point no more MMU notifiers will
>>> +	 * run, but the lock could still be held if KVM's notifier was removed
>>> +	 * between range_start and range_end.  No threads can be waiting on the
>>> +	 * lock as the last reference on KVM has been dropped.  If the lock is
>>> +	 * still held, freeing memslots will deadlock.
>>> +	 */
>>> +	init_rwsem(&kvm->mmu_notifier_slots_lock);
>>
>> I was going to say that this is nasty, then I noticed that
>> mmu_notifier_unregister uses SRCU to ensure completion of concurrent calls
>> to the MMU notifier.  So I guess it's fine, but it's better to point it out:
>>
>> 	/*
>> 	 * At this point no more MMU notifiers will run and pending
>> 	 * calls to range_start have completed, but the lock would
>> 	 * still be held and never released if the MMU notifier was
>> 	 * removed between range_start and range_end.  Since the last
>> 	 * reference to the struct kvm has been dropped, no threads can
>> 	 * be waiting on the lock, but we might still end up taking it
>> 	 * when freeing memslots in kvm_arch_destroy_vm.  Reset the lock
>> 	 * to avoid deadlocks.
>> 	 */
> 
> An alternative would be to not take the lock in install_new_memslots() if
> kvm->users_count == 0.  It'd be weirder to document, and the conditional locking
> would still be quite ugly.  Not sure if that's better than blasting a lock
> during destruction?

No, that's worse...

Paolo

