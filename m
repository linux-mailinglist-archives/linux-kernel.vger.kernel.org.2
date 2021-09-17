Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236DF40FE51
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244703AbhIQRDW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Sep 2021 13:03:22 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:62383 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhIQRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:03:21 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B0AE740006;
        Fri, 17 Sep 2021 17:01:55 +0000 (UTC)
Date:   Fri, 17 Sep 2021 19:01:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jan Hoffmann <jan@3e8.eu>
Cc:     Daniel Kestrel <kestrelseventyfour@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Message-ID: <20210917190154.76203a9a@xps13>
In-Reply-To: <51f2ebf4-6df1-eba5-99f1-1ec88e475d20@3e8.eu>
References: <20210808072643.GA5084@ubuntu>
        <51f2ebf4-6df1-eba5-99f1-1ec88e475d20@3e8.eu>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

jan@3e8.eu wrote on Thu, 16 Sep 2021 21:38:26 +0200:

> Hello,
> 
> Configuration of the ECC engine type using device tree has actually
> worked before. I am using OpenWrt on a Fritzbox 7362 SL, which has a
> Micron 29F1G08ABADA flash chip. The bootloader of the device uses on-die
> ECC, so that has to be used for Linux as well. It is configured in DTS
> using "nand-ecc-mode = "on-die";". This worked fine with kernel 5.4.
> However, after switching to kernel 5.10 it is ignored and software ECC
> is used instead.
> 
> If I understand this correctly, the situation is as follows:
> 
> Originally, xway-nand did set defaults for ECC mode and algorithm, but
> different values could be configured using device tree.
> 
> Commit d7157ff49a5b ("mtd: rawnand: Use the ECC framework user input
> parsing bits") broke these default values, as the ECC algorithm is now
> unconditionally set from the user configuration in rawnand_dt_init.
> Previously, the default value was only overwritten if the device tree
> actually contained a value.
> 
> This is fixed in d525914b5bd8 ("mtd: rawnand: xway: Move the ECC
> initialization to ->attach_chip()"). However, this makes it impossible
> to configure the ECC engine type in the device tree, as it is now
> overwritten by the default value in xway_attach_chip.
> 
> I am not sure if this patch is the best approach for fixing this, as it
> would again cause breakage for anyone who relies on the existing
> default value. And this kind of breakage seems to have been the reason
> for moving the default values to attach_chip in the first place (see
> https://lore.kernel.org/lkml/20201105084939.72ea6bfd@xps13/ ).
> 
> As similar changes were applied to other NAND drivers, the same issue
> probably also exists there. Maybe it makes sense to add a proper fix
> for all of them?

I am not sure to understand your message as answer to this thread.
There are two problems here:
1/ The DT values not being taken into account
2/ Kestrel's issue with two different integrations with no way to
distinguish between them.

1/ Has already been fixed (at least that is what I think)
2/ Cannot easily be fixed and I don't think there is anything we can do
besides the manufacturer "fixing" the board description.

Am I missing something?

Thanks,
Miquèl
