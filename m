Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1474300CD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 09:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243766AbhJPHRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 03:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243765AbhJPHRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634368492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BaxIwfVxonTLo15k+nEJpF6xy73a9k6tRs3kATSDU84=;
        b=OBvny+3wpF0Ss5GQACsPoRaZQ1VbeuvAkL1Gg5f5j77lWF4+ILrj+UXpfhXR+rbLvwKDQQ
        4YEcGvknMgGwComwn5yO69EG8FgzpQYAYbwashDY1lKLeX6zNjbSk6+GQyAoaPYyrcDV+W
        fLy67RSLv+Sxc/gyZJLmotYedGq9Nts=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-j5OjGMwlMyWSbIE3FCFDOA-1; Sat, 16 Oct 2021 03:14:51 -0400
X-MC-Unique: j5OjGMwlMyWSbIE3FCFDOA-1
Received: by mail-ed1-f70.google.com with SMTP id h19-20020aa7de13000000b003db6ad5245bso10190698edv.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 00:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BaxIwfVxonTLo15k+nEJpF6xy73a9k6tRs3kATSDU84=;
        b=BohX8K3iT7eJ9iTUzRDqMj6iTQKT6Uid48ViK0iGklYpntbT/HxaPWgVI1HGWsH4Zc
         Fp4PA47LkuULiR/TNo+vPFTwZqpEmxPL8rvlQU63HQenWtlOK/xk+fRlnRbScQXlUvYQ
         0iSQ7/tW44WHV0YFgsFGW/kjPec/a4tmWZ+XB8P0og6QZ9Hs174fqzeGU2QB20C1YuPT
         r4ShzYs/LOhJuX7q9dcDGYdv382wb3e+FELt7Vdq00+TCx+FOvnVP25wMZi8Jx9lcf0v
         UyGrx3gsl+AuFJIHhdAx8ymxBYjkv0JIZWRZf2uacXOAw9MH1Y6TVCYn5jfybioxNeb6
         sq+A==
X-Gm-Message-State: AOAM533uca4NRi4xzYh7bAfFmZwQ/vakOBTYDPe6RHZIIIDuCX5p72We
        /ZUZxcjgnhAifsy4N3yc/qtG8bbrT+UxkZrKcwCHOIxymZSYdtTgtQrOqz3itRkuJjuNvR7Gclt
        Laa5+qneitbG+tab4nLLBHasc
X-Received: by 2002:a05:6402:4248:: with SMTP id g8mr24081557edb.91.1634368489758;
        Sat, 16 Oct 2021 00:14:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu7II/lBoJFLzogNCFPfshVOVNcIr3jIwXuw554nr36y9gf/8/fqdLpCAzn7r0OBvbrD0PYA==
X-Received: by 2002:a05:6402:4248:: with SMTP id g8mr24081533edb.91.1634368489577;
        Sat, 16 Oct 2021 00:14:49 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id q21sm5982372edi.58.2021.10.16.00.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 00:14:48 -0700 (PDT)
Message-ID: <00419ea5-9b51-0175-0500-0882fd0b4290@redhat.com>
Date:   Sat, 16 Oct 2021 09:14:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 2/2] x86: sgx_vepc: implement SGX_IOC_VEPC_REMOVE ioctl
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dave.hansen@linux.intel.com, x86@kernel.org, yang.zhong@intel.com,
        jarkko@kernel.org
References: <20211012105708.2070480-1-pbonzini@redhat.com>
 <20211012105708.2070480-3-pbonzini@redhat.com> <YWoA2lBUuFmDf6zu@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YWoA2lBUuFmDf6zu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/21 00:29, Sean Christopherson wrote:
> On Tue, Oct 12, 2021, Paolo Bonzini wrote:
>> diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
>> index 59cdf3f742ac..81a0a0f22007 100644
>> --- a/arch/x86/kernel/cpu/sgx/virt.c
>> +++ b/arch/x86/kernel/cpu/sgx/virt.c
>> @@ -150,6 +150,46 @@ static int sgx_vepc_free_page(struct sgx_epc_page *epc_page)
>>   	return 0;
>>   }
>>   
>> +static long sgx_vepc_remove_all(struct sgx_vepc *vepc)
>> +{
>> +	struct sgx_epc_page *entry;
>> +	unsigned long index;
>> +	long failures = 0;
>> +
>> +	xa_for_each(&vepc->page_array, index, entry) {
> 
> Might be worth a comment that xa_for_each() is safe to use concurrently with
> xa_load/xa_store, i.e. this doesn't need to take vepc->lock.

I considered that to be part of the xarray contract (xa_store uses 
rcu_assign_pointer so it has release semantics, and vepc->page_array is 
essentially "store once").

> It does raise the
> question of whether or not the kernel is responsible for providing deterministic
> results if userspace/guest is accessing previously-unallocated pages.

Garbage in, garbage out -- but you're right below that garbage in, WARN 
out is not acceptable.  I'm sending a v3 with documentation changes too.

Paolo

>> +		int ret = sgx_vepc_remove_page(entry);
> 
> I don't see anything that prevents userspace from doing SGX_IOC_VEPC_REMOVE_ALL
> on multiple threads with the same vEPC.  That means userspace can induce a #GP
> due to concurrent access.  Taking vepc->lock would solve that particular problem,
> but I think that's a moot point because the EREMOVE locking rules are relative to
> the SECS, not the individual page (because of refcounting).  SGX_IOC_VEPC_REMOVE_ALL
> on any two arbitrary vEPCs could induce a fault if they have children belonging to
> the same enclave, i.e. share an SECS.
> 
> Sadly, I think this needs to be:
> 
> 		if (ret == SGX_CHILD_PRESENT)
> 			failures++;
> 		else if (ret)
> 			return -EBUSY;
> 
>> +		switch (ret) {
>> +		case 0:
>> +			break;
>> +
>> +		case SGX_CHILD_PRESENT:
>> +			failures++;
>> +			break;
>> +
>> +		case SGX_ENCLAVE_ACT:
>> +			/*
>> +			 * Unlike in sgx_vepc_free_page, userspace could be calling
>> +			 * the ioctl while logical processors are running in the
>> +			 * enclave; do not warn.
>> +			 */
>> +			return -EBUSY;
>> +
>> +		default:
>> +			WARN_ONCE(1, EREMOVE_ERROR_MESSAGE, ret, ret);
>> +			failures++;
>> +			break;
>> +		}
>> +		cond_resched();
>> +	}
>> +
>> +	/*
>> +	 * Return the number of pages that failed to be removed, so
>> +	 * userspace knows that there are still SECS pages lying
>> +	 * around.
>> +	 */
>> +	return failures;
>> +}
> 

