Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C637443165B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhJRKpp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Oct 2021 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhJRKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:45:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300EBC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:43:33 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mcQ73-0002kW-4N; Mon, 18 Oct 2021 12:43:25 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mcQ72-0006Cg-PW; Mon, 18 Oct 2021 12:43:24 +0200
Message-ID: <0b319e9a397d3c8299761a65393a69b0a45be22b.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] reset: mchp: sparx5: Extend support for lan966x
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     robh+dt@kernel.org, andrew@lunn.ch, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 18 Oct 2021 12:43:24 +0200
In-Reply-To: <20211014154000.jxnzeq6lnlkmnxzf@soft-dev3-1.localhost>
References: <20211013073807.2282230-1-horatiu.vultur@microchip.com>
         <20211013073807.2282230-3-horatiu.vultur@microchip.com>
         <8241fb1053df3583d9f4f0698907038c8f4ac769.camel@pengutronix.de>
         <20211014154000.jxnzeq6lnlkmnxzf@soft-dev3-1.localhost>
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

On Thu, 2021-10-14 at 17:40 +0200, Horatiu Vultur wrote:
> 
> > > +      */
> > > +     err = mchp_sparx5_map_syscon(pdev, "cuphy-syscon", &ctx->cuphy_ctrl);
> > > +     if (err && err != -ENODEV)
> > > +             return err;
> > 
> > So -ENODEV should return an error if .cuphy_reg is set?
> 
> I am not sure I follow this.
> If cuphy-syscon is not set then mchp_sparx5_map_syscon will return
> -ENODEV. This can be ignored for sparx5 as this is not required.
> If cuphy-syscon is set then if mchp_sparx5_map_syscon returns an error
> then report this error.

My point was that in case of cuphy-syscon missing from the DT, the
lan966x compatible reset controller should probably throw the error
instead of ignoring it. With v4 this is not relevant any more.

regards
Philipp
