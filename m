Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157EA3656E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhDTKvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232536AbhDTKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618915787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJVvP2tIDEge+gKxKQ2GpW/yaknjlmpS+fur6I21c5o=;
        b=f3L0ptWpPM8Vb7SaQrATNlkD8obSmTP5IlyAdmvFNJEIGG1nJQ3SVe+eXawaiTpSlvYznm
        d/fslKtF2MpN7JNT+bLrwEgbe4V3R0pTltWip5ot8loznw42MlsbYOfHNg8L9L+mZlAPNt
        YCnIizu/gXaU6CGC7vJhrV2C8bmRbRs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-JcJ4SWduPZWRA1jtFe_rLA-1; Tue, 20 Apr 2021 06:49:46 -0400
X-MC-Unique: JcJ4SWduPZWRA1jtFe_rLA-1
Received: by mail-ed1-f72.google.com with SMTP id c13-20020a05640227cdb0290385526e5de5so2846279ede.21
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 03:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MJVvP2tIDEge+gKxKQ2GpW/yaknjlmpS+fur6I21c5o=;
        b=RR7RUyKfdA3/3a5ooBt1EDZi+3frtoSVYFcXIeqcRkkxi+Zi4EPmCK22PyTvOAB7Z8
         ksC0gF14PSBd32iApYpE0NM5ONmPwDN40eL6rjkRdhqr+0PaiUL2B03tCAVGdEA0SB9W
         l3GEMdW6UvAiPoKk1QGWf9MuofDW8Kkk8Cs2zXraza+1JtyaygCR/Kx4y4h2hC+r3htO
         yZSf1bA5lOXgAcXNwzjv757vxhPdMVSqwxf/b/y43JM2JCbK2iYxsjKsH4OBOS+Q/JFY
         XCtwv0Ge5D1iPpaJQtUMit95p9WmNrJGuHv0QBdjeP3ikfV1st7Kl0fRH61iE6OFS3mh
         +T/A==
X-Gm-Message-State: AOAM532ZoA/hMOXSqM8NxCusjKxBwj4Z0hdeAE/v0IC/bALX1LNJfcJ9
        GdE4sWDWL3HQRsoA4LESevlltmK/2Y5mWzf+935n/Q2FX9VVNc2RWjMmTAMJjW0h7zkZHN+htR1
        rloDEbZe8knI7ggHBlKNEXJVe
X-Received: by 2002:a17:907:161e:: with SMTP id hb30mr17732942ejc.280.1618915783711;
        Tue, 20 Apr 2021 03:49:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY7HBNoq4MzOUj64AegtX7SRGg1lSeqF7KQscuRZdh/679Dy82rGsuhTozkFlFHMKV6/QLXQ==
X-Received: by 2002:a17:907:161e:: with SMTP id hb30mr17732926ejc.280.1618915783503;
        Tue, 20 Apr 2021 03:49:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j10sm9186003ejk.93.2021.04.20.03.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 03:49:42 -0700 (PDT)
To:     Sean Christopherson <seanjc@google.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        joro@8bytes.org, bp@suse.de, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, venu.busireddy@oracle.com,
        brijesh.singh@amd.com
References: <cover.1618498113.git.ashish.kalra@amd.com>
 <3232806199b2f4b307d28f6fd4f756d487b4e482.1618498113.git.ashish.kalra@amd.com>
 <YH4M5guOafToCWd7@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v13 10/12] KVM: x86: Introduce new
 KVM_FEATURE_SEV_LIVE_MIGRATION feature & Custom MSR.
Message-ID: <988e38b4-2f69-ff66-eac9-e1714c049867@redhat.com>
Date:   Tue, 20 Apr 2021 12:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YH4M5guOafToCWd7@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/21 01:06, Sean Christopherson wrote:
>> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
>> index 950afebfba88..f6bfa138874f 100644
>> --- a/arch/x86/include/uapi/asm/kvm_para.h
>> +++ b/arch/x86/include/uapi/asm/kvm_para.h
>> @@ -33,6 +33,7 @@
>>   #define KVM_FEATURE_PV_SCHED_YIELD	13
>>   #define KVM_FEATURE_ASYNC_PF_INT	14
>>   #define KVM_FEATURE_MSI_EXT_DEST_ID	15
>> +#define KVM_FEATURE_SEV_LIVE_MIGRATION	16
>>   
>>   #define KVM_HINTS_REALTIME      0
>>   
>> @@ -54,6 +55,7 @@
>>   #define MSR_KVM_POLL_CONTROL	0x4b564d05
>>   #define MSR_KVM_ASYNC_PF_INT	0x4b564d06
>>   #define MSR_KVM_ASYNC_PF_ACK	0x4b564d07
>> +#define MSR_KVM_SEV_LIVE_MIGRATION	0x4b564d08
>>   
>>   struct kvm_steal_time {
>>   	__u64 steal;
>> @@ -136,4 +138,6 @@ struct kvm_vcpu_pv_apf_data {
>>   #define KVM_PV_EOI_ENABLED KVM_PV_EOI_MASK
>>   #define KVM_PV_EOI_DISABLED 0x0
>>   
>> +#define KVM_SEV_LIVE_MIGRATION_ENABLED BIT_ULL(0)
> 
> Even though the intent is to "force" userspace to intercept the MSR, I think KVM
> should at least emulate the legal bits as a nop.  Deferring completely to
> userspace is rather bizarre as there's not really anything to justify KVM
> getting involved.  It would also force userspace to filter the MSR just to
> support the hypercall.

I think this is the intention, the hypercall by itself cannot do much if
you cannot tell userspace that it's up-to-date.

On the other hand it is kind of wrong that KVM_GET_SUPPORTED_CPUID
returns the feature, but the MSR is not supported.

> Somewhat of a nit, but I think we should do something like s/ENABLED/READY,

Agreed.  I'll send a patch that puts everything together.

Paolo

