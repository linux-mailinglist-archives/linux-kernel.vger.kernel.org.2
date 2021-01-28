Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E73080F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhA1WMA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Jan 2021 17:12:00 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:32915 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhA1WL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:11:57 -0500
X-Originating-IP: 86.210.203.150
Received: from xps13 (lfbn-tou-1-972-150.w86-210.abo.wanadoo.fr [86.210.203.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A951F40007;
        Thu, 28 Jan 2021 22:11:11 +0000 (UTC)
Date:   Thu, 28 Jan 2021 23:11:10 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     mdalam@codeaurora.org
Cc:     manivannan.sadhasivam@linaro.org, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: update last code word register
Message-ID: <20210128231110.64266932@xps13>
In-Reply-To: <769ea3fe77eab9b37d863251e97bcb29@codeaurora.org>
References: <1610251305-20792-1-git-send-email-mdalam@codeaurora.org>
        <20210114165325.3d510355@xps13>
        <769ea3fe77eab9b37d863251e97bcb29@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

mdalam@codeaurora.org wrote on Fri, 29 Jan 2021 03:18:46 +0530:

> On 2021-01-14 21:23, Miquel Raynal wrote:
> > Hello,
> > 
> > Md Sadre Alam <mdalam@codeaurora.org> wrote on Sun, 10 Jan 2021
> > 09:31:45 +0530:
> >   
> >> From QPIC version 2.0 onwards new register got added to  
> > 
> >                                 a
> >   
> >> read last codeword. This change will update the same.  
> > 
> >        the?           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >                       Please reword this sentence.  
> 
>    Fixed this in V4 patch.
> >   
> >> For first three code word READ_LOCATION_n register will be
> >> use.For last code word READ_LOCATION_LAST_CW_n register will be
> >> use.  
> > 
> > "For the first three codewords, READ_LOCATION_n registers will be used.
> > The last codeword register will be accessed through
> > READ_LOCATION_LAST_CW_n."
> > 
> > Also, please specify what these registers store.  
> 
>    The location register is mainly use for reading controller
>    buffer via BAM mode. The bits of the register "NAND_READ_LOCATION_LAST_CW_n, n=0..4"
>    as follow:

Perhaps what I do not understand is: when is this "last_cw" register
more useful than the previous set?

>    [9:0]-bits : (OFFSET) This bit defines the offset from the buffer base address to be picked up for DMA.
>    [25:16]-bits: (SIZE) This bit of every register will define the size of the chunk for DMA.
>    31-bit :      (LAST) If this bit is set, the controller takes the particular register to specify the last chunk
>                        of data made available for DMA. This chunk is part of the internal buffer of the controller.
> 
> >   

Thanks,
Miquèl
