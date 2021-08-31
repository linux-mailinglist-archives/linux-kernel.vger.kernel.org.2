Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79DF3FC939
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbhHaOAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234726AbhHaOAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630418349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eoZoakAfFIrOybBxZsdFJvMhw582s3B1lhkKRH8aPPI=;
        b=XTr+EZhYhOwVoz1jX2CAispBt3qJHnaSv4eyYRuAeq0aROViVqhIOXvl9NZAalCCB5ODC/
        enh9KpGVyhwnt/K6QhJxudWUSGyYHH+H0UGw5nXMB7FflzQKspMY83qAm30SYBW6HERHzM
        m0LAHq5EtaEjSY3bWJRIBR7OK9D9AYQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-q8NsLm3bNMatyegCmsaQhw-1; Tue, 31 Aug 2021 09:59:07 -0400
X-MC-Unique: q8NsLm3bNMatyegCmsaQhw-1
Received: by mail-wr1-f69.google.com with SMTP id j15-20020adfea4f000000b001592040d08dso533518wrn.18
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eoZoakAfFIrOybBxZsdFJvMhw582s3B1lhkKRH8aPPI=;
        b=SHylgPgAQ2Wv4ekzJpjsOMRiWdCrCYZfvkhId3W8pmrs69bbpwQiOrCIykYDPe/P1O
         imuCEnKgHTqbjQMvmJdAY8Iayj3mN4qxUb70iSuMHhOnjS1UDyC9a+5h7GyO3ods6sSO
         EJJnTGbHJVRJLhqLoOGnrmPSignHb5b1FWg9hDySFpjLeXjxB2nusezxzAf1xzG57z/a
         1wHyy8LHLqzLCxLr2OMYVyVl7IwKdauD+AsLJvIK9pTmRhAKbdZlVcLM4B1Flt7oLJ8J
         NARc9YkCuV1KnltUfcmohYZ9eg4yJLsxjQAvrQXBdfutxRg7Vq3RX2vHqGQ6J7JkGA+f
         esCw==
X-Gm-Message-State: AOAM530s+/C7/VNViq6ITnQz6yGj7NoLD/hgF95ibRddFJHbUMIDcPOr
        4PI6dWEI6eSbYV5JEbpDBcnu/XlytlN5wH70FnYbnk7w/QEz1E8j2U/a5o+HZk40E4CgevepoMD
        RApehSvQNBQjp8cuGkJIVoLDW
X-Received: by 2002:adf:f991:: with SMTP id f17mr31434989wrr.56.1630418346621;
        Tue, 31 Aug 2021 06:59:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLrNmZ87nLAPswJDNvaJ17N+XDx8mVOLrGb7eKjqGs7O6Nzg1GUEeNfP9JTf/IP+cFIBtOLA==
X-Received: by 2002:adf:f991:: with SMTP id f17mr31434964wrr.56.1630418346347;
        Tue, 31 Aug 2021 06:59:06 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bf5.dip0.t-ipconnect.de. [79.242.59.245])
        by smtp.gmail.com with ESMTPSA id s12sm18748921wru.41.2021.08.31.06.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 06:59:05 -0700 (PDT)
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
References: <1627979206-32663-1-git-send-email-pmorel@linux.ibm.com>
 <1627979206-32663-2-git-send-email-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/3] s390x: KVM: accept STSI for CPU topology
 information
Message-ID: <b5ee1953-b19d-50ec-b2e2-47a05babcee4@redhat.com>
Date:   Tue, 31 Aug 2021 15:59:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1627979206-32663-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.21 10:26, Pierre Morel wrote:
> STSI(15.1.x) gives information on the CPU configuration topology.
> Let's accept the interception of STSI with the function code 15 and
> let the userland part of the hypervisor handle it when userland
> support the CPU Topology facility.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   arch/s390/kvm/priv.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 9928f785c677..8581b6881212 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -856,7 +856,8 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>   	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>   		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>   
> -	if (fc > 3) {
> +	if ((fc > 3 && fc != 15) ||
> +	    (fc == 15 && !test_kvm_facility(vcpu->kvm, 11))) {
>   		kvm_s390_set_psw_cc(vcpu, 3);
>   		return 0;
>   	}
> @@ -893,6 +894,10 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>   			goto out_no_data;
>   		handle_stsi_3_2_2(vcpu, (void *) mem);
>   		break;
> +	case 15:
> +		trace_kvm_s390_handle_stsi(vcpu, fc, sel1, sel2, operand2);
> +		insert_stsi_usr_data(vcpu, operand2, ar, fc, sel1, sel2);
> +		return -EREMOTE;
>   	}
>   	if (kvm_s390_pv_cpu_is_protected(vcpu)) {
>   		memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
> 

Sorry, I'm a bit rusty on s390x kvm facility handling.


For test_kvm_facility() to succeed, the facility has to be in both:

a) fac_mask: actually available on the HW and supported by KVM 
(kvm_s390_fac_base via FACILITIES_KVM, kvm_s390_fac_ext via 
FACILITIES_KVM_CPUMODEL)

b) fac_list: enabled for a VM

AFAIU, facility 11 is neither in FACILITIES_KVM nor 
FACILITIES_KVM_CPUMODEL, and I remember it's a hypervisor-managed bit.

So unless we unlock facility 11 in FACILITIES_KVM_CPUMODEL, will 
test_kvm_facility(vcpu->kvm, 11) ever successfully trigger here?


I'm pretty sure I am messing something up :)

-- 
Thanks,

David / dhildenb

