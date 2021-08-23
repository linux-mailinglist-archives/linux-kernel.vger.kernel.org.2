Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2575D3F4D00
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhHWPEm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Aug 2021 11:04:42 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47821 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhHWPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:04:41 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2D1E01BF203;
        Mon, 23 Aug 2021 15:03:55 +0000 (UTC)
Date:   Mon, 23 Aug 2021 17:03:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-mtd@lists.infradead.org, richard@nod.at,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] mtd: spinand: add support for Foresee FS35ND0*G
 parts
Message-ID: <20210823170354.2dccabd5@xps13>
In-Reply-To: <CAFr9PXkSeeHNn-KVyrVxp6RRdLYExTgWpheWKLLSZqEo_EHvRg@mail.gmail.com>
References: <20210811084924.52293-1-daniel@0x0f.com>
        <20210816101143.2a64d7b9@xps13>
        <CAFr9PXnna+b3ChVUftT7YbU1kYR=5JDcik3bMNqzKK-LW=GQzw@mail.gmail.com>
        <20210823162148.35a24183@xps13>
        <CAFr9PXkSeeHNn-KVyrVxp6RRdLYExTgWpheWKLLSZqEo_EHvRg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Mon, 23 Aug 2021 23:54:20
+0900:

> Hi Miquel,
> 
> On Mon, 23 Aug 2021 at 23:21, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > I am not sure to follow, above the software says "3 corrected bf" while  
> 
> Due to the status being "between 0 and 3 bitflips" I think it'll
> basically report 3 most of the time.
> As a refresher we seem to have a status for 0 - 3 flips but ok, 4 bit
> flips but ok, and >4 flips no go.
> In most cases (0 - 3) the driver is reporting 3.
> 
> > I thought the problem was when getting 4 bf, but the dump show many
> > more. Can you show me how it behaves:
> > * erase (like you did)
> > * insert {1, 2, 3, 4, 5} bf and show the dump each time?  
> 
> Here's a complete log of erasing the page then flipping all the bits
> in the first byte.
> 
> # flash_erase /dev/mtd0 0x8000000 1
> Erasing 128 Kibyte @ 8000000 -- 100 % complete
> # nanddump --bb=dumpbad -s 0x8000000 -l 1 -c -p /dev/mtd0 | head -n 10
> ECC failed: 0
> ECC corrected: 6249
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
> 0x08000070: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> # nandflipbits /dev/mtd0 0@0x8000000
> # nanddump --bb=dumpbad -s 0x8000000 -l 1 -c -p /dev/mtd0 | head -n 10
> ECC failed: 0
> ECC corrected: 6252
> Number of bad blocks: 0
> Number of bbt blocks: 0
> Block size 131072, page size 2048, OOB size 64
> Dumping data starting at 0x08000000 and ending at 0x08000001...
> ECC: 3 corrected bitflip(s) at offset 0x08000000
> 0x08000000: fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|

How is this result possible? You are dumping with the ECC engine
enabled, it reports 3 bf (meaning that it is actually running, at least
the software really thinks there is an on-die engine enabled) but the
data has not been corrected. I expect the first byte to be 0xFF after
correction. Only with -n (raw dump) we should see this.

> 0x08000010: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000070: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 0x08000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|

Thanks,
Miquèl
