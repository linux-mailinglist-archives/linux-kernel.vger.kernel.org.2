Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A5B41772F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346946AbhIXPAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 11:00:49 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:51321 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346908AbhIXPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 11:00:48 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id E5DE9580C68;
        Fri, 24 Sep 2021 10:59:14 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Fri, 24 Sep 2021 10:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=c1bp1vZKmpUpTWZmDMjCv933PKun
        Qkv3Vp6Hm48cSZo=; b=DBlss/Z6+yzWbFkJRny83cw8rFvGwgWB+ZhbGPNDsrWY
        iBeMtKI6XDQYDIhx0Fi+BJ5c8qLKtmjvmQcwSWCWWjrZ5LF0JsJk+I+VVrBCJkvR
        3jK7VxdJ4ptmEu4bVyJcej1F4KkyCJUZLZ/i3IQx+peOgczhq2jTHPXIthiL2Yop
        vJLLdPKum0STrD8v06TEcXmNErYEaCkCg+/HZGrq3eamebKCzVXQg5UqmCNtAkWY
        kPSGTErjKuNcd25Dril898WkQEOamWY2HqXaCLi7v89VlBtezmimZPYjj8Y45ahe
        bD8seFQxHCOYC/7Cixmy67vTlBEOr+kku+1Aq0pZLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=c1bp1v
        ZKmpUpTWZmDMjCv933PKunQkv3Vp6Hm48cSZo=; b=Ls2yjZ4whsnrpAx7Vop7hu
        xVA418tjpjhQ0uac6kkvFT1lQaGBsNihbzbJEZdX5xxwuNfGUt/8nmxXNi1jfQBR
        0F4o9NwAQAdj/CkhyojDZIyikJyHpkD4tKOwRanOhEuCbA8k8QOrFXjhWufw1nIy
        43P5knR0sqF+z1NA6NVtG25HXu/YveJXXDcqUVRn3HR/UnRkFbWzEboHqMgNFuWq
        ctv+/Fje8muJAoFoLDpo1wq47G/eOpfOHQrmqwnxQtvJDz8J2nqmcJjwlwVKXkX5
        jkmcIJH6oMicWzbo84Ue84+T0a9ojKz1iJWizendrrBOEwAPoQFsXMZO2ace+t8w
        ==
X-ME-Sender: <xms:wedNYdCU1O9EOyyuWuPGokzTzaYnOe6MzLdnxz8z0-3Tp97RLwOy7A>
    <xme:wedNYbhY7PIqlF1gJJoZsqDMnIV-xJ9ZLGO0RWkpaEcGFQ8ANLMWdl6-Ul8Q1Fc-M
    PO1EhmgyDAyZvVtGzE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejuddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:wedNYYluVxe0j_ZYvi46bQrEHgm65T1WQO3yaN2zDFrLiw-5h42r4A>
    <xmx:wedNYXySuHZky1Ew_EqS5BeeRqA17NNoShDdSEwPLNp2eLpXWd8bdw>
    <xmx:wedNYSSLxS5RgUEwY20LR0jFROV7eRzczVRZ4Q4vG3duYWtdhdF_Fg>
    <xmx:wudNYT9KR5MtRJPotDs5sp8o2L-jr5rf2t1EHmBYhj6JO7p7Fuwa9A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B2E8851C0060; Fri, 24 Sep 2021 10:59:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <41c29255-ba7b-4385-9637-0cef8ecb4be1@www.fastmail.com>
In-Reply-To: <YU3jtIvYOk/IHUWn@kuha.fi.intel.com>
References: <20210923181321.3044-1-sven@svenpeter.dev>
 <20210923181321.3044-5-sven@svenpeter.dev>
 <YU3jtIvYOk/IHUWn@kuha.fi.intel.com>
Date:   Fri, 24 Sep 2021 16:58:52 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Heikki Krogerus" <heikki.krogerus@linux.intel.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Alexander Graf" <graf@amazon.com>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Subject: Re: [PATCH v2 4/6] usb: typec: tipd: Add support for Apple CD321X
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Fri, Sep 24, 2021, at 16:41, Heikki Krogerus wrote:
> Hi,
>
> One more question below.
>
> On Thu, Sep 23, 2021 at 08:13:19PM +0200, Sven Peter wrote:
>> Apple CD321x chips are a variant of the TI TPS 6598x chips.
>> The major differences are the changed interrupt numbers and
>> the concurrent connection to the SMC which we must not disturb.
>> 
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>> changes since v1:
>>   - new commit since Heikki suggested to just add a separate irq handler
>> 
>>  drivers/usb/typec/tipd/core.c     | 86 ++++++++++++++++++++++++++++++-
>>  drivers/usb/typec/tipd/tps6598x.h |  6 +++
>>  drivers/usb/typec/tipd/trace.h    | 23 +++++++++
>>  3 files changed, 113 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index cd1e37eb8a0c..6c9c8f19a1cf 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/i2c.h>
>>  #include <linux/acpi.h>
>>  #include <linux/module.h>
>> +#include <linux/of_device.h>
>>  #include <linux/power_supply.h>
>>  #include <linux/regmap.h>
>>  #include <linux/interrupt.h>
>> @@ -76,6 +77,16 @@ static const char *const modes[] = {
>>  /* Unrecognized commands will be replaced with "!CMD" */
>>  #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
>>  
>> +enum tipd_hw_type {
>> +	HW_TPS6598X,
>> +	HW_CD321X
>> +};
>> +
>> +struct tipd_hw {
>> +	enum tipd_hw_type type;
>> +	irq_handler_t irq_handler;
>> +};
>> +
>>  struct tps6598x {
>>  	struct device *dev;
>>  	struct regmap *regmap;
>> @@ -458,6 +469,51 @@ static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
>>  	}
>>  }
>>  
>> +static irqreturn_t cd321x_interrupt(int irq, void *data)
>> +{
>> +	struct tps6598x *tps = data;
>> +	u64 event = 0;
>> +	u32 status;
>> +	int ret;
>> +
>> +	mutex_lock(&tps->lock);
>> +
>> +	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event);
>> +	if (ret) {
>> +		dev_err(tps->dev, "%s: failed to read events\n", __func__);
>> +		goto err_unlock;
>> +	}
>> +	trace_cd321x_irq(event);
>> +
>> +	if (!event)
>> +		goto err_unlock;
>> +
>> +	if (!tps6598x_read_status(tps, &status))
>> +		goto err_clear_ints;
>> +
>> +	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE)
>> +		if (!tps6598x_read_power_status(tps))
>> +			goto err_clear_ints;
>> +
>> +	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
>> +		if (!tps6598x_read_data_status(tps))
>> +			goto err_clear_ints;
>> +
>> +	/* Handle plug insert or removal */
>> +	if (event & APPLE_CD_REG_INT_PLUG_EVENT)
>> +		tps6598x_handle_plug_event(tps, status);
>> +
>> +err_clear_ints:
>> +	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event);
>> +
>> +err_unlock:
>> +	mutex_unlock(&tps->lock);
>> +
>> +	if (event)
>> +		return IRQ_HANDLED;
>> +	return IRQ_NONE;
>> +}
>> +
>>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
>>  {
>>  	struct tps6598x *tps = data;
>> @@ -615,8 +671,19 @@ static int devm_tps6598_psy_register(struct tps6598x *tps)
>>  	return PTR_ERR_OR_ZERO(tps->psy);
>>  }
>>  
>> +static const struct tipd_hw ti_tps6598x_data = {
>> +	.type = HW_TPS6598X,
>> +	.irq_handler = tps6598x_interrupt,
>> +};
>> +
>> +static const struct tipd_hw apple_cd321x_data = {
>> +	.type = HW_CD321X,
>> +	.irq_handler = cd321x_interrupt,
>> +};
>> +
>>  static int tps6598x_probe(struct i2c_client *client)
>>  {
>> +	const struct tipd_hw *hw;
>>  	struct typec_capability typec_cap = { };
>>  	struct tps6598x *tps;
>>  	struct fwnode_handle *fwnode;
>> @@ -629,6 +696,10 @@ static int tps6598x_probe(struct i2c_client *client)
>>  	if (!tps)
>>  		return -ENOMEM;
>>  
>> +	hw = of_device_get_match_data(&client->dev);
>> +	if (!hw)
>> +		hw = &ti_tps6598x_data;
>> +
>>  	mutex_init(&tps->lock);
>>  	tps->dev = &client->dev;
>>  
>> @@ -655,6 +726,16 @@ static int tps6598x_probe(struct i2c_client *client)
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (hw->type == HW_CD321X) {
>> +		/* CD321X chips have all interrupts masked initially */
>> +		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
>> +					APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
>> +					APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
>> +					APPLE_CD_REG_INT_PLUG_EVENT);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>  	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
>>  	if (ret < 0)
>>  		return ret;
>> @@ -736,7 +817,7 @@ static int tps6598x_probe(struct i2c_client *client)
>>  	}
>>  
>>  	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>> -					tps6598x_interrupt,
>> +					hw->irq_handler,
>>  					IRQF_SHARED | IRQF_ONESHOT,
>>  					dev_name(&client->dev), tps);
>
> Couldn't you just use the compatible property and local variable here?
>
>         irq_handler_t irq_handler = tps6598x_interrupt;
>         struct device_node *np = client->dev.of_node;
>
>         if (np && of_device_is_compatible(np, "apple,cd321x")) {
>                 /* CD321X chips have all interrupts masked initially */
>                 ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
>                                         APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
>                                         APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
>                                         APPLE_CD_REG_INT_PLUG_EVENT);
>                 if (ret)
>                         return ret;
>
>                 irq_handler = cd321x_interrupt;
>         }
>
> 	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> 					irq_handler,
> 					IRQF_SHARED | IRQF_ONESHOT,
> 					dev_name(&client->dev), tps);
>
> I did not go over the whole series yet, so I may have missed
> something.

Sure, that will work and get rid of the slightly awkward and redundant interrupt/enum
combination. I'll wait for your comments for the rest of the series and do that for v3 then :)


Thanks,


Sven
