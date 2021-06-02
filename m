Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CAA398EC8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhFBPiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhFBPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:38:01 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C360C061574;
        Wed,  2 Jun 2021 08:36:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id n12so2518107pgs.13;
        Wed, 02 Jun 2021 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+AN3vLHpRvIwF6y4b2szGjoewM+eL/fawceeUYmkAow=;
        b=Y1LDh+RYU8lzIeprPXCEYksPgT7R0HzRuigEkLiiRFHFnBYVpbA3g/Sfdu4vC3bBz7
         mBM150bE5rGLtG4wZU4Dav3Q1gUa4CQsXiv7PSh1vyZWgIaLYJ+dHdcFZ/HUXe3RF3gn
         DtodgBAf+XkIsGt+fciQi8UGP+Yn8DD79Xn/EoftoGb7viq2XBcBsTNoqy4qlR/cTvcG
         By+ims2BZGpvYXdKEmjRuO/TFBEMLQZhIqhzSQVZ/mr3GDBhCNe15BYvLZIezK6gMEpp
         Hyp8CT3HCK8pivGYZ4ASAMWqWdEtD2P55jtnc+K1SnXMnCM5LvrMTPHN8EzPNm0U/afo
         qHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+AN3vLHpRvIwF6y4b2szGjoewM+eL/fawceeUYmkAow=;
        b=a5HmkZ3fzdFbt8F1SSfz/B/GVpz9KxxdsihdbdZwwkMxP5CFA5SEorUvdQqL/BS+HG
         95l6VDSrLIxkFnm8fXcX8F/Tk8VJqfBqcCu6JKLCiTzwTkqzj6ZLgMlv4jPf1TSffASb
         QUfhro6pqmzPn6sjKzvJ1iviMDa1ThWg8Tds0UaEJjvSqxJsCx9+Mf5Nz14At1ts0NyJ
         EGn1g3bhY74GbSMCoMOW7c1+zQE1HDmkvKrJz8m/slqpCSiah7wTKeqU0jD86DqHxaCy
         C+8exkI9z1lbkAUp5+pXT4BV0Sd0VXSnbg0GW4rBzunMS63sW3roouzMQ758Eomx1SsN
         w0aw==
X-Gm-Message-State: AOAM531kJCnK3R9tY4CCYcRKeF8/mdAgJGYjLd4u+DFBBfZ4F+RKoWPa
        6Mpj6AumHu3sQEo8AWr2R3E=
X-Google-Smtp-Source: ABdhPJzgeMOxm/4VquaFLmaZzwmqLLnoZ2tuDFrR9UMwLg40KCUKNP2Szg3BIf3EsW9mrUWwQvf2Qw==
X-Received: by 2002:a63:4512:: with SMTP id s18mr22938846pga.81.1622648164646;
        Wed, 02 Jun 2021 08:36:04 -0700 (PDT)
Received: from [172.30.1.14] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id j16sm153850pgh.69.2021.06.02.08.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 08:36:03 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] extcon: sm5502: Refactor driver to use
 chip-specific struct
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20210601200007.218802-1-stephan@gerhold.net>
 <20210601200007.218802-3-stephan@gerhold.net>
 <b3a9eed8-0d7c-e935-36d4-13918f5b7b21@gmail.com>
 <YLeh2Q1q3643iFkZ@gerhold.net>
 <83b00ca8-aa70-6c4b-5f9f-eebf571ee621@gmail.com>
Message-ID: <a53f8fa3-60c3-2727-d309-f77f35cfd510@gmail.com>
Date:   Thu, 3 Jun 2021 00:35:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <83b00ca8-aa70-6c4b-5f9f-eebf571ee621@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 6. 3. 오전 12:30, Chanwoo Choi wrote:
> On 21. 6. 3. 오전 12:20, Stephan Gerhold wrote:
>> On Thu, Jun 03, 2021 at 12:13:18AM +0900, Chanwoo Choi wrote:
>>> On 21. 6. 2. 오전 5:00, Stephan Gerhold wrote:
>>>> Prepare for supporting SM5504 in the extcon-sm5502 driver by replacing
>>>> enum sm5504_types with a struct sm5504_type that stores the 
>>>> chip-specific
>>>> definitions. This struct can then be defined separately for SM5504
>>>> without having to add if (type == TYPE_SM5504) everywhere in the code.
>>>>
>>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>>>> ---
>>>> Changes in v3: New patch to simplify diff on next patch
>>>> ---
>>>>    drivers/extcon/extcon-sm5502.c | 64 
>>>> +++++++++++++++++++++-------------
>>>>    drivers/extcon/extcon-sm5502.h |  4 ---
>>>>    2 files changed, 40 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/drivers/extcon/extcon-sm5502.c 
>>>> b/drivers/extcon/extcon-sm5502.c
>>>> index 9f40bb9f1f81..951f6ca4c479 100644
>>>> --- a/drivers/extcon/extcon-sm5502.c
>>>> +++ b/drivers/extcon/extcon-sm5502.c
>>>> @@ -40,17 +40,13 @@ struct sm5502_muic_info {
>>>>        struct i2c_client *i2c;
>>>>        struct regmap *regmap;
>>>> +    const struct sm5502_type *type;
>>>>        struct regmap_irq_chip_data *irq_data;
>>>> -    struct muic_irq *muic_irqs;
>>>> -    unsigned int num_muic_irqs;
>>>>        int irq;
>>>>        bool irq_attach;
>>>>        bool irq_detach;
>>>>        struct work_struct irq_work;
>>>> -    struct reg_data *reg_data;
>>>> -    unsigned int num_reg_data;
>>>> -
>>>>        struct mutex mutex;
>>>>        /*
>>>> @@ -62,6 +58,17 @@ struct sm5502_muic_info {
>>>>        struct delayed_work wq_detcable;
>>>>    };
>>>> +struct sm5502_type {
>>>> +    struct muic_irq *muic_irqs;
>>>> +    unsigned int num_muic_irqs;
>>>> +    const struct regmap_irq_chip *irq_chip;
>>>> +
>>>> +    struct reg_data *reg_data;
>>>> +    unsigned int num_reg_data;
>>>> +
>>>> +    int (*parse_irq)(struct sm5502_muic_info *info, int irq_type);
>>>> +};
>>>> +
>>>>    /* Default value of SM5502 register to bring up MUIC device. */
>>>>    static struct reg_data sm5502_reg_data[] = {
>>>>        {
>>>> @@ -502,11 +509,11 @@ static irqreturn_t sm5502_muic_irq_handler(int 
>>>> irq, void *data)
>>>>        struct sm5502_muic_info *info = data;
>>>>        int i, irq_type = -1, ret;
>>>> -    for (i = 0; i < info->num_muic_irqs; i++)
>>>> -        if (irq == info->muic_irqs[i].virq)
>>>> -            irq_type = info->muic_irqs[i].irq;
>>>> +    for (i = 0; i < info->type->num_muic_irqs; i++)
>>>> +        if (irq == info->type->muic_irqs[i].virq)
>>>> +            irq_type = info->type->muic_irqs[i].irq;
>>>> -    ret = sm5502_parse_irq(info, irq_type);
>>>> +    ret = info->type->parse_irq(info, irq_type);
>>>
>>> Looks good to me. But there is only one comment.
>>> Need to check the 'parse_irq' as following:
>>>
>>> If you agree this suggestion, I'll apply with following changes by 
>>> myself:
>>>
>>>     if (!info->type->parse_irq) {
>>>         dev_err(info->dev, "failed to handle irq due to parse_irq\n",
>>>         return IRQ_NONE;
>>>     }
>>>
>>>
>>
>> This condition should be impossible, since .parse_irq is set for both
>> SM5502 and SM5504:
>>
>> static const struct sm5502_type sm5502_data = {
>>     /* ... */
>>     .parse_irq = sm5502_parse_irq,
>> };
>>
>> static const struct sm5502_type sm5504_data = {
>>     /* ... */
>>     .parse_irq = sm5504_parse_irq,
>> };
>>
>> Which failure case are you trying to handle with that if statement?
> 
> There is not failure case of this patchset. But, this refactoring 
> suggestion has the potential problem without checking whether mandatory 
> function pointer is NULL or not. When adding new chip by using this 
> driver, the author might have the human error without parse_irq 
> initialization even if the mandatory.
> 

Instead, it is better to check whether parser_irq is NULL or not
on probe function in order to reduce the unnecessary repetitive checking.

>>
>> Thanks!
>> Stephan
>>
> 
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
