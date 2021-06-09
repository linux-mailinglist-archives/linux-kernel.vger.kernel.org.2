Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B953A1522
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhFINKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:10:54 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44012 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFINKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:10:52 -0400
Received: by mail-wr1-f44.google.com with SMTP id r9so8721081wrz.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kEJI7UvKz+ACKbMHESfgG5FvPLQQKWlKNyAxgiMp+mE=;
        b=dAKRH9HkKHdZdIBpdDI+4WBmuXPHtENaNb3y2Z1eb82lIpZwJgEwsmru32SRmv5Qof
         yCFdYzVIC5oeY0iOdRfh4A7nCNuVRIltVb8eHnDuJ2mJfcDb+26G0KsOK1+mm/Zd301T
         8B9c1zwR7JKbbaEr7OZwxfTOKlGvGLLmFcj9yBxnPFJc1wETQbw7ksssupVKwVhf/4KP
         G9rRq5NEq4SNjXA/Mnlw7qJmSyxg/ZLfEu3YDSGITTUzrYV+jPgWdEnNd4im0mOpfPwz
         /On9gcLgBx0voRGMSnzTKA9nrHoGh42VGhCtkes7tL8t3xqzX/frcJ82BJpwxbmbUCsG
         jIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kEJI7UvKz+ACKbMHESfgG5FvPLQQKWlKNyAxgiMp+mE=;
        b=YCM4+GMR0KdNBXHjmVnv3fB9UjMGjAHedRG0UpA9ATRpFnpblKWhdYMwSG7k7E30lx
         c4/JNEzCxudT8pCKNEG9vZGxq3pMzcyHg3H/O1+5ANijJfgUWhD4OQ84LI0v5Gc1/Rmd
         7ZBlN0Nb1Clv92DQq3VnJ97PGf1jx12eIa1BaJdj6iHJZFwlFuXpwRcd5Cfeq+UPKH1B
         K3buYUj4qeWZp6I1g9MbkoHJHYZRLoKT9V9bFHz7VfWUqZ9SpQ+y5d1A5VuIvZMQnGuN
         WnqY12A3xF/wXWw9LPRYjPuwNDq/5DWbJfxzJ8u0cRiMLnfyflsAco8b16rY41Wphod9
         c8XA==
X-Gm-Message-State: AOAM530NThMJdonFImli78zKvXtKJK6DDQnrLGQnEWVLVFh24fltEWmy
        0/BQa/1UyjW0kdBobFmMMwcf2Q==
X-Google-Smtp-Source: ABdhPJyEzA2Ttg+fe3SSs/W6tnxSyhgY4k+sIdj5FY05CPkcMvpVPQXJGhWZKXhJKz8WYw3MOYSMig==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr24425435wrn.156.1623244076710;
        Wed, 09 Jun 2021 06:07:56 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:f5b2:1a3b:b4d:517c? ([2a01:e0a:90c:e290:f5b2:1a3b:b4d:517c])
        by smtp.gmail.com with ESMTPSA id b15sm22391505wru.64.2021.06.09.06.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:07:56 -0700 (PDT)
Subject: Re: [RFC] mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
To:     Marek Szyprowski <m.szyprowski@samsung.com>, ulf.hansson@linaro.org
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20210608153357eucas1p24cbc7a2ddb00beada8cdd51ae2337c53@eucas1p2.samsung.com>
 <20210608153344.3813661-1-narmstrong@baylibre.com>
 <e9f057f6-324e-0637-b57a-cc2f87e0d108@samsung.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <ebb1421c-e55c-eee3-ea42-09ae051659d4@baylibre.com>
Date:   Wed, 9 Jun 2021 15:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e9f057f6-324e-0637-b57a-cc2f87e0d108@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/06/2021 17:50, Marek Szyprowski wrote:
> Hi
> 
> On 08.06.2021 17:33, Neil Armstrong wrote:
>> It has been reported that usage of memcpy() to/from an iomem mapping is invalid,
>> and and recent arm64 memcpy update [1] triggers a memory abort when dram-access-quirk
>> is used on the G12A/G12B platforms.
>>
>> This adds a local sg_copy_to_buffer which makes usage of io versions of memcpy
>> when dram-access-quirk is enabled.
>>
>> Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> [1] 285133040e6c ("arm64: Import latest memcpy()/memmove() implementation")
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>> Hi Ulf, Marek, Mark,
>>
>> I haven't tested the patch yet, but should fix issue reported at [2].
> 
> Works fine here and fixed the issue.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks, I'll need to rework to pass an __iomem pointer to memcpy_to/fromio so sparse doesn't scream anymore.

Neil

> 
>> Neil
>>
>> [2] https://lore.kernel.org/r/acb244ad-0759-5a96-c659-5c23003d3dcd@samsung.com
>>
>>   drivers/mmc/host/meson-gx-mmc.c | 48 ++++++++++++++++++++++++++++++---
>>   1 file changed, 44 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index b8b771b643cc..89ff6038092d 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -742,6 +742,48 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
>>   	writel(start, host->regs + SD_EMMC_START);
>>   }
>>   
>> +/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
>> +static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
>> +				  size_t buflen, bool to_buffer)
>> +{
>> +	unsigned int sg_flags = SG_MITER_ATOMIC;
>> +	struct scatterlist *sgl = data->sg;
>> +	unsigned int nents = data->sg_len;
>> +	struct sg_mapping_iter miter;
>> +	void *buf = host->bounce_buf;
>> +	unsigned int offset = 0;
>> +
>> +	if (to_buffer)
>> +		sg_flags |= SG_MITER_FROM_SG;
>> +	else
>> +		sg_flags |= SG_MITER_TO_SG;
>> +
>> +	sg_miter_start(&miter, sgl, nents, sg_flags);
>> +
>> +	while ((offset < buflen) && sg_miter_next(&miter)) {
>> +		unsigned int len;
>> +
>> +		len = min(miter.length, buflen - offset);
>> +
>> +		/* When dram_access_quirk, the bounce buffer is a iomem mapping */
>> +		if (host->dram_access_quirk) {
>> +			if (to_buffer)
>> +				memcpy_toio(buf + offset, miter.addr, len);
>> +			else
>> +				memcpy_fromio(miter.addr, buf + offset, len);
>> +		} else {
>> +			if (to_buffer)
>> +				memcpy(buf + offset, miter.addr, len);
>> +			else
>> +				memcpy(miter.addr, buf + offset, len);
>> +		}
>> +
>> +		offset += len;
>> +	}
>> +
>> +	sg_miter_stop(&miter);
>> +}
>> +
>>   static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>   {
>>   	struct meson_host *host = mmc_priv(mmc);
>> @@ -785,8 +827,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>   		if (data->flags & MMC_DATA_WRITE) {
>>   			cmd_cfg |= CMD_CFG_DATA_WR;
>>   			WARN_ON(xfer_bytes > host->bounce_buf_size);
>> -			sg_copy_to_buffer(data->sg, data->sg_len,
>> -					  host->bounce_buf, xfer_bytes);
>> +			meson_mmc_copy_buffer(host, data, xfer_bytes, true);
>>   			dma_wmb();
>>   		}
>>   
>> @@ -955,8 +996,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>>   	if (meson_mmc_bounce_buf_read(data)) {
>>   		xfer_bytes = data->blksz * data->blocks;
>>   		WARN_ON(xfer_bytes > host->bounce_buf_size);
>> -		sg_copy_from_buffer(data->sg, data->sg_len,
>> -				    host->bounce_buf, xfer_bytes);
>> +		meson_mmc_copy_buffer(host, data, xfer_bytes, false);
>>   	}
>>   
>>   	next_cmd = meson_mmc_get_next_command(cmd);
> 
> Best regards
> 

