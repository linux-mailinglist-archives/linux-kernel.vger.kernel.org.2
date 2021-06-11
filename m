Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9083A3FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFKKM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:12:59 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:39272 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhFKKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:12:58 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d06 with ME
        id FmAy2500721Fzsu03mAyrf; Fri, 11 Jun 2021 12:10:59 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 11 Jun 2021 12:10:59 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH 4/9] nvmem: sprd: Fix an error message
To:     Greg KH <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-5-srinivas.kandagatla@linaro.org>
 <YMMlRq250A53CDaM@kroah.com>
 <a34f8a9d-c9e7-5c2d-521f-13677cfd7ccb@linaro.org>
 <YMMqPlknDF+k466x@kroah.com> <YMMwteJ5XvDST+zH@kroah.com>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <7bd13064-8a50-2723-4ebe-d4ff7563c199@wanadoo.fr>
Date:   Fri, 11 Jun 2021 12:10:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMMwteJ5XvDST+zH@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 11/06/2021 à 11:45, Greg KH a écrit :
> On Fri, Jun 11, 2021 at 11:17:50AM +0200, Greg KH wrote:
>> On Fri, Jun 11, 2021 at 10:05:40AM +0100, Srinivas Kandagatla wrote:
>>>
>>> On 11/06/2021 09:56, Greg KH wrote:
>>>> On Fri, Jun 11, 2021 at 09:33:43AM +0100, Srinivas Kandagatla wrote:
>>>>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>>>
>>>>> 'ret' is known to be 0 here.
>>>>> The expected error status is stored in 'status', so use it instead.
>>>>>
>>>>> Also change %d in %u, because status is an u32, not a int.
>>>>>
>>>>> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
>>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>>> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
>>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>> ---
>>>>>    drivers/nvmem/sprd-efuse.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
>>>>> index 5d394559edf2..e3e721d4c205 100644
>>>>> --- a/drivers/nvmem/sprd-efuse.c
>>>>> +++ b/drivers/nvmem/sprd-efuse.c
>>>>> @@ -234,7 +234,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
>>>>>    	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
>>>>>    	if (status) {
>>>>>    		dev_err(efuse->dev,
>>>>> -			"write error status %d of block %d\n", ret, blk);
>>>>> +			"write error status %u of block %d\n", status, blk);
>>>> Shouldn't this be %pe and not %u?
>>> This is not error pointer its status value read back from a register.
>>>
>>> I think %u should be good here.
>> Argh, you are right, my fault.  For some reason I thought this worked
>> for integers as well.  Don't we have such a printk modifier somewhere to
>> turn error values into strings?  Let me dig...
> Ah, errname() will do it.
>
> Looks like no one uses it, so nevermind, sorry for the noise.  I'll go
> apply this one now.
>
> thanks,
>
> greg k-h

Hi,

errname() depends on CONFIG_SYMBOLIC_ERRNAME.
Is this widely used?
If not, using errname() directly would loose the error code.
(note that %pe already deals with it)

Dan Capenter already spoke about a potential %e extension, but I don't 
think anyone did anything yet.

CJ

