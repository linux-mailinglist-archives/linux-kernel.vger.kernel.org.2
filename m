Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C914440FFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbhIQTeW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Sep 2021 15:34:22 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39875 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbhIQTeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 15:34:12 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D87EE1BF209;
        Fri, 17 Sep 2021 19:32:47 +0000 (UTC)
Date:   Fri, 17 Sep 2021 21:32:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jan Hoffmann <jan@3e8.eu>
Cc:     Daniel Kestrel <kestrelseventyfour@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Message-ID: <20210917213246.319e60cb@xps13>
In-Reply-To: <e9dd0653-139f-749b-c088-e756ee2d2132@3e8.eu>
References: <20210808072643.GA5084@ubuntu>
        <51f2ebf4-6df1-eba5-99f1-1ec88e475d20@3e8.eu>
        <20210917190154.76203a9a@xps13>
        <e9dd0653-139f-749b-c088-e756ee2d2132@3e8.eu>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

jan@3e8.eu wrote on Fri, 17 Sep 2021 19:45:33 +0200:

> Hi Miquèl,
> 
> > I am not sure to understand your message as answer to this thread.
> > There are two problems here:
> > 1/ The DT values not being taken into account  
> 
> This is the issue I'm referring to.
> 
> > 1/ Has already been fixed (at least that is what I think)  
> 
> This is not fixed in kernel 5.10. And unless I am missing something
> there also doesn't seem be a fix in more recent kernels.
> 
> I am aware of commit 33d974e76e21 ("mtd: rawnand: xway: Do not force a
> particular software ECC engine"), but that only fixes the ECC
> algorithm. The ECC engine type is still hard-coded in xway_attach_chip.

Yes this was my understanding, that only software ECC engine was
supported. The mainline driver shows absolutely no signs of hardware
ECC engine support.

Perhaps however you mean that on-die ECC engine are not supported
anymore because of the engine_type being set in attach_chip()? If yes
then indeed there is something to do, perhaps checking if an engine has
been already set is enough? You can try something like:

if (engine_type == unknown)
	engine_type = soft;
 
Thanks,
Miquèl
