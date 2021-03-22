Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF7F344DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhCVRyn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Mar 2021 13:54:43 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36074 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhCVRyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:54:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A714E60A357B;
        Mon, 22 Mar 2021 18:54:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z28JrLjOa-cP; Mon, 22 Mar 2021 18:54:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0C2A860A357C;
        Mon, 22 Mar 2021 18:54:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rnKQDEnnD768; Mon, 22 Mar 2021 18:54:12 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D97E360A357B;
        Mon, 22 Mar 2021 18:54:12 +0100 (CET)
Date:   Mon, 22 Mar 2021 18:54:12 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <867376179.104878.1616435652773.JavaMail.zimbra@nod.at>
In-Reply-To: <9fb7a635-75ed-2840-b751-3ab8764f0890@gmail.com>
References: <20210303155735.25887-1-michael@walle.cc> <9fb7a635-75ed-2840-b751-3ab8764f0890@gmail.com>
Subject: Re: [PATCH] mtd: require write permissions for locking and badblock
 ioctls
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: require write permissions for locking and badblock ioctls
Thread-Index: MD3YlBDD0Vk+6pgMtjmJD07E01YdqQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Rafał Miłecki" <zajec5@gmail.com>
> An: "Michael Walle" <michael@walle.cc>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> Gesendet: Montag, 22. März 2021 17:39:41
> Betreff: Re: [PATCH] mtd: require write permissions for locking and badblock ioctls

> On 03.03.2021 16:57, Michael Walle wrote:
>> MEMLOCK, MEMUNLOCK and OTPLOCK modify protection bits. Thus require
>> write permission. Depending on the hardware MEMLOCK might even be
>> write-once, e.g. for SPI-NOR flashes with their WP# tied to GND. OTPLOCK
>> is always write-once.
>> 
>> MEMSETBADBLOCK modifies the bad block table.
>> 
>> Fixes: f7e6b19bc764 ("mtd: properly check all write ioctls for permissions")
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Should be fine for OpenWrt tools to my best knowledge (and quick testing).
> 
> Acked-by: Rafał Miłecki <rafal@milecki.pl>

Nice!

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
