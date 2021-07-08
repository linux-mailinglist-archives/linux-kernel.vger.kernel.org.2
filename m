Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE903C14F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhGHOSY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Jul 2021 10:18:24 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:60291 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGHOSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:18:23 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 37B69C46A2;
        Thu,  8 Jul 2021 14:13:58 +0000 (UTC)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DEEA2C000A;
        Thu,  8 Jul 2021 14:13:34 +0000 (UTC)
Date:   Thu, 8 Jul 2021 16:13:34 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: at91: fix count of periph clocks passed to
 pmc_data_allocate
Message-ID: <20210708161334.039d09fb@fixe.home>
In-Reply-To: <YMB8RYhCY4WVQXg+@piout.net>
References: <20210609080145.44226-1-clement.leger@bootlin.com>
        <YMB8RYhCY4WVQXg+@piout.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le Wed, 9 Jun 2021 10:31:01 +0200,
Alexandre Belloni <alexandre.belloni@bootlin.com> a écrit :

> hi,
> 
> Subject should have been:
> clk: at91: sama5d2: fix count of periph clocks passed to
> pmc_data_allocate
> 

This patch can actually be discarded since it won't fix allocation at
all but will just allocate more data than needed since nck already
returns the max .id field of the periph array.

> 
> 
> On 09/06/2021 10:01:44+0200, Clément Léger wrote:
> > When allocating clk_hw structure, only the periph32 clocks are
> > considered. Since sama5d2_periphck are also added to the phws there
> > is currently an out of bound write. Fix this by adding the count of
> > periphck to periph32ck.
> > 
> > Signed-off-by: Clément Léger <clement.leger@bootlin.com>  
> Fixes: a2038077de9a ("clk: at91: add sama5d2 PMC driver")
> 
> > ---
> >  drivers/clk/at91/sama5d2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> > index 3d1f78176c3e..663b73a032ee 100644
> > --- a/drivers/clk/at91/sama5d2.c
> > +++ b/drivers/clk/at91/sama5d2.c
> > @@ -170,7 +170,7 @@ static void __init sama5d2_pmc_setup(struct
> > device_node *np) 
> >  	sama5d2_pmc = pmc_data_allocate(PMC_AUDIOPLLCK + 1,
> >  					nck(sama5d2_systemck),
> > -					nck(sama5d2_periph32ck),
> > +					nck(sama5d2_periphck) +
> > nck(sama5d2_periph32ck), nck(sama5d2_gck), 3);
> >  	if (!sama5d2_pmc)
> >  		return;
> > -- 
> > 2.32.0
> >   
> 

