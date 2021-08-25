Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27BB3F7639
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbhHYNpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbhHYNpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:45:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C0C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:44:36 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s12so18562538ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rYkXVeoS0VQkQDH+la46zmVl272xw9ola2W/w/JjUaA=;
        b=keo1I2aUlOgqbTjyviXQrX2APtGkOrSmRoLis6rMft0n3LEmjU/7ktwHwRHPVRTwgZ
         4p4wGa9VidIgbxzGD4DEML6MTUV9nHA0w5ACrez+tCawxQlnMi75nLVH5++3smdJ7NRk
         og30h2F8BKLe6YFpETMRHJRdLsF30ZnQdfMe90Yl1bKKs39MxWwZrqLlTAf5a/DuHUhM
         eRUzoITaiEqynGDX+Pt4xU4DOvQ662XuTYpj7oLGCQ9sleqCnriweQaGLccQ3ARndGHV
         ZWdtQkZqAa6iMsdo/JekSlbKiVpPCUIlcGes6Xwf1NKAb0Mc3d8vR9TniCL6A7bBMdZv
         Ozqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rYkXVeoS0VQkQDH+la46zmVl272xw9ola2W/w/JjUaA=;
        b=K33viSeI+s0yikrL9nDUYMxgIX4H+K5JxdGEsokMo0kumXfNucETXKOnUDmb+StDRO
         D4bdjqaEHjfmWFWbyRGKBScNnXdoIWtb7mf6L+M6jRjuVU61iZ3iQJqA1WChubmdcUyW
         DBMYrbncRaIsvf7CZo0w3Bva62WFpBys1N/Tz6O0AmjvyyrAj6IZj6EjZ9PX42WhDLnZ
         266BMh265+IbmH6yucuKuyg/vUt3N7s2NnYQr60V11DqknkuL9VOhrXFN6YQB/kPUR01
         tYlH4vOGZbjWUmojT2Q+QVhU26JQPV80SgSY1Xs+wvUbEnwzcgP/p54tzFVmvqERktU2
         1ihg==
X-Gm-Message-State: AOAM532zFXI1XYKKY3n68JdTUmNRsuLMd7tZV9zKOhYEiBNTX6cbWaDC
        Ilv2Lxp5J/8vdjKde90ozPlQ3RqTQYMY4w==
X-Google-Smtp-Source: ABdhPJwQ2kc0ijx6DzIyyLLuVogoLaFtdmxKJ7udCht7raRcU7ih+atiF/PvaOnMPpoPYKB3fubP5Q==
X-Received: by 2002:a2e:bd09:: with SMTP id n9mr36757665ljq.76.1629899074428;
        Wed, 25 Aug 2021 06:44:34 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id r7sm8818lfr.60.2021.08.25.06.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 06:44:33 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] staging: r8188eu: add error handling of rtw_read8
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kernel test robot <lkp@intel.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
 <202108251911.Vwmzl4rI-lkp@intel.com>
 <9743e1ee-75f4-6231-427b-8c7f659fb252@gmail.com>
 <20210825125159.GU1931@kadam>
 <bd50c00e-1814-dc32-36cf-73cf58123201@gmail.com>
 <20210825133432.GW1931@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <c982eea8-3b16-656b-dcb3-1b6e0d3e995d@gmail.com>
Date:   Wed, 25 Aug 2021 16:44:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825133432.GW1931@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 4:34 PM, Dan Carpenter wrote:
> On Wed, Aug 25, 2021 at 04:02:26PM +0300, Pavel Skripkin wrote:
>> > This is not related to your patch.  Ignore it.
>> > 
>> > 
>> > > > vim +2022 drivers/staging/r8188eu/hal/usb_halinit.c
>> > > >
>> > > 
>> > > >    2020		case HW_VAR_BCN_VALID:
>> > > >    2021			/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
>> > > > > 2022				u8 tmp;
>> > > 
>> > > Hm, I don't know anything about ARM compilers, so should I wrap this code
>> > > block with {}?
>> > 
>> > Yep.
>> > 
>> > > 
>> > > My local gcc 11.1.1 (x86_64) does not produce any warnings/errors
>> > > 
>> > 
>> > You should figure out whats up with that because it shouldn't compile
>> > with the gcc options that the kernel uses.
>> > 
>> 
>> AFAIK, at least 2 guys except me in this CC list compiled my series without
>> errors/warnings. Maybe, staging tree is missing some Makefile updates?
>> 
>> 
>> I'll resend series this evening anyway, but this is strange....
> 
> Hm...  In my version of GCC the error is:
> 
> drivers/staging/r8188eu/hal/usb_halinit.c:1870:3: error: a label can only be part of a statement and a declaration is not a statement
> 
> That's a different error from what I was expecting.  It's caused by
> having a declaration directly after a case statement.  The warning that
> I was expecting was from -Wdeclaration-after-statement and it looks
> like this:
> 
> warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> 
> You really should try investigate why this compiles for you because
> something is going wrong.  It should not build without a warning.
> 

Looks like it's bug in gcc 11.1.1. I've rebuilt this module with gcc 10 
(gcc-10 (SUSE Linux) 10.3.1 20210707 [revision 
048117e16c77f82598fca9af585500572d46ad73]) and build fails with error 
described above


My default gcc is

gcc (SUSE Linux) 11.1.1 20210721 [revision 
076930b9690ac3564638636f6b13bbb6bc608aea]


Any idea? :)


With regards,
Pavel Skripkin
