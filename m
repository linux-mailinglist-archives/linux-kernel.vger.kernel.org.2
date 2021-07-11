Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2203C3AA6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 06:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhGKFBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 01:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhGKFBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 01:01:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12062C0613DD;
        Sat, 10 Jul 2021 21:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=UxQ2dIQx/zfnKbmU0OxyUOKsymrLJGr1c/xiyGR4OGM=; b=npej3SVbfKj9hGliI+29YjHDDk
        CHyP4kh+IWGy3lrtzDExa6t8RFqr7ohRqjPcpsOhLu/ydlDTPU/Zr5C03rzKyoE4xyvQ1jd7KYGZ4
        wZkdtv6AoM3Nlm8z35OeVgExUvRMvMU3bnGofsaf0wvy4XLSfI4Frd0swX+B2GJwnbKiTPzwwh1Ew
        loDcYV0rDrMYdqabubTaA9xKmTh0PytgNTxhMz5hgZa40Pg+ItJuvbFjBZknJFdOv/CYqWi1vDrO9
        Bpf1Zm5hMvf40WpcaghlVUPaRY/dDtZB97FeHMfbH9+vC7SPTUWk97I2VOvFYnyCDopXTKHiQImCG
        LqsKQkAw==;
Received: from [2601:1c0:6280:3f0::a22f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2RY2-004ZiS-Ja; Sun, 11 Jul 2021 04:58:34 +0000
Subject: Re: [PATCH v3 2/3] hwmon: da9063: HWMON driver
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
 <2c24ef5953401e80d92c907704bffeff1d024de0.1625662290.git.plr.vincent@gmail.com>
 <20210710160813.GA3560663@roeck-us.net> <20210711025502.347af8ff@gmail.com>
 <20210711044419.7b1c00f8@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f9113bf9-ab00-d0b1-cbc2-f4107b93e727@infradead.org>
Date:   Sat, 10 Jul 2021 21:58:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711044419.7b1c00f8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/21 9:44 PM, Vincent Pelletier wrote:
> On Sun, 11 Jul 2021 02:55:02 +0000, Vincent Pelletier <plr.vincent@gmail.com> wrote:
>> On Sat, 10 Jul 2021 09:08:13 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
>>> Unnecessary include.
>> [...]
>>> I don't immediately see where this include is needed. Is this a
>>> leftover ?
>> [...]
>>> Same here.
>>
>> Are there ways to systematically tell which includes are useless
>> besides commenting them out all and uncommenting until it compiles ?
>> (if that is even a good idea)
> 
> I tried this, just to get a baseline: the module compiles with just
>    linux/hwmon.h
>    linux/mfd/da9063/core.h
>    linux/module.h
>    linux/platform_device.h
>    linux/regmap.h
> 
> Beyond what you suggested this also gets rid of:
> - seems reasonable:
>    - linux/delay.h
>    - linux/init.h
>    - linux/slab.h
> - looks suspicious to me:
>    - linux/err.h, which means the error constants are indirectly
>      imported. Removing it feels brittle.
>    - linux/kernel.h, although to my surprise a lot of c files do not
>      include it.
> 
> By default I'll drop the former and keep the latter in the
> next version, please let me know if another combination is preferred.
> 

Hi,

Please use Rule #1 from Documentation/process/submit-checklist.rst:

1) If you use a facility then #include the file that defines/declares
    that facility.  Don't depend on other header files pulling in ones
    that you use.


so if Enumbers (error numbers) are used, then #include the header file
for that.

etc.

thanks.

-- 
~Randy

