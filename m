Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691C232AA6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835814AbhCBT3W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Mar 2021 14:29:22 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:60147 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbhCBRNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:13:00 -0500
Received: from xps13 (lfbn-tou-1-491-148.w86-206.abo.wanadoo.fr [86.206.8.148])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E0D1C200004;
        Tue,  2 Mar 2021 17:12:09 +0000 (UTC)
Date:   Tue, 2 Mar 2021 18:12:08 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 8/9] mtd/drivers/nand: Use HZ macros
Message-ID: <20210302181208.3b673e2c@xps13>
In-Reply-To: <ad7da99c-5385-02dc-5fbc-c9ae31903802@linaro.org>
References: <20210302163143.22998-1-miquel.raynal@bootlin.com>
        <ad7da99c-5385-02dc-5fbc-c9ae31903802@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Lezcano <daniel.lezcano@linaro.org> wrote on Tue, 2 Mar 2021
18:03:12 +0100:

> On 02/03/2021 17:31, Miquel Raynal wrote:
> > On Wed, 2021-02-24 at 14:42:18 UTC, Daniel Lezcano wrote:  
> >> HZ unit conversion macros are available in units.h, use them and
> >> remove the duplicate definition.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>  
> > 
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.  
> 
> Actually, I was expecting to have it merged through linux-pm as this
> patch depends on 1/9
> 
> 
> 

No problem, I just removed it from my tree. However in this case
please fix the subject prefix to "mtd: rawnand: intel:". With this nit
fixed,

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
