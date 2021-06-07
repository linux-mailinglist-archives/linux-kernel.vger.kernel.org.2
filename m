Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9BD39D4AA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFGGKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:10:51 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:41249 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhFGGKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:10:50 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A95F322172;
        Mon,  7 Jun 2021 08:08:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623046137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzuWySf29iNNVaJeQVLK8ftx+fbfOMCdpAMGH60BRJY=;
        b=v6fteIE6JrovjRlc372f+PAaq6l6ffqlKryJOv8kigSsoen+hGv8D62fCjULu0BUFz/CBM
        zv1ldaTEA+1QE00H0phE3V3sImfoWsN0ndZyvm0AEH19ZBkw/sBmIYtCTWY6YHh+UMbHP7
        Bevb4FQD7vDAC4gOzpd9IjqdVylQb8M=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 07 Jun 2021 08:08:56 +0200
From:   Michael Walle <michael@walle.cc>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at
Subject: Re: [PATCH v5 3/5] mtd: spi-nor: otp: return -EROFS if region is
 read-only
In-Reply-To: <1549db61-500a-e5df-9303-823b41457861@ti.com>
References: <20210604100252.9975-1-michael@walle.cc>
 <20210604100252.9975-4-michael@walle.cc>
 <c2b58dcc-5a60-792c-30ac-a3db327a85ed@microchip.com>
 <e117bc50b9f9e10549c25602b66cfe26@walle.cc>
 <1549db61-500a-e5df-9303-823b41457861@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <4ba7994b0cc8d436012a776ca14addca@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-06-07 07:46, schrieb Vignesh Raghavendra:
> On 6/4/21 6:45 PM, Michael Walle wrote:
>> Am 2021-06-04 15:07, schrieb Tudor.Ambarus@microchip.com:
>>> On 6/4/21 1:02 PM, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>> know the content is safe
>>>> 
>>>> SPI NOR flashes will just ignore program commands if the OTP region 
>>>> is
>>>> locked. Thus, a user might not notice that the intended write didn't 
>>>> end
>>>> up in the flash. Return -EROFS to the user in this case. From what I 
>>>> can
>>>> tell, chips/cfi_cmdset_0001.c also return this error code.
>>>> 
>>>> One could optimize spi_nor_mtd_otp_range_is_locked() to read the 
>>>> status
>>>> register only once and not for every OTP region, but for that we 
>>>> would
>>>> need some more invasive changes. Given that this is
>>>> one-time-programmable memory and the normal access mode is reading, 
>>>> we
>>>> just live with the small overhead.
>>>> 
>>>> Fixes: 069089acf88b ("mtd: spi-nor: add OTP support")
>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
>>>> ---
>>>>  drivers/mtd/spi-nor/otp.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 36 insertions(+)
>>>> 
>>>> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
>>>> index 3898ed67ba1c..063f8fb68649 100644
>>>> --- a/drivers/mtd/spi-nor/otp.c
>>>> +++ b/drivers/mtd/spi-nor/otp.c
>>>> @@ -249,6 +249,32 @@ static int spi_nor_mtd_otp_info(struct mtd_info
>>>> *mtd, size_t len,
>>>>         return ret;
>>>>  }
>>>> 
>>>> +static int spi_nor_mtd_otp_range_is_locked(struct spi_nor *nor,
>>>> loff_t ofs,
>>>> +                                          size_t len)
>>>> +{
>>>> +       const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
>>>> +       unsigned int region;
>>>> +       int locked;
>>>> +
>>>> +       if (!len)
>>>> +               return 0;
>>>> +
>>> 
>>> You won't need this if you put patch 4/5 before this one. With this:
>> 
>> This patch will get backported to the stable kernels. Patch 4 on the
>> other hand does not.
>> 
> 
> I don't see why 4/5 cannot be marked for backport too as it makes 3/5
> much cleaner?

What kind of problem does 4/5 fix? I can't see how that patch would
apply to any rule in Documentation/process/stable-kernel-rules.rst.

But sure, adding the same Fixes: tag, I can swap those two.

-michael
