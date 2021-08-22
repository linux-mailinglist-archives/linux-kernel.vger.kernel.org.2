Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862C73F40B2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 19:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhHVRi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 13:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhHVRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 13:38:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DEEC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 10:38:14 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k5so32808189lfu.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6NIIlmrM1M/Zn9wE/qIDg3xKfQE8bmnDl6vhZrmG6N4=;
        b=JXaxLoghO3b7+2JCIuQpT1pIgRtQScjru3C3dMhUl5ZPjFzppUgerFbPTLOI2PPOPU
         tCEHyDZ/HLyRKwjIUghpo5JKujhyzD1kW/xwU/g3EK+JSjfyY8Pv4ch8TslMhRiXsqBI
         kZTEX3nZc9G8EOfbJDGAlWsckm1NJKkhzyx2zNnFNB3YT1oFpYq0QFa7XDN14iG/A4xl
         ZfslMrpOBbCylHFlTQ3bKBas9O+HL7ZOn1daACWbqkQDGAmVvEJlUw5CEeMyMKJZy/tN
         hefIoGqlHilPhSIinsFNrTrNJG6mgcd67Y12MFnmz7M/2h+Xxf9kMXQWAejcMn8hiVYf
         HiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6NIIlmrM1M/Zn9wE/qIDg3xKfQE8bmnDl6vhZrmG6N4=;
        b=V+XP5aoOGLIkCEwSqlveXuUhUrM3bh5n6tZzyiz8jx/K7VSOxhP7FrfTao5gyWkLlZ
         KaGIzfrXBDpAXXbWafysp3mchWVvDVN6JKWj7Pl/yJ+OjMCLEoF7qxthG9bvnr2EyCj8
         XjessKOQVKeekR3nouUH8sgcg8Mv0eYyoZUgaEP1qPHpLuFCPRikw8S6jqflaUly2obq
         tPLwWBKRfpRaweLd0PtLVoBsxfmVkgs5NemugnrtSeW5JGiBDIMuEqinGk2bRSXPuqSu
         4CU6iI6pLHcgJ4QpN/w1FJrVDaBtX5ZaohhfF05zSA2CT0f0IbpRUlejJ6gNql/luG57
         7NaA==
X-Gm-Message-State: AOAM5303Qx2fGYzV6YyWmYua7gjY8RTuQQo1ybIKKRtLg8M9siBnlgiF
        2CfoZMfHN5UwVisoF53O8j6WdxDM9Pu+9i8o
X-Google-Smtp-Source: ABdhPJwyn55tpdIlP3Wuh4/orBl8zAbtg4zIUe2BTyREjvt3PFONlS2w1Ax9wu3y+FLkSIHd0UpXvg==
X-Received: by 2002:a05:6512:b93:: with SMTP id b19mr18346549lfv.453.1629653892645;
        Sun, 22 Aug 2021 10:38:12 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id g18sm586317lfb.23.2021.08.22.10.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 10:38:12 -0700 (PDT)
Subject: Re: [PATCH RFC v2 0/6] staging: r8188eu: avoid uninit value bugs
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com>
 <cover.1629642658.git.paskripkin@gmail.com>
 <15979623.JslXr83I74@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <9ef4cd9f-4f0c-bc6a-76d2-b9e30f6744a4@gmail.com>
Date:   Sun, 22 Aug 2021 20:38:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <15979623.JslXr83I74@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 8:36 PM, Fabio M. De Francesco wrote:
> On Sunday, August 22, 2021 4:35:05 PM CEST Pavel Skripkin wrote:
>> Hi, Greg, Larry and Phillip!
>> 
>> I noticed, that new staging driver was added like 3 weeks ago and I decided
>> to look at the code, because drivers in staging directory are always buggy.
>> 
>> The first thing I noticed is *no one* was checking read operations result, but
>> it can fail and driver may start writing random stack values into registers. It
>> can cause driver misbehavior or device misbehavior.
>> 
>> To avoid this type of bugs, I've changed rtw_read* API. Now all rtw_read
>> funtions return an error, when something went wrong with usb transfer.
>> 
>> It helps callers to break/return earlier and don't write random values to
>> registers or to rely on random values.
>> 
>> Why is this pacth series RFC?
>>   1. I don't have this device and I cannot test these changes.
>>   2. I don't know how to handle errors in each particular case. For now, function
>>      just returns or returns an error. That's all. I hope, driver maintainers will
>>      help with these bits.
>>   3. I guess, I handled not all uninit value bugs here. I hope, I fixed
>>      at least half of them
>> 
>> v1 -> v2:
>>   1. Make rtw_read*() return an error instead of initializing pointer to error
>>   2. Split one huge patch to smaller ones for each rtw_read{8,16,32} function
>>      changes
>>   3. Add new macro for printing register values (It helps to not copy-paste error
>>      handling)
>>   4. Removed {read,write}_macreg (Suggested by Phillip)
>>   5. Rebased on top of staging-next
>>   6. Cleaned checkpatch errors and warnings
>> 
>> Only build-tested, since I don't have device with r8118eu chip
>> 
>> Pavel Skripkin (6):
>>   staging: r8188eu: remove {read,write}_macreg
>>   staging: r8188eu: add helper macro for printing registers
>>   staging: r8188eu: add error handling of rtw_read8
>>   staging: r8188eu: add error handling of rtw_read16
>>   staging: r8188eu: add error handling of rtw_read32
>>   staging: r8188eu: make ReadEFuse return an int
> 
> Hi Pavel,
> 
> I've just read your v2 of the series. I had no time to read each and every line,
> however, I suppose that I saw enough to say that I think they are a huge
> improvement over v1. I really like your patches and if I were you, I'd drop
> that RFC tag.
> 

Thank you, Fabio! I appreciate it :)


With regards,
Pavel Skripkin
