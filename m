Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFB6347A66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhCXOPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbhCXOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:14:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D713BC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:14:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u9so33122150ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FCHZXs+Na6H0beDmf/OCng/T5K6DKQZL7k9xPgulymE=;
        b=CSmURK4SwSnVaLiGIPpo0hW0XaafR3WnY0Kktfn6Q8w2WAkQ2pI/vtZsaqDMr+Rrqm
         3j9+izYQ4UqWXHMKZToSCUpFRjOnIXY8UJy2FWXpJpqMTZ1LwLqfqxHXjI3T7WuIhnJ3
         rDX0OvQ/BcN4cPnIJD1S57p05tgOJZ1lraw5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FCHZXs+Na6H0beDmf/OCng/T5K6DKQZL7k9xPgulymE=;
        b=M/LyLcQVNmSOiidj+ksqL/uTWnyOZu0LXHcFS/roseiW4GBM5nM2VbJMaGz5SPH0Uu
         kHUPYbunByb0sedWFvTqr0a45LZ1V++eRZgtxUkY9FmrKxwoLqen7obB3K0Vw/82x4KZ
         20Lj8nWIfD4MGw4q+vLnyCp4LyKvNfdNEGNQ8BsBqScMKvgLcDngX/qpiiiVl/l+8LQ0
         5wESWX/7gn2QNlP+PBANwpb+xOOcUzvCK2U4yJ8wqrzlwKLxoqrdxWtl8XFbhE5B3bKN
         TADP0kMVLSBTaZv6ZWNiQnxM9PcXmNN2z8EUNgSVQCiNcDb+WdngJX7Km6lOwelndH8s
         mmWQ==
X-Gm-Message-State: AOAM533Fm+I1HYOweZrt2LnC2vqMInpoJN5omPna+w8g3V09iNqmxel5
        9pEVzjASsT2CNpqzTd2vuIkxy2rrkz+ybA3s
X-Google-Smtp-Source: ABdhPJww1pdM64UL62x05vVdAART6xCBNzDfZeqUIHi/5inBRmV8dfVIuzHdABjEJtiJD1nhk3/fww==
X-Received: by 2002:a17:906:8447:: with SMTP id e7mr3979848ejy.523.1616595278353;
        Wed, 24 Mar 2021 07:14:38 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id c10sm1179885edt.64.2021.03.24.07.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 07:14:37 -0700 (PDT)
Subject: Re: [PATCH] amdgpu: fix gcc -Wrestrict warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210323130430.2250052-1-arnd@kernel.org>
 <f8cd5d0b-0c50-a2e9-a5a1-a2358419dd44@rasmusvillemoes.dk>
 <CAK8P3a17=PdOqKrvemuP1OCzoxRZ0HLBje-tV4Ssc=kZeVbQRw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4e63dbbc-0aa3-2950-dda1-1e6aa19d7d5d@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 15:14:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a17=PdOqKrvemuP1OCzoxRZ0HLBje-tV4Ssc=kZeVbQRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 14.33, Arnd Bergmann wrote:
> On Tue, Mar 23, 2021 at 4:57 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>> On 23/03/2021 14.04, Arnd Bergmann wrote:
>>>                       if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
>>> +                             int pos = 0;
>>>                               memset(i2c_output,  0, sizeof(i2c_output));
>>>                               for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
>>> -                                     sprintf(i2c_output, "%s 0x%X", i2c_output,
>>> +                                     pos += sprintf(i2c_output + pos, " 0x%X",
>>>                                               securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
>>>                               dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
>>
>> Eh, why not get rid of the 256 byte stack allocation and just replace
>> all of this by
>>
>>   dev_info(adev->dev, ""SECUREDISPLAY: I2C buffer out put is: %*ph\n",
>> TA_SECUREDISPLAY_I2C_BUFFER_SIZE,
>> securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf);
>>
>> That's much less code (both in #LOC and .text), and avoids adding yet
>> another place that will be audited over and over for "hm, yeah, that
>> sprintf() is actually not gonna overflow".
>>
>> Yeah, it'll lose the 0x prefixes for each byte and use lowercase hex chars.
> 
> Ah, I didn't know the kernel's sprintf could do that, that's really nice.

If you're bored, you can "git grep -E -C4 '%[0.]2[xX]'" and find places
that are inside a small loop, many can trivially be converted to %ph,
though often with some small change in formatting. If you're lucky, you
even get to fix real bugs when people pass a "char" to %02x and "know"
that that will produce precisely two bytes of output, so they've sized
their stack buffer accordingly - boom when "char" happens to be signed
and one of the bytes have a value beyond ascii and %02x produces 0xffffffXX.

%ph has a hard-coded upper bound of 64 bytes, I think that's silly
because people instead do these inefficient and very verbose loops
instead, wasting stack, .text and runtime.

Rasmus
