Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E6B371728
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhECOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229924AbhECOzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620053672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3b540+x5tTROkhNIivHz2jfrf6p5DdmXEjkUmZeSpJM=;
        b=KcG/boF7aAEIrUAWGBPZx8j3vkBIRRWofcQ6AWeCeVWYlcEGn1TPmWLFXZO7cNx3wln3jH
        qcbTyDIoPsBtkA5UgPG/1IU+gxRdMdVoLgYY0Nf5ThandzXlNOjtnJ3/uJkyJx27TyYoXs
        mGqSfflmaSaY0D/w00xzeHJ5dWEKv6Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-3wikUtxgNmOeUYRpMsG-0Q-1; Mon, 03 May 2021 10:54:30 -0400
X-MC-Unique: 3wikUtxgNmOeUYRpMsG-0Q-1
Received: by mail-ed1-f71.google.com with SMTP id h13-20020a05640250cdb02903790a9c55acso4679882edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 07:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3b540+x5tTROkhNIivHz2jfrf6p5DdmXEjkUmZeSpJM=;
        b=Zl654+gtWjgGwXupLE4w61LmdTHwSl63awMaevIoirVIjtTXctGbUIfpCjnjBgJEjV
         lp3R5uHbR1rrIYh/+sSR6/cIvVm7Jd7FxHYrtdgeHD2ZKa0RiYQ6jgz8axJ3cgbJmx7M
         W7ymTCXeNCF6nXU1a0LJ41TRD9W6HZzGyLfk0PTJgSPTnQdVLo+uyk+bwYENgOwH2eZZ
         hXRyxkSSc0ThYhN9GNTxEwJxkHS1MMRN7CUe6kuxUa/qoBotL7ZyJXuerPDJ5V+dHIlA
         4++Z3cpFBhvziUgiasLTPErOzXoW0BzEB3ZudP6E294vt8Uir7MagFoIPRyk6+MNusp8
         OQ2A==
X-Gm-Message-State: AOAM532CgS8bEUkbePkzsOs+aa4ttSgaOhpqzpBIcf9W4USDHcmXkVi7
        chdjAIOYOKkA5wmB7Lw7hX5yA2KhrYW4rh54eOgIu5vVHeuen7kXgkzgA5wVY9lzSe2VPOj41F8
        e2e3oFef5HYSHglAxEqTF0sDF
X-Received: by 2002:a17:906:3884:: with SMTP id q4mr3800242ejd.492.1620053669155;
        Mon, 03 May 2021 07:54:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoR23CFOSjH9ccO37wfLz2PUmLdvsRxh6LTPVmadaUWrtpbDf7jx//gWJ/S64YXlz2inuaaw==
X-Received: by 2002:a17:906:3884:: with SMTP id q4mr3800225ejd.492.1620053668986;
        Mon, 03 May 2021 07:54:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id go38sm11070888ejc.40.2021.05.03.07.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:54:28 -0700 (PDT)
Subject: Re: [PATCH v4] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid
 entries count
To:     Sean Christopherson <seanjc@google.com>,
        Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Denis Lunev <den@openvz.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20210428172729.3551-1-valeriy.vdovin@virtuozzo.com>
 <YIoFFl72VSeuhCRt@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d68dbc3-8462-7763-fbad-f3b895fcf6e6@redhat.com>
Date:   Mon, 3 May 2021 16:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIoFFl72VSeuhCRt@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/21 03:00, Sean Christopherson wrote:
> On Wed, Apr 28, 2021, Valeriy Vdovin wrote:
>> It's very explicit by the code that it was designed to receive some
>> small number of entries to return E2BIG along with the corrected number.
> 
> LOL, saying KVM_GET_CPUID2 was "designed" is definitely giving the KVM
> forefathers the benefit of the doubt.

I was going to make a different joke, i.e. that KVM_GET_CPUID2 was 
indeed designed the way Valeriy described, but that design was forgotten 
soon after.

Really, this ioctl has been such a trainwreck that I think the only good 
solution here is to drop it.

Paolo

>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index efc7a82ab140..3f941b1f4e78 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -4773,14 +4773,17 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>   		r = -EFAULT;
>>   		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
>>   			goto out;
>> +
>>   		r = kvm_vcpu_ioctl_get_cpuid2(vcpu, &cpuid,
>>   					      cpuid_arg->entries);
>> -		if (r)
>> +
>> +		if (r && r != -E2BIG)
>>   			goto out;
>> -		r = -EFAULT;
>> -		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
>> +
>> +		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid))) {
>> +			r = -EFAULT;
>>   			goto out;
> 
> As I pointed out[*], copying the number of entries but not the entries themselves
> is wrong.  All of my feedback on v1 still stands.
> 
> [*] https://lkml.kernel.org/r/YIl4M/GgaYvwNuXv@google.com
> 
>> -		r = 0;
>> +		}
>>   		break;
>>   	}
>>   	case KVM_GET_MSRS: {
> 

