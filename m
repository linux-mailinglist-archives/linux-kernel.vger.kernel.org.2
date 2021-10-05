Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B0342271D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhJEMzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234740AbhJEMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633438413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2U8nm5oILXRxTumN8OJpg8AB5IsbA9id5Pw+v+JssA8=;
        b=Mkf/hlgNqwdm6fgN5anA6M12HwN8ewkc92FV08qauEy8xcHySP7KbjRUqbYuKXgQF0b2E2
        G/nSCfB51NkFSHbJKFux0/LiFjHJhre3mIql5K2rdjHvDxZV/oxutb23SOIeDvPPHY2uBO
        tWJGgC718gjDYkBLr0AHU6oQxLVS9nU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-ofxMSdHfNxeurNfCFSg70g-1; Tue, 05 Oct 2021 08:53:32 -0400
X-MC-Unique: ofxMSdHfNxeurNfCFSg70g-1
Received: by mail-wr1-f69.google.com with SMTP id v15-20020adfa1cf000000b00160940b17a2so4194531wrv.19
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 05:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2U8nm5oILXRxTumN8OJpg8AB5IsbA9id5Pw+v+JssA8=;
        b=X8OnOpqPxwYDpOZZFNaotBRgBWOmil1cwx3hneNkikcINmN5xp6IZMvMH9FNZqO+l5
         WNEW4eFvx9Gyl2QUGe7XAPWr3jmQ5LtNlCM5nfATyEu4Q5MHwVj0iEskc49ACXIs+uqk
         BosfJpox0Wo5VsH5DqWCv3w57OJ6GjMsi1Y3r7V+NY6cSnc/u2BL7xX6Y/z0i1aCTr9b
         EssSiMu93mK6LxiLEnHCVaoFAXGqJ/2Puid+ggXGlR71SufHoyJWuC3NUDfpQ3ME5OXl
         yHtF9b3peu9jCYBx5C4KaM5esg6lIyIClZ/cFeYuORAqVc1xeTpbvQgwb0V8oehsf7ns
         z6Eg==
X-Gm-Message-State: AOAM530DxfwCuTb9srfa7U6ho/ES3cNgfBYDlWVuRa1wnJk83V9QFoPX
        yJ2jjqdvoV79LXbwBHfSRULaQdsXjRrt6K22k0EiXK/N+SmSMUsXtJrHx42Cmg/7Iz/T/zd8BP6
        etwCsJmXa1Xhxbia8aOOQ5OjQ
X-Received: by 2002:adf:b1d7:: with SMTP id r23mr8751136wra.145.1633438411584;
        Tue, 05 Oct 2021 05:53:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxotYojOAO5JjkvHs+sm+3sr8WLaMaMKXYt5ZVKusnKdUPpXUEQD8jkYsipU/QiHoIfZsSO8w==
X-Received: by 2002:adf:b1d7:: with SMTP id r23mr8751110wra.145.1633438411421;
        Tue, 05 Oct 2021 05:53:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z18sm10966382wro.25.2021.10.05.05.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 05:53:30 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Wei Liu <wei.liu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/hyperv: remove on-stack cpumask from
 hv_send_ipi_mask_allbutself
In-Reply-To: <87ee9batb5.ffs@tglx>
References: <20210910185714.299411-1-wei.liu@kernel.org>
 <20210910185714.299411-3-wei.liu@kernel.org> <87ee9batb5.ffs@tglx>
Date:   Tue, 05 Oct 2021 14:53:29 +0200
Message-ID: <87k0ir63au.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Wei!
>

Not Wei here but I don't see the question answered on the mailing list
so let me give my thoughts.

> On Fri, Sep 10 2021 at 18:57, Wei Liu wrote:
>> -static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
>> +static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>> +		bool exclude_self)
>>  {
>>  	struct hv_send_ipi_ex **arg;
>>  	struct hv_send_ipi_ex *ipi_arg;
>> @@ -123,7 +124,10 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
>>  
>>  	if (!cpumask_equal(mask, cpu_present_mask)) {
>
> Not part of that patch, but is checking cpu_present_mask correct here?
> If so then this really lacks a comment for the casual reader.

It seems it *was* correct prior to 'exclude_self': the idea is that for
everything but 'cpu_present_mask' we use HV_GENERIC_SET_SPARSE_4K
format, for 'cpu_present_mask' we just use 'all' (HV_GENERIC_SET_ALL)
to avoid specifying individual CPUs. 

>
>>  		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
>> -		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
>> +		if (exclude_self)
>> +			nr_bank = cpumask_to_vpset_noself(&(ipi_arg->vp_set), mask);
>> +		else
>> +			nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
>>  	}
>
> But, what happens in the case that mask == cpu_present_mask and
> exclude_self == true?
>
> AFAICT it ends up sending the IPI to all CPUs including self:
>
> 	if (!nr_bank)
> 		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
>
> Not entirely correct, right?

It's not, I think we need something like (completely untested) 

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 32a1ad356c18..80b7660208e4 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -122,17 +122,17 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
        ipi_arg->reserved = 0;
        ipi_arg->vp_set.valid_bank_mask = 0;
 
-       if (!cpumask_equal(mask, cpu_present_mask)) {
+       if (!cpumask_equal(mask, cpu_present_mask) || exclude_self) {
                ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
                if (exclude_self)
                        nr_bank = cpumask_to_vpset_noself(&(ipi_arg->vp_set), mask);
                else
                        nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
-       }
-       if (nr_bank < 0)
-               goto ipi_mask_ex_done;
-       if (!nr_bank)
+               if (nr_bank =< 0)
+                       goto ipi_mask_ex_done;
+       } else {
                ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
+       }
 
        status = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
                              ipi_arg, NULL);

here. Wei, I can test and send this out if you're not on it already.

-- 
Vitaly

