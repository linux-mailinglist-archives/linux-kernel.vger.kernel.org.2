Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E474837F32C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhEMGqk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 May 2021 02:46:40 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:39683 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMGqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:46:36 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0FED220004;
        Thu, 13 May 2021 06:45:24 +0000 (UTC)
Date:   Thu, 13 May 2021 08:45:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     ycllin@mxic.com.tw
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/2] Fix double counting of S/W ECC engines' ECC stat
Message-ID: <20210513084523.41d1cdd6@xps13>
In-Reply-To: <OFAD6CC9BD.1F0CDB53-ON482586D4.000A51D2-482586D4.000BFF66@mxic.com.tw>
References: <1620697235-7829-1-git-send-email-ycllin@mxic.com.tw>
        <20210511105319.0c077fd5@xps13>
        <OFAD6CC9BD.1F0CDB53-ON482586D4.000A51D2-482586D4.000BFF66@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YouChing,

ycllin@mxic.com.tw wrote on Thu, 13 May 2021 10:11:02 +0800:

> > "Miquel Raynal" <miquel.raynal@bootlin.com>   
> <deleted>
> > 
> > Good catch!
> > 
> > However I don't think the current fix is valid because these engines
> > are meant to be used by the raw NAND core as well, I propose something
> > like the below, can you please tell me if it works as expected? (not
> > even build tested)
> > 
> > Thanks,
> > Miquèl
> > 
> >   
> <deleted>
> 
> Thanks for your work.
> 
> I tested the two patches(yours and mine) separately in our environment: 
> 1) MXIC NFC(&raw NAND),2) MXIC SPI host(&SPI-NAND) with S/W BCH engine. 
> Both patches are valid(using nandtest/nandbiterrs, values of ecc_stats are 
> normal).
> 
> This seems to be because the function(nand_ecc_sw_bch_finish_io_req() 
> in ecc-sw-bch.c) that would increase the ecc_stats counter is not used 
> in the raw NAND world. Am I misunderstanding or is it platform dependency?

I don't think it can be called a platform dependency, it's more like
legacy from the raw NAND world which makes the use of the generic ECC
framework hard and thus is limited to a given set of functions.

> BTW, I think your modification should be more in line with the design 
> spirit 
> of generic ECC engine framework.

Yes, ideally raw NAND should fully comply to this framework but this
would require a hundred days of work and dozens of available boards to
test. During the past 20 years people assumed NAND controller and ECC
engine were a single entity which makes the use of the generic ECC
framework hard to implemented in the raw NAND. So I decided not to put
all my energy there in order to first get this framework available to
SPI-NAND devices.

Thanks,
Miquèl
