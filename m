Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148743C802E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbhGNIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbhGNIfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:35:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C09C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 01:32:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j9so1370957pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dX1snp8Zkg1yewGw7VfUJfTAWh+xT6mywa/1czjEeQA=;
        b=0zJnH4Zyt7DWULsNgwhWY9gCJlGQkLo1Ovz83E+FpkILCFpER32q1+2Fg+FOrGrNYg
         awADz0RVRI1V7iRBiwZ7X3DWXvgkHITcH8+lx7EvsnLtYknQUlKtABh3Ro5QpmyMxO57
         y2Ic3fEsYvSibPdcs4Odroe2/K+rmDQ4MzrLqHL3jErQAc8h1skozyDTWkQwNEki4yam
         jxKT1MkwCXPs4eP6xp06BJzKj87bDvVooC3YcuBtTL/VeKZkid3Nw2z2kYN/KaWaOLm3
         8wAt+ppvNjyKbUeasIUSYxLEpeXCCks5AD39+WnJl8ER/wkx7ZeEKDT9/FyoDvXEmD0A
         P5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dX1snp8Zkg1yewGw7VfUJfTAWh+xT6mywa/1czjEeQA=;
        b=PQiNtNKE91uRc2gGqVeQx/PSjmZuAqLFBSHXUdDlKFKrEdygRtbYh+bw82fQxuUrNO
         Oj83X107/pmvnmeGe5iJflrVllo4qdk+hVW3006r2KtbyWTsQUOYtTqjr9qDK6+YXUoo
         TIdsGQT8UQBYzBzyF0Ac7g9OWxKmJaihLgPQLdyZY8tlKskH59j7S3A7swRpie73UOtU
         9vAdmsoGxnBLM+pk8abyxpbD7xMoGnKYVggrZwWgmhcrW95dJE6mFN/zsBZUa2zQLpKA
         OIyE0lgvei3x/AIvvoLEOfpavpVa+DV9JaF9B2Uy/f3PvuG0USvpY9TOHQDPSS2xXZlF
         3GDg==
X-Gm-Message-State: AOAM5312H1RS3S6gpZqq51brNcFIyk3sTAWWZOR4yyPkTstImN/FQiuS
        wPajaocPCZYIjibvDKnoj6dh2Q==
X-Google-Smtp-Source: ABdhPJwXiSa8hgrN6WGQ+H85kKC0acFWBcHlebTwNvpvrBehSoFoXD+F27Xzsi1qYrUPDyb1bUcsdA==
X-Received: by 2002:a65:6145:: with SMTP id o5mr8474989pgv.410.1626251549586;
        Wed, 14 Jul 2021 01:32:29 -0700 (PDT)
Received: from [192.168.10.23] (219-90-184-65.ip.adam.com.au. [219.90.184.65])
        by smtp.gmail.com with UTF8SMTPSA id a23sm1820095pfn.117.2021.07.14.01.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 01:32:28 -0700 (PDT)
Message-ID: <88e3b97e-201d-0782-0e95-8e3d2d850a38@ozlabs.ru>
Date:   Wed, 14 Jul 2021 18:32:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:90.0) Gecko/20100101
 Thunderbird/90.0
Subject: Re: [PATCH v4 07/11] powerpc/pseries/iommu: Reorganize
 iommu_table_setparms*() with new helper
Content-Language: en-US
To:     =?UTF-8?Q?Leonardo_Br=c3=a1s?= <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210430163145.146984-1-leobras.c@gmail.com>
 <20210430163145.146984-8-leobras.c@gmail.com>
 <e4984fa0-2afe-a987-4fb8-61b878431b1f@ozlabs.ru>
 <97626d3883ed207b818760a8239babb08a6b5c59.camel@gmail.com>
 <b25dff0f130b9ab721b8b524e55a3cd4c244a8f3.camel@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <b25dff0f130b9ab721b8b524e55a3cd4c244a8f3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/2021 14:47, Leonardo Brás wrote:
> Hello Alexey,
> 
> On Fri, 2021-06-18 at 19:26 -0300, Leonardo Brás wrote:
>>>
>>>> +                                        unsigned long liobn,
>>>> unsigned long win_addr,
>>>> +                                        unsigned long
>>>> window_size,
>>>> unsigned long page_shift,
>>>> +                                        unsigned long base,
>>>> struct
>>>> iommu_table_ops *table_ops)
>>>
>>>
>>> iommu_table_setparms() rather than passing 0 around.
>>>
>>> The same comment about "liobn" - set it in
>>> iommu_table_setparms_lpar().
>>> The reviewer will see what field atters in what situation imho.
>>>
>>
>> The idea here was to keep all tbl parameters setting in
>> _iommu_table_setparms (or iommu_table_setparms_common).
>>
>> I understand the idea that each one of those is optional in the other
>> case, but should we keep whatever value is present in the other
>> variable (not zeroing the other variable), or do someting like:
>>
>> tbl->it_index = 0;
>> tbl->it_base = basep;
>> (in iommu_table_setparms)
>>
>> tbl->it_index = liobn;
>> tbl->it_base = 0;
>> (in iommu_table_setparms_lpar)
>>
> 
> This one is supposed to be a question, but I missed the question mark.
> Sorry about that.

Ah ok :)

> I would like to get your opinion in this :)

Besides making the "base" parameter a pointer, I really do not have 
strong preference, just make it not hurting eyes of a reader, that's all :)

imho in general, rather than answering 5 weeks later, it is more 
productive to address whatever comments were made, add comments (in the 
code or commit logs) why you are sticking to your initial approach, 
rebase and repost the whole thing. Thanks,



-- 
Alexey
