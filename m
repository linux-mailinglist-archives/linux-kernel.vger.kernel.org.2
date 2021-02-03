Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0D5309ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhAaUNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhAaTfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:35:48 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2154DC0613D6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 09:22:47 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s5so3351339edw.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RbOAw9iCiWf3vmIBB9AiaSewZnK8UfYjYbdl5JtZIlU=;
        b=I5Wcmj0UAC6wdR3DY92+88WJi1/9uiSMxxSlG9RelNfX805mewkB7cDRME4hvjQrnh
         krIRCOREWZpvch2cizO57Y600GiafsWMxdpdx+W/eVbGsjD86yydzaD9HwYjMUalw1dz
         6RDPmgCrhq9ddPjiOvdm5klP9Tj/siWGoLhb6hjWVMhKAW8GyMYmZ13xRDIzYcHhv2q6
         lcpZ2tdUQUc0wSHJuGLDOgCHyYCyzfD77emu6ZAyqZmd9k7i7kZlIHnfFqhLF40ykSXV
         OK5pPvM2tSOfiR4rBex91N5Io80/ocombyF02+gw4jIgWYoOUegmwZ1+7u1z5Xpl6Fpv
         08GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=RbOAw9iCiWf3vmIBB9AiaSewZnK8UfYjYbdl5JtZIlU=;
        b=LuXWRI+bY3Jl3PWQNB4jg+HQqYsVXJMP18sOJCAnB1eW83Tv51c29Szou6JJCWPHCO
         n66VIP7VQmf8FreRDYjoXhlDh19k4lDNIBhe4EPjCypX3soEHuRxYFE5flR1T4/bdWyG
         b0aEtYxn2o914MKUYBNyuSGaXG+jqKNgjPa91TE/kFqynKb5YI6PrgnVkeC8gFATaoPI
         iARyrxALT48toR2ua3dUo10EdXze5g9j91fJshOnHD80UXI6Gpp885bpvKb4VZCpbL7B
         Pl9l3lbaQvFF/4IzQgV4jeWGevjImEDi0cc0SjDLEGJgQxVw6e2o0MJDOxyrltvhjz8/
         RUfQ==
X-Gm-Message-State: AOAM531lsp0MEbM+ERSd3hXqfgxmYwOrLkUWLc38jsMarElEq/h1MqmO
        niqWV6kFSLew9TR7Vflplqw=
X-Google-Smtp-Source: ABdhPJyxGbRH/z5GOJ5Doybkfw1rnXoP6pLt1cG2awWcU3nF6e6ZKQ6evlW3bcBukvSlhs8Zvpgn/A==
X-Received: by 2002:aa7:d0d4:: with SMTP id u20mr14407950edo.203.1612113765833;
        Sun, 31 Jan 2021 09:22:45 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id j4sm7493834edt.18.2021.01.31.09.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 09:22:45 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [bug] 5.11-rc5 brought page allocation failure issue
 [ttm][amdgpu]
To:     David Rientjes <rientjes@google.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CABXGCsNazWZQGfSnFgQ_K5_H9uBQ=8gBdFORXrU1FEMGMohO2w@mail.gmail.com>
 <4ce29a7e-f58a-aeb4-bef-34a7eada70d0@google.com>
 <e0c2c823-5f-efe8-cd87-6dd6cc33a33@google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7a677c89-1974-0676-ba7d-b057ad2cab3f@gmail.com>
Date:   Wed, 3 Feb 2021 14:22:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e0c2c823-5f-efe8-cd87-6dd6cc33a33@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.01.21 um 02:03 schrieb David Rientjes:
> On Sat, 30 Jan 2021, David Rientjes wrote:
>
>> On Sun, 31 Jan 2021, Mikhail Gavrilov wrote:
>>
>>> The 5.11-rc5 (git 76c057c84d28) brought a new issue.
>>> Now the kernel log is flooded with the message "page allocation failure".
>>>
>>> Trace:
>>> msedge:cs0: page allocation failure: order:10,
>> Order-10, wow!
>>
>> ttm_pool_alloc() will start at order-10 and back off trying smaller orders
>> if necessary.  This is a regression introduced in
>>
>> commit bf9eee249ac2032521677dd74e31ede5429afbc0
>> Author: Christian König <christian.koenig@amd.com>
>> Date:   Wed Jan 13 14:02:04 2021 +0100
>>
>>      drm/ttm: stop using GFP_TRANSHUGE_LIGHT
>>
>> Namely, it removed the __GFP_NOWARN that we otherwise require.  I'll send
>> a patch in reply.
>>
> Looks like Michel Dänzer <michel@daenzer.net> already sent a patch that
> should fix this:
> https://lore.kernel.org/lkml/20210128095346.2421-1-michel@daenzer.net/

Yeah, known issue. I already pushed Michel's fix to drm-misc-fixes. 
Should land in the next -rc by the weekend.

Regards,
Christian.
