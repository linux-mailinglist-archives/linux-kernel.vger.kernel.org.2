Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1B3E7BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbhHJPKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:10:49 -0400
Received: from foss.arm.com ([217.140.110.172]:57644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241056AbhHJPKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:10:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B3E61FB;
        Tue, 10 Aug 2021 08:10:26 -0700 (PDT)
Received: from [10.163.67.89] (unknown [10.163.67.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D40C3F718;
        Tue, 10 Aug 2021 08:10:23 -0700 (PDT)
Subject: Re: [PATCH 2/5] KVM: arm64: Drop init_common_resources()
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
 <1628578961-29097-3-git-send-email-anshuman.khandual@arm.com>
 <20210810132123.GB2946@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0480869b-bb08-747a-f4f1-3f77ba4bbed9@arm.com>
Date:   Tue, 10 Aug 2021 20:41:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210810132123.GB2946@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/21 6:51 PM, Will Deacon wrote:
> On Tue, Aug 10, 2021 at 12:32:38PM +0530, Anshuman Khandual wrote:
>> Could do without this additional indirection via init_common_resources() by
>> just calling kvm_set_ipa_limit() directly instead. This change saves memory
>> and cycles.
> 
> Does it? Really?

TBH, I did not really measure them to be sure. It was more like an intuitive
assumption. But do you suspect that the compiler might be already optimizing
this out, hence giving memory and CPU cycle benefits ? Regardless this still
drops an unnecessary function.

> 
> Will
> 
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index e9a2b8f27792..19560e457c11 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -1696,11 +1696,6 @@ static bool init_psci_relay(void)
>>  	return true;
>>  }
>>  
>> -static int init_common_resources(void)
>> -{
>> -	return kvm_set_ipa_limit();
>> -}
>> -
>>  static int init_subsystems(void)
>>  {
>>  	int err = 0;
>> @@ -2102,7 +2097,7 @@ int kvm_arch_init(void *opaque)
>>  		}
>>  	}
>>  
>> -	err = init_common_resources();
>> +	err = kvm_set_ipa_limit();
>>  	if (err)
>>  		return err;
>>  
>> -- 
>> 2.20.1
>>
