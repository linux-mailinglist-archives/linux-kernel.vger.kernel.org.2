Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B7F3F4C45
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhHWOWf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Aug 2021 10:22:35 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:45999 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhHWOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:22:34 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 16FF140007;
        Mon, 23 Aug 2021 14:21:49 +0000 (UTC)
Date:   Mon, 23 Aug 2021 16:21:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-mtd@lists.infradead.org, richard@nod.at,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] mtd: spinand: add support for Foresee FS35ND0*G
 parts
Message-ID: <20210823162148.35a24183@xps13>
In-Reply-To: <CAFr9PXnna+b3ChVUftT7YbU1kYR=5JDcik3bMNqzKK-LW=GQzw@mail.gmail.com>
References: <20210811084924.52293-1-daniel@0x0f.com>
        <20210816101143.2a64d7b9@xps13>
        <CAFr9PXnna+b3ChVUftT7YbU1kYR=5JDcik3bMNqzKK-LW=GQzw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Mon, 23 Aug 2021 23:19:02
+0900:

> Hi Miquel,
> 
> > > +     /*
> > > +      * The datasheet says *successful* with 4 bits flipped.
> > > +      * nandbiterrs always complains that the read reported
> > > +      * successful but the data is incorrect.
> > > +      */
> > > +     case FS35ND01G_S1Y2_STATUS_ECC_4_BITFLIPS:
> > > +             return 4;  
> >
> > This is a real issue. Can you use the nandflipbits tool from the
> > mtd-utils package (you should take a recent version of the package) and
> > try to observe what happens when you insert a 4th bitflip in a section?
> >
> > I generally believe the tool more than the datasheet :)  
> 
> Maybe I'm using it incorrectly but I can't get a 4 bit flipped
> situation to happen.
> 
> I erased the paged so it's all 0xFF:
> 
> # flash_erase /dev/mtd0 0x8000000 1
> Erasing 128 Kibyte @ 8000000 -- 100 % complete
> # nanddump --bb=dumpbad -s 0x8000000 -l 1 -c -p /dev/mtd0
> ECC failed: 0
> ECC corrected: 6234
> Number of bad blocks: 0
> Number of bbt blocks: 0
> Block size 131072, page size 2048, OOB size 64
> Dumping data starting at 0x08000000 and ending at 0x08000001...
> ECC: 3 corrected bitflip(s) at offset 0x08000000
> 0x08000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000010: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 
> Then used nandflipbits to flip a bunch of bits in the first byte and
> then a few other bytes:
> 
> # nanddump --bb=dumpbad -s 0x8000000 -l 1 -c -p /dev/mtd0
> ECC failed: 0
> ECC corrected: 6246
> Number of bad blocks: 0
> Number of bbt blocks: 0
> Block size 131072, page size 2048, OOB size 64
> Dumping data starting at 0x08000000 and ending at 0x08000001...
> ECC: 3 corrected bitflip(s) at offset 0x08000000
> 0x08000000: f0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000010: eb ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000020: ef ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000060: ef ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 
> Anyhow,
> I think we should probably return -EBADMSG if the 4 bit flips status
> appears as nandbiterrs always complains that the data is wrong.

I am not sure to follow, above the software says "3 corrected bf" while
I thought the problem was when getting 4 bf, but the dump show many
more. Can you show me how it behaves:
* erase (like you did)
* insert {1, 2, 3, 4, 5} bf and show the dump each time?

Thanks,
Miquèl
