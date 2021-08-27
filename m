Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2E3F9D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhH0RBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhH0RBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:01:37 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6AFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:00:48 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e186so9322184iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qY4u/QSD5mvN8lZY5uxrxfQLztvCoO84v1j/fKkjLkI=;
        b=LPqgm/9TH4nNGDCyZZ+4DPZiv/R/j2OSqWJ0xY8S5J4VYdZGOGN/5ViAHEr76dVQNK
         g2OZnECtAoKXXulNItoW6GV6ysXWtHE3keN7i7Wz2DtBmDUEk6GslNB4PwnnthtjnF/7
         d/fj0vixpa6PnDLxTO5HPh+6IltjOtwtnxyqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qY4u/QSD5mvN8lZY5uxrxfQLztvCoO84v1j/fKkjLkI=;
        b=olAl71iZW29W8mW8kfKRqqs+KEtB2wc2zGQPqw30HfI1Tw235Jbks1Cz+Q5Bh9zCfo
         +BHOL/H04GCC7OLRauOnbLaVLZVkpwqbDXYzRpqg0tnCYWzcvmkVjOS6AVu6Y+t8iqtX
         dYCmUva166eTILP1uoBN4+J9As5U3j4MOs3qFLoQZFy7Qymr73V1khbuH9xAL1ev9wBQ
         jcdR+0B2A9fkqST1V6V2VC3fl3xH9t2m+aMmHFUtaN5oMePzMYm9gbffhfZD08gZUxdI
         1RZj2+ihdI0AdaFcMZn6Zz66q5QUDvaT+5zrAHfjC9DjDrfh/T859MvphVbXucChZcPI
         NfNg==
X-Gm-Message-State: AOAM532nXtbuAF2J3dSts5Nn+ckORF28VuMHnRSVZS8KV2oOeNIUsW9H
        lLjf4mM5y9dukkCM/we83fq2NQ==
X-Google-Smtp-Source: ABdhPJwfB545VC1ov4ZmZTc67mKTH9BKIPoYlMHkgxx/oHH0ac0FXfe2j6fO1jqjoFTV3kaUhkVhjg==
X-Received: by 2002:a5d:83c4:: with SMTP id u4mr8436013ior.21.1630083647725;
        Fri, 27 Aug 2021 10:00:47 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o5sm3448725iow.48.2021.08.27.10.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 10:00:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] selftests/sync: Remove the deprecated config SYNC
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc:     "philip.li@intel.com" <philip.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
 <20210826015847.7416-2-lizhijian@cn.fujitsu.com>
 <239339d5-5626-ea04-97db-7dc070a48636@linuxfoundation.org>
 <69835666-1710-5103-fb06-2636a3a3c5bb@fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2c141f7e-bec8-49ad-2d2b-d238a372b0e6@linuxfoundation.org>
Date:   Fri, 27 Aug 2021 11:00:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <69835666-1710-5103-fb06-2636a3a3c5bb@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 7:35 PM, lizhijian@fujitsu.com wrote:
> 
> 
> On 27/08/2021 05:10, Shuah Khan wrote:
>> On 8/25/21 7:58 PM, Li Zhijian wrote:
>>> SYNC was removed since aff9da10e21 ("staging/android: make sync_timeline internal to sw_sync")
>>> LKP/0Day will check if all configs listing under selftests are able to be enabled properly.
>>>
>>
>> Can you please state what you arr fxing and also keep the sentences
>> 75 chars or less.
>>
>> Where is LKP warning?
> https://01.org/lkp
> LKP(aka. 0Day) often reports issue related to the *recent* kernel commits/WIP patches publicly.
> As the LKP keeping improvement, it will cover more aspects in the kernel so that more issues will be detected.
> 
> So in this case, which is related to too old kernel, it just reported it internally.
> 
> 
>> Include the warning and explain why this
>> change is necessary.
> - it's not reasonable to keep the deprecated configs, right ?
> 
> - In my understanding, configs under kselftests are recommended by corresponding tests.
> So if some configs are missing, it will impact the testing results
> 
> Do you mean the commit log should include above 2 reasons ?
> 

Correct. I am asking the commit log to include these details.

thanks,
-- Shuah
