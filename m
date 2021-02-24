Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F1323800
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhBXHi6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Feb 2021 02:38:58 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56573 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhBXHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:38:56 -0500
X-Originating-IP: 86.210.203.113
Received: from xps13 (lfbn-tou-1-972-113.w86-210.abo.wanadoo.fr [86.210.203.113])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0F5CF20009;
        Wed, 24 Feb 2021 07:38:06 +0000 (UTC)
Date:   Wed, 24 Feb 2021 08:38:05 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nand: brcmnand: fix OOB R/W with Hamming ECC
Message-ID: <20210224083805.34f625a0@xps13>
In-Reply-To: <0670B343-C39E-4610-8061-A7F81F90B9F4@gmail.com>
References: <20210222201655.32361-1-noltari@gmail.com>
        <32837cb2-f7ba-d59e-de66-051019b21e89@gmail.com>
        <0670B343-C39E-4610-8061-A7F81F90B9F4@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Álvaro,

Álvaro Fernández Rojas <noltari@gmail.com> wrote on Wed, 24 Feb 2021
08:16:58 +0100:

> Hi Florian,
> 
> > El 24 feb 2021, a las 4:46, Florian Fainelli <f.fainelli@gmail.com> escribió:
> > 
> > 
> > 
> > On 2/22/2021 12:16 PM, Álvaro Fernández Rojas wrote:
> >> Hamming ECC doesn't cover the OOB data, so reading or writing OOB shall
> >> always be done without ECC enabled.
> >> This is a problem when adding JFFS2 cleanmarkers to erased blocks. If JFFS2
> >> clenmarkers are added to the OOB with ECC enabled, OOB bytes will be changed
> >> from ff ff ff to 00 00 00, reporting incorrect ECC errors.
> >> 
> >> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> > 
> > Should there be a Fixes: tag provided here for back porting to stable trees?
> 
> I think so, but the fixed commit would be the first one, right?
> 27c5b17cd1b10564fa36f8f51e4b4b41436ecc32

Yep, shouldn't be a problem.

Thanks,
Miquèl
