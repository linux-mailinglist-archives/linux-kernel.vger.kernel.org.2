Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6E342D889
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhJNLvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:51:15 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50912
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231276AbhJNLux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:50:53 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 712FF40011
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634212128;
        bh=+QucqtrNNe6d3rRVyubBLIdJbWx18EKgEONOiKaaLaU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=oafp8naGyvjeqNiby0JaVHviUwPf5Kk+1sSCdhwbm1w6unVAQFYBgQn/78lyoY2Fe
         jypGOqbspCMxiBFsNMdajHks1lZjzcbTOmZmzSVFNTTY4uJFHlo8nt6kiUtjcjj6dv
         3VOg6czAL7cU0FaHpxKua4C23SzSELE2pFv6tTabAiTx37s7lpjsTb3WSa1pdRwovG
         CBoYHzKp43Z11EnllrzrJNuaFgx4hD9WQCWHXNiVkkQ9zE14LcHcgyRs4WQR2T1y2j
         1xolnQ1acfZHJHdjkkDGcN0RVd6GiXvEvGjKx/6T/6vd8ZAZtr5kmq1PDtfJv2YNOg
         wgi4XDmvTZ5+A==
Received: by mail-lf1-f72.google.com with SMTP id z18-20020a0565120c1200b003fd76d7ca21so1435631lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 04:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+QucqtrNNe6d3rRVyubBLIdJbWx18EKgEONOiKaaLaU=;
        b=W+XpnNsWFuOT25kZUi0sNrtiJjKY/OnQmmGht3LLo7dyoOEqGEAZ/nBjifDt3gT9ra
         IQAveje/+4tgiOqHKybq7Dgv92c19W/rPcYUbGEI97mwFHvnDC9kiBbotO7fvleBdlpT
         eQfNqbZZFWpeDzU0g118LN5jYDeXlv+1OgbYctqpJdu9FL9DKwBHjjS2BodSEaOO1DRS
         5Z+KimtZOS8DgYjWeik8bPi1bZIbR9sKCFSQpsie4vK9RBpCprQT3FShHanKKowIVoFm
         8gVMmF+Bdl+cRUxfPbh6JRDtcfKceNVAKHrx6b3s1UvyYidKSCe3QLkNpMPCE6IwcxzY
         V9fw==
X-Gm-Message-State: AOAM532Wge+j16X4mA9amrpfcBamhEBBMbRBDrPNcbhZCvSnAGChsJOs
        0EidDCGow22ZdnlSKHeBTv3mKRpsBx2q6VQauBdDVhQFs4AHW2/fR3ncmtl1MujTUDIkjSXTMdR
        R1GXo1ZFo81hwPIZuQekC2Sqs7Kuk9sFJ0eBHS3OnSQ==
X-Received: by 2002:a05:651c:38c:: with SMTP id e12mr5437333ljp.292.1634212126947;
        Thu, 14 Oct 2021 04:48:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTmoDAukQG+HglITBNz+qRvcuRhzHlNt5dUpM/nqpNFtGelU3omyg5mS+6th9Ubg6fNz2+Lw==
X-Received: by 2002:a05:651c:38c:: with SMTP id e12mr5437314ljp.292.1634212126730;
        Thu, 14 Oct 2021 04:48:46 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id a19sm241434ljb.3.2021.10.14.04.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 04:48:46 -0700 (PDT)
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
 <1cd31098-ba9d-f2e3-e34c-5bada00a2696@canonical.com>
 <CAPLW+4mtSnt8dCCtSeu-yNTR0F5ZO-hdjFjyGChi=tTWQQt85Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <dd61666c-fd1a-c152-9423-9dc6718b1626@canonical.com>
Date:   Thu, 14 Oct 2021 13:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPLW+4mtSnt8dCCtSeu-yNTR0F5ZO-hdjFjyGChi=tTWQQt85Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2021 13:34, Sam Protsenko wrote:
> On Thu, 14 Oct 2021 at 10:11, Krzysztof Kozlowski
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
>>>
>>>  #include "exynos-asv.h"
>>>
>>> +struct exynos_chipid_variant {
>>> +     unsigned int rev_reg;           /* revision register offset */
>>> +     unsigned int main_rev_shift;    /* main revision offset in rev_reg */
>>> +     unsigned int sub_rev_shift;     /* sub revision offset in rev_reg */
>>> +};
>>> +
>>> +struct exynos_chipid_info {
>>> +     u32 product_id;
>>> +     u32 revision;
>>> +};
>>> +
>>>  static const struct exynos_soc_id {
>>>       const char *name;
>>>       unsigned int id;
>>> @@ -49,31 +61,55 @@ static const char *product_id_to_soc_id(unsigned int product_id)
>>>       int i;
>>>
>>>       for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
>>> -             if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
>>> +             if (product_id == soc_ids[i].id)
>>>                       return soc_ids[i].name;
>>>       return NULL;
>>>  }
>>>
>>> +static int exynos_chipid_get_chipid_info(struct regmap *regmap,
>>> +             const struct exynos_chipid_variant *data,
>>> +             struct exynos_chipid_info *soc_info)
>>> +{
>>> +     int ret;
>>> +     unsigned int val, main_rev, sub_rev;
>>> +
>>> +     ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &val);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +     soc_info->product_id = val & EXYNOS_MASK;
>>> +
>>> +     ret = regmap_read(regmap, data->rev_reg, &val);
>>
>> Isn't this the same register as EXYNOS_CHIPID_REG_PRO_ID?
>>
> 
> It is for Exynos4210, but it's not for Exynos850 (see PATCH 3/3), as
> it's described in the commit message. I tried to keep this code
> unified for all SoCs.

Yeah, but for Exynos4210 you read the same register twice. It's
confusing. Read only once. You could compare the offsets and skip second
read.

> 
>>> +     if (ret < 0)
>>> +             return ret;
>>> +     main_rev = (val >> data->main_rev_shift) & EXYNOS_REV_PART_MASK;
>>> +     sub_rev = (val >> data->sub_rev_shift) & EXYNOS_REV_PART_MASK;
>>> +     soc_info->revision = (main_rev << EXYNOS_REV_PART_SHIFT) | sub_rev;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>  static int exynos_chipid_probe(struct platform_device *pdev)
>>>  {
>>> +     const struct exynos_chipid_variant *drv_data;
>>> +     struct exynos_chipid_info soc_info;
>>>       struct soc_device_attribute *soc_dev_attr;
>>>       struct soc_device *soc_dev;
>>>       struct device_node *root;
>>>       struct regmap *regmap;
>>> -     u32 product_id;
>>> -     u32 revision;
>>>       int ret;
>>>
>>> +     drv_data = of_device_get_match_data(&pdev->dev);
>>> +     if (!drv_data)
>>> +             return -EINVAL;
>>> +
>>>       regmap = device_node_to_regmap(pdev->dev.of_node);
>>>       if (IS_ERR(regmap))
>>>               return PTR_ERR(regmap);
>>>
>>> -     ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &product_id);
>>> +     ret = exynos_chipid_get_chipid_info(regmap, drv_data, &soc_info);
>>>       if (ret < 0)
>>>               return ret;
>>>
>>> -     revision = product_id & EXYNOS_REV_MASK;
>>> -
>>>       soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
>>>                                   GFP_KERNEL);
>>>       if (!soc_dev_attr)
>>> @@ -86,8 +122,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
>>>       of_node_put(root);
>>>
>>>       soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>> -                                             "%x", revision);
>>> -     soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
>>> +                                             "%x", soc_info.revision);
>>> +     soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
>>>       if (!soc_dev_attr->soc_id) {
>>>               pr_err("Unknown SoC\n");
>>>               return -ENODEV;
>>> @@ -106,7 +142,7 @@ static int exynos_chipid_probe(struct platform_device *pdev)
>>>
>>>       dev_info(soc_device_to_device(soc_dev),
>>>                "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
>>> -              soc_dev_attr->soc_id, product_id, revision);
>>> +              soc_dev_attr->soc_id, soc_info.product_id, soc_info.revision);
>>>
>>>       return 0;
>>>
>>> @@ -125,9 +161,18 @@ static int exynos_chipid_remove(struct platform_device *pdev)
>>>       return 0;
>>>  }
>>>
>>> +static const struct exynos_chipid_variant exynos4210_chipid_drv_data = {
>>> +     .rev_reg        = 0x0,
>>> +     .main_rev_shift = 0,
>>> +     .sub_rev_shift  = 4,
>>
>> The code does not look correct here. Subrev is at 0:3 bits, mainrev is
>> at 4:7.
>>
> 
> Right. I was confused by those existing macros:
> 
>     #define EXYNOS_SUBREV_MASK        (0xf << 4)
>     #define EXYNOS_MAINREV_MASK        (0xf << 0)
> 
> Those were probably wrong the whole time? Anyway, now I've found
> Exynos4412 User Manual and checked it there -- you are right about
> offsets. Will fix in v3.

They were not used, I think.

> 
>> Did you test it that it produces same result? Looks not - I gave it a
>> try and got wrong revision.
>>
> 
> I only have Exynos850 based board, and that has 0x0 in Revision ID
> register. But for v3 I'll try to emulate register value in the code
> and make sure that the read value does not change with patch applied.

You should get one of Odroid boards to test it. The MC1 is fairly cheap.

Best regards,
Krzysztof
