Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890C53BF730
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhGHJD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231247AbhGHJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625734844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gIPcM/AEt6CFgVLe5U5Gt1G0R6Bu5ZtRDH8h8xxqSLM=;
        b=e+VQznPv8wzxD+bIzlDBENoiNrfTva5bKM1u77EI3jndrqI+WXWEKm7/0AJHMXUCqN90MK
        gJx/saB0gto1m/bvJHEZV8xHAliRd9KxS4xzYg6Q5zI0utmKSbiSvIL9OjCSjois2HNPpF
        lXccIL46Cg4xfrAQxmhGhIy/1pQ8HLA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-T_mPqJaqMXaR_g9eAGRlDw-1; Thu, 08 Jul 2021 05:00:43 -0400
X-MC-Unique: T_mPqJaqMXaR_g9eAGRlDw-1
Received: by mail-wr1-f69.google.com with SMTP id m9-20020a0560000089b02901362e1cd6a3so1675891wrx.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 02:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gIPcM/AEt6CFgVLe5U5Gt1G0R6Bu5ZtRDH8h8xxqSLM=;
        b=L7tFLZOyElazdM7ilc/c1c7eX8eqI7M9HRpqZR1n/WzarfqoSEEIeBZzEwyzwMwLud
         6JIItSLJI4Y58JKd9X2M4JUygcFEDF6bLfzAcKfeWF0nn4rQKF8/ZKY1OYY4YLwyGxcd
         W9s3nrqTjdmaIqxXj8eTz6rnErJKE8gCer9aT29lpV58npjGwL/nPy/hf2bIYSLydsl3
         Z7YZ18Mv8j8P/b6//lBPp/o/fhPWAJVTsGc2ycE9gYKQbryAMRLVZMfvzlmEkQkfiXpF
         fb6rcivaOzqkPABV4UK9TXmPFrPZH6Mp9OcC47utB8Po22WID5+d0yjGl3u4Mcwa77sG
         ENeQ==
X-Gm-Message-State: AOAM530Nr8ICZok9+TNRgTWYhvyjQrwntSgJs/4hVlP7sjkKC6fLEZBL
        +GDZVdHyL+i1pQUL6N2d7dSRwxZww9KfDwQJ2ECbumJ8mV7OEK2+EB6gIHIYS/721PTTCMjr5EF
        xiClFfGZurnS7b/h1MgdjCHAS
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr36763733edu.380.1625734413610;
        Thu, 08 Jul 2021 01:53:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxx/+0c8nIU7pwYBojXCHzTNcV8ZCk6Cqibqq/t9wTBQKxs+CGQcGK3UP/Yf8+cmhDD/LkdhQ==
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr36763691edu.380.1625734413381;
        Thu, 08 Jul 2021 01:53:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u17sm853904edt.67.2021.07.08.01.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 01:53:32 -0700 (PDT)
Subject: Re: [PATCH Part1 RFC v4 04/36] x86/mm: Add sev_feature_enabled()
 helper
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-5-brijesh.singh@amd.com> <YOa8TlaZM42+sz+E@work-vm>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6c68c70-ac6e-07f2-c24e-f1c892080eab@redhat.com>
Date:   Thu, 8 Jul 2021 10:53:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOa8TlaZM42+sz+E@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/21 10:50, Dr. David Alan Gilbert wrote:
>> +enum sev_feature_type {
>> +	SEV,
>> +	SEV_ES,
>> +	SEV_SNP
>> +};
> Is this ....
> 
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index a7c413432b33..37589da0282e 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -481,8 +481,10 @@
>>   #define MSR_AMD64_SEV			0xc0010131
>>   #define MSR_AMD64_SEV_ENABLED_BIT	0
>>   #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
>> +#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
> Just the same as this ?
> 

No, it's just a coincidence.

Paolo

