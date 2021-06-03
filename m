Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1B339A202
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhFCNSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhFCNS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:18:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E4BC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 06:16:45 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k16so6187563ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QMqPQvUnypqLHjPLaT9xyug0EDGENj9f58UV0CdwgRM=;
        b=CFMc2N12Cx79ffls6ViamhiWoLw/R4+zxBqyCvAFh6ZEjMHmuS0YZZ5LapV3LDUj0c
         wlysEOLY7aPIvUgp2ksvPoY5T449DrIFEJCdsM4EOTmP8Ghp4WcUZEFwViTIE4CdY2mT
         q8xV96VO4R3MszAyp+NBaA7X4HnI1/Gg9Ag2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QMqPQvUnypqLHjPLaT9xyug0EDGENj9f58UV0CdwgRM=;
        b=s/uSJda039KWiMD64Wb3ok0Nqs9QH5qnmZUZ3X/BctL7tA7bQqek8Ba9BSmtMTFmIT
         t1XjXA3PNX6fflkJtCvVrfkKQRfqPu0Ap1lwYtTT00sBhsb2TOmWK11hWbwidCEMPmUn
         NNVggoxJj6Q8BbWzZdv4HAbRS8tj90MUYK4E3ILc4pvvk8sFZnS0MxxFl0WeipaoeWuD
         +8DVGU4EZbBxFnAC2X7sEOvvQBYmy9NcbwHmTFfZvCY58M6oeHLuyTDvhHFALPQT+Mvd
         BqhALyhzUol2x45AvliezcJmT2nguxPzxbBMC6MVhpl6JrJeYnB3XPYSVlyDTqArsUl8
         ZdjA==
X-Gm-Message-State: AOAM533n8Ql9xGLEh27yfVJCI98w2XLSUmDxPKhb5e+j1vzxoUcmkKQ3
        zFNXVBfY3J2qTZj7BZ6IBbo88A==
X-Google-Smtp-Source: ABdhPJygkmyBgoBrQOB/rwJPtjellTqkTCsw39wzcGcU21hbYGIad1fCPHc4YWG13IAVVphEY1XfIw==
X-Received: by 2002:a5e:974d:: with SMTP id h13mr29121397ioq.150.1622726204263;
        Thu, 03 Jun 2021 06:16:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r8sm1737623ile.25.2021.06.03.06.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 06:16:43 -0700 (PDT)
Subject: Re: [patch 1/8] selftests/x86: Test signal frame XSTATE header
 corruption handling
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210602095543.149814064@linutronix.de>
 <20210602101618.285452223@linutronix.de> <YLd7s/cw8MsUlWvM@zn.tnic>
 <87a6o81hg0.ffs@nanos.tec.linutronix.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <156569f3-bd44-d2c3-84fa-a363e83e35c4@linuxfoundation.org>
Date:   Thu, 3 Jun 2021 07:16:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87a6o81hg0.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 8:15 AM, Thomas Gleixner wrote:
> On Wed, Jun 02 2021 at 14:38, Borislav Petkov wrote:
>> On Wed, Jun 02, 2021 at 11:55:44AM +0200, Thomas Gleixner wrote:
>>> From: Andy Lutomirski <luto@kernel.org>
>>>
>>> This is very heavily based on some code from Thomas Gleixner.  On a system
>>> without XSAVES, it triggers the WARN_ON():
>>>
>>>      Bad FPU state detected at copy_kernel_to_fpregs+0x2f/0x40, reinitializing FPU registers.
>>
>> That triggers
>>
>> [  149.497274] corrupt_xstate_[1627] bad frame in rt_sigreturn frame:00000000dad08ab1 ip:7f031449ffe1 sp:7ffd0c5c59f0 orax:ffffffffffffffff in libpthread-2.31.so[7f0314493000+10000]
>>
>> on an AMD laptop here.
> 
> Yes, that's the ratelimited printk in the signal code.
> 
>>> +static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
>>> +			   unsigned int *ecx, unsigned int *edx)
>>> +{
>>> +	asm volatile(
>>> +		"cpuid;"
>>> +		: "=a" (*eax),
>>> +		  "=b" (*ebx),
>>> +		  "=c" (*ecx),
>>> +		  "=d" (*edx)
>>> +		: "0" (*eax), "2" (*ecx));
>>> +}
>>> +
>>> +static inline int xsave_enabled(void)
>>> +{
>>> +	unsigned int eax, ebx, ecx, edx;
>>> +
>>> +	eax = 0x1;
>>> +	ecx = 0x0;
>>> +	__cpuid(&eax, &ebx, &ecx, &edx);
>>> +
>>> +	/* Is CR4.OSXSAVE enabled ? */
>>> +	return ecx & (1U << 27);
>>> +}
>>
>> One fine day someone should sit down and unify all those auxillary
>> functions used in the selftests into a lib...
> 
> Yes please. Shuah, that would be a great newcomer task...
> 

Yes. I will add to newcomer task list.

thanks,
-- Shuah
