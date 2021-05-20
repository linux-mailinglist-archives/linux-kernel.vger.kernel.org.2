Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A545038AAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbhETLTm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 May 2021 07:19:42 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:59505 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhETK7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:59:00 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 14KAurMl003795;
        Thu, 20 May 2021 18:56:53 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 8F2DFEB31973D2233DFB;
        Thu, 20 May 2021 18:56:54 +0800 (CST)
In-Reply-To: <20210513084523.41d1cdd6@xps13>
References: <1620697235-7829-1-git-send-email-ycllin@mxic.com.tw>       <20210511105319.0c077fd5@xps13>
        <OFAD6CC9BD.1F0CDB53-ON482586D4.000A51D2-482586D4.000BFF66@mxic.com.tw> <20210513084523.41d1cdd6@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, richard@nod.at,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, vigneshr@ti.com
Subject: Re: [PATCH 0/2] Fix double counting of S/W ECC engines' ECC stat
MIME-Version: 1.0
X-KeepSent: 12EB0BE9:7879DE49-482586DB:0039FC49;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP6 SHF907 April 26, 2018
Message-ID: <OF12EB0BE9.7879DE49-ON482586DB.0039FC49-482586DB.003C2449@mxic.com.tw>
From:   ycllin@mxic.com.tw
Date:   Thu, 20 May 2021 18:56:54 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2021/05/20 PM 06:56:54,
        Serialize complete at 2021/05/20 PM 06:56:54
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG3.macronix.com 14KAurMl003795
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquèl,

> "Miquel Raynal" <miquel.raynal@bootlin.com> 
> Re: [PATCH 0/2] Fix double counting of S/W ECC engines' ECC stat
> 
> Hi YouChing,
> 
> ycllin@mxic.com.tw wrote on Thu, 13 May 2021 10:11:02 +0800:
> 
> > > "Miquel Raynal" <miquel.raynal@bootlin.com> 
> > <deleted>
> > > 
> > > Good catch!
> > > 
> > > However I don't think the current fix is valid because these engines
> > > are meant to be used by the raw NAND core as well, I propose 
something
> > > like the below, can you please tell me if it works as expected? (not
> > > even build tested)
> > > 
> > > Thanks,
> > > Miquèl
> > > 
> > > 
> > <deleted>
> > 
> > Thanks for your work.
> > 
> > I tested the two patches(yours and mine) separately in our 
environment: 
> > 1) MXIC NFC(&raw NAND),2) MXIC SPI host(&SPI-NAND) with S/W BCH 
engine. 
> > Both patches are valid(using nandtest/nandbiterrs, values of ecc_stats 
are 
> > normal).
> > 
> > This seems to be because the function(nand_ecc_sw_bch_finish_io_req() 
> > in ecc-sw-bch.c) that would increase the ecc_stats counter is not used 

> > in the raw NAND world. Am I misunderstanding or is it platform 
dependency?
> 
> I don't think it can be called a platform dependency, it's more like
> legacy from the raw NAND world which makes the use of the generic ECC
> framework hard and thus is limited to a given set of functions.
> 
> > BTW, I think your modification should be more in line with the design 
> > spirit 
> > of generic ECC engine framework.
> 
> Yes, ideally raw NAND should fully comply to this framework but this
> would require a hundred days of work and dozens of available boards to
> test. During the past 20 years people assumed NAND controller and ECC
> engine were a single entity which makes the use of the generic ECC
> framework hard to implemented in the raw NAND. So I decided not to put
> all my energy there in order to first get this framework available to
> SPI-NAND devices.

Thanks for your detailed explanation. 
I agree with your change and it works fine in SPI-NAND world 
(with on-die or S/W ECC engines) and raw NAND world(with S/W ECC engines).

Tested-by: YouChing Lin <ycllin@mxic.com.tw>


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

