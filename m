Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2642F40C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbhJONqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:46:04 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39804
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236048AbhJONqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:46:03 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5FF5F40062
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634305436;
        bh=eEc0Vi/iayffTVpVwLxFg1C5akct/CAQN7k1AuOgZVk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=mYxgOPN5Jb1TUhAxbERSP6oDQkg7DCQNK8eFutEd5A20s2mxFGybFNL+foQd1WRpG
         ZxaqsIrJ4T2/uNSLlE7x+VPfqv6PMJtFujJyThFfRwUKGLx46/KB1/lzKKKteR1Ban
         fSIrwVAkj09TyzqyOaOm5IbQ+1sEFc7IXLpaMFSys5AEJx0Tw43kTKAuM6jHgfox+K
         rhLBTjx1GycliuZg+ol0ifw31Ln3IapsrFgbLyyUZHq6P33QnExUczT8WadfsLB/ay
         VntUX7yQTQiN8P6+ASCPK2gpPgKnK6TSawYMOZduT0eNCfQb3/TooFbh4uMdFsbqa4
         6cHROuIcSZLcw==
Received: by mail-lf1-f72.google.com with SMTP id g10-20020a05651222ca00b003fda3f05c17so6756855lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 06:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eEc0Vi/iayffTVpVwLxFg1C5akct/CAQN7k1AuOgZVk=;
        b=gku75wM1laitsO+s/yUMSd+Dhr6RuwDm98ldO6bgYDyKtmbaOvYgT9+Cihxq+vYojz
         oDGKAdnaYjsfvrvIG5TYGwTTytnSclOXiyMcheTzNnXziGz9e+X7jo8kYLpDQJGoYqDh
         xJB5uwHZSdooODoMwF8uh4mhnrLl6yj3BSVReAII8ZWkkjb4849/H0ITUa1jTRm6l/wY
         ZYtbjkRQtYohq6/8SbV1/pDzPq8NzfJb/LjSd664pi48T6VsW1U5MJ+4+uncIXNI0ILt
         qAFBCcy6g2OxOHa0LEBiLkO/4x6lmIHyWyKAzO0MF/Ocs0hHZyqAc52MXtSRYnRHWTPx
         V1WQ==
X-Gm-Message-State: AOAM530yQpLY6575KRp8kteqtixUrMQeLrIk0AnFzgI+QV6qEwZj2jzD
        1Ye/e+9gkgQODOHQ4NYJ7f6poztoZ2QTpb6R4t+MhzHN35TtyJG1Trpm8vbQcTE2nHAKFmFZyap
        a+eX6J1mDAqxL4TOmgf4dfjY/eloooJ85pFpOlANQSA==
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr11244757lfd.330.1634305435637;
        Fri, 15 Oct 2021 06:43:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ+/w4Io+W6PbEi76wSIW7Mdthem4+NCuHObjSgdwIOXIeUa8NDjlAeavafuyp7tD/WUbVmQ==
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr11244728lfd.330.1634305435410;
        Fri, 15 Oct 2021 06:43:55 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bd19sm557333ljb.28.2021.10.15.06.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 06:43:54 -0700 (PDT)
Subject: Re: [PATCH v4 03/13] memory: mtk-smi: Use clk_bulk clock ops
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com,
        Ikjoon Jang <ikjn@chromium.org>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
 <20210914113703.31466-4-yong.wu@mediatek.com>
 <e466b3fb-d9fe-bb20-23c2-f9766a35f120@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ab5c6dd1-7eed-4515-8781-c79e5317d038@canonical.com>
Date:   Fri, 15 Oct 2021 15:43:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e466b3fb-d9fe-bb20-23c2-f9766a35f120@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2021 15:38, AngeloGioacchino Del Regno wrote:
>> Use clk_bulk interface instead of the orginal one to simplify the code.
>>
>> For SMI larbs: Require apb/smi clocks while gals is optional.
>> For SMI common: Require apb/smi/gals0/gal1 in has_gals case. Otherwise,
>>                  also only require apb/smi, No optional clk here.
>>
>> About the "has_gals" flag, for smi larbs, the gals clock also may be
>> optional even this platform support it. thus it always use
>> *_bulk_get_optional, then the flag has_gals is unnecessary. Remove it.
>> The smi_common's has_gals still keep it.
>>
>> Also remove clk fail logs since bulk interface already output fail log.
>>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> 
> Hello Yong,
> thanks for the patch! However, I have an improvement to point out:
> 
>> ---
>>   drivers/memory/mtk-smi.c | 143 +++++++++++++++------------------------
>>   1 file changed, 55 insertions(+), 88 deletions(-)
>>
>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>> index c5fb51f73b34..f91eaf5c3ab0 100644
>> --- a/drivers/memory/mtk-smi.c
>> +++ b/drivers/memory/mtk-smi.c
>> @@ -60,6 +60,20 @@ enum mtk_smi_gen {
>>   	MTK_SMI_GEN2
>>   };
>>   
>> +#define MTK_SMI_CLK_NR_MAX			4
> 
> This refers to mtk_smi_common_clks[] and should be probably moved after that.
> In any case, I don't think that there's any need to manually define this as 4,
> as you can simply use the macro ARRAY_SIZE(mtk_smi_common_clks).
> Using that will make you able to not update this definition everytime an update
> occurs to the mtk_smi_common_clks array.
> 
>> +
>> +/* larbs: Require apb/smi clocks while gals is optional. */
>> +static const char * const mtk_smi_larb_clks[] = {"apb", "smi", "gals"};
>> +#define MTK_SMI_LARB_REQ_CLK_NR		2
>> +#define MTK_SMI_LARB_OPT_CLK_NR		1
>> +
>> +/*
>> + * common: Require these four clocks in has_gals case. Otherwise, only apb/smi are required.
>> + */
>> +static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1"};
>> +#define MTK_SMI_COM_REQ_CLK_NR		2
>> +#define MTK_SMI_COM_GALS_REQ_CLK_NR	MTK_SMI_CLK_NR_MAX
>> +
> 
> Apart from that,
> Acked-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

The patchset was merged around a month ago:
https://lore.kernel.org/lkml/163229303729.7874.4095337797772755570.b4-ty@canonical.com/


Best regards,
Krzysztof
