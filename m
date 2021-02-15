Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF6E31B7DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 12:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBOLRm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Feb 2021 06:17:42 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40755 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhBOLRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:17:38 -0500
X-Originating-IP: 92.184.108.178
Received: from xps13 (pop.92-184-108-178.mobile.abo.orange.fr [92.184.108.178])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 17D241C000C;
        Mon, 15 Feb 2021 11:16:54 +0000 (UTC)
Date:   Mon, 15 Feb 2021 12:16:53 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
Message-ID: <20210215121653.4edd86c4@xps13>
In-Reply-To: <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com>
References: <20210213095724.3411058-1-daniel@0x0f.com>
        <20210215112409.1a755bf0@xps13>
        <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Mon, 15 Feb 2021 19:53:13
+0900:

> Hi Miquel,
> 
> On Mon, 15 Feb 2021 at 19:24, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Can you please add a changelog here when you send a new version of a
> > patch?  
> 
> Sorry, I was going to add a cover letter but elsewhere got told that
> one isn't needed for a single patch..

A cover letter is useful when there are many patches, or when there is
some context that is important to remember.

But a changelog should always be added when you change something
between two versions. And the changelog can be located below the three
dashes ("---") without being part of the final commit message, it does
not need to be in a separate cover letter.

> Basically I changed FS35ND01G to FS35ND01G-S1Y2 as that's the proper
> part number for the chip I have and there seem to be a few variations
> of this.
> Aside from that I fixed up the hex numbers to be uppercase and added
> the oob layout callbacks.
> 
> > > +static int fs35nd01g_s1y2_ooblayout_free(struct mtd_info *mtd, int section,
> > > +                                 struct mtd_oob_region *region)
> > > +{
> > > +     if (section > 3)
> > > +             return -ERANGE;
> > > +
> > > +     /*
> > > +      * No ECC data is stored in the accessible OOB so the full 16 bytes
> > > +      * of each spare region is available to the user. Apparently also
> > > +      * covered by the internal ECC.  
> >
> > How is this even possible? ECC must be stored somewhere, maybe it is
> > not possible to retrieve it but I guess you cannot use the 32 bytes of
> > OOB for user data. Can you please verify that?  
> 
> This worried me too as I could not find the OOB layout anywhere.
> They simply list there being 4 512 byte main areas and then 4 16 byte
> spare areas. The only other note is that the first byte of spare0 is
> used for the bad block marker.
> 
> I contacted Longsys but they didn't get back to me.
> So what I did here was I started googling strings within the datasheet
> to find other chips that are probably the same IP inside and I found
> the FM25G01.
> It's datasheet shares a lot of the same text and the flash layout
> diagrams etc are the same.
> It has the same table for the flash layout. 4 512 byte areas and 4 16
> byte spare areas. It has the same note for the bad block marker and
> then one additional note:
> 
> "2. Spare area 800H to 83FH is all available for user.
>  ECC parity codes are programmed in
> additional space and not user accessible."
> 
> It would seem that the pages are actually bigger than 2K + 64 or there
> is some other place they keep the ECC.
> Or both datasheets are lying. Somewhere else in the datasheets it says
> that writes to the ECC area will be ignored but that doesn't make a
> lot of sense if the ECC area isn't user accessible in the first place.
> 
> I didn't think about it at the time but I can take a dump of the OOB
> area of my FS35ND01G-S1Y2 to confirm it's all 0xff except for any
> factory marked bad blocks.

I see. Can you please try the following:

nandwrite -o /dev/mtdx /dev/zero
nanddump -ol1 /dev/mtdx

If the entire area is effectively free to be used, you should see 0's
everywhere. Otherwise you should have ff's somewhere.

Thanks,
Miquèl
