Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF71E414C97
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhIVPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:00:39 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34731 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236358AbhIVPAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:00:30 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 78D27580ACD;
        Wed, 22 Sep 2021 10:59:00 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 22 Sep 2021 10:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=96uf9r25tZ+rFVz9V65UgKSRRvB6
        6XWK+SRSHb8lQSk=; b=dM/eRfLC5EeA1t7ZAsvBwAMXhbNjk+sdAJ44AteH1K/S
        P8QO5pqDsg6APWqtmvPxC4878fS3Mx1WSOcqxWVuzqUm9XMAj9LISH15QXaefT7Z
        LOH1fV4KqVCkMQpWlfHGJp8b+yxjWhJrCjC6/iTNp+Ayv+QBCAxWKOERGW0cbqkl
        Et/8CFIwp2n67TPNR/KiytC0TK1NNELKKh8OTE2nsxyRgDrbSbJusGvCsxwYKg74
        PZuztb2NZc9yc74xl3itjxS2wksqVOgEZs2sGXyOxE25CcJ7x8hhMK+6Z8M8TppV
        2gRuMGR58fp2H5APsmDE7fT7HY39QXgvKB4CkFfI+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=96uf9r
        25tZ+rFVz9V65UgKSRRvB66XWK+SRSHb8lQSk=; b=ue+jY6JHa6mZuqFqj9Ulcw
        YH837GSuvfztVVEpOWYzSNKeCRWUdC8QtACDU97K6kuZDL0n8wdVJKsUpWdRxvEw
        6VOS0LwNbgw3n3p6FlVUj0cGkRrP/1Bu1hc8yYA2FELRWdpXB/ktRRumYhVuwdHI
        PhIc7Z+XEbnPd9TrYoLHY4w2/wQSRIB8hxeV/Z04QTKMWZZccKM+raLEXMOVxif6
        6/uVb5V6Yza+mSLCVsGWbF/wrTl7uA2t+qqA/AO91aQHWlpKv4V+c2B5/06LQGRu
        wqxe2dacvw9+eKdKev1huYPg7x17/0+vmV7w3bDq5oO79wZWUbsU1+yXWXq+UCOQ
        ==
X-ME-Sender: <xms:tERLYcLWa4_z6ugJbh74K8O517615PHB2CNc7L_V8JAnhA9Qs_QjEQ>
    <xme:tERLYcLYqnJ5n_zZCsXnyq1mcNuW9ZuBJ4LC9cl0ZrmlLck9IcgxtWhCyNSdsXdGq
    ZX8T6U47_Y20StB6C4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeijedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:tERLYcvutFd_fCl9I85ItB2vIkDSjJp851c5V3BtPBlT2CStOQwpVw>
    <xmx:tERLYZZ6m1gUrtE2PvEy3-VejkqQYGz0k0QnQSsc5iZGH8--AcAmyQ>
    <xmx:tERLYTa64bzHfkDlJve4qetm87EZtH-841g1NibGOR_6oAjCcoEq7g>
    <xmx:tERLYdlsfJ_ebpUFT-IfX29c1DcD0bW9__qpm5qBnYDUXQjT0YrRBA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4AB2A51C0060; Wed, 22 Sep 2021 10:59:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1302-gc62ab821ef-fm-20210921.001-gc62ab821
Mime-Version: 1.0
Message-Id: <1fac9efc-f24c-4912-8c26-b959574e6b4e@www.fastmail.com>
In-Reply-To: <YUngxBX8CSJK4nw8@kuha.fi.intel.com>
References: <20210918120934.28252-1-sven@svenpeter.dev>
 <20210918120934.28252-7-sven@svenpeter.dev>
 <YUngxBX8CSJK4nw8@kuha.fi.intel.com>
Date:   Wed, 22 Sep 2021 16:58:39 +0200
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
Subject: Re: [RFT PATCH 6/9] usb: typec: tipd: Setup IntMask explicitly
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Sep 21, 2021, at 15:40, Heikki Krogerus wrote:
> On Sat, Sep 18, 2021 at 02:09:31PM +0200, Sven Peter wrote:
>> Right now the code relies on the bootloader to set up the interrupt mask
>> correctly. This usually works but let's make sure to do it explicitly to
>> guarantee it will always work.
>> 
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  drivers/usb/typec/tipd/core.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index d191e7435018..2058e8cca631 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -728,6 +728,24 @@ static int tps6598x_probe(struct i2c_client *client)
>>  			dev_err(&client->dev, "failed to register partner\n");
>>  	}
>>  
>> +	if (tps->hw->use_int1) {
>> +		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
>> +					tps->hw->irq_power_status_update |
>> +					tps->hw->irq_data_status_update |
>> +					tps->hw->irq_plug_event);
>> +		if (ret)
>> +			goto err_role_put;
>> +	}
>> +
>> +	if (tps->hw->use_int2) {
>> +		ret = tps6598x_write64(tps, TPS_REG_INT_MASK2,
>> +					tps->hw->irq_power_status_update |
>> +					tps->hw->irq_data_status_update |
>> +					tps->hw->irq_plug_event);
>> +		if (ret)
>> +			goto err_role_put;
>> +	}
>
> You should first only set the mask on your board. We can then see if
> it's something that should be done on other boards as well later.
>

Make sense, I'll only call this when the cd321x variant is probed then.


Sven
