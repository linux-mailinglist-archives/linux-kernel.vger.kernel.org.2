Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5A3F794E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbhHYPnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:43:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42458 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241121AbhHYPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:43:30 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6B18424F;
        Wed, 25 Aug 2021 17:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1629906162;
        bh=z+pGs7ptzS2pWN5a//5s422Ig5ykca/VKKLgcOkqcck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpLVDgUyv9p+Lvjvv4W3jq+s+YF5NoVGTMRTEAFR8Og9jXeyuVgvon699aTEJaokF
         K2ymO/VhXZYP0OPhh/UBw06ZdbF1S9lIeQ9tVvRbVqyjnOZVeY5zirFMySSE2/XiVq
         KqiF5WvtuLk5k3lzpgciLmUimBzgzS8tBKOg6RME=
Date:   Wed, 25 Aug 2021 18:42:30 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
Message-ID: <YSZk5tyAxZoosXS3@pendragon.ideasonboard.com>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <cc65098e-b459-b20a-f6e2-ee521fc20ca7@redhat.com>
 <20210825152735.GJ5186@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210825152735.GJ5186@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 04:27:35PM +0100, Mark Brown wrote:
> On Wed, Aug 25, 2021 at 04:48:15PM +0200, Hans de Goede wrote:
> 
> > Daniel, I believe that what Mark wants here is something similar to what
> > we already do for the 5v boost converter regulator in the TI bq24190 charger
> > chip used on some Cherry Trail devices.
> 
> Yeah, that or something like a generalized version of it which lets a
> separate quirk file like they seem to have register the data to insert -
> I'd be happy enough with the simple thing too given that it's not
> visible to anything, or with DMI quirks in the regulator driver too for
> that matter if it's just one or two platforms but there do seem to be
> rather a lot of these platforms which need quirks.

Let's also remember that we have to handle not just regulators, but also
GPIOs and clocks. And I'm pretty sure there will be more. We could have
a mechanism specific to the tps68470 driver to pass platform data from
the board file to the driver, and replicate that mechanism in different
drivers (for other regulators, clocks and GPIOs), but I really would
like to avoid splitting the DMI-conditioned platform data in those
drivers directly. I'd like to store all the init data for a given
platform in a single "board" file.

-- 
Regards,

Laurent Pinchart
