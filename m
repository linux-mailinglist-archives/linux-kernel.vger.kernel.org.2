Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4037F12A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 04:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhEMCMz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 May 2021 22:12:55 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:11270 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhEMCMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 22:12:54 -0400
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 14D2B2YG014974;
        Thu, 13 May 2021 10:11:02 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id E8A4283D3192A84A1029;
        Thu, 13 May 2021 10:11:02 +0800 (CST)
In-Reply-To: <20210511105319.0c077fd5@xps13>
References: <1620697235-7829-1-git-send-email-ycllin@mxic.com.tw> <20210511105319.0c077fd5@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH 0/2] Fix double counting of S/W ECC engines' ECC stat
MIME-Version: 1.0
X-KeepSent: AD6CC9BD:1F0CDB53-482586D4:000A51D2;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP6 SHF907 April 26, 2018
Message-ID: <OFAD6CC9BD.1F0CDB53-ON482586D4.000A51D2-482586D4.000BFF66@mxic.com.tw>
From:   ycllin@mxic.com.tw
Date:   Thu, 13 May 2021 10:11:02 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2021/05/13 AM 10:11:02,
        Serialize complete at 2021/05/13 AM 10:11:02
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG4.macronix.com 14D2B2YG014974
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> "Miquel Raynal" <miquel.raynal@bootlin.com> 
<deleted>
> 
> Good catch!
> 
> However I don't think the current fix is valid because these engines
> are meant to be used by the raw NAND core as well, I propose something
> like the below, can you please tell me if it works as expected? (not
> even build tested)
> 
> Thanks,
> Miquèl
> 
> 
<deleted>

Thanks for your work.

I tested the two patches(yours and mine) separately in our environment: 
1) MXIC NFC(&raw NAND),2) MXIC SPI host(&SPI-NAND) with S/W BCH engine. 
Both patches are valid(using nandtest/nandbiterrs, values of ecc_stats are 
normal).

This seems to be because the function(nand_ecc_sw_bch_finish_io_req() 
in ecc-sw-bch.c) that would increase the ecc_stats counter is not used 
in the raw NAND world. Am I misunderstanding or is it platform dependency?

BTW, I think your modification should be more in line with the design 
spirit 
of generic ECC engine framework.

Thanks,
YouChing

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

