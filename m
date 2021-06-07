Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46339D576
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFGG7G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Jun 2021 02:59:06 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35795 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGG7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:59:05 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4E9BAE000E;
        Mon,  7 Jun 2021 06:57:12 +0000 (UTC)
Date:   Mon, 7 Jun 2021 08:57:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: rawnand: ensure return variable is
 initialized
Message-ID: <20210607085711.65c64c58@xps13>
In-Reply-To: <20210601121401.GY1955@kadam>
References: <20210527145048.795954-1-colin.king@canonical.com>
        <20210527170309.4d99bc31@xps13>
        <20210601121401.GY1955@kadam>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Dan Carpenter <dan.carpenter@oracle.com> wrote on Tue, 1 Jun 2021
15:14:02 +0300:

> On Thu, May 27, 2021 at 05:03:09PM +0200, Miquel Raynal wrote:
> > Hi Colin,
> > 
> > Colin King <colin.king@canonical.com> wrote on Thu, 27 May 2021
> > 15:50:48 +0100:
> >   
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Currently there are corner cases where spec_times is NULL and
> > > chip->parameters.onfi or when best_mode is zero where ret is  
> > 
> >                        ^
> > something is missing here, the sentence is not clear
> >   
> > > not assigned a value and an uninitialized return value can be
> > > returned. Fix this by ensuring ret is initialized to -EINVAL.  
> > 
> > I don't see how this situation can happen.
> > 
> > In both cases, no matter the value of best_mode, the for loop will
> > always execute at least one time (mode 0) so ret will be populated.
> > 
> > Maybe the robot does not know that best_mode cannot be negative and
> > should be defined unsigned, but the current patch is invalid.
> >  
> 
> People think list counter unsigned is a good idea, but it's a terrible
> idea and has caused hundreds of bugs for me to fix/report over the
> years.  *grumble*.
> 
> Anyway, I was revisiting this code because it showed up as a Smatch
> warning and the bug appears to be real.
> 
> 	best_mode = fls(chip->parameters.onfi->sdr_timing_modes) - 1;
> 
> The "onfi->sdr_timing_modes" comes from the hardware in nand_onfi_detect()
> and nothing checks that it is non-zero so "best_mode = fls(0) - 1;" is
> negative and "ret" is uninitialized.

In the ONFI specification, the sdr_timing_mode field is defined as
follow:

SDR timing mode support
BIT  VALUE MEANING
6-15 N/A   Reserved (0)
5    1     supports timing mode 5
4    1     supports timing mode 4
3    1     supports timing mode 3
2    1     supports timing mode 2
1    1     supports timing mode 1
0    1     supports timing mode 0, shall be 1

IOW sdr_timing_modes *cannot* be 0, or it is a truly deep and crazily
impacting hardware bug (so far I am not aware of any chip not returning
the right timing mode 0 value). Hence my proposal to turn best_mode as
unsigned. I honestly don't know what is the best option here and am
fully open to other suggestions to silence the robot.

Thanks,
Miquèl
