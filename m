Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93631B5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 09:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhBOIh7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Feb 2021 03:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBOIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 03:37:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66165C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 00:37:17 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=puma.localnet)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1lBZNb-0000lv-9m; Mon, 15 Feb 2021 09:37:15 +0100
From:   =?ISO-8859-1?Q?J=FCrgen?= Borleis <jbe@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] fs: ubifs: set s_uuid in super block to support ima/evm uuid options
Date:   Mon, 15 Feb 2021 09:37:11 +0100
Message-ID: <11692601.O9o76ZdvQC@puma>
Organization: Pengutronix e. K.
In-Reply-To: <CAFLxGvw=5uK0AHmMq5vqOWiBzS68TBd-vU3G9mpWeTXeO5B47A@mail.gmail.com>
References: <20210202124838.30805-1-jbe@pengutronix.de> <CAFLxGvw=5uK0AHmMq5vqOWiBzS68TBd-vU3G9mpWeTXeO5B47A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: jbe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Am Freitag, 12. Februar 2021, 21:59:52 CET schrieb Richard Weinberger:
> On Tue, Feb 2, 2021 at 1:55 PM Juergen Borleis <jbe@pengutronix.de> wrote:
> > From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > 
> > This is required to provide uuid based integrity functionality for:
> > ima_policy (fsuuid option) and the 'evmctl' command ('--uuid' option).
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Acked-by: Juergen Borleis <jbe@pengutronix.de>
> 
> I took this patch, thanks a lot for this but I have changed the sob-chain
> to:
> 
>     Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
>     Co-developed-by: Juergen Borleis <jbe@pengutronix.de>
>     Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> Namely, "patch was created by Steffen Trumtrar, Oleksij Rempel and
> Juergen Borleis.
> Steffen Trumtrar committed it and Juergen Borleis later sent it to the
> mailing list".
> 
> Is this right?

Yes.

> Okay. I've dropped the patch from linux-next.
> Juergen, please address Andy's comments and resend.

I will talk to Steffen and re-send a V2.

Thanks,
Jürgen



