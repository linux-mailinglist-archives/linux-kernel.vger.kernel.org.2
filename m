Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACF932C07F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578760AbhCCSRy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Mar 2021 13:17:54 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49602 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346523AbhCCQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:18:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C0AEF6083244;
        Wed,  3 Mar 2021 17:17:18 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 47tz6j-1yi-U; Wed,  3 Mar 2021 17:17:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A02CD6083275;
        Wed,  3 Mar 2021 17:17:16 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S4uJLM3KDg-S; Wed,  3 Mar 2021 17:17:16 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7E9876083244;
        Wed,  3 Mar 2021 17:17:16 +0100 (CET)
Date:   Wed, 3 Mar 2021 17:17:16 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <689194005.42755.1614788236355.JavaMail.zimbra@nod.at>
In-Reply-To: <YD+0mAPTMN8AwNBx@kroah.com>
References: <20210303155735.25887-1-michael@walle.cc> <YD+0mAPTMN8AwNBx@kroah.com>
Subject: Re: [PATCH] mtd: require write permissions for locking and badblock
 ioctls
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: require write permissions for locking and badblock ioctls
Thread-Index: KRfYtqpl1pr2bZDMHpym/f0qKEWheA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

----- Ursprüngliche Mail -----
> Von: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> An: "Michael Walle" <michael@walle.cc>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Miquel Raynal"
> <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>
> Gesendet: Mittwoch, 3. März 2021 17:08:56
> Betreff: Re: [PATCH] mtd: require write permissions for locking and badblock ioctls

> On Wed, Mar 03, 2021 at 04:57:35PM +0100, Michael Walle wrote:
>> MEMLOCK, MEMUNLOCK and OTPLOCK modify protection bits. Thus require
>> write permission. Depending on the hardware MEMLOCK might even be
>> write-once, e.g. for SPI-NOR flashes with their WP# tied to GND. OTPLOCK
>> is always write-once.
>> 
>> MEMSETBADBLOCK modifies the bad block table.
>> 
>> Fixes: f7e6b19bc764 ("mtd: properly check all write ioctls for permissions")
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/mtdchar.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Thanks for auditing the rest of these from my original patch.  If this
> is ok with userspace tools, it's fine with me, but I don't even have
> this hardware to test with :)

That's my fear. Michael, did you verify?
In general you need to be root to open these device files.
So, I don't see a security problem here.

Thanks,
//richard
