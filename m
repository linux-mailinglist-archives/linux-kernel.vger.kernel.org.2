Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6A3F7D42
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 22:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbhHYUl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 16:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhHYUlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 16:41:55 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120B6C061757;
        Wed, 25 Aug 2021 13:41:08 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 060D824F;
        Wed, 25 Aug 2021 22:41:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1629924065;
        bh=H1EdrY52ZkovQX2rp32ISCsBuUB4CKaTX2F6hJeT4lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fT5+2Us2Zo2Zf3bjBJh0ixlLn80fqIIGpoHrZwIOOp4TLjsR7S9gEoNnTSZvIZaeB
         gjM15bmSSGG+tLTS6sj6WdmT/S/8UWUhgQYOQnmLkm9n1dh2FPDXMh8YDHU9jqHZTj
         lrBPbr1vhv1z5NZ3NnHuAZLtYhthG3rKvreJRYkM=
Date:   Wed, 25 Aug 2021 23:40:53 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
Message-ID: <YSaq1R6kp6tYeRAJ@pendragon.ideasonboard.com>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <cc65098e-b459-b20a-f6e2-ee521fc20ca7@redhat.com>
 <20210825152735.GJ5186@sirena.org.uk>
 <YSZk5tyAxZoosXS3@pendragon.ideasonboard.com>
 <a5421695-803a-52fd-ea2e-edd9ef548892@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5421695-803a-52fd-ea2e-edd9ef548892@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Wed, Aug 25, 2021 at 10:25:23PM +0200, Hans de Goede wrote:
> On 8/25/21 5:42 PM, Laurent Pinchart wrote:
> > On Wed, Aug 25, 2021 at 04:27:35PM +0100, Mark Brown wrote:
> >> On Wed, Aug 25, 2021 at 04:48:15PM +0200, Hans de Goede wrote:
> >>
> >>> Daniel, I believe that what Mark wants here is something similar to what
> >>> we already do for the 5v boost converter regulator in the TI bq24190 charger
> >>> chip used on some Cherry Trail devices.
> >>
> >> Yeah, that or something like a generalized version of it which lets a
> >> separate quirk file like they seem to have register the data to insert -
> >> I'd be happy enough with the simple thing too given that it's not
> >> visible to anything, or with DMI quirks in the regulator driver too for
> >> that matter if it's just one or two platforms but there do seem to be
> >> rather a lot of these platforms which need quirks.
> > 
> > Let's also remember that we have to handle not just regulators, but also
> > GPIOs and clocks. And I'm pretty sure there will be more. We could have
> > a mechanism specific to the tps68470 driver to pass platform data from
> > the board file to the driver, and replicate that mechanism in different
> > drivers (for other regulators, clocks and GPIOs), but I really would
> > like to avoid splitting the DMI-conditioned platform data in those
> > drivers directly. I'd like to store all the init data for a given
> > platform in a single "board" file.
> 
> I agree, but so far all the handling for clks/gpios for IPU3 (+ IPU4 (*))
> laptops is done in the drivers/platform/x86/intel/int3472 code and the
> passing of platform_data with regulator init-data would also happen in
> the mfd-cell instantiation code living there. IOW if we just go with
> that then we will already have everything in one place. At least
> for the IPU3 case.

If the GPIOs are also hooked up to the TPS68470 and not to GPIOs of the
SoC, then I suppose that would be fine in this case.

Do you have any plan to work on IPU4 support ? ;-)

> *) IPU4 also used the INT3472 ACPI devices and what we have for discrete
> IO devices seems to match.

-- 
Regards,

Laurent Pinchart
