Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5113735061D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhCaSPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhCaSPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:15:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC674C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:15:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so20631866wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eA66IfwNLCvflZyaO4GLWcFCdnWN4ORiomGXqXfK2fI=;
        b=f1Ar6CrHVwvmPAM3/9xMSRkKbN4usB8LfM583KmVSNJXs0r9cwmW9stwOKoZwMrxBC
         8M90NIfDKnoSwcSiBxVfvwLjuz4IWvYeL1vFxRhKMDhJy6I/CtyXQDHWLF33EeEata6X
         Vi3odTlTawbhhkRC9Uy49cUyQLQlneOe1+Gor6WnNMINgZ3UD+UJIp/iYVsdaGRunxCw
         8/5ewEzObkstEaa9ST1but+pEE6GrBuM+tCgEoaMtfPcVJ/swYbM7F45HJ43j2bArRWg
         1OjhHJJFXK4zMoAnUEpJPxvr1NkIVWETfE9pNj6lDRs36zWNuAsqSW7gDAoMo5YZCzYf
         2ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eA66IfwNLCvflZyaO4GLWcFCdnWN4ORiomGXqXfK2fI=;
        b=HJ+RO9Bn8mNx8kJLRvy/pvTc9sTEBMkYBw3m73tfcK3Em+7FMi7Q3kU2nmO8+rgi7G
         HnG7BC7l0fxPgurdXiiLOt5CbiwgJA37g5yqvCTZSYfGazDMQm16VTROkf6Iyq3Hcsai
         X/fWxmTXXAaMjC0rJ68G21t+VkrZ9bJAJphWg2LaSyaKAYaZBVaNDlUH5uRgVKxHeIB3
         WMfBFQ5crxMPhsPJLgvF20VHvYlzh3Y65krYF/J97K2JKoeAxY+z5nQF2WLqjZTEcj8j
         +1tK3vtV6elYpIdyV2GWqluDDkyA6cXxy8S4RFAJwj5NTpGSwvtbF1/vBAZbbHD9FWDE
         /4Kg==
X-Gm-Message-State: AOAM533HnKVzq8bSyMwNgm0fOlyeEWbNwySWVAGxsDlVb3r71Zx+LiDj
        iA1GIzco2GERRsfvUt3FF40ucA==
X-Google-Smtp-Source: ABdhPJyyWfx/c+aqE54lTrl3dhisDbSZEmIFGt41YeVVb1gbg4eQ0gsUx3VoNGnZ5VsumWW6ywd2EQ==
X-Received: by 2002:adf:ba94:: with SMTP id p20mr5188220wrg.300.1617214516602;
        Wed, 31 Mar 2021 11:15:16 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i4sm4661186wmq.12.2021.03.31.11.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 11:15:16 -0700 (PDT)
Subject: Re: [PATCH] powerpc/vdso: Separate vvar vma from vdso
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
References: <20210326191720.138155-1-dima@arista.com>
 <47623d02-eb29-0fcb-0cfd-a9c11c9fab02@csgroup.eu>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <8cd82b69-c8cc-8591-1f92-5c9400e00579@arista.com>
Date:   Wed, 31 Mar 2021 19:15:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <47623d02-eb29-0fcb-0cfd-a9c11c9fab02@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/21 11:17 AM, Christophe Leroy wrote:
> 
> 
> Le 26/03/2021 à 20:17, Dmitry Safonov a écrit :
[..]
>> --- a/arch/powerpc/kernel/vdso.c
>> +++ b/arch/powerpc/kernel/vdso.c
>> @@ -55,10 +55,10 @@ static int vdso_mremap(const struct
>> vm_special_mapping *sm, struct vm_area_struc
>>   {
>>       unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
>>   -    if (new_size != text_size + PAGE_SIZE)
>> +    if (new_size != text_size)
>>           return -EINVAL;
> 
> In ARM64 you have removed the above test in commit 871402e05b24cb56
> ("mm: forbid splitting special mappings"). Do we need to keep it here ?
> 
>>   -    current->mm->context.vdso = (void __user *)new_vma->vm_start +
>> PAGE_SIZE;
>> +    current->mm->context.vdso = (void __user *)new_vma->vm_start;
>>         return 0;
>>   }
> 

Yes, right you are, this can be dropped.

Thanks,
          Dmitry
