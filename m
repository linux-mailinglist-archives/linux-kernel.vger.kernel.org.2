Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA57A362FE0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhDQMbz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 17 Apr 2021 08:31:55 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40689 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDQMby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 08:31:54 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 2A81A240003;
        Sat, 17 Apr 2021 12:31:24 +0000 (UTC)
Date:   Sat, 17 Apr 2021 14:31:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: fix an error code in
 nand_setup_interface()
Message-ID: <20210417143124.6a79c71c@xps13>
In-Reply-To: <20210417102426.GP6048@kadam>
References: <YHaEEYg2DUFwnxSo@mwanda>
        <20210416170040.4e467039@xps13>
        <20210417102426.GP6048@kadam>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Dan Carpenter <dan.carpenter@oracle.com> wrote on Sat, 17 Apr 2021
13:24:26 +0300:

> On Fri, Apr 16, 2021 at 05:00:40PM +0200, Miquel Raynal wrote:
> > Hi Dan,
> > 
> > Dan Carpenter <dan.carpenter@oracle.com> wrote on Wed, 14 Apr 2021
> > 08:56:33 +0300:
> >   
> > > We should return an error code if the timing mode is not acknowledged
> > > by the NAND chip.  
> > 
> > This truly is questionable (and I am not yet decided whether the answer
> > should be yes or no).
> > 
> > Returning an error here would produce the entire boot sequence to fail,
> > even though the NAND chip would work in mode 0.
> > 
> > Not returning an error would print the below warning (so the
> > user/developer is warned) and continue the boot with the slowest
> > timing interface.
> > 
> > Honestly I would be more in favor of letting things as they are
> > because I don't think this may be considered as a buggy situation, but I
> > am open to discussion.
> >   
> 
> If we decided that the original code is correct then one way to silence
> the warning would be to do:
> 
> 	if (tmode_param[0] != chip->best_interface_config->timings.mode) {
> 		pr_warn("timing mode %d not acknowledged by the NAND chip\n",
>  			chip->best_interface_config->timings.mode);
> 		ret = 0;
> 		goto err_reset_chip;
> 	}
> 
> Setting "ret = 0;" right before the goto makes the code look more
> intentional to human readers as well.

Absolutely right. Let's got for it then.

Cheers,
Miquèl
