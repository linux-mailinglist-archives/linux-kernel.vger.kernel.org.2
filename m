Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65167441598
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhKAIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:48:18 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58344
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231841AbhKAIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:48:14 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0F1F23F170
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635756341;
        bh=gDEC7fcYyadG/CPtgrvRFpzQy+6XwYhZQ8QIsHdNyxU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Onw4qkC7H0HmewpFOPga08eWzocPT0NcXTCM/MT2461p3fhGQHLuNLIif02DKF+aJ
         uFuUC+hdDQQw0biRrAvKYFquVQFQ0BtUWFcLK3IJXui7zrY34Pll/Z9jrSzJfeAK+G
         onBkFrDUyu7JTk0tT1gwWyK6ve0+5CV7PAzVwSYt3OIVbD27tCIOH27KnNuqQeDeLh
         DevUD3BiLSxHSoArvVyaQJ4NtvGzeq0wO1BH3E2JAkl8SDrYfRRjDULcB9yuxkCoC0
         lmiYndLhPueGU63xmPeRM0P6U9Ss0a0fmimIufROo9C2nC7rtm0VjlOD3k4VhUkEou
         vWYoDvX3+JbdA==
Received: by mail-lj1-f198.google.com with SMTP id s12-20020a2e98cc000000b0021539440855so1043712ljj.20
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gDEC7fcYyadG/CPtgrvRFpzQy+6XwYhZQ8QIsHdNyxU=;
        b=tDrWoOUuc6gQ21i94nrIiXY1ayvZ6qSRac7ut+jjkal++Uyk1EgUNn/7KlFD1VGDG8
         32XLrOlbxsCEEAG9hn9Jei97fi3tUKyywTHwlfHVJA/d8ppWn84GE6/lBPKkPNCT3wTn
         TUFelthMX4t4KLPT/sbnuH2taTvj/BOuMpexeP5MRtRckHIaOdspFROAs+1mntU6YixS
         qNgCq9QKGMlaqTkbMVRNLdNB9/iX04vAPkWkaM6y/1p19WwQsgzVGNsB1rc6bEYr52H1
         xGuGM0Q8n/eyeX638bPLY0FerxeBHHcbyv81eUVhpE1NCt4UekbIN3afpp914RC+53dr
         y7BQ==
X-Gm-Message-State: AOAM531hoTpm/DWvWYf98ZGRjlNBm+D6CIGx/b8kzUDVVXRYLEL6hYVg
        PkswN7jFlPuxnRgdWF5X4gJCe3SaUoLb3PfvTbZTk119r7u2J2AOnhMeufFPAr2LJJpAHxvqvYH
        9PXzIIQHz0LUc8dRS7gvyLeB05URi7IdaXYDBKJqmpQ==
X-Received: by 2002:a2e:7804:: with SMTP id t4mr31193470ljc.305.1635756340469;
        Mon, 01 Nov 2021 01:45:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO4eUQalnMY+GmolbvNX6MLf2tjTZ/qaEH8Q6qIcLzLQsXmD8ENqNX0LUt9PZiHmN4NRJPcA==
X-Received: by 2002:a2e:7804:: with SMTP id t4mr31193446ljc.305.1635756340279;
        Mon, 01 Nov 2021 01:45:40 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d9sm131527lfs.108.2021.11.01.01.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 01:45:39 -0700 (PDT)
Message-ID: <82835e3d-11a3-32e4-0782-d827a5e3d78e@canonical.com>
Date:   Mon, 1 Nov 2021 09:45:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] memory: mtk-smi: Fix a null dereference for the ostd
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com, Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20211028055056.26378-1-yong.wu@mediatek.com>
 <23b036d1-bdc4-da55-a800-03fc3dabd48e@canonical.com>
 <9e4f327511fd85ba8613ec27644fbc29bc4ddb6b.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <9e4f327511fd85ba8613ec27644fbc29bc4ddb6b.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2021 07:09, Yong Wu wrote:
> On Fri, 2021-10-29 at 19:35 +0200, Krzysztof Kozlowski wrote:
>> On 28/10/2021 07:50, Yong Wu wrote:
>>> We add the ostd setting for mt8195. It introduces a abort for the
>>> previous SoC which doesn't have ostd setting. This is the log:
>>>
>>> Unable to handle kernel NULL pointer dereference at virtual address
>>> 0000000000000080
>>> ...
>>> pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
>>> lr : mtk_smi_larb_resume+0x54/0x98
>>> ...
>>> Call trace:
>>>  mtk_smi_larb_config_port_gen2_general+0x64/0x130
>>>  pm_generic_runtime_resume+0x2c/0x48
>>>  __genpd_runtime_resume+0x30/0xa8
>>>  genpd_runtime_resume+0x94/0x2c8
>>>  __rpm_callback+0x44/0x150
>>>  rpm_callback+0x6c/0x78
>>>  rpm_resume+0x310/0x558
>>>  __pm_runtime_resume+0x3c/0x88
>>>
>>> In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
>>> if "larb->larb_gen->ostd" is null, the "larbostd" is the offset, it
>>> is
>>> also a valid value, thus, use the larb->larb_gen->ostd as the
>>> condition
>>> inside the "for" loop.
>>
>> You need to write more clearly, what you are fixing here.
>>
>>>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>> Hi Krzysztof,
>>> Could you help review and conside this as a fix for the mt8195
>>> patchset?
>>> The mt8195 patchset are not in mainline, thus, I don't know its
>>> sha-id,
>>> and don't add Fixes tag.
>>> Thanks
>>> ---
>>>  drivers/memory/mtk-smi.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>>> index b883dcc0bbfa..0262a59a2d6e 100644
>>> --- a/drivers/memory/mtk-smi.c
>>> +++ b/drivers/memory/mtk-smi.c
>>> @@ -257,7 +257,7 @@ static void
>>> mtk_smi_larb_config_port_gen2_general(struct device *dev)
>>>  	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_SW_FLAG))
>>>  		writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base +
>>> SMI_LARB_SW_FLAG);
>>>  
>>> -	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd &&
>>> !!larbostd[i]; i++)
>>> +	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larb->larb_gen->ostd &&
>>> !!larbostd[i]; i++)
>>>  		writel_relaxed(larbostd[i], larb->base +
>>> SMI_LARB_OSTDL_PORTx(i));
>>
>> The code does not look good. You have already a dereference at line
>> 244:
>>
>> 	const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
> 
> if larb->larb_gen->ostd is null, larbostd is the offset, e.g. 0x80 in
> the log above. thus, we can not use "larbostd[i]" in the "for" loop.
> 
> sorry for the unreadable. In this case, is the change ok?

No, it's ok, I did not check the type of ostd and it's confusing a bit
that it is defined as a pointer to an array but you actually use it as
array of pointers to 32-elemenet arrays... Anyway I was mistaken and
there will be indeed no dereference at the assignment, but for code
clarity I would still prefer to do the check earlier, so:

> 
> or like this:
> 
> -const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
> +const u8 *larbostd = larb->larb_gen->ostd ? larb->larb_gen-ostd[larb-
>> larbid] : NULL;

Although I think now the proper type should be explicit.
mtk_smi_larb_mt8195_ostd is an 28-element array of
SMI_LARB_PORT_NR_MAX-element u8 arrays, therefore struct
mtk_smi_larb_gen should be:
	const u8 (*ostd)[][SMI_LARB_PORT_NR_MAX];

Right?


Best regards,
Krzysztof
