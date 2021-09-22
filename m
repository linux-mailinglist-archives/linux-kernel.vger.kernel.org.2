Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A07414C91
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhIVPAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:00:11 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50711 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236157AbhIVPAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:00:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id E2761580A8A;
        Wed, 22 Sep 2021 10:58:39 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 22 Sep 2021 10:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=OPzCsgbYp19VSjY7zgSnAkS2Kxq+
        sjQaWrNwDj2lBLg=; b=IwzCQV0Gtmp1OvpOfhO1LPZWmYvevtnmk8ZFXap5VoP/
        OPGygl9gmwmjSTMmTV+hA+hCFnj8dqRgHdQDz+UVbINc45ptbjbLBQBKJHC6veMZ
        flsV85mtIArhhL4XEbYG+n8XADIjaZVrHEAshGIa2lY3ePVuag/IVrWHLeWMtK7E
        F6nRxqQaAIIkq5gXc/0Kk+DM1U9uYf4Vs7QIeQh10Sg+b3tjmOlcNFdENT6YFvBB
        DR1WDB/EMaaTp0PT+OjCJ5IvvVBZyfnMMPTSKtOzLAfKU5j97eWX+3vJZ82e+NCh
        +yZEjkd/ONrs8jHHgs7iJuvWQKYRwFZpKtR+BvQpDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OPzCsg
        bYp19VSjY7zgSnAkS2Kxq+sjQaWrNwDj2lBLg=; b=hLqlZK9WknnmNRWBaNBwUL
        jyTkcpCxfPgwt4rlrATLbVQCXgOjGXljqU1yfHp+HmNqMfmf1elcamc35+KDUclQ
        FErWMcxbFL/Ff0FwjxCHIs1XLZ4X1GoeqFBhuZ9Ays75uKzq0fdAvwFTC1FEP97O
        CsZMSNYDylP616zm1M2n0p98H6y/HGDAut+4seh/qsQhh6hGaIS2fpmLdasdOKx4
        gVsAwrv3a/Vj2+SwcM0STxtLHUeXJVyVwi8whVINe6QpVgoRPRTEa1lQ1LWgGKZ2
        kLQfpXzMUqikLE8Ws3pJ0eW3XDSSDtJ+q1qRhiMzuxL6LGxkZEYEzka1Puqs47NQ
        ==
X-ME-Sender: <xms:nURLYSGNSBFuW1QHcWOOG2P02wicSZ_By0M1OciB2tsrvbAMcCndqg>
    <xme:nURLYTXZEYsd3jgU7RZxYuXF6tHZijfoI3T7tt4_QKhuxKOxtN1Wo7V1It3k74VsF
    rKx5w6aMFBeXG8k6dM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeijedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:nURLYcJx-2n7ZToISM0kz-RseWg7SO-EpZGBmR5dtPF8qhP1N8Ys6g>
    <xmx:nURLYcEn_2dOu08KO-HGN85D2TPZKd_WvXpnlQwRldL9OYCSpidHFQ>
    <xmx:nURLYYUXi8UI3nG6ncSmQpIVbbJcJGr-iXIDcuT6AMLLmAldq9dUVg>
    <xmx:n0RLYcS6oeYGsZ72Ea7GO7aPOV5PsMd88V87jIvifu60wuaEUpnxzQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 985DB51C0060; Wed, 22 Sep 2021 10:58:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1302-gc62ab821ef-fm-20210921.001-gc62ab821
Mime-Version: 1.0
Message-Id: <8d5937fc-49a5-4556-a3bf-f6c37eaa6942@www.fastmail.com>
In-Reply-To: <YUnfXkVHbgeqV9V2@kuha.fi.intel.com>
References: <20210918120934.28252-1-sven@svenpeter.dev>
 <20210918120934.28252-6-sven@svenpeter.dev>
 <YUnfXkVHbgeqV9V2@kuha.fi.intel.com>
Date:   Wed, 22 Sep 2021 16:58:15 +0200
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
Subject: Re: [RFT PATCH 5/9] usb: typec: tipd: Allow to configure irq bits
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tue, Sep 21, 2021, at 15:34, Heikki Krogerus wrote:
> On Sat, Sep 18, 2021 at 02:09:30PM +0200, Sven Peter wrote:
>> The Apple variant of the TI TPS6598x chip uses different interrupt
>> numbers. Prepare for that by allowing those to be configured depending
>> on the compatible.
>
> OK, so I think this justifies having a completely separate irq
> handler for your board.

OK, If you're fine with a bit of code duplication for the irq handler this will
all be quite a bit simpler then.

>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  drivers/usb/typec/tipd/core.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index 4a6d66250fef..d191e7435018 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -80,6 +80,10 @@ static const char *const modes[] = {
>>  struct tps6598x_hw {
>>  	bool use_int1;
>>  	bool use_int2;
>> +	unsigned int irq_power_status_update;
>> +	unsigned int irq_data_status_update;
>> +	unsigned int irq_plug_event;
>> +	void (*irq_trace)(u64 event1, u64 event2);
>>  };
>
> Then I believe you don't need any of that.

Yup, I think I'll really only need something like

struct tps6598x_hw {
	int type;
	irq_handler_t irq_handler;
};

in that case!


Thanks,


Sven
