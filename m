Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358F3345BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhCWKdL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Mar 2021 06:33:11 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42523 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhCWKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:32:37 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 618D1C0008;
        Tue, 23 Mar 2021 10:32:33 +0000 (UTC)
Date:   Tue, 23 Mar 2021 11:32:33 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
Message-ID: <20210323113233.3523d66b@xps13>
In-Reply-To: <CAFr9PX=mL9UWcr-yWbYa5NXS-R=yHeGgM+hd_MKOa2XiBUAJOQ@mail.gmail.com>
References: <20210213095724.3411058-1-daniel@0x0f.com>
        <20210215112409.1a755bf0@xps13>
        <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com>
        <20210215121653.4edd86c4@xps13>
        <CAFr9PXmVehtcm6FjBqi_hmEAj1rgtxMvarisjPmWhgjruVj++Q@mail.gmail.com>
        <20210322193213.18520b9a@xps13>
        <CAFr9PX=mL9UWcr-yWbYa5NXS-R=yHeGgM+hd_MKOa2XiBUAJOQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Tue, 23 Mar 2021 18:33:54
+0900:

> Hi Miquel,
> 
> On Tue, 23 Mar 2021 at 03:32, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > I think this shows that the datasheet is right in that the complete 64
> > > bytes of "spare area" is usable.
> > > I have no idea where it puts the ECC though. :)  
> >
> > Argh, I don't like when hardware tries to be smart.  
> 
> I'm sort of worried that there just isn't any ECC :D

You can run nandbiterrs -i /dev/mtdX

You'll see if there is ECC correction or not (and its level).

Thanks,
Miquèl
