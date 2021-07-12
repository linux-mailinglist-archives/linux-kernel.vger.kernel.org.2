Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963443C60EC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhGLQ7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:59:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56160 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbhGLQ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:58:57 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC46FCC;
        Mon, 12 Jul 2021 18:56:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1626108968;
        bh=LnlGq5h8vhemkjb4YPOI1+jY+cg7vy+BSFWvwOxd3+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTWHk5c1ifR/hzOYihQbVOQ5lc1KjdKOCKfLJMxt+VSyA5LEJi2Q4Oiy5TXcUhqmf
         EuH/+uOYGXK7io9uxg2Tl4yiSoKvKNDx8xDrKt9bjUZNxxDw4qZfb1mm3wIzGQPBh6
         bu4N2z1zmAA6BNtRzUqhIEd3hddy6BBl7oWt70ps=
Date:   Mon, 12 Jul 2021 19:55:21 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, hdegoede@redhat.com,
        mgross@linux.intel.com, luzmaximilian@gmail.com,
        lgirdwood@gmail.com, andy.shevchenko@gmail.com,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <YOxz+b/giZTKoJkk@pendragon.ideasonboard.com>
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210709170426.GC4112@sirena.org.uk>
 <c95da883-581b-d1f4-4c8a-2162b8b58b64@gmail.com>
 <20210712141528.GE4435@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210712141528.GE4435@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Jul 12, 2021 at 03:15:28PM +0100, Mark Brown wrote:
> On Sat, Jul 10, 2021 at 11:48:33PM +0100, Daniel Scally wrote:
> 
> > I went with this approach because the ACPI isn't entirely lacking, it
> > enumerates the TPS68470 as an i2c device for its driver to bind to
> > without a problem which results in the regulator driver registering the
> > regulator devices (7 of them for this chip), so I was thinking along the
> > lines of repairing the problems with ACPI to give those rdevs the right
> > init_data rather than sidestepping it altogether. I could register the
> > platform devices for the regulator driver to bind to in a board file
> > instead if that's the preferred option...usually this would involve
> > using i2c_board_info I think but as ACPI will enumerate the i2c device
> > for the chip independently we'd need to handle that somehow to stop them
> > racing each other I guess.
> 
> Like I said elsewhere it seems a lot easier to just have the I2C driver
> set platform data based on parsing DMI information like we do elsewhere.
> I really don't see any benefit to introducing an additional layer of
> abstraction and binding here, it just seems to be making things more
> fragile.

The idea behind software nodes is that individual device drivers
shouldn't care about where platform-specific data come from. They can
use the same fwnode API, regardless of whether the device is described
through OF, ACPI, or software nodes created by a board file in the
kernel. It allows grouping all platform data that should be provided by
firmware in a single place, conditioned by a DMI match, instead of
distributing DMI matches to lots of drivers.

> I'm not sure what you mean by "register the platform devices for the
> regualtor to bind to" - if the PMIC is an I2C device it's going to need
> to be an I2C device, and if the device is enumerated by firmware we'd
> need to suppress that firmware enumeration to replace it.

We can't. ACPI describes the device, and that's how it's enumerated.
ACPI does provide information (as well as ACPI methods) needed by the
driver, but fails to provide all the required information. That's why a
mechanism to supplement the information provided by ACPI is needed.

> > I'll take a look and see if I can make it work that way.
> > 
> > >> I'm posting this to see if people agree it's a good approach for tackling the 
> > >> problem; I may be overthinking this and there's a much easier way that I should
> > > I don't think I understand what the problem you are trying to solve is
> > > so it's hard to say if this is a good approach to solving it.
> > 
> > Hope this is a bit clearer now?

-- 
Regards,

Laurent Pinchart
