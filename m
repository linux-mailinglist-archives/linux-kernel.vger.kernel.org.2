Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E0639D9FC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFGKrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:47:42 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:46273 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGKrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:47:41 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 998BE22173;
        Mon,  7 Jun 2021 12:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623062747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HtcjoDEottJsH6hOo8FFAg8Br0rxwSoDL6YU6qH3MNk=;
        b=WzDsxEeoMpRcUuQZn5ScEFSd6wBgtBLSRzU79gjrQG7H5Vu1C8GDvuHnCXVzYvsmmYckNS
        2l/fNQOPKZMsGSZ+3sAZTBB9OYTkrvp+zRxyMM4cAUI/TWZN654L1vpYBoA1lCTTjGgDXi
        Pmjuv2nTMzSVBEABP2Il3xBsLCXvcLY=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 07 Jun 2021 12:45:47 +0200
From:   Michael Walle <michael@walle.cc>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at
Subject: Re: [PATCH v5 3/5] mtd: spi-nor: otp: return -EROFS if region is
 read-only
In-Reply-To: <4b3e1bde-09ff-eebd-8e93-8db7a5834f96@ti.com>
References: <20210604100252.9975-1-michael@walle.cc>
 <20210604100252.9975-4-michael@walle.cc>
 <c2b58dcc-5a60-792c-30ac-a3db327a85ed@microchip.com>
 <e117bc50b9f9e10549c25602b66cfe26@walle.cc>
 <1549db61-500a-e5df-9303-823b41457861@ti.com>
 <4ba7994b0cc8d436012a776ca14addca@walle.cc>
 <3e46bc75-6ace-f7c0-1b14-aae812554ac9@ti.com>
 <2559d150b3a0d964ece0c9e29e155ecc@walle.cc>
 <4b3e1bde-09ff-eebd-8e93-8db7a5834f96@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <6745ec209caa1d335a3e093c1de76ef6@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-06-07 12:30, schrieb Vignesh Raghavendra:
> On 6/7/21 3:26 PM, Michael Walle wrote:
>> Am 2021-06-07 08:47, schrieb Vignesh Raghavendra:
>>> On 6/7/21 11:38 AM, Michael Walle wrote:
>>>> Am 2021-06-07 07:46, schrieb Vignesh Raghavendra:
>>>>> On 6/4/21 6:45 PM, Michael Walle wrote:
>>>>>> Am 2021-06-04 15:07, schrieb Tudor.Ambarus@microchip.com:
>>>>>>> On 6/4/21 1:02 PM, Michael Walle wrote:
>>>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless 
>>>>>>>> you
>>>>>>>> know the content is safe
>>>>>>>> 
>>>>>>>> SPI NOR flashes will just ignore program commands if the OTP
>>>>>>>> region is
>>>>>>>> locked. Thus, a user might not notice that the intended write
>>>>>>>> didn't end
>>>>>>>> up in the flash. Return -EROFS to the user in this case. From 
>>>>>>>> what
>>>>>>>> I can
>>>>>>>> tell, chips/cfi_cmdset_0001.c also return this error code.
>>>>>>>> 
>>>>>>>> One could optimize spi_nor_mtd_otp_range_is_locked() to read the
>>>>>>>> status
>>>>>>>> register only once and not for every OTP region, but for that we
>>>>>>>> would
>>>>>>>> need some more invasive changes. Given that this is
>>>>>>>> one-time-programmable memory and the normal access mode is
>>>>>>>> reading, we
>>>>>>>> just live with the small overhead.
>>>>>>>> 
>>>>>>>> Fixes: 069089acf88b ("mtd: spi-nor: add OTP support")
>>>>>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>>>>>> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
>>>>>>>> ---
>>>>>>>>  drivers/mtd/spi-nor/otp.c | 36 
>>>>>>>> ++++++++++++++++++++++++++++++++++++
>>>>>>>>  1 file changed, 36 insertions(+)
>>>>>>>> 
>>>>>>>> diff --git a/drivers/mtd/spi-nor/otp.c 
>>>>>>>> b/drivers/mtd/spi-nor/otp.c
>>>>>>>> index 3898ed67ba1c..063f8fb68649 100644
>>>>>>>> --- a/drivers/mtd/spi-nor/otp.c
>>>>>>>> +++ b/drivers/mtd/spi-nor/otp.c
>>>>>>>> @@ -249,6 +249,32 @@ static int spi_nor_mtd_otp_info(struct 
>>>>>>>> mtd_info
>>>>>>>> *mtd, size_t len,
>>>>>>>>         return ret;
>>>>>>>>  }
>>>>>>>> 
>>>>>>>> +static int spi_nor_mtd_otp_range_is_locked(struct spi_nor *nor,
>>>>>>>> loff_t ofs,
>>>>>>>> +                                          size_t len)
>>>>>>>> +{
>>>>>>>> +       const struct spi_nor_otp_ops *ops = 
>>>>>>>> nor->params->otp.ops;
>>>>>>>> +       unsigned int region;
>>>>>>>> +       int locked;
>>>>>>>> +
>>>>>>>> +       if (!len)
>>>>>>>> +               return 0;
>>>>>>>> +
>>>>>>> 
>>>>>>> You won't need this if you put patch 4/5 before this one. With 
>>>>>>> this:
>>>>>> 
>>>>>> This patch will get backported to the stable kernels. Patch 4 on 
>>>>>> the
>>>>>> other hand does not.
>>>>>> 
>>>>> 
>>>>> I don't see why 4/5 cannot be marked for backport too as it makes 
>>>>> 3/5
>>>>> much cleaner?
>>>> 
>>>> What kind of problem does 4/5 fix? I can't see how that patch would
>>>> apply to any rule in Documentation/process/stable-kernel-rules.rst.
>>>> 
>>> 
>>> Looking further, I don't see the need for 4/5 to be a separate patch.
>>> Patch 4/5 is simplifying spi_nor_mtd_otp_range_is_locked() by 
>>> ensuring
>>> 'len' passed is never 0 which can be done in 3/5 when introducing
>>> spi_nor_mtd_otp_range_is_locked().
>>> 
>>> So why not squashed it into 3/5.
>> 
>> Because, strictly speaking, it is not part of that particular fix
>> and IMHO violates "It must fix only one thing". But if you're fine
>> with that, I can squash the two.
>> 
>> TBH I find it kinda funny to bend the rules, just to get rid of
>> these three lines of code or the ugliness that they will be removed
>> in the following patch.
>> 
> 
> This is still fixing only one thing "Indicating OTP writes are ignored
> when region is locked" (ie spi_nor_mtd_otp_range_is_locked() check).
> But, spi_nor_mtd_otp_range_is_locked() (as in 3/5) can be simplified if
> 'len != 0' is checked prior to calling the function. That's what 4/5
> does which I believe can be squashed here.

Correct, but it also skip the lock/unlock as well as the "*retlen = 0",
which isn't needed to just fix the error, IMHO. I've already asked Tudor
before adding this patch, but I guess I didn't make it clear enough that
one would be for the backporting and one for for-next.

> I just don't like code being refactored for the purpose of being able 
> to
> be backported. It feels weird to have a piece of code being added in 
> one
> commit, and then being deleted the very next commit.
> So strictly speaking 4/5 has to come before 3/5.

Fair enough. And I tend to agree. But see my reasoning above why I did
it that way.

> But I am fine to live with this temporary ugliness if Tudor agrees.

No need ;) I'll squash it. It might even be better, if the two versions
doesn't diverge that much.

-michael
