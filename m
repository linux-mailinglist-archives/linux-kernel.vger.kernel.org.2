Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5F33ECF8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhHPHnA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 03:43:00 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33985 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhHPHm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:42:56 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1EC241BF203;
        Mon, 16 Aug 2021 07:42:22 +0000 (UTC)
Date:   Mon, 16 Aug 2021 09:42:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mtd: spinand: core: Properly fill the OOB area.
Message-ID: <20210816094221.28ad02ea@xps13>
In-Reply-To: <CAFr9PXm4FTw5U9pFNoqptZ28M21czDHrbipCOVRcn7uABkEKSQ@mail.gmail.com>
References: <20210617110842.2358461-1-daniel@0x0f.com>
        <20210806220242.4b83237d@xps13>
        <CAFr9PXm4FTw5U9pFNoqptZ28M21czDHrbipCOVRcn7uABkEKSQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Wed, 11 Aug 2021 16:37:55
+0900:

> Hi Miquel,
> 
> On Sat, 7 Aug 2021 at 05:02, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > This change looks fine, I'll use spinand->oobbuf instead of databuf +
> > offset (will update when applying).  
> 
> Thanks for looking at this for me. One thing I was worried about is
> why the SPI NAND subsystem worked before this change with winbond etc
> parts.

I didn't look closely to the history but it is possible that during the
ECC engine framework introduction and the split of the on-die ECC code
the behavior changed (which, in this case, is a regression).

> You probably don't remember now but I sent a patch to include support
> for the longsys foresee parts that have the weird quirk of having no
> ECC
> data in the OOB so it's all usable by the user except for the bad
> block marker and the ECC status bits being next to useless.
> I found this issue while trying to validate ubi + my ECC status
> decoding worked. [0]

Yes I remember now!

> The SPI NAND subsystem in u-boot worked fine as it could create the
> ubi formatting on the flash and that would survive reboots but any
> blocks written by Linux would be bad on reboot.
> When Linux created the ubi format it would work until a reboot as the
> correct data was cached in memory then u-boot would complain because
> all of the blocks were marked bad.
> 
> But winbond parts mounted on the same board, same code etc worked just fine.
> I guess the OOB is getting fixed somewhere else for other parts.

I think the reason is that most ECC codes do not cover the OOB part,
hence writing garbage there is not an issue (while with your part, the
OOB area was actually fully protected). But it is certainly best to keep
this area tidy anyway.

> Maybe
> it only happens on the longsys parts because there is no ECC in OOB?
> 
> Anyhow I was worried my fix hid some other issue/broke other parts.

I think this patch is legit, I will keep it.

> 
> Cheers,
> 
> Daniel
> 
> 0 - https://lore.kernel.org/lkml/20210408174922.55c1149f@xps13/

Thanks,
Miquèl
