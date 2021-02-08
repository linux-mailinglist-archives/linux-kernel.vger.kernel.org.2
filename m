Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900C9313889
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 16:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhBHPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 10:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhBHPHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:07:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7391AC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 07:06:31 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l987K-00034y-2B; Mon, 08 Feb 2021 16:06:22 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l987G-0001VY-3n; Mon, 08 Feb 2021 16:06:18 +0100
Date:   Mon, 8 Feb 2021 16:06:18 +0100
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Youling Tang <tangyouling@loongson.cn>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: fix ignoring return value warning
Message-ID: <20210208150618.GI8233@pengutronix.de>
References: <1612689808-30985-1-git-send-email-tangyouling@loongson.cn>
 <20210208134517.GG2696@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208134517.GG2696@kadam>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:57:09 up 68 days,  2:24, 102 users,  load average: 0.06, 0.08,
 0.09
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Mon, Feb 08, 2021 at 04:45:17PM +0300, Dan Carpenter wrote:
> On Sun, Feb 07, 2021 at 05:23:28PM +0800, Youling Tang wrote:
> > Fix the below ignoring return value warning for device_reset.
> > 
> > drivers/staging/mt7621-dma/mtk-hsdma.c:685:2: warning: ignoring return value
> > of function declared with 'warn_unused_result' attribute [-Wunused-result]
> >         device_reset(&pdev->dev);
> >         ^~~~~~~~~~~~ ~~~~~~~~~~
> > drivers/staging/ralink-gdma/ralink-gdma.c:836:2: warning: ignoring return value
> > of function declared with 'warn_unused_result' attribute [-Wunused-result]
> >         device_reset(&pdev->dev);
> >         ^~~~~~~~~~~~ ~~~~~~~~~~
> > 
> 
> We can't really do this sort of fix without the hardware to test it.
> This could be the correct fix or perhaps switching to device_reset_optional()
> is the correct fix.  We can't know unless we have the hardware to test.

When device_reset() is the wrong function then adding a return value
check will turn this into a runtime error for those who have the
hardware which will hopefully trigger them to tell us why reset_device
is wrong for them.
At least for a staging driver I find this procedure opportune.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
