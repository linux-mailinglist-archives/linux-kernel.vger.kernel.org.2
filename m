Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4332BFA5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579167AbhCCSae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346684AbhCCQ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:26:57 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A0AC0613DB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 08:25:51 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 063E32223A;
        Wed,  3 Mar 2021 17:25:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614788749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBW9WYF4VIOc6BFxnRf5anhpRbWsUv3hkVrcjwL2WwU=;
        b=iBEg8N8OMPPPXXyef//mbJLbe7VeToyM8IMbtPns0WKqlh/76bnZI/isUmnLZ+qcbylVY7
        QWC8Ul9OsB8ZHm3tLimQMcQrYGV3KKXz4QlwkptDDF8bsKP7biaxf2dcd1o2DXDE3p4jl0
        oBpN6FaOCSkbtwsWPEplV/AIciVMtoc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 03 Mar 2021 17:25:48 +0100
From:   Michael Walle <michael@walle.cc>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mtd: require write permissions for locking and badblock
 ioctls
In-Reply-To: <689194005.42755.1614788236355.JavaMail.zimbra@nod.at>
References: <20210303155735.25887-1-michael@walle.cc>
 <YD+0mAPTMN8AwNBx@kroah.com>
 <689194005.42755.1614788236355.JavaMail.zimbra@nod.at>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <040cf2058fe4cf5e63dbff534582881a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-03 17:17, schrieb Richard Weinberger:
> Michael,
> 
> ----- Ursprüngliche Mail -----
>> Von: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
>> An: "Michael Walle" <michael@walle.cc>
>> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" 
>> <linux-kernel@vger.kernel.org>, "Miquel Raynal"
>> <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh 
>> Raghavendra" <vigneshr@ti.com>
>> Gesendet: Mittwoch, 3. März 2021 17:08:56
>> Betreff: Re: [PATCH] mtd: require write permissions for locking and 
>> badblock ioctls
> 
>> On Wed, Mar 03, 2021 at 04:57:35PM +0100, Michael Walle wrote:
>>> MEMLOCK, MEMUNLOCK and OTPLOCK modify protection bits. Thus require
>>> write permission. Depending on the hardware MEMLOCK might even be
>>> write-once, e.g. for SPI-NOR flashes with their WP# tied to GND. 
>>> OTPLOCK
>>> is always write-once.
>>> 
>>> MEMSETBADBLOCK modifies the bad block table.
>>> 
>>> Fixes: f7e6b19bc764 ("mtd: properly check all write ioctls for 
>>> permissions")
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> ---
>>>  drivers/mtd/mtdchar.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> Thanks for auditing the rest of these from my original patch.  If this
>> is ok with userspace tools, it's fine with me, but I don't even have
>> this hardware to test with :)
> 
> That's my fear. Michael, did you verify?

I don't know any tools except the mtd-utils. So no.

> In general you need to be root to open these device files.
> So, I don't see a security problem here.

Then this begs the question, why is this check there in
the first place?

This come up because I was adding a OTPERASE which
was suggested that is was a "dangerous" command. So I
was puzzled why the ones above are considered "safe" ;)

-michael
