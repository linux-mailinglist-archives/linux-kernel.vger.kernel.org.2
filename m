Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1AD324B83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhBYHtd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Feb 2021 02:49:33 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37391 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbhBYHt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:49:27 -0500
X-Originating-IP: 86.250.253.134
Received: from xps13 (lfbn-tou-1-813-134.w86-250.abo.wanadoo.fr [86.250.253.134])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id D5391E0007;
        Thu, 25 Feb 2021 07:48:39 +0000 (UTC)
Date:   Thu, 25 Feb 2021 08:48:38 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nand: brcmnand: fix OOB R/W with Hamming ECC
Message-ID: <20210225084838.34bbdbff@xps13>
In-Reply-To: <CAN8TOE_Eg6zYqy8wLtrNcTiCQdcihM7wGM5JHw=bh4=b1CL-_A@mail.gmail.com>
References: <20210222201655.32361-1-noltari@gmail.com>
        <20210224080210.23686-1-noltari@gmail.com>
        <CAN8TOE_Eg6zYqy8wLtrNcTiCQdcihM7wGM5JHw=bh4=b1CL-_A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Álvaro,

Brian Norris <computersforpeace@gmail.com> wrote on Wed, 24 Feb 2021
13:01:13 -0800:

> On Wed, Feb 24, 2021 at 12:02 AM Álvaro Fernández Rojas
> <noltari@gmail.com> wrote:
> > Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")  
> 
> FWIW, I could believe this was broken. We weren't testing Hamming ECC
> (nor JFFS2) at the time, so it could easily have obvious bugs like
> this.

Right, you should probably limit the backport to the time when raw
accessors got introduced/fixed.

Thanks,
Miquèl
