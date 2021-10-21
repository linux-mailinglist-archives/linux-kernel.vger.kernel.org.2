Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5143650D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhJUPJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhJUPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:09:17 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A6EC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:07:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 75so593773pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8J+7f2f4xuhNe3jNVdWk7a86I7pUDjUPQRras1jT8jA=;
        b=j2xqGy2XNECrbul6qEKx9SST/rdB96W/R24/Vvcb8OqiQ/EHcxnhHYfq5uycgpIPfE
         RcoveVySySpwpVV4tBCzFXMBjD2Nbo+r7Vouu3zvunyfI91UcGulu7Nf/Efg6vE0BHHv
         /LkDq7xiH7ZfRV3m5sF462W0KJ3z1wKCyuvxatQAiZ0IhNp9AB4OJO5f48RqdrwxWEXV
         mKN4COsAen3/I4rFmP2EK85hFYa8xqnSauu6h/p0/SzhsTzXY2mralghgKwja2Of6/fO
         GfDWT4tqD+WyHwETcfuO7Mci1xa1bCHrSgDFMYZySCx/rxAhmzRhX68rxf6QbT/UQcIq
         UsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8J+7f2f4xuhNe3jNVdWk7a86I7pUDjUPQRras1jT8jA=;
        b=k2YCqwVk6pm1BbIMJiSDJX7SvojbkPTOAkYtZdP4jaZfmxusLB6pEoDjHiFbOdaw4J
         fqrAkw5i2Uxl4N04zAT9whVo4jG5lgBYkjhOH8qlXx8TqxJWOxJjszOxRYcA0HwzEnCc
         0hfspVFnoagmhkqFV9cqIZDZpttjwGodhHsM2eeIyBQCY/icZ4FpFDSsdfAsoIVJJ6y9
         1yCIc+ayYyt/w507PpaDluIYxF0vU33mXjQXpOVe6Aj/IUvsVTVVNssP3cXsR1wcNEWl
         QaoNxWIyywUzkj7q8k7jUWxhaHr0o11l7utScIORBhA4470OPDN88k5yHu8SL++OdAAk
         n3og==
X-Gm-Message-State: AOAM5326OLNp/jeeMuRO5+5sA9F8gpD/2Pk9WcL5q2SBLImeOIgZOh2D
        rOii9corQx7j/Vpj6Avgw71Leg==
X-Google-Smtp-Source: ABdhPJyz7GFpoPYi0O9X5+kNyiRMV3FyOoAIfXtYBZpu6m8G0bDaRlzBGocZrUEoxY+npHCfOUgOYA==
X-Received: by 2002:a05:6a00:b48:b0:444:f9d4:d800 with SMTP id p8-20020a056a000b4800b00444f9d4d800mr6713446pfo.38.1634828820211;
        Thu, 21 Oct 2021 08:07:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:459d:a8c7:78e4:f487])
        by smtp.gmail.com with ESMTPSA id 60sm9545333pjz.11.2021.10.21.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:06:58 -0700 (PDT)
Date:   Thu, 21 Oct 2021 08:06:58 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Oct 2021 08:06:53 PDT (-0700)
Subject:     Re: [GIT PULL] riscv: dts: few cleanups for v5.16
In-Reply-To: <4a27b400-4fb1-bb7a-335a-ae1d084cdf73@canonical.com>
CC:     Conor.Dooley@microchip.com, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, arm@kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     krzysztof.kozlowski@canonical.com
Message-ID: <mhng-743556e6-a149-4301-8c4b-c14b3bf4d3d8@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 06:09:50 PDT (-0700), krzysztof.kozlowski@canonical.com wrote:
> On 21/10/2021 15:06, Conor.Dooley@microchip.com wrote:
>> On 21/10/2021 13:23, Arnd Bergmann wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On Thu, Oct 21, 2021 at 11:09 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@canonical.com> wrote:
>>>> Hi Arnd and Olof,
>>>>
>>>> I have an old patchset for RISC-V dts cleanups which I sent to mailing lists in
>>>> August 2021 (v1, v2), resent in September and pinged two times.  They got some
>>>> review (from Alexandre Ghiti for SiFive, from Conor Dooley for Microchip) but
>>>> unfortunately Palmer (RISC-V maintainer) did not respond here.
>>
>> Out of curiosity which series is this one? Is it the one with the
>> plic/clint changes?
>> Pretty sure that I have taken them in internally, but I am going to
>> submit a bunch
>> of changes to our device tree soon (tm) and want to make sure I have the
>> right
>> dependent series listed.
>>
>
> There is only one Microchip patch here (plic/clint). Others are for
> SiFive. All the patches are described in the pull reqeust:
> https://lore.kernel.org/lkml/20211021090955.115005-1-krzysztof.kozlowski@canonical.com/
>
> I had also second set of RISC-V patches for Microchip. These were picked
> up by Palmer:
> https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=for-next

Sorry I missed this.  If you guys took this through the SOC tree that's 
fine, otherwise LMK and I'll put it in the RISC-V tree.
