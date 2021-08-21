Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25E3F3A40
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 12:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhHUKnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 06:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHUKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 06:43:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD656C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 03:42:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id v19so915565lfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=++nuhkr/DqW2s47uscZNM6t2OksbeUl9i6AgDlpry78=;
        b=oNxTHh2E/oyfawWxymEodPLUOJdfX/QGRwhzprgxXULBs7ipPBYi/qGbKB1ubUGyD8
         GN6dK66qHa7rSyQSufEfzZmikr76XP07Fbbgy3Xe7zPRFu95hfsL/nwL1X89fxkyeUrS
         A3FS/Pb6c2bng0YIYO3TlyF1Nzl+b+iYWV2z95hVm8+7w9/4V8H6AYIuzTaScPBLL0im
         Rsmzc53lCwyL7CTsPTpxR+7ZMtsf4o8GPj4kfJAtZRoduVbGTAmOiFzrHRhUiqaU5qXk
         r17YR26DhnxMmR16qlJ+sqItanmqwANUecAVmQZzMEzFtte5J/eQD+28LlK4i9oBU4XM
         DPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=++nuhkr/DqW2s47uscZNM6t2OksbeUl9i6AgDlpry78=;
        b=LU1CS2ggYz3+Nhgz/gPx6O42/KpZPU/Su5gh1r0Y6H6rLalX+hVmy5vBtqN2eoZb7G
         4ddEZTdeaMko4Fl42WrYXZvEHgLWtRGdN0DA5D0nZHThFHHUiux9LbdOSaY1lU7OVV2M
         UCHjSRKsXZKhGnprmG4bvV3ISjtdicxfQAEWyLrGMDHUKtt1TLLIP7JVA6l3PTI/Uo1p
         uDYWJE5Jx5OkyT7h5Q+JBGf0611jBEg683t9pCIOJSQZ5fGdFPnNpmGWhQuCub4mxf+Z
         MCL0wXFMOl8d0d3nY3X5HGttGMECJgloIGNYWEm3YiRy4MVsBs98lzaYlD6hXXkB0UiS
         tjlQ==
X-Gm-Message-State: AOAM53362Nxe+HfCH7RygkU01tddoQae4kwsy5MU1Ltt7Dfdt6nL8GlY
        mCMxLDhVtVdg/zV3Qw3vkDk=
X-Google-Smtp-Source: ABdhPJzwoq7HeJILrGtHhi8Z6cje/cBSWmD2LSLS9Sj3HEqTMP0v+MpKZAjBEoh9x5L8Y36LSJU/2Q==
X-Received: by 2002:a05:6512:39d1:: with SMTP id k17mr18064104lfu.464.1629542553143;
        Sat, 21 Aug 2021 03:42:33 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id d5sm880100lfm.73.2021.08.21.03.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 03:42:32 -0700 (PDT)
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com
References: <cover.1629479152.git.paskripkin@gmail.com>
 <df71ec12574f546edc0620dc5624c09e921a8f23.camel@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <8d16252d-d85d-284b-0235-f41d5d2166cf@gmail.com>
Date:   Sat, 21 Aug 2021 13:42:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <df71ec12574f546edc0620dc5624c09e921a8f23.camel@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 2:12 AM, Phillip Potter wrote:
> On Fri, 2021-08-20 at 20:07 +0300, Pavel Skripkin wrote:
>> Hi, Greg, Larry and Phillip!
>> 
>> I noticed, that new staging driver was added like 3 weeks ago and I
>> decided
>> to look at the code, because drivers in staging directory are always
>> buggy.
>> 
>> The first thing I noticed is *no one* was checking read operations
>> result, but
>> it can fail and driver may start writing random stack values into
>> registers. It
>> can cause driver misbehavior or device misbehavior.
>> 
>> To avoid this type of bugs, i've expanded read() API with error
>> parametr,
>> which will be initialized to error if read fails. It helps callers to
>> break/return earlier and don't write random values to registers or to
>> rely
>> on random values.
>> 
>> Why is this pacth series RFC?
>>   1. I don't have this device and I cannot test these changes.
>>   2. I don't know how to handle errors in each particular case. For
>> now, function
>>      just returns or returns an error. That's all. I hope, driver
>> maintainers will
>>      help with these bits.
>>   3. I guess, I handled not all uninit value bugs here. I hope, I
>> fixed
>>      at least half of them
>> 
>> This series was build-tested and made on top of staging-testing
>> branch
>> 
>> 
>> With regards,
>> Pavel Skripkin
>> 
>> Pavel Skripkin (3):
>>   staging: r8188eu: add proper rtw_read* error handling
>>   staging: r8188eu: add error handling to ReadFuse
>>   staging: r8188eu: add error argument to read_macreg
>> 
>>  drivers/staging/r8188eu/core/rtw_debug.c      |  79 +++-
>>  drivers/staging/r8188eu/core/rtw_efuse.c      | 119 +++--
>>  drivers/staging/r8188eu/core/rtw_io.c         |  18 +-
>>  drivers/staging/r8188eu/core/rtw_mp.c         |  38 +-
>>  drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  20 +-
>>  drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   6 +-
>>  drivers/staging/r8188eu/core/rtw_sreset.c     |   7 +-
>>  drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   9 +-
>>  drivers/staging/r8188eu/hal/hal_com.c         |  22 +-
>>  drivers/staging/r8188eu/hal/hal_intf.c        |   6 +-
>>  drivers/staging/r8188eu/hal/odm_interface.c   |  12 +-
>>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  37 +-
>>  drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   6 +-
>>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 260 ++++++++---
>>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  26 +-
>>  drivers/staging/r8188eu/hal/rtl8188e_sreset.c |  20 +-
>>  drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  17 +-
>>  drivers/staging/r8188eu/hal/usb_halinit.c     | 412 ++++++++++++++--
>> --
>>  drivers/staging/r8188eu/hal/usb_ops_linux.c   |  55 ++-
>>  drivers/staging/r8188eu/include/hal_intf.h    |   6 +-
>>  .../staging/r8188eu/include/rtl8188e_hal.h    |   2 +-
>>  drivers/staging/r8188eu/include/rtw_efuse.h   |   4 +-
>>  drivers/staging/r8188eu/include/rtw_io.h      |  18 +-
>>  drivers/staging/r8188eu/include/rtw_mp.h      |   2 +-
>>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 168 +++++--
>>  drivers/staging/r8188eu/os_dep/usb_intf.c     |   4 +-
>>  26 files changed, 1072 insertions(+), 301 deletions(-)
>> 
> 
> Dear Pavel,
> 
> Firstly, thank you for this contribution, it is much appreciated.
> Whilst I'm still learning myself when it comes to this driver and to
> kernel code in general, I can certainly say the code looks pretty good
> in general so far. I will try and offer individual comments on each
> patch.
> 

Thank you for your feedback. So, I will prepare a v2 version in few days 
and, I think, I will leave RFC prefix.

Also, I want to receive some feedback from Larry about error handling in 
each particular case, I guess, he can help us with it.

So, I will split each rtw_read* changes into separate patche and make 
them return an error instead of read value.


Again, big thanks to you and Fabio for feedback, I appreciate it :)




With regards,
Pavel Skripkin
