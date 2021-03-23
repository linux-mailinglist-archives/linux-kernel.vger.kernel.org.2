Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27033460FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhCWOGU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Mar 2021 10:06:20 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:38371 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhCWOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:06:07 -0400
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id C84F7100016;
        Tue, 23 Mar 2021 14:06:04 +0000 (UTC)
Date:   Tue, 23 Mar 2021 15:06:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
Message-ID: <20210323150603.6b942a60@xps13>
In-Reply-To: <CAFr9PX=KMZuzp61Hq=2WdHyEzE=6J7HEPWZxPs7FEqiH-G8wFw@mail.gmail.com>
References: <20210213095724.3411058-1-daniel@0x0f.com>
        <20210215112409.1a755bf0@xps13>
        <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com>
        <20210215121653.4edd86c4@xps13>
        <CAFr9PXmVehtcm6FjBqi_hmEAj1rgtxMvarisjPmWhgjruVj++Q@mail.gmail.com>
        <20210322193213.18520b9a@xps13>
        <CAFr9PX=mL9UWcr-yWbYa5NXS-R=yHeGgM+hd_MKOa2XiBUAJOQ@mail.gmail.com>
        <20210323113233.3523d66b@xps13>
        <CAFr9PX=KMZuzp61Hq=2WdHyEzE=6J7HEPWZxPs7FEqiH-G8wFw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Tue, 23 Mar 2021 20:47:10
+0900:

> Hi Miquel,
> 
> On Tue, 23 Mar 2021 at 19:32, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > You can run nandbiterrs -i /dev/mtdX
> >
> > You'll see if there is ECC correction or not (and its level).  
> 
> These are results I get for both of the nandbiterrs tests.
> 
> # nandbiterrs -i /dev/mtd1
> incremental biterrors test
> Successfully corrected 0 bit errors per subpage
> Inserted biterror @ 0/5
> Read reported 4 corrected bit errors
> ECC failure, invalid data despite read success

This is not a valid behavior. There is something wrong with the way ECC
status is read/retrieved. The read should indeed report 4 corrected bit
errors, but then the data should be valid. Here it means that the
introduced error appears corrected but in fact is not.

We need to understand what status are available and write the
appropriate vendor code.

Thanks,
Miquèl
