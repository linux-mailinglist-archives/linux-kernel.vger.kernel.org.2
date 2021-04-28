Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3436DC72
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhD1Pvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:51:55 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:52147 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbhD1Pvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:51:49 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4E49D22264;
        Wed, 28 Apr 2021 17:51:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619625061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFht+zx1PoLsNlmKgN724WfPJPYd2yT3Zx3URd+ONYM=;
        b=SeUi5wsG92TXP2NouVl0Atl7uAMfUU+gj2VUnkxbF/WQcSHJQBZ228wjWK6NZtZA7BY18h
        jRmv6NE3buEKWBUfp4Sm288Vy4EPWvUMz1dTR604TkUzj/uIincAggnbiwSsPrydwNY76B
        gMA+3+4snX2+jHMIqv2GyDVIfAyoErA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Apr 2021 17:51:01 +0200
From:   Michael Walle <michael@walle.cc>
To:     Alexander Williams <awill@google.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: spi-nor: Export SFDP access to sysfs
In-Reply-To: <CACqsJN-Vernbp5kJc+qZ6nUW50xPWz_9DznLDjtTu=btSra09Q@mail.gmail.com>
References: <20210428052725.530939-1-awill@google.com>
 <dd33cf8d3a78d60eebbb6f1be90cb7d3@walle.cc>
 <CACqsJN-Vernbp5kJc+qZ6nUW50xPWz_9DznLDjtTu=btSra09Q@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <5e23722b1c7d6716c404667a3c5bfbff@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-04-28 17:37, schrieb Alexander Williams:
> On Wed, Apr 28, 2021 at 12:58 AM Michael Walle <michael@walle.cc> 
> wrote:
>> 
>> Hi Alexander,
>> 
>> Am 2021-04-28 07:27, schrieb Alexander Williams:
>> > Add the ability to specify a technology-specific attribute_group, and
>> > expose the SFDP through spi-nor's private group. This enables user
>> > space
>> > to have full access to the contents of the SFDP, so all information is
>> > available without regard for whether the kernel supports parsing it.
>> 
>> Please see:
>> https://lore.kernel.org/linux-mtd/20210318092406.5340-1-michael@walle.cc/
> 
> Thanks for the pointer! Sorry I didn't see that patch series already: 
> My search
> skills need some work... In any case, there's no good reason for me to 
> duplicate
> work.
> 
> I should probably comment on that series directly, but I'll note that 
> one thing
> I tried to do with the sysfs attributes here was avoid racing with user 
> space.
> The uevent is suppressed until all the related files are created in 
> sysfs. See
> http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/ 
> for
> Greg's explanation of a scenario.

Sure, reviews and remarks are always welcome. Btw. what is patch 2/3 and 
3/3?
I couldn't find it on the LKML.

-michael
