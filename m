Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9328742233E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhJEKYa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Oct 2021 06:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhJEKY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:24:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BA9C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 03:22:34 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mXhac-00027b-W0; Tue, 05 Oct 2021 12:22:26 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mXhab-0006B5-TG; Tue, 05 Oct 2021 12:22:25 +0200
Message-ID: <6993ccdaf8f3f248f4ff1c739445e0f798ee0efa.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] reset: socfpga: add empty driver allowing consumers
 to probe
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     =?UTF-8?Q?Pawe=C5=82?= Anikiel <pan@semihalf.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        dinguyen@kernel.org
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tomasz Nowicki <tn@semihalf.com>,
        Konrad Adamczyk <ka@semihalf.com>,
        Jacek Majkowski <jam@semihalf.com>
Date:   Tue, 05 Oct 2021 12:22:25 +0200
In-Reply-To: <CAF9_jYQVpG8imn3zjAGKeZqZqDPtWRYWLQjNSXi2SXjjzAKvfA@mail.gmail.com>
References: <20210920124141.1166544-1-pan@semihalf.com>
         <20210920124141.1166544-4-pan@semihalf.com>
         <ce254cc123f2809976c2f2404941a9074c458309.camel@pengutronix.de>
         <CAF9_jYQVpG8imn3zjAGKeZqZqDPtWRYWLQjNSXi2SXjjzAKvfA@mail.gmail.com>
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

On Tue, 2021-10-05 at 13:12 +0200, Paweł Anikiel wrote:
> On Tue, Oct 5, 2021 at 11:34 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Hi Paweł,
> > 
> > On Mon, 2021-09-20 at 14:41 +0200, Paweł Anikiel wrote:
> > > The early reset driver doesn't ever probe, which causes consuming
> > > devices to be unable to probe. Add an empty driver to set this device
> > > as available, allowing consumers to probe.
> > > 
> > > Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> > > ---
> > >  drivers/reset/reset-socfpga.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > > 
> > > diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
> > > index 2a72f861f798..8c6492e5693c 100644
> > > --- a/drivers/reset/reset-socfpga.c
> > > +++ b/drivers/reset/reset-socfpga.c
> > > @@ -92,3 +92,29 @@ void __init socfpga_reset_init(void)
> > >       for_each_matching_node(np, socfpga_early_reset_dt_ids)
> > >               a10_reset_init(np);
> > >  }
> > > +
> > > +/*
> > > + * The early driver is problematic, because it doesn't register
> > > + * itself as a driver. This causes certain device links to prevent
> > > + * consumer devices from probing. The hacky solution is to register
> > > + * an empty driver, whose only job is to attach itself to the reset
> > > + * manager and call probe.
> > > + */
> > > +static const struct of_device_id socfpga_reset_dt_ids[] = {
> > > +     { .compatible = "altr,rst-mgr", },
> > > +     { /* sentinel */ },
> > > +};
> > > +
> > > +static int reset_simple_probe(struct platform_device *pdev)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +static struct platform_driver reset_socfpga_driver = {
> > > +     .probe  = reset_simple_probe,
> > > +     .driver = {
> > > +             .name           = "socfpga-reset",
> > > +             .of_match_table = socfpga_reset_dt_ids,
> > > +     },
> > > +};
> > > +builtin_platform_driver(reset_socfpga_driver);
> > 
> > If we can just let devlink delay all consumers until the empty driver is
> > probed, does the reset controller have to be registered early at all?
> > 
> > regards
> > Philipp
> 
> I asked Dinh if the reset controller code needs to be called early:
> 
> > That's correct. It's for one of the SP timers.

Ah, right, those call of_reset_control_get() from TIMER_OF_DECLARE().
Thank you, I'll apply this to reset/fixes.

regards
Philipp
