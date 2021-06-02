Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D80398EA3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhFBPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhFBPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:32:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C739DC06174A;
        Wed,  2 Jun 2021 08:30:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e1so1270047pld.13;
        Wed, 02 Jun 2021 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BUuJ+663ryW3aCLGW4N/wOnkqzF/PIsZJ+Jk8r5v/i0=;
        b=LmHS/3bLpztg0JrzrPy5bFrjFmazJB/JwKd/hhfQVg0b7DZhOLX0XVkuSgFzK5JMDV
         mHOARrNxspOR6UuVp1dGFc5/MS3CI9VF+c0U2COhzZT+IEpSIa9x4zu6jZbFhYMfAZyX
         QL1vVrM889p7VCzf6EO9rxB3MWaiRB7+N7QXGkOflnR0KkMM1/LQogNpCW+hbn55OahS
         33syvzZuWsllExZRUROcrsZ/UItxxlfwt4Ki39sSQdMfWSw1ETqHFDK3nbQMvLTmWzc3
         zWk3gKnPvTJhBZyq9kVCYK3I6od0rKGfV/mQ/BE2aWGAmCLjJLjVi5gcQkjhi5EzViTe
         956A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BUuJ+663ryW3aCLGW4N/wOnkqzF/PIsZJ+Jk8r5v/i0=;
        b=o7S2bg+JhTZPn4mCbHue3QjoACClGrRdxSwfka+EcHXFIZleRk16fqR6PLO9lvgWP8
         +Dt6YTWWIqXO2gTDQW4g0EWyG2aqvjkQyy01ClKGC7k9+tObEgHNUthRGgFknuYqp62k
         88QkLIL+ko2dQyCCV+xCGkjCznH55l39125iJpNbUKWmGOix9uG+RV7Ff/9wgE0JR707
         2yJ2EaNIwmQkB9EIUt4UnwHaq6RGFVaQFjBvLCwgD2yDqKbWXmzcKov5PYK8MfQtA62x
         MlJac229KEsLXid1xUN0PTJtYTyDwFA8FhbkkudwR9CouLGrU4XgOJW2o+SPhYthwPSd
         GBjA==
X-Gm-Message-State: AOAM531++Z826q6Ogf0MyTndx4tVy4qnC/l2tkFqDfpF4cqfMLzL/HGV
        5W1Anztcid2b4m41p1WU7VA=
X-Google-Smtp-Source: ABdhPJxUC9lYcmvSWqFS4Uv2T0UXFDfoleQzHvaFxml3ZFRQq3EqqmSx4T3neWdIPtWq/zWUa5IaQg==
X-Received: by 2002:a17:90a:3948:: with SMTP id n8mr32120008pjf.32.1622647850115;
        Wed, 02 Jun 2021 08:30:50 -0700 (PDT)
Received: from [172.30.1.14] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id f7sm38346pfk.191.2021.06.02.08.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 08:30:49 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] extcon: sm5502: Refactor driver to use
 chip-specific struct
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
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <83b00ca8-aa70-6c4b-5f9f-eebf571ee621@gmail.com>
Date:   Thu, 3 Jun 2021 00:30:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLeh2Q1q3643iFkZ@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 6. 3. 오전 12:20, Stephan Gerhold wrote:
> On Thu, Jun 03, 2021 at 12:13:18AM +0900, Chanwoo Choi wrote:
>> On 21. 6. 2. 오전 5:00, Stephan Gerhold wrote:
>>> Prepare for supporting SM5504 in the extcon-sm5502 driver by replacing
>>> enum sm5504_types with a struct sm5504_type that stores the chip-specific
>>> definitions. This struct can then be defined separately for SM5504
>>> without having to add if (type == TYPE_SM5504) everywhere in the code.
>>>
>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>>> ---
>>> Changes in v3: New patch to simplify diff on next patch
>>> ---
>>>    drivers/extcon/extcon-sm5502.c | 64 +++++++++++++++++++++-------------
>>>    drivers/extcon/extcon-sm5502.h |  4 ---
>>>    2 files changed, 40 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
>>> index 9f40bb9f1f81..951f6ca4c479 100644
>>> --- a/drivers/extcon/extcon-sm5502.c
>>> +++ b/drivers/extcon/extcon-sm5502.c
>>> @@ -40,17 +40,13 @@ struct sm5502_muic_info {
>>>    	struct i2c_client *i2c;
>>>    	struct regmap *regmap;
>>> +	const struct sm5502_type *type;
>>>    	struct regmap_irq_chip_data *irq_data;
>>> -	struct muic_irq *muic_irqs;
>>> -	unsigned int num_muic_irqs;
>>>    	int irq;
>>>    	bool irq_attach;
>>>    	bool irq_detach;
>>>    	struct work_struct irq_work;
>>> -	struct reg_data *reg_data;
>>> -	unsigned int num_reg_data;
>>> -
>>>    	struct mutex mutex;
>>>    	/*
>>> @@ -62,6 +58,17 @@ struct sm5502_muic_info {
>>>    	struct delayed_work wq_detcable;
>>>    };
>>> +struct sm5502_type {
>>> +	struct muic_irq *muic_irqs;
>>> +	unsigned int num_muic_irqs;
>>> +	const struct regmap_irq_chip *irq_chip;
>>> +
>>> +	struct reg_data *reg_data;
>>> +	unsigned int num_reg_data;
>>> +
>>> +	int (*parse_irq)(struct sm5502_muic_info *info, int irq_type);
>>> +};
>>> +
>>>    /* Default value of SM5502 register to bring up MUIC device. */
>>>    static struct reg_data sm5502_reg_data[] = {
>>>    	{
>>> @@ -502,11 +509,11 @@ static irqreturn_t sm5502_muic_irq_handler(int irq, void *data)
>>>    	struct sm5502_muic_info *info = data;
>>>    	int i, irq_type = -1, ret;
>>> -	for (i = 0; i < info->num_muic_irqs; i++)
>>> -		if (irq == info->muic_irqs[i].virq)
>>> -			irq_type = info->muic_irqs[i].irq;
>>> +	for (i = 0; i < info->type->num_muic_irqs; i++)
>>> +		if (irq == info->type->muic_irqs[i].virq)
>>> +			irq_type = info->type->muic_irqs[i].irq;
>>> -	ret = sm5502_parse_irq(info, irq_type);
>>> +	ret = info->type->parse_irq(info, irq_type);
>>
>> Looks good to me. But there is only one comment.
>> Need to check the 'parse_irq' as following:
>>
>> If you agree this suggestion, I'll apply with following changes by myself:
>>
>> 	if (!info->type->parse_irq) {
>> 		dev_err(info->dev, "failed to handle irq due to parse_irq\n",
>> 		return IRQ_NONE;
>> 	}
>>
>>
> 
> This condition should be impossible, since .parse_irq is set for both
> SM5502 and SM5504:
> 
> static const struct sm5502_type sm5502_data = {
> 	/* ... */
> 	.parse_irq = sm5502_parse_irq,
> };
> 
> static const struct sm5502_type sm5504_data = {
> 	/* ... */
> 	.parse_irq = sm5504_parse_irq,
> };
> 
> Which failure case are you trying to handle with that if statement?

There is not failure case of this patchset. But, this refactoring 
suggestion has the potential problem without checking whether mandatory 
function pointer is NULL or not. When adding new chip by using this 
driver, the author might have the human error without parse_irq 
initialization even if the mandatory.

> 
> Thanks!
> Stephan
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
