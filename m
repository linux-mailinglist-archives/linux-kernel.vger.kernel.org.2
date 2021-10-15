Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42B42FA8E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbhJORxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237670AbhJORw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634320251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsfQJ+QgzOOfLaCjggWbwpgeV1kvleQ7Jz1X1qSYym0=;
        b=ARo7Xu3iYD7fUu+qfdP2c5UwSgLB7o/hVB6t3/qKXu1tvLVakHl/jTE1t2r3mdSGIL2gO+
        AoMRF7DDOp3KOmFyBwRhBdoCEGYEiE9v7ZyxKBC7270wc0dbZnw3cH4EIpA9TLD16vbBzZ
        Ok2Fcn+tLaqdCMRO8nQiE3cWfqj32UM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-alzmxp_zNRu8UwJAACQm1g-1; Fri, 15 Oct 2021 13:50:50 -0400
X-MC-Unique: alzmxp_zNRu8UwJAACQm1g-1
Received: by mail-ed1-f71.google.com with SMTP id f4-20020a50e084000000b003db585bc274so8886193edl.17
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TsfQJ+QgzOOfLaCjggWbwpgeV1kvleQ7Jz1X1qSYym0=;
        b=MBYnWb3YIIKS4mApXYLm1e0TBbXUTE2/Azy04KBt3JfdkorX3suT0K37g61BZencDL
         2fWjtdG5y6XM1zJQQrI92pCzU0J96NrdkCFvM4gLmhrWJIISCIbV2f43sib/xr+bTHE5
         PxQA7WMLbStGrWMQYbTnRwilJw0QKTMka7U2ZIgQfss5b3e5G0elv6Q4mnsFOLX1v4wQ
         XQMF5O7oV4GO5gufeuwGyN8UupR2qLXu22nSCXOuwMptZjtSk5DERHCDEBGXU8wmiGBA
         lAfRAYKQvjhjYCyv5NfhpFECGELTfxRW5HMXaqtWb/gO1yF+1Sj4JrMQligMnKVBOBSj
         0GKw==
X-Gm-Message-State: AOAM531/44Ighlpt5NjVUpxp8JWOylRL70dubGwb2IMokJUq/iB+apZM
        OgqHsPkIIIVkD6bXpuBhKdx3/NatTM7YigFlMcRlr7+UwJBlmVcps8TsVLMXoV2SAbj/Is8vu6i
        MWMAQCpWq/s1pG0d3rFcg0Ls4
X-Received: by 2002:a17:906:abd3:: with SMTP id kq19mr8652278ejb.285.1634320248920;
        Fri, 15 Oct 2021 10:50:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlvUF01PAH9b4uRCsZicwTcvW53v52vttAUA9z7TDvslDRI455Y9rszntyFoG5LxAZ43rs5w==
X-Received: by 2002:a17:906:abd3:: with SMTP id kq19mr8652246ejb.285.1634320248691;
        Fri, 15 Oct 2021 10:50:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y21sm4572949ejk.30.2021.10.15.10.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 10:50:48 -0700 (PDT)
Message-ID: <b148def5-9d34-bfa7-db6e-afaf11728639@redhat.com>
Date:   Fri, 15 Oct 2021 19:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/2] KVM: x86: Fix and cleanup for recent AVIC changes
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211009010135.4031460-1-seanjc@google.com>
 <9e9e91149ab4fa114543b69eaf493f84d2f33ce2.camel@redhat.com>
 <YWRJwZF1toUuyBdC@google.com> <YWRtHmAUaKcbWEzH@google.com>
 <ebf038b7b242dd19aba1e4adb6f4ef2701c53748.camel@redhat.com>
 <YWmpKTk/7MOCzm15@google.com>
 <5faa7e49-9eb6-a075-982a-aa7947a5a3d6@redhat.com>
 <YWmt/A4pemf2050j@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YWmt/A4pemf2050j@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/21 18:36, Sean Christopherson wrote:
>> Installing a SPTE based on global state is weird because this is a vCPU
>> action; installing it based on vCPU state is weird because it is knowingly
>> out of date.
> If that's the argument, then kvm_faultin_page() should explicitly check for a
> pending KVM_REQ_APICV_UPDATE, because I would then argue that contuining on when
> KVM_knows_  its new SPTE will either get zapped (page fault wins the race) or
> will get rejected (kvm_zap_gfn_range() wins the race) is just as wrong.  The SPTE
> _cannot_  be used even if the page fault wins the race, becuase all vCPUs need to
> process KVM_REQ_APICV_UPDATE and thus will be blocked until the initiating vCPU
> zaps the range and drops the APICv lock.

Right, that was my counter-argument - no need to check for the request 
because the request "synchronizes" with the actual use of the PTE, via 
kvm_make_all_cpus_request + kvm_zap_gfn_range.

> And I personally do_not_  want to add a check for the request because it implies
> the check is sufficient, which it is not, because the page fault doesn't yet hold
> mmu_lock.

Of course, that would be even worse.

> Since all answers are some form of wrong, IMO we should at least be coherent with
> respect to the original page fault.

Okay, you win if you send a patch with a comment. :)

Paolo

