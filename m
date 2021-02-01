Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A530A744
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhBAMJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:09:56 -0500
Received: from relay2.uni-heidelberg.de ([129.206.119.212]:12334 "EHLO
        relay2.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbhBAMJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:09:46 -0500
X-IPAS-Result: =?us-ascii?q?A2BOAAAA7xdg/1BqzoFiHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYMLa2eDekaRWY9gimcUgXMBAQEBAQEBAQEJLAECBAEBhkQCJTUID?=
 =?us-ascii?q?gIDAQEBAwIDAQEBAQYBAQEBAQYEhl+FdAEFIzAmEAsYAgImAgIUKCEThi2wS?=
 =?us-ascii?q?oEyiRmBISOBDioBjWMPgU0/hCo+hAkBEgGDOjSCLASCRoEPgQNtFYEbjy4Jp?=
 =?us-ascii?q?n+BWywHgWiBEYEdC5pGAg0igy+KPYU5j26XRp50gVgBgR5wMxokgzhQGQ2ca?=
 =?us-ascii?q?0MwAjUCBgoBAQMJWQEBizoBAQ?=
X-IronPort-Anti-Spam-Filtered: true
Received: from lemon.iwr.uni-heidelberg.de ([129.206.106.80])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2021 13:08:16 +0100
Received: from hlauer by lemon.iwr.uni-heidelberg.de with local (Exim 4.92)
        (envelope-from <hlauer@lemon.iwr.uni-heidelberg.de>)
        id 1l6Xzv-00045i-Ei; Mon, 01 Feb 2021 13:08:03 +0100
Date:   Mon, 1 Feb 2021 13:08:03 +0100
From:   Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-arm-kernel@lists.infradead.org, wens@csie.org,
        jernej.skrabec@siol.net, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v4] ARM: dts: sun7i: a20: bananapro: Fix ethernet
 phy-mode
Message-ID: <20210201120803.GF15207@lemon.iwr.uni-heidelberg.de>
References: <20210121170836.GA4948@lemon.iwr.uni-heidelberg.de>
 <20210128094040.GD11559@lemon.iwr.uni-heidelberg.de>
 <20210128111842.GA11919@lemon.iwr.uni-heidelberg.de>
 <20210128145937.vtdi4e2aih7milmt@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128145937.vtdi4e2aih7milmt@gilmour>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 03:59:37PM +0100, Maxime Ripard wrote:
> On Thu, Jan 28, 2021 at 12:18:42PM +0100, Hermann.Lauer@uni-heidelberg.de wrote:
> > BPi Pro needs TX and RX delay for Gbit to work reliable and avoid high
> > packet loss rates. The realtek phy driver overrides the settings of the
> > pull ups for the delays, so fix this for BananaPro.
> >     
> > Fix the phy-mode description to correctly reflect this so that the
> > implementation doesn't reconfigure the delays incorrectly. This
> > happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> > rx/tx delay config").
> > 
> > Fixes: 10662a33dcd9 ("ARM: dts: sun7i: Add dts file for Bananapro board")
> > Signed-off-by: Hermann Lauer <Hermann.Lauer@uni-heidelberg.de>
> 
> Applied since it's a fix simple enough, but please provide a changelog
> between versions.

v3 added the correct fixes tag, where the problem originated (initial commit
of banana pro device tree). That worked in the past until a change in
the phy device driver for realtek phy on banana pro overrode the
phyical configuration of the hardware pull-ups.

v4 added the commit which implemented that driver change (shamelessly stolen
from the commit of the fix of the identical problem on the banana pi)

Thanks,
 greetings
  Hermann

-- 
Administration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 205; 69120 Heidelberg; Tel: (06221)54-14405 Fax: -14427
Email: Hermann.Lauer@iwr.uni-heidelberg.de
