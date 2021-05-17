Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9F3825EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhEQH5k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 May 2021 03:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbhEQH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:57:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 00:56:23 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1liY6v-0008Ld-TH; Mon, 17 May 2021 09:56:21 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1liY6t-0006Ze-L2; Mon, 17 May 2021 09:56:19 +0200
Message-ID: <9027c4693dd9377d15109ff590a283d4d06595ef.camel@pengutronix.de>
Subject: Re: [PATCH] reset: hi6220: Use the correct HiSilicon copyright
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "fanghao (A)" <fanghao11@huawei.com>
Cc:     puck.chen@hisilicon.com, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com
Date:   Mon, 17 May 2021 09:56:19 +0200
In-Reply-To: <a54e7ec4-7b20-0adb-151f-6e943c61d9e3@huawei.com>
References: <1617087044-19572-1-git-send-email-fanghao11@huawei.com>
         <9094d229c86bd55395ad9b01ae8f5432bb80fd35.camel@pengutronix.de>
         <a54e7ec4-7b20-0adb-151f-6e943c61d9e3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao,

On Thu, 2021-05-13 at 10:35 +0800, fanghao (A) wrote:
[...]
> diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
> > > index 1992650..5ca145b 100644
> > > --- a/drivers/reset/hisilicon/hi6220_reset.c
> > > +++ b/drivers/reset/hisilicon/hi6220_reset.c
> > > @@ -3,7 +3,7 @@
> > >   * Hisilicon Hi6220 reset controller driver
> > 
> > Why leave this "Hisilicon" alone?
> 
> HiSilicon has applied for two trademarks Hisilicon/HiSilicon, so I
> think this one is OK. But there is only one English name for the
> company,
> We have consulted with company's lawyer who suggested that should use
> a copyright statement consistent with the official website.

Ok, got it, thank you.

> > >   *
> > >   * Copyright (c) 2016 Linaro Limited.
> > > - * Copyright (c) 2015-2016 Hisilicon Limited.
> > > + * Copyright (c) 2015-2016 HiSilicon Limited.
> > >   *
> > >   * Author: Feng Chen <puck.chen@hisilicon.com>
> > >   */
> > 
> > That will be a lot of churn:
> > 
> >   git grep Copyright.*Hisilicon | wc -l
> >   141
> > 
> >   git grep Hisilicon | wc -l
> >   371
> 
> As mentioned above, I am focused on correcting the copyright.
> 5.13-rc1 has been released and I will continue to clean the rest by
> make one patch per subsystem.
> 
> Should I resend this based on 5.13-rc1?

Not necessary, the patch still applies.

> > Could I get an Acked-by from someone at HiSilicon for this?
> 
> Maybe I could remind the author.

That's ok, they are in Cc:.
I'll apply this to reset/next.

regards
Philipp
