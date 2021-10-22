Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1E74373A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhJVI35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232142AbhJVI34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634891259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3oZmb5X5Wiq6TAUc+R676kz52C0MZzlKXhj1RnIhDQ=;
        b=BQOMWmjdwyeBf5iBflFBrpqycP/zYk68t3p0gvVxN7IO+ZBtJUNnAx7CpKScld5SLpldte
        bX03mXe0/1f9YBwD3Jmp8pY1we7EAZLmXhOwjiKa9bfk4JW7mv/DRf7HdHMG/6ibmhfgAl
        /YTUfgbMkwSA3XEj6rXsQRn1jvKItNM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-k8HQGI-MPsa2-EOltfGovw-1; Fri, 22 Oct 2021 04:27:37 -0400
X-MC-Unique: k8HQGI-MPsa2-EOltfGovw-1
Received: by mail-ed1-f69.google.com with SMTP id l10-20020a056402230a00b003db6977b694so2922645eda.23
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v3oZmb5X5Wiq6TAUc+R676kz52C0MZzlKXhj1RnIhDQ=;
        b=S6izyOcKdvh+aOCvSlq3jVw7eVHsmI/NsIdSRwZz6SbqCLvY8G8z+dwMjX4Mj3Yeqa
         6P7Uv8BnuT7Pl2mtIAp/+a2qruENKtS3DzLAapKZDMiQPDNEAXc22iA/cv+g9D+ip7JO
         uVjWHfZs7dPr4E6aJ5h6y2eV+OlrRWX2504CfiJTORelI1hB+3KjPuPxZ5VbEb4kLLBm
         4EyByXEmU32ELgPxp9MLmQ7INFwD9FtmEEO8jvMBCno7YEPZOi/zEuRiGcqWG2m3bBTX
         2WMt50u/DtMhYMB06GQkc1rYNG1H8+0Z9J20Y7HGiOP1+hWZgcbVsBLOk0O8fvaqx7Gz
         eCjA==
X-Gm-Message-State: AOAM530LkPzN4/j+fhRnfMpAJVM6UUUfMLBraA/u94e7TPfKwibNNP4x
        L+qvcEOGWbj7I0ONuS4JBSAFnJYDRgpG64cHsY2AomMTZxxSb2iAFCI0C2s8BoH+N0fSEV269H6
        GohGl4L7j5s5M9414O2HFJE40
X-Received: by 2002:a17:907:868c:: with SMTP id qa12mr13578205ejc.346.1634891256595;
        Fri, 22 Oct 2021 01:27:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPwRDKvf75gYruYmYeFWBYl4p46bdPXTTIyIva9IFWQeizVMcT9wTYm0zHNbHaMEGqt6llzg==
X-Received: by 2002:a17:907:868c:: with SMTP id qa12mr13578194ejc.346.1634891256399;
        Fri, 22 Oct 2021 01:27:36 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id d22sm3536082ejj.47.2021.10.22.01.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 01:27:35 -0700 (PDT)
Message-ID: <de8dbc64-ae2d-aa9f-a973-171feb5874d6@redhat.com>
Date:   Fri, 22 Oct 2021 10:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: x86: advertise absence of X86_BUG_NULL_SEG via CPUID
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, dgilbert@redhat.com
References: <20211021211958.1531754-1-pbonzini@redhat.com>
 <CALMp9eR3bt5P_+ZTJqcckL1pbZCyS6dCNK8o2OQR-atU_A_jtQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CALMp9eR3bt5P_+ZTJqcckL1pbZCyS6dCNK8o2OQR-atU_A_jtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/21 23:36, Jim Mattson wrote:
> On Thu, Oct 21, 2021 at 2:20 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Guests have X86_BUG_NULL_SEG if and only if the host have it.  Use
>> the info from static_cpu_has_bug to form the 0x80000021 CPUID leaf that
>> was defined for Zen3.  Userspace can then set the bit even on older
>> CPUs that do not have the bug, such as Zen2.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   arch/x86/kvm/cpuid.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 2d70edb0f323..b51398e1727b 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -902,7 +902,13 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>                  entry->edx = 0;
>>                  break;
>>          case 0x80000000:
>> -               entry->eax = min(entry->eax, 0x8000001f);
>> +               entry->eax = min(entry->eax, 0x80000021);
>> +               /*
>> +                * X86_BUG_NULL_SEG is not reported in CPUID on Zen2; in
>> +                * that case, provide the CPUID leaf ourselves.
>> +                */
> 
> I think this is backwards. !X86_BUG_NULL_SEG isn't reported in CPUID on Zen2.

Right I should use the name of the bit instead.

>> +               if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
>> +                       entry->eax = max(entry->eax, 0x80000021);
>>                  break;
>>          case 0x80000001:
>>                  cpuid_entry_override(entry, CPUID_8000_0001_EDX);
>> @@ -973,6 +979,15 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>                          entry->ebx &= ~GENMASK(11, 6);
>>                  }
>>                  break;
>> +       case 0x80000020:
>> +               entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>> +               break;
>> +       case 0x80000021:
>> +               entry->ebx = entry->ecx = entry->edx = 0;
>> +               entry->eax &= BIT(6);
> 
> While we're here, shouldn't bit 0 (Processor ignores nested data
> breakpoints) and bit 2 (LFENCE is always dispatch serializing) also
> match the hardware?

Yes, that makes sense.  Just wanted to gauge whether anybody thought it 
a really bad idea.

Paolo

> 
>> +               if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
>> +                       entry->eax |= BIT(6);
>> +               break;
>>          /*Add support for Centaur's CPUID instruction*/
>>          case 0xC0000000:
>>                  /*Just support up to 0xC0000004 now*/
>> --
>> 2.27.0
>>
> 

