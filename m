Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F1131077D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhBEJOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBEJKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:10:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBCEC0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 01:09:30 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1l7x7F-00089v-MV; Fri, 05 Feb 2021 10:09:25 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1l7x7E-0005or-5D; Fri, 05 Feb 2021 10:09:24 +0100
Date:   Fri, 5 Feb 2021 10:09:24 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     thierry.reding@gmail.com, Fabio Estevam <festevam@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/panel: simple: add SGD GKTW70SDAD1SD
Message-ID: <20210205090924.s7rsjebzvatgus5t@pengutronix.de>
References: <1612287314-5384-1-git-send-email-oliver.graute@gmail.com>
 <20210202175910.ycnf7ehk2i4u3f5o@pengutronix.de>
 <20210204181541.GA13054@portage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204181541.GA13054@portage>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:08:03 up 64 days, 23:14, 45 users,  load average: 0.08, 0.04,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-04 19:15, Oliver Graute wrote:
> On 02/02/21, Marco Felsch wrote:
> > Hi Oliver,
> > 
> > On 21-02-02 18:35, Oliver Graute wrote:
> > > Add support for the Solomon Goldentek Display Model: GKTW70SDAD1SD
> > > to panel-simple.
> > > 
> > > The panel spec from Variscite can be found at:
> > > https://www.variscite.com/wp-content/uploads/2017/12/VLCD-CAP-GLD-RGB.pdf
> > > 
> > > Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> > > Cc: Marco Felsch <m.felsch@pengutronix.de>
> > > Cc: Fabio Estevam <festevam@gmail.com>
> > > ---
> > > 
> > > v3:
> > > 
> > > - added flags
> > > - added delay
> > 
> > Thanks, did you test the changes?
> > I just picked it from the datasheet.
> 
> yes, it didn't break anything. 

Feel free to add my:

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

PS:
+1 for Fabio's comment ^^

Regards,
  Marco

> 
> Best regards,
> 
> Oliver
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
