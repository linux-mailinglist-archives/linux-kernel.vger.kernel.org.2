Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18603A4B04
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 00:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFKWub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 18:50:31 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:43671 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhFKWu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 18:50:29 -0400
Received: by mail-io1-f44.google.com with SMTP id k16so32775985ios.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rQPaBTxH6zmCmow24Ez/25u3aT/BbkT5Z3FMYjKkQD4=;
        b=foHbHgWLRUOeDdrUUtQo5W+xDkKSaogccxeI9Y3GB8DlJwljzOJ+Lg597umTqeTMTb
         fY8gJ47PnGJQo/RVPEvNf5PdZaDGNecOGl19KtekqED2TDtZX43KUTLiorhzUp/6lBt2
         oz5w8QecWW942LM1RxHrObEkHehi60fovjjJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rQPaBTxH6zmCmow24Ez/25u3aT/BbkT5Z3FMYjKkQD4=;
        b=Rf8SUZluB42986WbbitpV5LImMtVR1h/hV0jPOFvQrYGYy27fGUWXlUOOP1pviD+LY
         hm3wsYEdNBTkKs3dsExXhocUsU6FDAYB0Hxf6cr+gMyFoBGTT2XHjYuFWypsUZsE+h+B
         SKtnBjLDX6JzRB2q+dlrap4LiCQ0DAwO+y/Ds47KmvRaeJL5a1HTjIgEWSJa9mLYxOAA
         Hmp/W0ZOhwZtrDE45+1xfrRboyE2xdDy+3jGn9vLHH2Zj7/IGqMeeHu8ZbimogRvc2pG
         5fQ3EzwKGiPo2oRW/1fuBd6Wu4ylGhs8KdNr9lmA+Z2GRev9LVFCr40loYyTchHjFFSE
         JFNw==
X-Gm-Message-State: AOAM533bCxSykxLj9LMb+DzlFT1ntiuyjpSwOgd0R6MnQbViurOdj4gV
        KYp+4SxyimSu7whU256JM2cT3g==
X-Google-Smtp-Source: ABdhPJzYhIxyLeAPQfmBQvodXCR2Xj9xHbnPvzsaxcBbNu4D4KPVCTAAKGS5ajq24bteysnPjY0wXg==
X-Received: by 2002:a5d:9c88:: with SMTP id p8mr5082265iop.31.1623451651344;
        Fri, 11 Jun 2021 15:47:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y17sm4160145ilb.60.2021.06.11.15.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 15:47:31 -0700 (PDT)
Subject: Re: [PATCH v8 1/5] selftests/sgx: Rename 'eenter' and 'sgx_call_vdso'
To:     Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
 <b5e06639-8bf4-c267-0aa7-b6c110767edc@intel.com>
 <8d071d3f-604f-1876-05bb-91568dd3c563@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6378d2a9-9f55-18f8-ce46-7ea954ac159c@linuxfoundation.org>
Date:   Fri, 11 Jun 2021 16:47:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8d071d3f-604f-1876-05bb-91568dd3c563@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 11:35 AM, Shuah Khan wrote:
> On 6/10/21 9:45 AM, Dave Hansen wrote:
>> On 6/10/21 1:30 AM, Jarkko Sakkinen wrote:
>>> Rename symbols for better clarity:
>>>
>>> * 'eenter' might be confused for directly calling ENCLU[EENTER].  It 
>>> does
>>>    not.  It calls into the VDSO, which actually has the EENTER 
>>> instruction.
>>> * 'sgx_call_vdso' is *only* used for entering the enclave.  It's not 
>>> some
>>>    generic SGX call into the VDSO.
>>>
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> These all look fine to me.  Feel free to add my ack on them.
>>
>> Since these are pure x86 selftests and the initial code went through the
>> x86 maintainers, should these got through them as well?  Or, since this
>> is only selftest code, should Shuah pick them up?
>>
> 
> I will queue these up for 5.14-rc1
> 

I almost applied these. Does this require root access, if so,
please add logic to skip the test if non-root user runs it.

Please check for code paths that require root access and skip
the tests.

thanks,
-- Shuah
