Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655C631B1BB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 19:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBNR50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 12:57:26 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19737 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhBNR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 12:57:23 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6029645b0000>; Sun, 14 Feb 2021 09:56:43 -0800
Received: from [10.25.100.251] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Feb
 2021 17:56:39 +0000
Subject: Re: [PATCH 1/3] ASoC: simple-card-utils: Fix device module clock
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <broonie@kernel.org>, <robh@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>
References: <1612939421-19900-1-git-send-email-spujar@nvidia.com>
 <1612939421-19900-2-git-send-email-spujar@nvidia.com>
 <87im6y5fv8.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <93c9d656-8379-b463-e724-e48ce486c17d@nvidia.com>
Date:   Sun, 14 Feb 2021 23:26:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87im6y5fv8.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613325403; bh=5r+No4EM/ChCUa5jbPRUAONV8A4MOJSJyXrLuV1AsSI=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=LgHZ5qdLHsWmzU8DMrRQI6N8CM/TDMWra1cBp9axNMkO15oMKK9fdcirGuNbg6/C6
         WI6uZMclf0l1Fd9gvdZZ/nI/v5VxPq9jDrbe4k970Ze/l9qXAtpYx4KwmEP4oXYT+k
         qElLpuyLYZEV+DC8KNnbPTgdRRakSyq1htNqmtHxsTtlU/oChBrYBJTTb1fw8UxtUs
         U3KUDBs80FMqIigdNfQjZW97n+Fj3IvaZGuPZGMBeSs9kAlx2bB09tj9zonEXZfd7w
         oIvtZsIWhgigqPR2PSLLJ/dWPCnIPaJVUNDiCmCl7PRgROK14uzQ9QOKlmpnWrLksW
         dL2KABFKD4bhw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,


On 2/12/2021 5:14 AM, Kuninori Morimoto wrote:
>> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
>> index bc0b62e..0754d70 100644
>> --- a/sound/soc/generic/simple-card-utils.c
>> +++ b/sound/soc/generic/simple-card-utils.c
>> @@ -173,16 +173,15 @@ int asoc_simple_parse_clk(struct device *dev,
>>         *  or device's module clock.
>>         */
>>        clk = devm_get_clk_from_child(dev, node, NULL);
>> -     if (!IS_ERR(clk)) {
>> -             simple_dai->sysclk = clk_get_rate(clk);
>> +     if (IS_ERR(clk))
>> +             clk = devm_get_clk_from_child(dev, dlc->of_node, NULL);
>>
>> +     if (!IS_ERR(clk)) {
>>                simple_dai->clk = clk;
>> -     } else if (!of_property_read_u32(node, "system-clock-frequency", &val)) {
>> +             simple_dai->sysclk = clk_get_rate(clk);
>> +     } else if (!of_property_read_u32(node, "system-clock-frequency",
>> +                                      &val)) {
>>                simple_dai->sysclk = val;
>> -     } else {
>> -             clk = devm_get_clk_from_child(dev, dlc->of_node, NULL);
>> -             if (!IS_ERR(clk))
>> -                     simple_dai->sysclk = clk_get_rate(clk);
>>        }
> The comment is indicating that that the clock parsing order,
> but this patch exchanges it.
> This comment also should be updated, I think.
>
>          /*
>           * Parse dai->sysclk come from "clocks = <&xxx>"
>           * (if system has common clock)
>           *  or "system-clock-frequency = <xxx>"
>           *  or device's module clock.
>           */

Yes, this can be rephrased now.

> asoc_simple_set_clk_rate() will be called if it has simple_dai->clk.
> CPU or Codec component clock rate will be exchanged by this patch, I think.
> I'm not sure the effect of this patch to existing boards.

If CPU or Codec node does not specifiy "mclk-fs" factor, 
asoc_simple_set_clk_rate() won't be called. So I don't think there would 
be any effect w.r.t clock rate. With this patch clocks would get 
enabled/disabled.

>
> And also, this patch has too many unneeded exchange,
> thus it was difficult to read for me.
> I think it can be simply like this ?
> It is understandable what it want to do.

I think the patch does exactly the same thing as what you are suggesting 
below. Am I missing anything?

>
> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
> index 8c423afb9d2e..d441890de4dc 100644
> --- a/sound/soc/generic/simple-card-utils.c
> +++ b/sound/soc/generic/simple-card-utils.c
> @@ -168,16 +168,14 @@ int asoc_simple_parse_clk(struct device *dev,
>           *  or device's module clock.
>           */
>          clk = devm_get_clk_from_child(dev, node, NULL);
> +       if (IS_ERR(clk))
> +               clk = devm_get_clk_from_child(dev, dlc->of_node, NULL);
> +
>          if (!IS_ERR(clk)) {
>                  simple_dai->sysclk = clk_get_rate(clk);
> -
>                  simple_dai->clk = clk;
>          } else if (!of_property_read_u32(node, "system-clock-frequency", &val)) {
>                  simple_dai->sysclk = val;
> -       } else {
> -               clk = devm_get_clk_from_child(dev, dlc->of_node, NULL);
> -               if (!IS_ERR(clk))
> -                       simple_dai->sysclk = clk_get_rate(clk);
>          }
>
>          if (of_property_read_bool(node, "system-clock-direction-out"))
