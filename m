Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689BA3588D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhDHPtp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Apr 2021 11:49:45 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:45151 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhDHPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:49:40 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B281DC0016;
        Thu,  8 Apr 2021 15:49:24 +0000 (UTC)
Date:   Thu, 8 Apr 2021 17:49:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
Message-ID: <20210408174922.55c1149f@xps13>
In-Reply-To: <CAFr9PXk-PNWBa9VPriP3nLUqdhtm6uPnbG3n4_rRCdF5YvS7OQ@mail.gmail.com>
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
        <20210407100204.08d894ca@xps13>
        <CAFr9PXk-PNWBa9VPriP3nLUqdhtm6uPnbG3n4_rRCdF5YvS7OQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Wed, 7 Apr 2021 21:01:01 +0900:

> Hi Miquel,
> 
> On Wed, 7 Apr 2021 at 17:02, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > You may look at micron_8_ecc_get_status() helper to guide you. But
> > IMHO, if there are 0-3 bf, you should probably assume there were 3 bf
> > and return 3, if there were 4, return 4, if it's uncorrectable return
> > -EBADMSG otherwise -EINVAL.  
> 
> Understood.
> 
> > We should verify that this does not mess with UBI wear leveling
> > though. Please check that returning 3-bit errors no matter the
> > actual number of flipped bits does not lead UBI to move the data away
> > (I think it's fine but we need to be sure otherwise the implementation
> > proposal is not valid).  
> 
> Ok. I'm not sure how to check that yet but I'll look into it.
> 

You can probably check the threshold in sysfs
(/sys/class/mtd/mtdX/*threshold*).

Thanks,
Miquèl
