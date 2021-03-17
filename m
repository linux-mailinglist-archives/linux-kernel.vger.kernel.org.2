Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5D33EB55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhCQIWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:22:10 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:35509 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhCQIVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:21:36 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1AB3B22255;
        Wed, 17 Mar 2021 09:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615969294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UyKNx2MYFWz0kJgEDgATo7j4IS8GZ7xQ4SVeMgtlp9g=;
        b=i/BRY4sfOhudWHjLImUF7RlfJgcXFgdevwEJqw90SPJdhdqlqhnKQg1TrWBCZQuvOuc/gp
        5wR3hmbQIksa6xPL6XCGfTqlBZJO50H6wZLHokpTR/lQzMUxhUTjwSVV7WFnwMcTxyh8df
        wxecIH4nU4JXztn8qPHrz9YQjUMlQkU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Mar 2021 09:21:31 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     vigneshr@ti.com, p.yadav@ti.com, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection logic
 out of the core
In-Reply-To: <45d00a12-cb79-774e-f8e8-d65602629a90@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
 <963232a4-9100-ebca-927c-7f5a1e947fbe@ti.com>
 <9889bae0-8eba-7cbc-d9bb-04e038bd28c8@microchip.com>
 <6016b725-a779-1d2c-9884-099c58f53557@ti.com>
 <45d00a12-cb79-774e-f8e8-d65602629a90@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <a9e1e18c034dfa185eeb5492acf2dff7@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-17 07:09, schrieb Tudor.Ambarus@microchip.com:
> On 3/15/21 8:23 AM, Vignesh Raghavendra wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> On 3/9/21 12:58 PM, Tudor.Ambarus@microchip.com wrote:
>>> On 3/8/21 7:28 PM, Vignesh Raghavendra wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know the content is safe
>>>> 
>>>> On 3/6/21 3:20 PM, Tudor Ambarus wrote:
>>>>> It makes the core file a bit smaller and provides better separation
>>>>> between the Software Write Protection features and the core logic.
>>>>> All the next generic software write protection features (e.g. 
>>>>> Individual
>>>>> Block Protection) will reside in swp.c.
>>>>> 
>>>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>>>> ---
>>>>>  drivers/mtd/spi-nor/Makefile |   2 +-
>>>>>  drivers/mtd/spi-nor/core.c   | 407 
>>>>> +---------------------------------
>>>>>  drivers/mtd/spi-nor/core.h   |   4 +
>>>>>  drivers/mtd/spi-nor/swp.c    | 419 
>>>>> +++++++++++++++++++++++++++++++++++
>>>> 
>>>> Hmmm, name swp.c does not seem intuitive to me. How about expanding 
>>>> it a
>>>> bit:
>>>> 
>>>> soft-wr-protect.c or software-write-protect.c ?
> 
> Having in mind that we have the SWP configs, I think I prefer swp.c.
> But let's see what majority thinks, we'll do as majority prefers.
> Michael, Pratyush?

It's just an internal name, thus as long as it remotely makes sense,
I'm fine. It's just a matter of taste, isn't it?

But here's one technical reason that would bother me more: name
clashes between the core modules: core, sfdp, otp, swp and the
vendor names. It is very unlikely, but there is a non-zero chance ;)

-michael
