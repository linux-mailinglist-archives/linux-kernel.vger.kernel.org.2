Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D5E416ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbhIXJ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:26:14 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:10724 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244480AbhIXJ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:26:13 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18O7OxP2030465;
        Fri, 24 Sep 2021 04:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=Dtu+AMmyUppUlZKAaDNhyU5E9Qe0t2X5XmtE+DaywZw=;
 b=UAlNyXwoFqJ5ikBwHx0Uju+oG+akmtAWBw4Us6Dx3oJe9ERSg1M6IIEK7NjFq2oDYuCz
 H++ApmpgP4VZfAYbgobDJXZiKwzuAzSfY7Acy9DameKvN2WG3BzxzChuaBBT23bOZGbd
 j5EFkf1rLmSA0YgJ872Ho2maVBDTiW63K/s4j2jWUrkLV2/FimeuEzAJm8Hz10RrwkPO
 R7lzd+JrYJ7xs1XcVLs+AKX+XH2tHFSrLIgv5Gw/xvoJs1ZuiGzl6YP+Eb16IZVJbyxE
 3VrhsZ8FRLmrfqRz+qTBFwJ2rveIPN6Xy/YxEqZLxKleq0tmsYhsxtR8+haQ1cw3kRqN 6w== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3b93f2ge3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Sep 2021 04:24:39 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 24 Sep
 2021 10:24:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 24 Sep 2021 10:24:17 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 56C5445D;
        Fri, 24 Sep 2021 09:24:17 +0000 (UTC)
Subject: Re: [PATCH v1 2/4] mfd: arizona: Add missing entries SPI to device ID
 table
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20210923194645.53046-1-broonie@kernel.org>
 <20210923194645.53046-3-broonie@kernel.org>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <538c0c79-d568-be03-e524-01f5c6429554@opensource.cirrus.com>
Date:   Fri, 24 Sep 2021 10:24:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210923194645.53046-3-broonie@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KqeZkcd-I4zHlPLs1cCgGoH70Pk2KOpg
X-Proofpoint-ORIG-GUID: KqeZkcd-I4zHlPLs1cCgGoH70Pk2KOpg
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2021 20:46, Mark Brown wrote:
> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding SPI IDs for parts that
> only have a compatible listed.
> 
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: patches@opensource.cirrus.com
> ---
>   drivers/mfd/arizona-spi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
> index aa1d6f94ae53..8b44af297b7c 100644
> --- a/drivers/mfd/arizona-spi.c
> +++ b/drivers/mfd/arizona-spi.c
> @@ -216,9 +216,12 @@ static int arizona_spi_remove(struct spi_device *spi)
>   }
>   
>   static const struct spi_device_id arizona_spi_ids[] = {
> +	{ "wm1814", WM1814 },
>   	{ "wm5102", WM5102 },
>   	{ "wm5110", WM5110 },
>   	{ "wm8280", WM8280 },
> +	{ "wm8997", WM8997 },
> +	{ "wm8998", WM8998 },

WM1814, WM8997 and WM8998 do not have a SPI interface, which is why they
aren't in the table of SPI IDs.
