Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6495D3565FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhDGIDD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Apr 2021 04:03:03 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39605 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244592AbhDGICZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:02:25 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9D409FF80E;
        Wed,  7 Apr 2021 08:02:05 +0000 (UTC)
Date:   Wed, 7 Apr 2021 10:02:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
Message-ID: <20210407100204.08d894ca@xps13>
In-Reply-To: <CAFr9PXntCmdrmg+i3BB1j-aY4VbE=2iqyLcoSr9cX2090jGiGQ@mail.gmail.com>
References: <20210213095724.3411058-1-daniel@0x0f.com>
        <20210215112409.1a755bf0@xps13>
        <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com>
        <20210215121653.4edd86c4@xps13>
        <CAFr9PXmVehtcm6FjBqi_hmEAj1rgtxMvarisjPmWhgjruVj++Q@mail.gmail.com>
        <20210322193213.18520b9a@xps13>
        <CAFr9PX=mL9UWcr-yWbYa5NXS-R=yHeGgM+hd_MKOa2XiBUAJOQ@mail.gmail.com>
        <20210323113233.3523d66b@xps13>
        <CAFr9PX=KMZuzp61Hq=2WdHyEzE=6J7HEPWZxPs7FEqiH-G8wFw@mail.gmail.com>
        <20210323150603.6b942a60@xps13>
        <CAFr9PXntCmdrmg+i3BB1j-aY4VbE=2iqyLcoSr9cX2090jGiGQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Fri, 26 Mar 2021 23:09:28
+0900:

> Hi Miquel,
> 
> Sorry for the constant pestering on this..
> 
> On Tue, 23 Mar 2021 at 23:06, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > # nandbiterrs -i /dev/mtd1
> > > incremental biterrors test
> > > Successfully corrected 0 bit errors per subpage
> > > Inserted biterror @ 0/5
> > > Read reported 4 corrected bit errors
> > > ECC failure, invalid data despite read success  
> >
> > This is not a valid behavior. There is something wrong with the way ECC
> > status is read/retrieved. The read should indeed report 4 corrected bit
> > errors, but then the data should be valid. Here it means that the
> > introduced error appears corrected but in fact is not.
> > We need to understand what status are available and write the
> > appropriate vendor code.  
> 
> I looked at the datasheet again and the encoding for ecc status seems
> a bit funky.
> The chip seems to have only two bits for ECC status with this encoding:
> 0 - Read success with 0-3 flipped bits.
> 1 - Read success with 4 flipped bits.
> 2 - Uncorrectable.
> 3 - Reserved.
> 

Very nice information.

> This looks almost the same as the Winbond chips with 0 and 1 being successes
> but with no totally error free status.
> 
> Anyhow, if 4 bits were corrected is returned for 1 then nandbiterrs
> reports "ECC failure, invalid data despite read success".
> If I return 3 bit errors for 0 and -EBADMSG for anything else
> nandbiterrs doesn't complain anymore but is this right?:

You may look at micron_8_ecc_get_status() helper to guide you. But
IMHO, if there are 0-3 bf, you should probably assume there were 3 bf
and return 3, if there were 4, return 4, if it's uncorrectable return
-EBADMSG otherwise -EINVAL.

We should verify that this does not mess with UBI wear leveling
though. Please check that returning 3-bit errors no matter the
actual number of flipped bits does not lead UBI to move the data away
(I think it's fine but we need to be sure otherwise the implementation
proposal is not valid).

Thanks,
Miquèl
