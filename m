Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA113318CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCHUn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCHUn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:43:26 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56736C06174A;
        Mon,  8 Mar 2021 12:43:26 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 75B23E7B;
        Mon,  8 Mar 2021 21:43:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615236204;
        bh=eUIxsi6KUQOw5q47XWeSrdAkbyfhRraA71IbHa9KDhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJhlDVqUrAmPMxbo24TtmerInhAUXJLZaYnFraZ2XCkmvBAJATYIs9i1t1BE9Lk0k
         fb9L467HOf4vTHEbdlOR5LnBULflEuzWb+cU5MsFGvJI/kbFsptv1cpB+cHK4ddugF
         H2Sb8UI3Q2n057EJoJi1R2O9WUnyXMi/uzLNxvFE=
Date:   Mon, 8 Mar 2021 22:42:53 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "nikhil.nd@ti.com" <nikhil.nd@ti.com>,
        "kishon@ti.com" <kishon@ti.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for HDCP
Message-ID: <YEaMTbJ7Wx7otX2k@pendragon.ideasonboard.com>
References: <1614597685-4192-1-git-send-email-pthombar@cadence.com>
 <1614597746-4563-1-git-send-email-pthombar@cadence.com>
 <YD0LKg3Jl5nauMqF@pendragon.ideasonboard.com>
 <DM5PR07MB319661E8BFEB251CE17AF587C19A9@DM5PR07MB3196.namprd07.prod.outlook.com>
 <YD0WAMySrv53lxFR@pendragon.ideasonboard.com>
 <DM5PR07MB319628C858F667D9E5058904C1999@DM5PR07MB3196.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR07MB319628C858F667D9E5058904C1999@DM5PR07MB3196.namprd07.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parshuram,

On Tue, Mar 02, 2021 at 12:53:50PM +0000, Parshuram Raju Thombare wrote:
> Hi Laurent,
> 
> >>> Is this a property of the hardware, that is, are there multiple versions
> >>> of this IP core covered by the same compatible string that support HDCP
> >>> 1.4 only, DHCP 2.2 only or both ? Or is it a way to select what a given
> >>> system will offer ?[]
> >>
> >> MHDP hardware supports both HDCP 2.2 and 1.4. So, this is a way
> >> to select the version of HDCP, system wish to support.
> >
> > Then I'm not sure this qualifies as a DT property, which should describe
> > the system, not configure it. A way for userspace to configure this
> > would be better.
> 
> Since this is for source device, I am not sure how useful it is to allow
> user to change HDCP version supported. I think doing it in DTS
> gives more control over HDCP to system designer/integrator.

But how would they do so ? What would be the rationale for selecting a
particular version in DT ?

I'm not thinking about giving control of this parameter to the end-user,
but in the context of an embedded system, it may be useful to select
which HDCP versions to offer based on different constraints at runtime.
This really seems like a system configuration parameter to me, not a
system description.

-- 
Regards,

Laurent Pinchart
