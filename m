Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5614F458B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbhKVJfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:35:34 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36054
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232524AbhKVJfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:35:31 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 97DD93F32D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637573544;
        bh=6sbqD1+5Siu68STzvxvEowqyfmYjVmX0yjDAVo+n4mU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=oFKRQ73/EEACWJuHrfsPSzvVl1AE0nGZLPJvMHXQovnhLcnYjv2ZqcP4C/7oEaabk
         sboYCR+/Pzbn8dsLSC3c6WkrbPiiZa0Hm94diSqbPLGeP8gTDaX5UGZDX7jx3NTNpK
         VNJwIbsj3x0rVRYl3xuKcAwS74WVsxfRumsiGKkxeK7CWnUZat2SuXn7Igdgw84Cu6
         AaxEEu+PPCP5VBWtl9r6zMfguniYv0ewo7TTuMQtOu/qkwExfPs17G262JB0ifDgsm
         LHgau2I8Y4qn28dbwtZhgxuvtqDpFWdCVK9OCg4SgaVAdxO31hvLpBVnyNGdY1jj18
         sq2QeDsjgXAiQ==
Received: by mail-lf1-f69.google.com with SMTP id bp10-20020a056512158a00b0040376f60e35so11770131lfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6sbqD1+5Siu68STzvxvEowqyfmYjVmX0yjDAVo+n4mU=;
        b=tGl7lJF/9pO5UkUlrQg+SxDFCEWPc53Yhd/UsZtzhsT5661Z5xjnPZFnDWKXvJ5QFE
         g+gawozWLehmODYMX7FE9bcU3dnFf/IvUHM7KnKs0X9tmjCtkD3WfyAT0ByvKbIkV4OA
         itVR9UVgJ2LGdAiWuhz0+j6AyCCZs4HXUQmrBbkDKWZj5F06ZVmmIyjpgay0tIrTjHPc
         mMWMtPYCajCQlblKLHxs9Oxm3ZbRLic0oh9CU6/eBu4ZFMYWtBNsITF0HQ6NlT3TqXLX
         +I3FM/pI6n1ARt2SHDMFKVA3Z/O0uFUNsIuLtLf80zhmL/GIfzj2bGBeYOb+uGemp1Et
         SH4A==
X-Gm-Message-State: AOAM531/mmHmdDro7SYVQHf5KzbP+tWxzWTIZHJeAP/AXu9hRyd82aRv
        PRzyJGvvHvUMDzYpszoMliP68gLlCdgrwJWFsziqmdpAEjZSrXOczA36yQwQ8AwAPvUnJkegfJ0
        LozHSk0HZ1slRlFCPvZX5BGrrjO9IW5+rMbhCSrD/9A==
X-Received: by 2002:a2e:a314:: with SMTP id l20mr52899058lje.86.1637573543911;
        Mon, 22 Nov 2021 01:32:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQpfyjBTtEprk7qBKeyvZ3vNul843lbt9yNFPYmiwteRd4nScQ4+hV7xfxkfQojpZN84GYgg==
X-Received: by 2002:a2e:a314:: with SMTP id l20mr52899034lje.86.1637573543744;
        Mon, 22 Nov 2021 01:32:23 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id c6sm897368ljn.84.2021.11.22.01.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 01:32:23 -0800 (PST)
Message-ID: <7eeeb5d0-3ef1-35cd-e7e2-cdeeb979b83b@canonical.com>
Date:   Mon, 22 Nov 2021 10:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] memory: renesas-rpc-if: Silence clang warning
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20211121180155.9062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUTLYn=14RzJORp1mn-TSwC1rk1BO_9L6TG4g9JhH27JA@mail.gmail.com>
 <CA+V-a8sGA4=oxwp87VonC6zdPYT5-BHmsVoV8L1ggTUV8m4ooA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CA+V-a8sGA4=oxwp87VonC6zdPYT5-BHmsVoV8L1ggTUV8m4ooA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2021 09:46, Lad, Prabhakar wrote:
> Hi Geert,
> 
> Thank you for the review.
> 
> On Mon, Nov 22, 2021 at 7:50 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> Hi Prabhakar,
>>
>> On Sun, Nov 21, 2021 at 7:05 PM Lad Prabhakar
>> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>>> This patch silences the following clang warning:
>>>
>>> | drivers/memory/renesas-rpc-if.c:253:14: warning: cast to smaller integer
>>> | type 'enum rpcif_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>>> |           rpc->type = (enum rpcif_type)of_device_get_match_data(dev);
>>> |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Fixes: b04cc0d912eb8 ("memory: renesas-rpc-if: Add support for RZ/G2L")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>>> --- a/drivers/memory/renesas-rpc-if.c
>>> +++ b/drivers/memory/renesas-rpc-if.c
>>> @@ -250,7 +250,7 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
>>>                 return PTR_ERR(rpc->dirmap);
>>>         rpc->size = resource_size(res);
>>>
>>> -       rpc->type = (enum rpcif_type)of_device_get_match_data(dev);
>>> +       rpc->type = (enum rpcif_type)(uintptr_t)of_device_get_match_data(dev);
>>
>> While correct, the cast to "enum rpcif_type" is not stricly needed anymore.
>>
> Agreed.
> 
> @Krzysztof, let me know if you want me to resend the patch with the
> cast to "enum rpcif_type" dropped.

I can fix it when applying, thanks!


Best regards,
Krzysztof
