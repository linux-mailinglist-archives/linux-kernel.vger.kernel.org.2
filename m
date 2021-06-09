Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EBA3A1837
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhFIO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:58:20 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38865 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbhFIO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:58:13 -0400
Received: by mail-wm1-f54.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso4487950wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aqUXgxKem/FgFj2OMd/1PjPY57LBnc5X2h5rJOjG66g=;
        b=DfyNKmTodZSmubr8h4Gd9vq39IM67wd+xk00ybFXRBanS3aS5Ro/Ocm0/54zq49csE
         8b4UkVNN3MnDd0RDmKAE6gTZsx/KgIQmDairrr1iT223CnAToVNHQSiHKvbBTSdJe91G
         5mYr452Kvs5KcObJ81VXUFQH7zeGkkxLoqgDzWp03WOaApsqj/HEkERhMAP7QPc1Qq2s
         HnTTRtBN6JtH0zLpW4G9zwhxPUccJ1WrcBtK3YFI4w1tegyU+utDqwbcawBbM+D3GKDJ
         uTy0lLjxEeK/cAEzTHno+viQoEIEjIF4Jl8fauFOYYqT/q3Bkm2Zm+MmCQUTAP43AR5S
         2XQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aqUXgxKem/FgFj2OMd/1PjPY57LBnc5X2h5rJOjG66g=;
        b=fsRbnpyHy/HFlLuHzoX4BgVDA4jdw8QjpT/zzAxPUxjn4zCAa1uZ3uRNwTXVc3ddLJ
         o9orNnDYQmE61rBPoCwzqdpaqeT5WabcfCQm19IwgmQBpk0839NF7FLN5TSwQOw79Jy0
         hzpo30X0o0s+mK9Pc87B+99jM8119jtkcbxOwnD8O8l+5ssfqGumV0ZT88k5w7oUmBqL
         e9MUMS56loK45J9NxBZQkdmVwrCFQVGrUid5NZO4+80pMvIV7y8ZFRLGHy1q7su8XWSg
         ltwhtPDO/rsloj5Ncms2x2E8BSy1iPy7wut3tDISWsrI/fwdR6niVsJzpNG2aKIpSg70
         BEjg==
X-Gm-Message-State: AOAM532bp9xXn/+k/jegemeRuRszC6UQGDoGNGFnlPfEPCol6w4DKB5O
        1OY3LZm0hBmDXJFx1aiclM0h2kujqF6o6lyJ
X-Google-Smtp-Source: ABdhPJyoyiHHWY07377g/rBQGUND7clmDjOwjTdSioN8Q1UBMK/7MPao/79fy28PA/aexKnh6iJ9ZQ==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr262420wmj.134.1623250518306;
        Wed, 09 Jun 2021 07:55:18 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:f5b2:1a3b:b4d:517c? ([2a01:e0a:90c:e290:f5b2:1a3b:b4d:517c])
        by smtp.gmail.com with ESMTPSA id q5sm52991wmc.0.2021.06.09.07.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:55:17 -0700 (PDT)
Subject: Re: [RFC] mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
To:     Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        ulf.hansson@linaro.org
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20210608153357eucas1p24cbc7a2ddb00beada8cdd51ae2337c53@eucas1p2.samsung.com>
 <20210608153344.3813661-1-narmstrong@baylibre.com>
 <e9f057f6-324e-0637-b57a-cc2f87e0d108@samsung.com>
 <ebb1421c-e55c-eee3-ea42-09ae051659d4@baylibre.com>
 <92024ca5-c6fa-0e6a-b6ba-f35f92222e76@arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <a59a4dd3-9a09-a9b4-71f2-7e37c92cf40e@baylibre.com>
Date:   Wed, 9 Jun 2021 16:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <92024ca5-c6fa-0e6a-b6ba-f35f92222e76@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 09/06/2021 16:45, Robin Murphy wrote:
> On 2021-06-09 14:07, Neil Armstrong wrote:
>> Hi,
>>
>> On 08/06/2021 17:50, Marek Szyprowski wrote:
>>> Hi
>>>
>>> On 08.06.2021 17:33, Neil Armstrong wrote:
>>>> It has been reported that usage of memcpy() to/from an iomem mapping is invalid,
>>>> and and recent arm64 memcpy update [1] triggers a memory abort when dram-access-quirk
>>>> is used on the G12A/G12B platforms.
>>>>
>>>> This adds a local sg_copy_to_buffer which makes usage of io versions of memcpy
>>>> when dram-access-quirk is enabled.
>>>>
>>>> Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
>>>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>
>>>> [1] 285133040e6c ("arm64: Import latest memcpy()/memmove() implementation")
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> ---
>>>> Hi Ulf, Marek, Mark,
>>>>
>>>> I haven't tested the patch yet, but should fix issue reported at [2].
>>>
>>> Works fine here and fixed the issue.
>>>
>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> Thanks, I'll need to rework to pass an __iomem pointer to memcpy_to/fromio so sparse doesn't scream anymore.
> 
> Hmm, might it be worth factoring out general sg_copy_{to,from}_iomem() helpers? From a quick grep I found at least mv_cesa_sg_copy() already doing essentially the same thing as meson_mmc_copy_buffer().

It's definitely worth it, but since we need a quick fix, we should have meson_mmc_copy_buffer() as a fix then we should definitely move to sg_copy_{to,from}_iomem() helpers

Neil

> 
> Robin.
> 
>>
>> Neil
>>
>>>
>>>> Neil
>>>>
>>>> [2] https://lore.kernel.org/r/acb244ad-0759-5a96-c659-5c23003d3dcd@samsung.com
>>>>
>>>>    drivers/mmc/host/meson-gx-mmc.c | 48 ++++++++++++++++++++++++++++++---
>>>>    1 file changed, 44 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>>> index b8b771b643cc..89ff6038092d 100644
>>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>>> @@ -742,6 +742,48 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
>>>>        writel(start, host->regs + SD_EMMC_START);
>>>>    }
>>>>    +/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
>>>> +static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
>>>> +                  size_t buflen, bool to_buffer)
>>>> +{
>>>> +    unsigned int sg_flags = SG_MITER_ATOMIC;
>>>> +    struct scatterlist *sgl = data->sg;
>>>> +    unsigned int nents = data->sg_len;
>>>> +    struct sg_mapping_iter miter;
>>>> +    void *buf = host->bounce_buf;
>>>> +    unsigned int offset = 0;
>>>> +
>>>> +    if (to_buffer)
>>>> +        sg_flags |= SG_MITER_FROM_SG;
>>>> +    else
>>>> +        sg_flags |= SG_MITER_TO_SG;
>>>> +
>>>> +    sg_miter_start(&miter, sgl, nents, sg_flags);
>>>> +
>>>> +    while ((offset < buflen) && sg_miter_next(&miter)) {
>>>> +        unsigned int len;
>>>> +
>>>> +        len = min(miter.length, buflen - offset);
>>>> +
>>>> +        /* When dram_access_quirk, the bounce buffer is a iomem mapping */
>>>> +        if (host->dram_access_quirk) {
>>>> +            if (to_buffer)
>>>> +                memcpy_toio(buf + offset, miter.addr, len);
>>>> +            else
>>>> +                memcpy_fromio(miter.addr, buf + offset, len);
>>>> +        } else {
>>>> +            if (to_buffer)
>>>> +                memcpy(buf + offset, miter.addr, len);
>>>> +            else
>>>> +                memcpy(miter.addr, buf + offset, len);
>>>> +        }
>>>> +
>>>> +        offset += len;
>>>> +    }
>>>> +
>>>> +    sg_miter_stop(&miter);
>>>> +}
>>>> +
>>>>    static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>>>    {
>>>>        struct meson_host *host = mmc_priv(mmc);
>>>> @@ -785,8 +827,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>>>            if (data->flags & MMC_DATA_WRITE) {
>>>>                cmd_cfg |= CMD_CFG_DATA_WR;
>>>>                WARN_ON(xfer_bytes > host->bounce_buf_size);
>>>> -            sg_copy_to_buffer(data->sg, data->sg_len,
>>>> -                      host->bounce_buf, xfer_bytes);
>>>> +            meson_mmc_copy_buffer(host, data, xfer_bytes, true);
>>>>                dma_wmb();
>>>>            }
>>>>    @@ -955,8 +996,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>>>>        if (meson_mmc_bounce_buf_read(data)) {
>>>>            xfer_bytes = data->blksz * data->blocks;
>>>>            WARN_ON(xfer_bytes > host->bounce_buf_size);
>>>> -        sg_copy_from_buffer(data->sg, data->sg_len,
>>>> -                    host->bounce_buf, xfer_bytes);
>>>> +        meson_mmc_copy_buffer(host, data, xfer_bytes, false);
>>>>        }
>>>>           next_cmd = meson_mmc_get_next_command(cmd);
>>>
>>> Best regards
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>

