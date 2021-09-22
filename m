Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B28414C84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhIVO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:58:10 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50989 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235014AbhIVO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:58:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 46057580257;
        Wed, 22 Sep 2021 10:56:38 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 22 Sep 2021 10:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=EgaJqj9gQEp6Qedx8pjCqByv5R/d
        MmsQ6pf4CG2eXMU=; b=Pl26iUEr0jctVpANcAQ+yg1NCy/C+4vbPUO8n6nwzX6L
        xUu+V4pLB5hEiKADHwoRrFDAinKNX2Z9ZVCCgBmYaCI+N3eEbnBtLWnsJaHiiFQL
        gWwNGyPyEnxKypENtG8VrRnbZMrVH5yT8H7vehNlTTAUHFgwMN47R6tcid9WtggW
        d1n7m9JwchzV4FDzO3sLKUybvM0j9XJYvRr8v8PxXKiJ0CEMm1Wz6bh7avS+E6tH
        gYWXfMAk+OOBN7//M07xsSDDGRHYqPmZ3IIARpdJbh+1yPvFPi6w6q0FUUxZfjf8
        CBM/md7UKXpgf4rdcySJTUjKiz0r/B5RekNEsLqqkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=EgaJqj
        9gQEp6Qedx8pjCqByv5R/dMmsQ6pf4CG2eXMU=; b=JPPfSImMwu8xhVT8lzqvJW
        eOoaxxP80FHbk/F5iavKKi1dopUUp2aSICl0dd4eu+qYPSG0oOH69OOCjMWU3you
        3ztZ0Cp8sxZQw/yZ2JDDcSPUktaIpF94hL8mr2JjxN1TYlzw0CAV8eENxBF+hR4t
        46NTSLYo4xUp8oMXiWE3UaDJf5BA7qcZRVt+LtTT2Y6snAyghJFxMRnkylAt6AOW
        P042ZBCAfHtqslsa4ZtuZ2YOE6QQJ7lDYKt1g2isr90j6peQgDy/Ed/90dGod0KZ
        EFUnyfLD1FPvyIV+WS07Ye7ib9HA2kPT01pFhtl7IsxqH4l2WF5CbHLq+8fMLLGA
        ==
X-ME-Sender: <xms:JERLYaC4BUy3lkjAEuoUhC99-3toZ-82858jw47PtT3jZnmd6op8xw>
    <xme:JERLYUh4xb0RPdZo9Kd3jrIsVcgAQMkTQ4Y88QS1PscAN1m1g8MY8o3ZlFGnxvkq6
    9aICRXx9pBvoot2wbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeijedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:JERLYdk-5YCkrKjZHbal5OgpTHCN359h5YpbyEsnpRjdQZQ-igMPiw>
    <xmx:JERLYYwkAjsZQg9U9yfl_lm9cqqWsYzvzu8yynqrbJk1ifAXCHiEzw>
    <xmx:JERLYfQbE2LxzINAda64cwM4xVYH3EPsnqv2fgBX0Zw3S5ogF4WNrw>
    <xmx:JkRLYU-AWSykM7C2OyXhQIj0DezCZxVQr7kYCJK1SuDSJQL06rxu7Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B675D51C0060; Wed, 22 Sep 2021 10:56:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1302-gc62ab821ef-fm-20210921.001-gc62ab821
Mime-Version: 1.0
Message-Id: <7d96308a-e8c4-4193-b0c3-50b3918c7deb@www.fastmail.com>
In-Reply-To: <YUncRyVlyZ7ejN++@kuha.fi.intel.com>
References: <20210918120934.28252-1-sven@svenpeter.dev>
 <20210918120934.28252-4-sven@svenpeter.dev>
 <YUncRyVlyZ7ejN++@kuha.fi.intel.com>
Date:   Wed, 22 Sep 2021 16:56:16 +0200
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
Subject: Re: [RFT PATCH 3/9] usb: typec: tipd: Allow irq controller selection
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Sep 21, 2021, at 15:21, Heikki Krogerus wrote:
> On Sat, Sep 18, 2021 at 02:09:28PM +0200, Sven Peter wrote:
>> TI TPS6598x chips come with two separate i2c buses which each have an
>> independent interrupt controller. When only a single controller is
>> connected both can just be used.
>> On Apple M1 machines the secondary bus is however connected to the system
>> management controller and we must not modify its configuration. Prepare
>> for that by allowing to chose which interrupt controller(s) are used.
>
> This is good, but...
>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  drivers/usb/typec/tipd/core.c | 30 +++++++++++++++++++++---------
>>  1 file changed, 21 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index 656020e7f533..c2c399722c37 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -78,6 +78,8 @@ static const char *const modes[] = {
>>  #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
>>  
>>  struct tps6598x_hw {
>> +	bool use_int1;
>> +	bool use_int2;
>>  };
>
> Wouldn't it be better to read that information from a device
> property/properties?
>
> Driver data is OK, but device property would be better. We don't have
> separate compatible for this on every board that uses it and we have
> also ACPI platforms.

Good point. Taking into account your review for the later patches I
think I can drop this completely though: On the Apple hardware the
second controller is always connected to the SMC so far. If it's
required later on we can always add the additional property with
a default value then.


Best,


Sven
