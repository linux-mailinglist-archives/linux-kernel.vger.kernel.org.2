Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190993C7379
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhGMPqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:46:13 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38892 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhGMPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:46:12 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E20D3CC;
        Tue, 13 Jul 2021 17:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1626191001;
        bh=hfm6vRDfOQUbocixFyQhi0XyJKlYXS1HHyIL2PwFDr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4GbJ41p+kd82EC3Sz8XIpx7xo3Hvd6Q+n6mRndiSOKh1s+o/3uvkQAP68osTJwpS
         itlitfIjEPKf/5k0+Yg+ml551XjgCOJBabWXUG/f6Mh9cxQzDxaGgkF1UAazqsOdbh
         IefdHmR5APrBwVkDr/3I+bjr18zSbbEDsws2eElY=
Date:   Tue, 13 Jul 2021 18:42:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <YO20aXWkqLgwHkku@pendragon.ideasonboard.com>
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210709170426.GC4112@sirena.org.uk>
 <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210713152454.GC4098@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jul 13, 2021 at 04:24:54PM +0100, Mark Brown wrote:
> On Tue, Jul 13, 2021 at 12:32:26AM +0100, Daniel Scally wrote:
> 
> > I do think it can simplify driver code too; a lot of them aren't written
> > to parse platform data to get the init data, as they're just relying on
> > reading it from devicetree so in the event that we get more cases like
> > this, we need to modify those drivers to look for platform data too. On
> > the other hand, even the drivers that don't directly call
> > of_get_regulator_init_data() still do that lookup during the
> > regulator_of_get_init_data() call in regulator_register(), so the ones
> > that do parse platform data for init_data structs will check DT as part
> > of regulator_register() anyway. Imitating that seems simpler to me.
> 
> The driver code is trivial boilerplate, assuming someone doesn't go and
> implement a helper to register stuff separately like I suggested.  The
> proposed swnode stuff would involve duplicating the DT parsing code.
> This seems like a whole lot of effort for something that provides a
> worse result than either of the existing things.
> 
> > It also creates some problems to suppress the enumeration of the i2c
> > device via ACPI (which we'll have to do in a machine specific fashion,
> > because some laptops have this chip with properly configured ACPI and
> 
> To be clear I think that's a terrible idea.

If you're talking about the ACPI implementation on those machines,
nobody disagrees :-)

To make sure I understand you correctly, do you advocate for suppressing
registration of the I2C devices from ACPI and instantiate them from
board code instead, or to somehow supplement the I2C device with
board-specific data ?

> > > down to being another data table, I imagine you could write a helper for
> > > it, or probably even come up with some generic thing that let you
> > > register a platform data/DMI combo independently of the driver to get it
> > > out of the driver code (looking more like the existing GPIO code which
> > > is already being used in another bit of this quirking).
> 
> > The advantage of the GPIO lookups is there's no need to have the pointer
> > to the registered devices to register the lookup table; we could imitate
> > that, by adding entries to a list with the lookup values being device
> > and regulator name (with the init data as the thing that's "looked up")
> > and check for those during regulator_register() maybe?
> 
> Like I keep saying I think that's a much better approach than trying to
> use swnodes, they just seem like a terrible fit for the problem.

-- 
Regards,

Laurent Pinchart
