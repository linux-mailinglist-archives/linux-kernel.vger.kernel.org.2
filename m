Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2440A3A0E86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhFIILj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:11:39 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:52036 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhFIILh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:11:37 -0400
Received: by mail-wm1-f50.google.com with SMTP id l9so3436151wms.1;
        Wed, 09 Jun 2021 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VgaMltfJo1z7GEQx4rEQbem+9M1sDH5NvdC/cDT43co=;
        b=K38NCOYzmomRJ7HWWg92jzk6WciNFspksJN9K+aaghil/1BPZ56e2OEPgPC/KwR+xx
         BYPEkKu1yoAHFE83Wm70y+wV7xZAPbxxxZahvpqZwqB2lnJQVbzj9AJhP0PHD6Rv/Lm6
         5sTL+YZAvkA1npgMW2b8D19Ld7BcREAG4q8crlscPMHV1B2QTzR3nKUp3iUpsRhHOS1b
         O82AfCmcAM8am9kqWuTwwMug3a4ujAfFw+5Lv/UHECP62uteXLHh5Dn9neuUQjqUVwf5
         oHl5bLlt7/yKLmjeTioQn5/lOLL5D5aTTSWnUCbwrQ5NKEeJDbi7iJNT8MIx7y1x/WaS
         zyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VgaMltfJo1z7GEQx4rEQbem+9M1sDH5NvdC/cDT43co=;
        b=Kj4csUW1eguLKMj5KXia/ElwEe7RGtmjvwG1zg5EOTsgS1ixdpiAg5AnLsZsVqzMmH
         X1tq/7T4DW4fySDt+7+SZGAC2FdH2WKDa8XvDTY541Ugl7rYc0ytOv+dEQLAOWuylmR2
         y5akKHOpp8Mv08Hx/aNAiJbFib43424FcXkLMqPaf8cMVKrjULzTCVxQ7cpxbwlkyD65
         GVIlcHsRI6NELHS94z+zyboWkxAfnsCh5TTGBH+doVtGn275MtDe4xo7Qa+mB6DPaiVf
         Ux8TcMdF1WaqWHmMV1Xoau9w52L5RqEzCzDoKAKQZVoqwFYy6PjppsXXH3wA/X8qSyE1
         MPOw==
X-Gm-Message-State: AOAM533oa7rTtg0R3bs9cD2sK0Llaio+fTrZSnuzf0E57Y7hgj1MjdHf
        axIFC/gGRVsp/NJuO+YDRgDZO9FQsO8=
X-Google-Smtp-Source: ABdhPJwP8qnw2dQb0Xb9SRf3aYteDR/JAE2GjpZniv4ftFR/DjNOBtVPcBQB441WfOAoZNSbCiKllg==
X-Received: by 2002:a1c:4d09:: with SMTP id o9mr26874571wmh.149.1623226122425;
        Wed, 09 Jun 2021 01:08:42 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id f14sm4257008wri.16.2021.06.09.01.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 01:08:41 -0700 (PDT)
Subject: Re: [PATCH v9 18/22] clk: mediatek: Add MT8192 mmsys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
 <20210524122053.17155-19-chun-jie.chen@mediatek.com>
 <7520a10b-b362-03d4-e41b-e2098ae26621@gmail.com>
 <ef9441888d4ca82d79295106548dd3d463c9c8bc.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b7a1c230-3f09-d9be-1138-3a5fa87600e7@gmail.com>
Date:   Wed, 9 Jun 2021 10:08:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <ef9441888d4ca82d79295106548dd3d463c9c8bc.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Jie,

On 09/06/2021 00:38, Chun-Jie Chen wrote:
> On Tue, 2021-06-08 at 16:44 +0200, Matthias Brugger wrote:
>>
>> On 24/05/2021 14:20, Chun-Jie Chen wrote:
>>> Add MT8192 mmsys clock provider
>>>
>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>> Signed-off-by: chun-jie.chen <chun-jie.chen@mediatek.com>
>>> ---
>>>  drivers/clk/mediatek/Kconfig         |   6 ++
>>>  drivers/clk/mediatek/Makefile        |   1 +
>>>  drivers/clk/mediatek/clk-mt8192-mm.c | 108
>>> +++++++++++++++++++++++++++
>>>  3 files changed, 115 insertions(+)
>>>  create mode 100644 drivers/clk/mediatek/clk-mt8192-mm.c
>>>
>>
>> [...]
>>> +
>>> +static int clk_mt8192_mm_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct device_node *node = dev->parent->of_node;
>>> +	struct clk_onecell_data *clk_data;
>>> +	int r;
>>> +
>>> +	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
>>> +	if (!clk_data)
>>> +		return -ENOMEM;
>>> +
>>> +	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
>>> clk_data);
>>> +	if (r)
>>> +		return r;
>>> +
>>> +	return of_clk_add_provider(node, of_clk_src_onecell_get,
>>> clk_data);
>>> +}
>>> +
>>> +static struct platform_driver clk_mt8192_mm_drv = {
>>> +	.probe = clk_mt8192_mm_probe,
>>> +	.driver = {
>>> +		.name = "clk-mt8192-mm",
>>> +	},
>>> +};
>>
>> Did you had a look at drivers/soc/mediatek/mtk-mmsys.c? How is the
>> MMSYS
>> different from all the other SoCs? I suppose it is not. Please don't
>> just
>> implement the clock drivers, but check in existing code how they play
>> together
>> with the HW they are for. MediaTek unfortunately has the design to
>> add the clock
>> registers in the address space of the IP block that needs this
>> registers. Which
>> makes it more complicated to implement clock driver in the first
>> place.
>>
>> Regards,
>> Matthias
> 
> Did you means binding the mm clock driver by creating a platform device
> in drivers/soc/mediatek/mtk-mmsys.c? There is 8192 mmsys compatible
> data in patch [1] but lack of it in the latest patch [2], I will check
> it.
> Thanks for your kind reminder.
> 

Yes, the clock driver should be a platform driver. Binding should be done
through the soc driver.


Thanks a lot,
Matthias

> [1] 
> https://patchwork.kernel.org/project/linux-mediatek/patch/1609815993-22744-11-git-send-email-yongqiang.niu@mediatek.com/
> [2] 
> https://patchwork.kernel.org/project/linux-mediatek/patch/1618236288-1617-5-git-send-email-yongqiang.niu@mediatek.com/
> 
> Best Regards,
> Chun-Jie
> 
