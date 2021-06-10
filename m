Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0934E3A2F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhFJPdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231625AbhFJPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623339110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ejIcZ8d5xgOmkEkmdVu8bslcTPC2PG7HhmoLIKG7Ig=;
        b=ZeMvd3mSf8OgbmKRNoz9UD0Kt/MGwArrQXiXVVneX7h/Tx5JXcvEWmAT0LXiTptguRj/1/
        ITqOn5G4A+qNhhVUQAf0jfkpvb1sdntr5ZN2z0pQKqff7ig0C8UMt0iNeZCpWPLLBHHZ7n
        G2CGbR2f5fXtFQ57jUoI+4bby2WjBEM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-RNBsKMOtOHii01tUhh6Z2Q-1; Thu, 10 Jun 2021 11:31:49 -0400
X-MC-Unique: RNBsKMOtOHii01tUhh6Z2Q-1
Received: by mail-wr1-f71.google.com with SMTP id d5-20020a0560001865b0290119bba6e1c7so1030675wri.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ejIcZ8d5xgOmkEkmdVu8bslcTPC2PG7HhmoLIKG7Ig=;
        b=b5di66xXFy84HAUeF94MnXUkAgHoE5GurdlK1wCry3I1mSFTvpdITYwvkReqoCjtQI
         YIukWZ7YHpzAoaAMNsvsDL2CujE8yiWBAh/D4in08+w4lUMdLmFYGcDXRITNIoFXX3CD
         Qv7OLp1cdfhj2Oxo3460ENV/yCUM0czFI3xrR720blZBljrEZMtGNgbA96dCEDNcFiS4
         HrfHuW9gpjTcm5ycF8/UpDi5BwdmZk4cJrQND2umnU3RqbL94DyMzwZQHF7UIqmBREZ+
         zfn97jW+nIGj7yfvIxlxz5AYtoCRWpslDZAc20IOzZxg0VPI6/YKTJ8S4m5aOr/7pURU
         kmMg==
X-Gm-Message-State: AOAM533+Zkxvqr9Vp0z+22q13FirktGTvsLCGa4Ey28woJMZg7XwoVJV
        b8H//VEOsVATKQqrARG13ZhcwjhiL6yggGEANJRGRA3VLLk6wVTYCUJOYEqrJ7+zDsD9f4ijEEl
        J6g6LdRCSVjGwQUCuBDJt0cCg
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr11603253wmh.101.1623339108043;
        Thu, 10 Jun 2021 08:31:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfyDWlbcUS4cHDkBjouUKwwgaqOQDkkyG6DbzCOWk22Yp81Al+gQru6bh2DqAPDQVKBDiyxQ==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr11603240wmh.101.1623339107875;
        Thu, 10 Jun 2021 08:31:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id o18sm9890566wmh.38.2021.06.10.08.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:31:47 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] KVM: nVMX: Fixes for nested state migration when
 eVMCS is in use
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210526132026.270394-1-vkuznets@redhat.com>
 <87mtrxyer2.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <31df7026-9500-a802-b23c-4f2233f120d5@redhat.com>
Date:   Thu, 10 Jun 2021 17:31:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87mtrxyer2.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/21 16:29, Vitaly Kuznetsov wrote:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> 
>> Changes since v2:
>> - 'KVM: nVMX: Use '-1' in 'hv_evmcs_vmptr' to indicate that eVMCS is not in
>>   use'/ 'KVM: nVMX: Introduce 'EVMPTR_MAP_PENDING' post-migration state'
>>   patches instead of 'KVM: nVMX: Introduce nested_evmcs_is_used()' [Paolo]
>> - 'KVM: nVMX: Don't set 'dirty_vmcs12' flag on enlightened VMPTRLD' patch
>>   added [Max]
>> - 'KVM: nVMX: Release eVMCS when enlightened VMENTRY was disabled' patch
>>    added.
>> - 'KVM: nVMX: Make copy_vmcs12_to_enlightened()/copy_enlightened_to_vmcs12()
>>   return 'void'' patch added [Paolo]
>> - R-b tags added [Max]
>>
>> Original description:
>>
>> Commit f5c7e8425f18 ("KVM: nVMX: Always make an attempt to map eVMCS after
>> migration") fixed the most obvious reason why Hyper-V on KVM (e.g. Win10
>>   + WSL2) was crashing immediately after migration. It was also reported
>> that we have more issues to fix as, while the failure rate was lowered
>> signifincatly, it was still possible to observe crashes after several
>> dozens of migration. Turns out, the issue arises when we manage to issue
>> KVM_GET_NESTED_STATE right after L2->L2 VMEXIT but before L1 gets a chance
>> to run. This state is tracked with 'need_vmcs12_to_shadow_sync' flag but
>> the flag itself is not part of saved nested state. A few other less
>> significant issues are fixed along the way.
>>
>> While there's no proof this series fixes all eVMCS related problems,
>> Win10+WSL2 was able to survive 3333 (thanks, Max!) migrations without
>> crashing in testing.
>>
>> Patches are based on the current kvm/next tree.
> 
> Paolo, Max,
> 
> Just to double-check: are we good here? I know there are more
> improvements/ideas to explore but I'd like to treat this patchset as a
> set of fixes, it would be unfortunate if we miss 5.14.
> 

Yes, I was busy the last couple of weeks but I am back now.

Paolo

