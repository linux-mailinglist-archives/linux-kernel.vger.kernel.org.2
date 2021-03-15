Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7473633AF7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCOKCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:02:15 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36973 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCOKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:01:55 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ADD4F2223A;
        Mon, 15 Mar 2021 11:01:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615802513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGPd+CT8s79hFeiEpM/nnYfFAxMfPqg60ZHDn0T03J4=;
        b=fGMoLNBJp8Pp/nYl6HtpNFLCX0GQXr4Ri1CbML5wUaQlTuTTaEvXwh23HCkE6qt8f6GC8k
        QkoWMKAdUOQ+JI3xVfpVc0iN7dkMZakL1h1JX3xbstUCopdIWzEisVxJRGP1gjXZ7VDNAp
        LMhpf0eyYmLuaQ6jNZnoJ8Y3kZF37Vc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Mar 2021 11:01:53 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at
Subject: Re: [PATCH v4 1/4] mtd: spi-nor: add OTP support
In-Reply-To: <f0ffd9b3-94d1-05ca-7e90-5014bf7a3db4@microchip.com>
References: <20210306000535.9890-1-michael@walle.cc>
 <20210306000535.9890-2-michael@walle.cc>
 <7dd4bfb0-bb38-20c8-68e1-ece836c847fa@microchip.com>
 <b83dbbcdee6bdeee0d494ba79fd792e4@walle.cc>
 <8b35d8f6-6ff8-9bf3-02bd-434cf46acccb@microchip.com>
 <f0ffd9b3-94d1-05ca-7e90-5014bf7a3db4@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <bbbc6230b7d60a2421520ce7d163be56@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-15 10:44, schrieb Tudor.Ambarus@microchip.com:
> On 3/15/21 11:39 AM, Tudor Ambarus - M18064 wrote:
>> On 3/15/21 11:23 AM, Michael Walle wrote:
>> 
>> cut
>> 
>>>>> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
>>>>> new file mode 100644
>>>>> index 000000000000..4e301fd5156b
>>>>> --- /dev/null
>>>>> +++ b/drivers/mtd/spi-nor/otp.c
>>>>> @@ -0,0 +1,218 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * OTP support for SPI NOR flashes
>>>>> + *
>>>>> + * Copyright (C) 2021 Michael Walle <michael@walle.cc>> + */
>>>>> +
>>>>> +#include <linux/log2.h>
>>>>> +#include <linux/mtd/mtd.h>
>>>>> +#include <linux/mtd/spi-nor.h>
>>>>> +
>>>>> +#include "core.h"
>>>>> +
>>>>> +#define spi_nor_otp_ops(nor) ((nor)->params->otp.ops)
>>>>> +#define spi_nor_otp_region_len(nor) ((nor)->params->otp.org->len)
>>>>> +#define spi_nor_otp_n_regions(nor)
>>>>> ((nor)->params->otp.org->n_regions)
>>>> 
>>>> I don't like these wrappers because they gratuiously hide what's 
>>>> really
>>>> there.
>>>> I find the code more easier to read without these wrappers, because 
>>>> I
>>>> don't
>>>> have to memorize what these wrappers are doing, and I better see how
>>>> the code
>>>> is organized.
>>> 
>>> TBH I find it easier on the eye and I've never seen so much 
>>> dereferences
>>> as in mtd/spi-nor.
> 
> the dereferences will still be there, but will be just hidden by these 
> wrappers,
> don't they? Why would one prefer the wrappers?

That's why I wrote "easier on the eye", yes that is subjective. But
there are also technical aspects, for example, the helpers all
operate on "struct nor*", so you don't have to use the
dereference chain or build up local variables. For example, see
spi_nor_otp_read_write(), it doesn't have to know
anything about the "struct spi_nor_otp_organization".

And of course you could change the actual implementation
without touching the code everywhere,.

-michael
