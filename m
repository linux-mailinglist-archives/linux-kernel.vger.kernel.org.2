Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813AF414C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhIVPCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:02:25 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43871 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236303AbhIVPCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:02:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 87124580ACF;
        Wed, 22 Sep 2021 11:00:53 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 22 Sep 2021 11:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=hfJGbhpQSJZLILbIIAyLZ6CJq6Tq
        NG5zUILLNAc/iKY=; b=SB501QdNOkqUVa4lGU0E3RCAlGzm2baEyrBGgNR+wUpf
        lX9wJpOjCVfVYb/MYsH2f3SiyB+1hJMTTHpcDuHs5Fw3GOby1lLf/3Hfxi7dyJVq
        3yHfA097XlODrojoaQHT9GHfP3uU4lTONusxyXlwvK+LTl2AhOy35OKRVyh/f7Cq
        a21Pkj9TMMxdojqNPl7RUBF6eTnWSdaRO889YZ1W/s6gNN2me9Ze5PAPy+5xBBNJ
        du0UsAbYK72ZrqJ/khFC/H33WXvhX6d0lProcRLiP/PtKYJglMDaMzRXjYTUx+8D
        IJ+LBTYo89RQfX++JYI03Qrm7CUb2oxh40sRXv7rJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hfJGbh
        pQSJZLILbIIAyLZ6CJq6TqNG5zUILLNAc/iKY=; b=MgXmBN/x0cmOjqA0oeR+zK
        Czm7sCxBo3muXxCDjI0j7Wks3RlUghpPzlQCTUbsvZEnn9dUDgnzYNFTzHEnHnQA
        p1FY6mG4GinWwQmjobxcuejeZqPlNP7foVt7zuXl1r1b4C9RCx9bTe5DGkfX6Nex
        yHomm/E350P3hjgDzn5Qk3Gb1wDDJTvtUGcG08bIP2mBq+6DKBawU49ZqNH8Gblz
        +1cqCc7qyW2wxoJgn749w7xGK19jnG/TxQx46nbETk2e7jJuvlTFhVaoUQelewEl
        zmkaDy6uxmcxU3GWGJJvrbdn0FJbjiy3R9oxV+FNFvexLjHhKKg4Oe/Tk0mE4iXQ
        ==
X-ME-Sender: <xms:I0VLYVRliXKijmALhRWv_ktFhksh1M8KS2wY4mgc8e5VKQWl2oVNvw>
    <xme:I0VLYey4777DO29fNiAZzOTbkI0zEAyytqgOEOz3IwK55AV-GFJA0RdjQwcByA93F
    hzhReWupo_IgotOzQM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeijedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeehjefgtddtfeelfeetjeeifeduueehleektdegtdejheeiteeuleehuefh
    geehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:I0VLYa0cJsU9J0FMSJHKrhwPXd8TUqy0qEweejSjQCY7xf-FX4sseQ>
    <xmx:I0VLYdAPXemT349Yav2fXzmJVO7WJfxdi0kqnhLIN3kHZ2DSJFxFvg>
    <xmx:I0VLYehf2Chz3h_D8JRi7AloNLuhB_Xz0tdNY9LFCBZZ83aMlTnBlA>
    <xmx:JUVLYZPEFUIVgcdYpzYoXrwHmHRqU8pW6ZnZydxf7z_e7yxc5ZgA8A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AE18751C0060; Wed, 22 Sep 2021 11:00:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1302-gc62ab821ef-fm-20210921.001-gc62ab821
Mime-Version: 1.0
Message-Id: <d8024591-0142-442e-98e9-0c92a7679768@www.fastmail.com>
In-Reply-To: <YUniTtc/DwGYPD+c@kuha.fi.intel.com>
References: <20210918120934.28252-1-sven@svenpeter.dev>
 <20210918120934.28252-9-sven@svenpeter.dev>
 <YUniTtc/DwGYPD+c@kuha.fi.intel.com>
Date:   Wed, 22 Sep 2021 17:00:31 +0200
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
Subject: =?UTF-8?Q?Re:_[RFT_PATCH_8/9]_usb:_typec:_tipd:_Switch_power_state_to_S0?=
 =?UTF-8?Q?_for_Apple_variant?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Sep 21, 2021, at 15:46, Heikki Krogerus wrote:
> On Sat, Sep 18, 2021 at 02:09:33PM +0200, Sven Peter wrote:
>> The Apple CD321x comes up in a low-power state after boot. Usually, the
>> bootloader will already power it up to S0 but let's do it here as well
>> in case that didn't happen.
>> 
>> Suggested-by: Stan Skowronek <stan@corellium.com>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  drivers/usb/typec/tipd/core.c     | 44 +++++++++++++++++++++++++++++++
>>  drivers/usb/typec/tipd/tps6598x.h |  6 +++++
>>  2 files changed, 50 insertions(+)
>> 
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index e96b17fe6af6..26807c050662 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -30,6 +30,7 @@
>>  #define TPS_REG_INT_MASK2		0x17
>>  #define TPS_REG_INT_CLEAR1		0x18
>>  #define TPS_REG_INT_CLEAR2		0x19
>> +#define TPS_REG_SYSTEM_POWER_STATE	0x20
>>  #define TPS_REG_STATUS			0x1a
>>  #define TPS_REG_SYSTEM_CONF		0x28
>>  #define TPS_REG_CTRL_CONF		0x29
>> @@ -84,6 +85,8 @@ struct tps6598x_hw {
>>  	unsigned int irq_data_status_update;
>>  	unsigned int irq_plug_event;
>>  	void (*irq_trace)(u64 event1, u64 event2);
>> +
>> +	bool supports_spss;
>>  };
[...]
>>  static int devm_tps6598_psy_register(struct tps6598x *tps)
>>  {
>>  	struct power_supply_config psy_cfg = {};
>> @@ -648,6 +685,11 @@ static int tps6598x_probe(struct i2c_client *client)
>>  	if (ret)
>>  		return ret;
>>  
>> +	/* Switch Apple chips to the correct system power state */
>> +	ret = cd321x_switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
>> +	if (ret)
>> +		return ret;
>
> If you call this from the same quirk where you set the mask for your
> board, you don't need that supports_spss flag at all, right?

Yup, that one will also disappear then.

Thanks,

Sven
