Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBB33C4E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbhGLHTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:19:50 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:56384
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234153AbhGLGzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:55:19 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jul 2021 02:55:18 EDT
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 3CCC240615
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626072290;
        bh=OR0zgeaONK2MupeyE6Ocj/7EocddRmlmkKFDNFfG1NY=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
        b=br/iqPO48s/Z3W9tLoJ24RW3B1DWXwDbbJMk3Ha/uEeMwKlLR31ReJRayF3Wh04+p
         eE6bxgxe0VQws1G10V1Casu5CgFOocOEfJp4eunsgLxlC8ZBkI7+j8VPYFWsPpwIja
         xCIoi62S3F3aA/XfOP5KyjHMBYlYT1jPVkW5C94Qv+ZRz8Y52TUSKLC9GNfmdfyFqg
         1/BszlrnHDo8UcyQHL8JbULf93HDRnTVMKOmcgrYilD/mowQw9Utu/HMf2oDX5RemW
         6OaxAdvJewFgSzuqu2GJDq696ccWeVAbvzLM8cTpfBVpfX83eKfVmVi7wmhBFMXS+R
         2u8NmB4iKr1cg==
Received: by mail-wm1-f69.google.com with SMTP id p3-20020a05600c3583b02901f55d71e34aso5887468wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 23:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OR0zgeaONK2MupeyE6Ocj/7EocddRmlmkKFDNFfG1NY=;
        b=nQeRNi9CnVQz0eWEcSsjSmU4g838o7zs6gVAFIH5scWLiflrPgxVkv1NX463f9lKRp
         HBv0HaUqnmEluQAbCx3MDHHw0opgMkygmS3doRjLhWAFJXJ+qtfQpIwGqufhbxI679UI
         MX/YqBj6PHS+XmQoW4JMIiiupcKt/Nhm2D0GqeLZI+YII7FTdqwS3zW1advAZhpIRG1v
         3fNxBNszPdw0w5QBSz98D6FS6faIMwhrOP/W9+jsYBuHMv0YawrX9PyGUgawonVDT/CN
         CBYnWsBNSk/Jia4gh79nu7ngyI0ZHBnCv6cCHzmvR0wveFBcP8iDA1BiQKOWLdYtGtv9
         fUtg==
X-Gm-Message-State: AOAM532ze6w/A6e6pcIRzHa/6N+jMvq9a+sHz5Wliw4bNZiF0CS9D8UZ
        IixaBrjspEh5fLzs0GoFAn+WSZu+IRIPDzcsNuT8FF7mAWypbA9m21tf2nTffhvhLC5wB7e+roA
        EAT2FHBxAqCAx3OoUfoyK1kdXVK1/kl17ORi2GvCl2A==
X-Received: by 2002:a05:600c:24d3:: with SMTP id 19mr3338998wmu.171.1626072289645;
        Sun, 11 Jul 2021 23:44:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySU0D9B7fRMXEvgvy6Ati/eZuKcVknMxNOdcIIsbPvm/GJGLKf3jsMbB7YcvqNiHnDrw1oEw==
X-Received: by 2002:a05:600c:24d3:: with SMTP id 19mr3338983wmu.171.1626072289515;
        Sun, 11 Jul 2021 23:44:49 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id o7sm15468284wrv.72.2021.07.11.23.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 23:44:49 -0700 (PDT)
Subject: Re: [PATCH 3/9] memory: mtk-smi: Use clk_bulk instead of the clk ops
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com
References: <20210616114346.18812-1-yong.wu@mediatek.com>
 <20210616114346.18812-4-yong.wu@mediatek.com>
 <4047dfaf-f2f8-b6b2-52fd-41821475b162@canonical.com>
 <1625992199.22309.15.camel@mhfsdcap03>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <fe426c10-4cfe-103c-9961-1b8fdb18a16a@canonical.com>
Date:   Mon, 12 Jul 2021 08:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1625992199.22309.15.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2021 10:29, Yong Wu wrote:
> On Thu, 2021-07-08 at 11:32 +0200, Krzysztof Kozlowski wrote:
>> On 16/06/2021 13:43, Yong Wu wrote:
>>> smi have many clocks: apb/smi/gals.
>>> This patch use clk_bulk interface instead of the orginal one to simply
>>> the code.
>>>
>>> gals is optional clk(some larbs may don't have gals). use clk_bulk_optional
>>> instead. and then remove the has_gals flag.
>>>
>>> Also remove clk fail logs since bulk interface already output fail log.
>>>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>  drivers/memory/mtk-smi.c | 124 +++++++++++----------------------------
>>>  1 file changed, 34 insertions(+), 90 deletions(-)
>>>
>>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>>> index c5fb51f73b34..bcd2bf130655 100644
>>> --- a/drivers/memory/mtk-smi.c
>>> +++ b/drivers/memory/mtk-smi.c
>>> @@ -60,9 +60,18 @@ enum mtk_smi_gen {
>>>  	MTK_SMI_GEN2
>>>  };
>>>  
>>> +#define MTK_SMI_CLK_NR_MAX			4
>>> +
>>> +static const char * const mtk_smi_common_clocks[] = {
>>> +	"apb", "smi", "gals0", "gals1", /* glas is optional */
>>
>> Typo here - glas.
> 
> Will Fix. Thanks.
> 
>>
>>> +};
>>> +
> 
> [snip]
> 
>>> @@ -493,7 +449,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>>>  	struct device *dev = &pdev->dev;
>>>  	struct mtk_smi *common;
>>>  	struct resource *res;
>>> -	int ret;
>>> +	int i, ret;
>>>  
>>>  	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
>>>  	if (!common)
>>> @@ -501,23 +457,13 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>>>  	common->dev = dev;
>>>  	common->plat = of_device_get_match_data(dev);
>>>  
>>> -	common->clk_apb = devm_clk_get(dev, "apb");
>>> -	if (IS_ERR(common->clk_apb))
>>> -		return PTR_ERR(common->clk_apb);
>>> -
>>> -	common->clk_smi = devm_clk_get(dev, "smi");
>>> -	if (IS_ERR(common->clk_smi))
>>> -		return PTR_ERR(common->clk_smi);
>>> +	common->clk_num = ARRAY_SIZE(mtk_smi_common_clocks);
>>> +	for (i = 0; i < common->clk_num; i++)
>>> +		common->clks[i].id = mtk_smi_common_clocks[i];
>>>  
>>> -	if (common->plat->has_gals) {
>>> -		common->clk_gals0 = devm_clk_get(dev, "gals0");
>>> -		if (IS_ERR(common->clk_gals0))
>>> -			return PTR_ERR(common->clk_gals0);
>>> -
>>> -		common->clk_gals1 = devm_clk_get(dev, "gals1");
>>> -		if (IS_ERR(common->clk_gals1))
>>> -			return PTR_ERR(common->clk_gals1);
>>> -	}
>>> +	ret = devm_clk_bulk_get_optional(dev, common->clk_num, common->clks);
>>> +	if (ret)
>>> +		return ret;
>>
>> How do you handle now missing required clocks?
> 
> It looks this is a common issue for this function which supports all the
> clocks could be optional. Is there common suggestion for this?
> 
> For our case, the apb/smi clocks are required while "gals" are optional.
> 
> thus, we should use devm_clk_bulk_get for the necessary clocks and
> devm_clk_bulk_get_optional for the optional ones. right?

Yes, I think that's the solution. Otherwise you might not have proper
clocks leading to accesses to disabled/gated hardware.

Best regards,
Krzysztof
