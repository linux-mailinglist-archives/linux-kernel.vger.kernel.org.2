Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DA93EB44E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 12:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbhHMK4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 06:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhHMK4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 06:56:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E2AC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 03:56:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z2so19245196lft.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 03:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TLuaFzoOKw+CbWnwJmYr9Zf013XDrND1bDlrJaLGxBk=;
        b=S2wyNo8ppmqVTaJvM3eGLCdd1cWZ668tYQi4+b5gofki3xPyrvGX2njSxbXbjPCs8G
         ijJLeqZoBafGQY1Kx3386s+CiNvhcxZWu96529KJN0ri9Yf9ET2lRCfHp2GQ6Tfa/s9I
         NujKhqj3FogKRfnLd/zBeNqJgR8XTgNonPjckB4JPXYbaUMDZv7hcNHK1bpQhmis5HR9
         t+WOJe8EwE/k1SKNUf+0Csaw38H/ZQ58rvY/DYNVZ/nDYr3X00u6aNHXm3d6R6/5KKP+
         PyamV4bSS/717BLvRnFGHpeOMsBUk9RdzS2fWwQLaiocvaF+mif8LQAKXxEi2aD7alwg
         dYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TLuaFzoOKw+CbWnwJmYr9Zf013XDrND1bDlrJaLGxBk=;
        b=NNWr9QPsYeTackl0d6Xl47H2XdUj4cUDPyxp82Q4Fv+YHfHPj6bBhOAFjvMOHh4B20
         n4cSrHUYtwjVrmj4Ntt/e2GPZOKHx+un241Qm/cPFvs5e2ZlmrqXqawmTxZbDUOjpzSU
         DzfjcTgZ6nNU6MO/X2QL9sfplb9iWuF+H+co4KDd2u58UUM8Ii+ZlzEUeln0Odux/1ec
         nOXlQHy/EI6cXyklxaV3QIbdB5vu/zE6toqLAfA+NlKGAirg5uWtwFX4arqB/ROWmOrs
         pHsUmb2NqHdIUmCOQL3IunO0hykcIICYo/NUH+/68g3lHSn/qK9mEu9SJHbIprTEx1Jc
         xnbg==
X-Gm-Message-State: AOAM532i8dcIf2qe/Kveki/SuzGdU95tiEg2SqCjh3UYlsmq39AajcdH
        8ZOSXVzAMTsVDpzuq8twdG0=
X-Google-Smtp-Source: ABdhPJxW+dH9xc0yN+C18MbKNZ8lFILQJBmnAiSAdYoXm1FTvzWhGmBco65Nh6Z8AQaw8Z5ZJqaHaQ==
X-Received: by 2002:ac2:5971:: with SMTP id h17mr1214184lfp.570.1628852179380;
        Fri, 13 Aug 2021 03:56:19 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.232])
        by smtp.gmail.com with ESMTPSA id e7sm142315ljq.9.2021.08.13.03.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 03:56:18 -0700 (PDT)
Subject: Re: [PATCH] profiling: fix shift-out-of-bounds in profile_setup
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        rostedt@goodmis.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com
References: <20210716190409.25523-1-paskripkin@gmail.com>
 <7bc788bf-ba81-5732-957e-55edf522d1ca@i-love.sakura.ne.jp>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <a222a2b1-63bd-9fe1-cbc4-ca0e1e214a46@gmail.com>
Date:   Fri, 13 Aug 2021 13:56:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7bc788bf-ba81-5732-957e-55edf522d1ca@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/21 2:21 PM, Tetsuo Handa wrote:
> On 2021/07/17 4:04, Pavel Skripkin wrote:
>> Syzbot reported shift-out-of-bounds bug in profile_init().
>> The problem was in incorrect prof_shift. Since prof_shift value comes from
>> userspace we need to check this value to avoid too big shift.
>> 
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Reported-and-tested-by: syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com
>> Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>> ---
>>  kernel/profile.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/kernel/profile.c b/kernel/profile.c
>> index c2ebddb5e974..c905931e3c3b 100644
>> --- a/kernel/profile.c
>> +++ b/kernel/profile.c
>> @@ -42,6 +42,7 @@ struct profile_hit {
>>  
>>  static atomic_t *prof_buffer;
>>  static unsigned long prof_len, prof_shift;
>> +#define MAX_PROF_SHIFT		(sizeof(prof_shift) * 8)
> 
> I came to think that we should directly use BITS_PER_LONG, for
> the integer value which is subjected to shift operation is e.g.
> 
> 	(_etext - _stext)
> 
> part of
> 
> 	prof_len = (_etext - _stext) >> prof_shift;
> 
> in profile_init().
> 
> Since "unsigned char" will be sufficient for holding BITS_PER_LONG - 1,
> defining MAX_PROF_SHIFT based on size of prof_shift is incorrect.
> 

I don't get it, sorry. Do you mean, that

#define MAX_PROF_SHIFT		BITS_PER_LONG

is better solution here? And as I understand we can change prof_shift 
type from "unsigned long" to "unsigned short", rigth?



> Also, there is
> 
> 	unsigned int sample_step = 1 << prof_shift;
> 
> in read_profile(). This may result in shift-out-of-bounds on BITS_PER_LONG == 64
> architecture. Shouldn't this variable changed from "unsigned int" to "unsigned long"
> and use 1UL instead of 1 ?
> 

Yep, it's necessary. Will do it in v2


With regards,
Pavel Skripkin
