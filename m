Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52065399827
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFCCsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:48:37 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:40225 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhFCCsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:48:36 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210603024650epoutp02063843c00f08af95b9b5831bf6636990~E8oMpSdMQ2166921669epoutp023
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 02:46:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210603024650epoutp02063843c00f08af95b9b5831bf6636990~E8oMpSdMQ2166921669epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622688410;
        bh=z9beWbRHO4Sg2Jo4qyw0ZrjduqpwhuYpAhhXfI1b/o0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kIGrwQ+njKuDB1GaKRlxSEgIy2nQNkJDp+rIkmnT90dN7zofFIeVeIxxztTs9tjKx
         kj3jJfWKvzXJCXgHF0+3Rn4dBJLhS6/HcV8jR8/RxaY8p9qla/lPU4c/NV6656dQ4s
         Y21CJjKbBM/4tuGpzIpZeHY1HaU4OB7kRbQbgMw8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210603024650epcas1p2fc526c7f8dae59d720a5d865c9d266a5~E8oMEhpQ10627406274epcas1p2E;
        Thu,  3 Jun 2021 02:46:50 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FwVfH1J6Wz4x9QB; Thu,  3 Jun
        2021 02:46:47 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.F6.09578.69248B06; Thu,  3 Jun 2021 11:46:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210603024646epcas1p42abc4e8fd4ea99a753990b1a5001f7e9~E8oIW3WeO1000410004epcas1p4p;
        Thu,  3 Jun 2021 02:46:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210603024646epsmtrp17586a5165870a50a04c635a0a63108bf~E8oIWKurJ0652406524epsmtrp1M;
        Thu,  3 Jun 2021 02:46:46 +0000 (GMT)
X-AuditID: b6c32a35-fb9ff7000000256a-cf-60b842968428
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.C7.08637.69248B06; Thu,  3 Jun 2021 11:46:46 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210603024646epsmtip109e5d20fed90e2e96246d718e2412da3~E8oIHWwfh2202822028epsmtip1a;
        Thu,  3 Jun 2021 02:46:46 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] extcon: sm5502: Refactor driver to use
 chip-specific struct
To:     Stephan Gerhold <stephan@gerhold.net>,
        Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a0cb546f-39e9-8361-0628-9dc1ea413d1c@samsung.com>
Date:   Thu, 3 Jun 2021 12:05:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <YLem9vz2KnpDYS1K@gerhold.net>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmvu50px0JBuc3MVo8O6ptMf/IOVaL
        y7vmsFncblzBZnHl5Q4Wi9a9R9gtbsw1sdj8/S+jA4dH2wJ7j52z7rJ7bFrVyebx/85ado++
        LasYPf51lXh83iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtq
        q+TiE6DrlpkDdJGSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9d
        Lzk/18rQwMDIFKgwITtj3s1+5oKtOhW3byxia2CcqNrFyMkhIWAi0TLlJAuILSSwg1FizhON
        LkYuIPsTo8TBC2eYIJxvjBIPnxxngem4tPEnG0RiL6PEnidXWCCc94wSR26vBqsSFoiUOPHn
        BxuILSLgI9G89yIrSBGzwFVGif2N/8GK2AS0JPa/uAFWxC+gKHH1x2NGEJtXwE7i9K0rYDUs
        AioS21ccYQWxRQXCJE5ua4GqEZQ4OfMJWA2ngLbE3kktYDXMAuISt57MZ4Kw5SWat85mBlks
        IbCWQ+LW3QPMED+4SHza/40VwhaWeHV8CzuELSXxsr8Nyq6WWHnyCBtEcwejxJb9F6AajCX2
        L50MtIEDaIOmxPpd+hBhRYmdv+cyQizmk3j3tYcVpERCgFeio00IokRZ4vKDu0wQtqTE4vZO
        tgmMSrOQvDMLyQuzkLwwC2HZAkaWVYxiqQXFuempxYYFhsjRvYkRnFy1THcwTnz7Qe8QIxMH
        4yFGCQ5mJRHePWo7EoR4UxIrq1KL8uOLSnNSiw8xmgIDeCKzlGhyPjC955XEG5oaGRsbW5gY
        mpkaGiqJ86Y7VycICaQnlqRmp6YWpBbB9DFxcEo1MEnP7n3LMdk+I/J0opKgzDWNZUm/pz5n
        bvY61s3BlROtu1uaucR8W+MH5+VxQspxqqn9B67v1vL8cEjgSoCAo8ubnVKaIbdFOu3PbV21
        akU7n3up7aVTP4VD+k/v2G66Rsm58/tSUaOX4imdKzMOCcUZbOfZ5llkt3/q+e5j/JH5i0ym
        /X24datv376a/+9YeniWbtWTZyj08cr33eKvbHL5i2NQ4j5d79g9Z7tuLZhz3qx8zbkyG03B
        kLhG+aVJVhe5Lu+bLJfp0a8VPzUkJK0nYurL34aTxHcozPQMvrL6X6LeMX/3q/3XF6w9v6gx
        VfT3i8orT4UEZ7F6zQo0tY9rXLXh9j77lX+WVt5QV2Ipzkg01GIuKk4EAHkej9k3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTnea044Eg02POS2eHdW2mH/kHKvF
        5V1z2CxuN65gs7jycgeLReveI+wWN+aaWGz+/pfRgcOjbYG9x85Zd9k9Nq3qZPP4f2ctu0ff
        llWMHv+6Sjw+b5ILYI/isklJzcksSy3St0vgyph3s5+5YKtOxe0bi9gaGCeqdjFyckgImEhc
        2viTrYuRi0NIYDejxJyNfxkhEpIS0y4eZe5i5ACyhSUOHy4GCQsJvGWUeDXdFMQWFoiUOPHn
        BxuILSLgI9G89yIryBxmgauMEveff2KGGDqDWWLNnltgQ9kEtCT2v7gB1sEvoChx9cdjsDiv
        gJ3E6VtXWEBsFgEVie0rjrCC2KICYRI7lzxmgqgRlDg58wlYDaeAtsTeSS1gNcwC6hJ/5l1i
        hrDFJW49mc8EYctLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3i
        xNzi0rx0veT83E2M4CjT0tzBuH3VB71DjEwcjIcYJTiYlUR496jtSBDiTUmsrEotyo8vKs1J
        LT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBSWnX9Q3lur/b54tO0Jqj9J4nhH2a
        TGdH3vHu6dlVjR7ZKifyZksILf9S/JX3yvNjjUXTJF81qGXWnGH5vPH2hkeWc29N31gVvLOJ
        6+q3xpuNk0VKjC9b54jXyHcuXLFl71Ev7+KN2QHPJ737L1NwLF/joIy2itQp57KNS8yS+qWX
        Zgg/842rvMpVGGQeUse9fFHno/8/639e29lRfkJyU+G241cWP36cM4GPu+27/NsNt7iLd7+P
        2toX5/T8xgOupYletdMmqwWumZcVdYrb4/LTG4VrTQUDFRj/pEbvP79M6ItcUXlE7qT5S9oK
        0/oUys2VzbXEvG4liyWcX5DmNWXz5dsXnAIffT+ysyHqpxJLcUaioRZzUXEiACSgOlwhAwAA
X-CMS-MailID: 20210603024646epcas1p42abc4e8fd4ea99a753990b1a5001f7e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210602154302epcas1p3d8d0f46225125214d8715fd1addd624c
References: <20210601200007.218802-1-stephan@gerhold.net>
        <20210601200007.218802-3-stephan@gerhold.net>
        <b3a9eed8-0d7c-e935-36d4-13918f5b7b21@gmail.com>
        <YLeh2Q1q3643iFkZ@gerhold.net>
        <83b00ca8-aa70-6c4b-5f9f-eebf571ee621@gmail.com>
        <a53f8fa3-60c3-2727-d309-f77f35cfd510@gmail.com>
        <CGME20210602154302epcas1p3d8d0f46225125214d8715fd1addd624c@epcas1p3.samsung.com>
        <YLem9vz2KnpDYS1K@gerhold.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 12:42 AM, Stephan Gerhold wrote:
> On Thu, Jun 03, 2021 at 12:35:58AM +0900, Chanwoo Choi wrote:
>> On 21. 6. 3. 오전 12:30, Chanwoo Choi wrote:
>>> On 21. 6. 3. 오전 12:20, Stephan Gerhold wrote:
>>>> On Thu, Jun 03, 2021 at 12:13:18AM +0900, Chanwoo Choi wrote:
>>>>> On 21. 6. 2. 오전 5:00, Stephan Gerhold wrote:
>>>>>> Prepare for supporting SM5504 in the extcon-sm5502 driver by replacing
>>>>>> enum sm5504_types with a struct sm5504_type that stores the
>>>>>> chip-specific
>>>>>> definitions. This struct can then be defined separately for SM5504
>>>>>> without having to add if (type == TYPE_SM5504) everywhere in the code.
>>>>>>
>>>>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>>>>>> ---
>>>>>> Changes in v3: New patch to simplify diff on next patch
>>>>>> ---
>>>>>>    drivers/extcon/extcon-sm5502.c | 64
>>>>>> +++++++++++++++++++++-------------
>>>>>>    drivers/extcon/extcon-sm5502.h |  4 ---
>>>>>>    2 files changed, 40 insertions(+), 28 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/extcon/extcon-sm5502.c
>>>>>> b/drivers/extcon/extcon-sm5502.c
>>>>>> index 9f40bb9f1f81..951f6ca4c479 100644
>>>>>> --- a/drivers/extcon/extcon-sm5502.c
>>>>>> +++ b/drivers/extcon/extcon-sm5502.c
>>>>>> @@ -40,17 +40,13 @@ struct sm5502_muic_info {
>>>>>>        struct i2c_client *i2c;
>>>>>>        struct regmap *regmap;
>>>>>> +    const struct sm5502_type *type;
>>>>>>        struct regmap_irq_chip_data *irq_data;
>>>>>> -    struct muic_irq *muic_irqs;
>>>>>> -    unsigned int num_muic_irqs;
>>>>>>        int irq;
>>>>>>        bool irq_attach;
>>>>>>        bool irq_detach;
>>>>>>        struct work_struct irq_work;
>>>>>> -    struct reg_data *reg_data;
>>>>>> -    unsigned int num_reg_data;
>>>>>> -
>>>>>>        struct mutex mutex;
>>>>>>        /*
>>>>>> @@ -62,6 +58,17 @@ struct sm5502_muic_info {
>>>>>>        struct delayed_work wq_detcable;
>>>>>>    };
>>>>>> +struct sm5502_type {
>>>>>> +    struct muic_irq *muic_irqs;
>>>>>> +    unsigned int num_muic_irqs;
>>>>>> +    const struct regmap_irq_chip *irq_chip;
>>>>>> +
>>>>>> +    struct reg_data *reg_data;
>>>>>> +    unsigned int num_reg_data;
>>>>>> +
>>>>>> +    int (*parse_irq)(struct sm5502_muic_info *info, int irq_type);
>>>>>> +};
>>>>>> +
>>>>>>    /* Default value of SM5502 register to bring up MUIC device. */
>>>>>>    static struct reg_data sm5502_reg_data[] = {
>>>>>>        {
>>>>>> @@ -502,11 +509,11 @@ static irqreturn_t
>>>>>> sm5502_muic_irq_handler(int irq, void *data)
>>>>>>        struct sm5502_muic_info *info = data;
>>>>>>        int i, irq_type = -1, ret;
>>>>>> -    for (i = 0; i < info->num_muic_irqs; i++)
>>>>>> -        if (irq == info->muic_irqs[i].virq)
>>>>>> -            irq_type = info->muic_irqs[i].irq;
>>>>>> +    for (i = 0; i < info->type->num_muic_irqs; i++)
>>>>>> +        if (irq == info->type->muic_irqs[i].virq)
>>>>>> +            irq_type = info->type->muic_irqs[i].irq;
>>>>>> -    ret = sm5502_parse_irq(info, irq_type);
>>>>>> +    ret = info->type->parse_irq(info, irq_type);
>>>>>
>>>>> Looks good to me. But there is only one comment.
>>>>> Need to check the 'parse_irq' as following:
>>>>>
>>>>> If you agree this suggestion, I'll apply with following changes
>>>>> by myself:
>>>>>
>>>>>     if (!info->type->parse_irq) {
>>>>>         dev_err(info->dev, "failed to handle irq due to parse_irq\n",
>>>>>         return IRQ_NONE;
>>>>>     }
>>>>>
>>>>>
>>>>
>>>> This condition should be impossible, since .parse_irq is set for both
>>>> SM5502 and SM5504:
>>>>
>>>> static const struct sm5502_type sm5502_data = {
>>>>     /* ... */
>>>>     .parse_irq = sm5502_parse_irq,
>>>> };
>>>>
>>>> static const struct sm5502_type sm5504_data = {
>>>>     /* ... */
>>>>     .parse_irq = sm5504_parse_irq,
>>>> };
>>>>
>>>> Which failure case are you trying to handle with that if statement?
>>>
>>> There is not failure case of this patchset. But, this refactoring
>>> suggestion has the potential problem without checking whether mandatory
>>> function pointer is NULL or not. When adding new chip by using this
>>> driver, the author might have the human error without parse_irq
>>> initialization even if the mandatory.
>>>
>>
>> Instead, it is better to check whether parser_irq is NULL or not
>> on probe function in order to reduce the unnecessary repetitive checking.
>>
> 
> Thanks for the explanation. This suggestion sounds better to me.
> (Although I consider it unlikely that someone would forget to define
>  .parse_irq when adding a new chip...)
> 
> Feel free to add something like the below when applying.
> Or let me know if I should re-send with this change:

Please resend them. Thanks.

> 
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index af44c1e2f368..93da2d8379b1 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -694,6 +694,10 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c)
>  	info->type = device_get_match_data(info->dev);
>  	if (!info->type)
>  		return -EINVAL;
> +	if (!info->type->parse_irq) {
> +		dev_err(info->dev, "parse_irq missing in struct sm5502_type\n");
> +		return -EINVAL;
> +	}
>  
>  	mutex_init(&info->mutex);
>  
> 
> Thanks for your review!
> Stephan
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
