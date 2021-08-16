Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C323EDAF9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhHPQal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhHPQa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:30:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C886DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:29:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dj8so19461227edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O/3RSOr5idTzCkHgdv/67Cswx38gY7f+MFagM4CWCLU=;
        b=gDDPXuHXNrkEONFxEWNW670ArXzUE+3rJT+WJypA5PjmA8/h9tj8A1OYQv7WIDqVsQ
         5Ez0k5lU3prlycGVprUOhp3l+TD2xaic/zf1juDeI7XWwNlp3ZYtrEuqEkQ7WGNY3lWO
         Yp4x67eYWCyDkqTEFMFy7k0+uu5vDm4tKMDRVD/OTDXB1918nFD3LCjFLKlA66QS9Dgk
         nA4ID14ZaLSH7chg/m1lTSlCaywyv9lR7r15ZFAMZBOrDDaYPvMYnYIQDo9Ep8D8kBY5
         vUV2Mr50q25EDWtEqtMr4CzB+7aHoJqlHp4pdan8GXgDHeP8wIPWix71jg+f3SoOW26e
         KQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/3RSOr5idTzCkHgdv/67Cswx38gY7f+MFagM4CWCLU=;
        b=alFGsXRDETRWJIGSgauD83aMX162tB5BdzBdgqdR0TXDJF7yHodhLApqrEumE9t1HQ
         uOxxKhXSPCAzlLdY4fye/Qb/jVk3bMrkmzb8RhhHa6hh4rw/VUn/2lYNrvJ7MOVaIbf0
         p8w++V+ykYfk0PNMebIOBhBaX/04ewSeb4/GyX6Yqy3EUwB5NWrslgqh7bvjXcvGrJ3k
         aityOFKOgTSO050vIcLMxj+35DRVZPDIV+KX4fndADSNM2FEuEQ97VnHydYj7pnBBh0/
         yujThLKPOrNgYdi1ihJRxf0tSNpEqLwG+Xvnxh0UwYJk1YMDcPc3Hfx4JckIOgBO19eM
         RYdQ==
X-Gm-Message-State: AOAM530uHebhKzidfWA5w98sWnAa65eI0t5Fu+67Gt6Utm43ubiukYwv
        KVcdpusuOLYjtXaS4g+wz8IxGi/jKag=
X-Google-Smtp-Source: ABdhPJy3PhA/YEk0suXqa3BX0mFMPTIeraxyI63ZHI4qHnADtNIGYOcajJuJmF+JWH4KR4KPCCRymQ==
X-Received: by 2002:a05:6402:2889:: with SMTP id eg9mr21873760edb.38.1629131394389;
        Mon, 16 Aug 2021 09:29:54 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::4058? ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id m18sm5094041edr.18.2021.08.16.09.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:29:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] staging: r8188eu: refactor
 rtw_is_cckrates_included()
To:     Joe Perches <joe@perches.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210816115430.28264-1-straube.linux@gmail.com>
 <22319347.s0ZA6q4zN9@localhost.localdomain>
 <c30b9e08b7df2bade93d217c0bf6eb4b416eb2ec.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <6033ab2b-d741-32a3-8b35-b76d63cee05a@gmail.com>
Date:   Mon, 16 Aug 2021 18:29:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c30b9e08b7df2bade93d217c0bf6eb4b416eb2ec.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 6:15 PM, Joe Perches wrote:
> On Mon, 2021-08-16 at 14:59 +0200, Fabio M. De Francesco wrote:
>> On Monday, August 16, 2021 1:54:27 PM CEST Michael Straube wrote:
>>> Refactor function rtw_is_cckrates_included(). Improves readability
>>> and slightly reduces object file size.
>>>
>>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>>> ---
>>> v1 -> v2
>>> Refactored to more compact code as suggested by Joe Perches.
>>>
>>>   drivers/staging/r8188eu/core/rtw_ieee80211.c | 9 ++++-----
>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>
>> Thanks for redoing the series as suggested by Joe Perches.
>> This is a perfect case where conciseness and readability don't clash and
>> instead the former enhances the latter.
> 
> Perhaps do the whole thing in one go (moving the & 0x7f into the helper
> avoids an early loop exit defect when the rate being indexed is 0x80)
> 

I will send v3 with your suggestions. The comparsions to boolean
( ... == true ) will be addressed in a separate series that cleans
up comparsions to true/false in all files.

Regards,
Michael


