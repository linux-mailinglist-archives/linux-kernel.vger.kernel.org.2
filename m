Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556FF42D86F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhJNLqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:46:20 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35824
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231249AbhJNLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:46:14 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1653A3FFF8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634211847;
        bh=YPH2WVu5uDitMh1aWqloZ1ZtuO3sS7qJNLEyKSmSBJE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=FCsj2h+b+MNJ+xky6rXT3zklhPWqLNFf1f7MmdlZR4wGh8kIldBLNpv5HbjHrCuwz
         c6VaGrjiOIdU20xj1fFcJYO+cY0d4QItVIYEiQ7USmbB2Rlpy3Xvdk0Uy6WWRRXUrY
         6+7c24WJ5Jtga/OE3qFAAlxW9RmqT3MVYljSXZVZr4fYbGWZt103GMIxjMqpglOjpL
         Dec1iWelQZuQ8CWN3WtfFdUwkjnq0sPInPDWlVcrSvHb41U1hHFu1OXB9v8xSx9lX3
         nrhXKSu55PK8K+7M47QHteJ82yXSf2jy49smdJlxoVK/Ddb7lOcbDVL4SY7Sstpw5q
         rNb9KdjBBdqEQ==
Received: by mail-lf1-f71.google.com with SMTP id bq35-20020a056512152300b003fd45087a72so4155907lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 04:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YPH2WVu5uDitMh1aWqloZ1ZtuO3sS7qJNLEyKSmSBJE=;
        b=Awv7o+dqKSraoxeAVetKine7VdA9FjdcO7Ppxei2QlvC+2N5ETrCmNpmJD7H9qyIfm
         KZMZAM6/QpoVrZxVEuo1ZvR7JHkYr/oIhNfibdjg4lF+AV7hbfzd+uD6micuc/mPRT/V
         8dl4of9TN2cLvR7YJpcY4lw2sx3f6L+sG3jmTiq7ClkEH6396DtH2naKjDkc/lRdNrpZ
         +VEoSfrzm50m1iBy96ki/1gX60TvtBsfzFreTDfUtI+m6y/0Axjtnz3i3+Tb7gfkkRJ1
         AJT6whxMczsmzatfXmtOUSZsUTvHE4OwNVQcolbBK1m6lMV+UNUqKWQoHlwK0M7eTuEg
         ywRw==
X-Gm-Message-State: AOAM530U5qe+XPJou6+OYF+mtoRokBXPYsEsEBy/ErYRpklg/yxuIWWD
        /E+kMxzP75VmdcM7OYYisJj+fDeuiMr47ytD9qWD3ffG91CXvv4JYCeRXp5xJjMC9jpscbMlmnv
        Jb50e0eFHulh1SUfns9K8QCIj3zn7EdVyVZk3CJloBA==
X-Received: by 2002:a05:6512:3b07:: with SMTP id f7mr4464262lfv.67.1634211845404;
        Thu, 14 Oct 2021 04:44:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLFOioy5nBCsU+Bnh4Jdc1/IvTUpnD/zPAtB+U5lrR/RgFHNx1XSSNThY8LhzFdmwR/kZAHw==
X-Received: by 2002:a05:6512:3b07:: with SMTP id f7mr4464244lfv.67.1634211845204;
        Thu, 14 Oct 2021 04:44:05 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id x4sm205011lfq.246.2021.10.14.04.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 04:44:04 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] soc: samsung: exynos-chipid: Pass revision reg
 offsets
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211013202110.31701-1-semen.protsenko@linaro.org>
 <3460c787-0a72-3c37-1075-dfee9cc2c0b3@canonical.com>
 <CAPLW+4mw8e+r=Jf8unQtLGXHpxvioQinOjrDChdvs8S+hddotw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d1a0dd67-6f29-1b4f-5cdf-5d203297adb9@canonical.com>
Date:   Thu, 14 Oct 2021 13:44:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPLW+4mw8e+r=Jf8unQtLGXHpxvioQinOjrDChdvs8S+hddotw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2021 13:25, Sam Protsenko wrote:
> On Thu, 14 Oct 2021 at 09:41, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 13/10/2021 22:21, Sam Protsenko wrote:
>>> Old Exynos SoCs have both Product ID and Revision ID in one single
>>> register, while new SoCs tend to have two separate registers for those
>>> IDs. Implement handling of both cases by passing Revision ID register
>>> offsets in driver data.
>>>
>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>>> ---
>>>  drivers/soc/samsung/exynos-chipid.c       | 67 +++++++++++++++++++----
>>>  include/linux/soc/samsung/exynos-chipid.h |  6 +-
>>>  2 files changed, 58 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
>>> index 5c1d0f97f766..7837331fb753 100644
>>> --- a/drivers/soc/samsung/exynos-chipid.c
>>> +++ b/drivers/soc/samsung/exynos-chipid.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/errno.h>
>>>  #include <linux/mfd/syscon.h>
>>>  #include <linux/of.h>
>>> +#include <linux/of_device.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/regmap.h>
>>>  #include <linux/slab.h>
>>> @@ -24,6 +25,17 @@
>>
>> Include a changelog please. Your patch does not apply and there is no
>> information on tree which it was based on.
>>
> 
> Sorry, my bad. Will do in v3. As for the tree: it's based on the
> latest mainline/master. I'll double check if patches apply correctly
> to that before sending v3. Please let me know if you want me to rebase
> this series on top of some other tree.

Mainline/master won't work in most of the cases. You need to rebase your
work on maintainer's tree. This is sometimes tricky, so usually it's
enough to base on linux-next.

In this case, either use linux-next or for-next branch of my tree:
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/

Best regards,
Krzysztof
