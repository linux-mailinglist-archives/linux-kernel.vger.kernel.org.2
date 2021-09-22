Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB69414C80
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhIVO5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:57:34 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46139 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235014AbhIVO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:57:32 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 750C6580257;
        Wed, 22 Sep 2021 10:56:01 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 22 Sep 2021 10:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=iyMn8FsRWY81AP9G2OEBtipr4SGG
        gm9Fi/gi8VaeYJ0=; b=OQpZxwMLDcV5HHoEPlt1vkezPpLQ/D5GfUZR1PwuHvJG
        gBp4sWZOkGCgNtRawG8hNOv1Pzz2HXeyqNNmnt6aXSZXTn0MDfNDZ+M9xrEoKDVP
        ZPqQq/wzRL7hDR5U1QoTd4L2CqfnmNFpDBk5LOxjjUh67wIlgNkReYOJb2kaKmmW
        w8mYyN6ZsBhJtyO08Gy0dm4z9V0qnjCIdZ+vDQmbhNPom2cYh3P94HEb/fb6pcUR
        9EcMSrXd1CiOA4QxrMLFMeynoplf5gCqP9UixXaYP3Q5aB+ZYPQcX2nZn+HXJVLt
        jevypF6OJulLVzqFpBzRf9ypGAzAaSsypyVc0y5TGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=iyMn8F
        sRWY81AP9G2OEBtipr4SGGgm9Fi/gi8VaeYJ0=; b=UcCZmXVM8kvlhyvCF/C8K6
        zozmkLh2dZwGUdmw/1Ossf6sHgnREfOI/cL3ZJTwQGNP2jAGmYUMXILTWjWndXeN
        7KoIYIdFyxSJFl9eQfZ+/ickP6HqKno+BOjs6uu51M8xrPuxXYxLCJLVf78KysAv
        HOSqoAASpmljeB/kiVawkujD0St9ri5RZGv3c0AWZ+i1xVB1exej81/wPkXZ6Keu
        ls0r7f5z9Q8K6BA9G7+zeWS24wVIlrNT+qgfRRUpi9C7Bgc/T+/EZSiZhEni+lMN
        49/yzxweNSffwajajt/kc9xLnNH3JaVdTq0NxCs5PLrC2y+T2exDDJ+0SIFfx7CQ
        ==
X-ME-Sender: <xms:_0NLYbhWh3gaoIWdXPcckvneXnezrGdqHSun3iMubbIkYhOypB1izA>
    <xme:_0NLYYBYH7PP4QH8TAnpbLk2KnspvOtzkgiSXoXHwUZvjqcCWDeuvmPiBgsTp1xni
    lACKveEVaj8P4xk-oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeijedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeehjefgtddtfeelfeetjeeifeduueehleektdegtdejheeiteeuleehuefh
    geehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:_0NLYbEGPPs6BwygClZA81cvxsyxC4OboNs5wYsW71O8bmO39o2xbQ>
    <xmx:_0NLYYRLodT7kVKyhtlOnXmNCU5wNpu8fVXXJyXNXH0GAuDBwPfLuw>
    <xmx:_0NLYYyDecREj4S_UZS6ldsxWWDOB3NOsdw5jcnxLwlrgcJ26h9Sog>
    <xmx:AURLYUdVcBSfRVSsnSyavArJLtGpYRaURO03Y1V4_5kGHB5W7x_vAQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 67FE551C0060; Wed, 22 Sep 2021 10:55:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1302-gc62ab821ef-fm-20210921.001-gc62ab821
Mime-Version: 1.0
Message-Id: <2de8da5a-eefb-487f-aaae-93bbc08ca7ef@www.fastmail.com>
In-Reply-To: <YUnZuOnyvoqsiRQj@kuha.fi.intel.com>
References: <20210918120934.28252-1-sven@svenpeter.dev>
 <20210918120934.28252-3-sven@svenpeter.dev>
 <YUnZuOnyvoqsiRQj@kuha.fi.intel.com>
Date:   Wed, 22 Sep 2021 16:55:39 +0200
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
Subject: =?UTF-8?Q?Re:_[RFT_PATCH_2/9]_usb:_typec:_tipd:_Prepare_supporting_diffe?=
 =?UTF-8?Q?rent_variants?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks a lot for quick review!

On Tue, Sep 21, 2021, at 15:10, Heikki Krogerus wrote:
> Hi,
>
> On Sat, Sep 18, 2021 at 02:09:27PM +0200, Sven Peter wrote:
>> Apple M1 machines come with a variant of the TI TPS6598x and will need
>> some changes to the current logic. Let's prepare for that by setting up
>> the infrastructure required to support different variants of this chip
>> identified by the DT compatible.
>
> I think in this case it would make sense to just squash this into the
> next patch.

Sure, and taking into account your review for the later patches I will
probably squash most of them into a single commit now.

>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  drivers/usb/typec/tipd/core.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index 21b3ae25c76d..656020e7f533 100644
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
>> @@ -76,6 +77,10 @@ static const char *const modes[] = {
>>  /* Unrecognized commands will be replaced with "!CMD" */
>>  #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
>>  
>> +struct tps6598x_hw {
>> +};
>
> Black line here.
>
>> +static const struct tps6598x_hw ti_tps6598x_data;
>> +
>>  struct tps6598x {
>>  	struct device *dev;
>>  	struct regmap *regmap;
>> @@ -91,6 +96,8 @@ struct tps6598x {
>>  	struct power_supply *psy;
>>  	struct power_supply_desc psy_desc;
>>  	enum power_supply_usb_type usb_type;
>> +
>> +	const struct tps6598x_hw *hw;
>>  };
>>  
>>  static enum power_supply_property tps6598x_psy_props[] = {
>> @@ -590,6 +597,13 @@ static int tps6598x_probe(struct i2c_client *client)
>>  	if (!tps)
>>  		return -ENOMEM;
>>  
>> +	if (client->dev.of_node)
>> +		tps->hw = of_device_get_match_data(&client->dev);
>> +	else
>> +		tps->hw = &ti_tps6598x_data;
>> +	if (!tps->hw)
>> +		return -EINVAL;
>
> 	tps->hw = of_device_get_match_data(&client->dev);
>         if (!tps->hw)
> 		tps->hw = &ti_tps6598x_data;
>

Ah yes, that's indeed much nicer!

>>  	mutex_init(&tps->lock);
>>  	tps->dev = &client->dev;
>>  
>> @@ -729,8 +743,11 @@ static int tps6598x_remove(struct i2c_client *client)
>>  	return 0;
>>  }
>>  
>> +static const struct tps6598x_hw ti_tps6598x_data = {
>> +};
>
> You could also move that above tps6598x_probe() and get rid of the
> forward declaration.

Ack.



Best,

Sven
