Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EC639325E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbhE0PZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:25:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40892 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbhE0PY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:24:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lmHqT-0007O9-9F; Thu, 27 May 2021 15:22:49 +0000
Subject: Re: [PATCH][next] mtd: rawnand: ensure return variable is initialized
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210527145048.795954-1-colin.king@canonical.com>
 <20210527170309.4d99bc31@xps13>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <06e72a95-1f01-f9b7-d172-51f22224a2a7@canonical.com>
Date:   Thu, 27 May 2021 16:22:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527170309.4d99bc31@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2021 16:03, Miquel Raynal wrote:
> Hi Colin,
> 
> Colin King <colin.king@canonical.com> wrote on Thu, 27 May 2021
> 15:50:48 +0100:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently there are corner cases where spec_times is NULL and
>> chip->parameters.onfi or when best_mode is zero where ret is
> 
>                        ^
> something is missing here, the sentence is not clear
> 
>> not assigned a value and an uninitialized return value can be
>> returned. Fix this by ensuring ret is initialized to -EINVAL.
> 
> I don't see how this situation can happen.
> 
> In both cases, no matter the value of best_mode, the for loop will
> always execute at least one time (mode 0) so ret will be populated.
> 
> Maybe the robot does not know that best_mode cannot be negative and
> should be defined unsigned, but the current patch is invalid.

Yep, I've looked at this again and it does seem like a false positive.
Apologies for the noise.

> 
>> Addresses-Coverity: ("Uninitialized scalar variable")
>> Fixes: 9d3194bf2aef ("mtd: rawnand: Allow SDR timings to be nacked")
>> Fixes: a9ecc8c814e9 ("mtd: rawnand: Choose the best timings, NV-DDR included")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/mtd/nand/raw/nand_base.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
>> index 57a583149cc0..18db742f650c 100644
>> --- a/drivers/mtd/nand/raw/nand_base.c
>> +++ b/drivers/mtd/nand/raw/nand_base.c
>> @@ -926,7 +926,7 @@ int nand_choose_best_sdr_timings(struct nand_chip *chip,
>>  				 struct nand_sdr_timings *spec_timings)
>>  {
>>  	const struct nand_controller_ops *ops = chip->controller->ops;
>> -	int best_mode = 0, mode, ret;
>> +	int best_mode = 0, mode, ret = -EINVAL;
>>  
>>  	iface->type = NAND_SDR_IFACE;
>>  
>> @@ -977,7 +977,7 @@ int nand_choose_best_nvddr_timings(struct nand_chip *chip,
>>  				   struct nand_nvddr_timings *spec_timings)
>>  {
>>  	const struct nand_controller_ops *ops = chip->controller->ops;
>> -	int best_mode = 0, mode, ret;
>> +	int best_mode = 0, mode, ret = 0;
>>  
>>  	iface->type = NAND_NVDDR_IFACE;
>>  
> 
> Thanks,
> Miquèl
> 

