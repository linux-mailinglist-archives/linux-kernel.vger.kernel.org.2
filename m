Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1770841905A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhI0IFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 04:05:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:42913 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233273AbhI0IFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 04:05:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="204582783"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="204582783"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 01:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="615681714"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 27 Sep 2021 01:03:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 27 Sep 2021 11:03:35 +0300
Date:   Mon, 27 Sep 2021 11:03:35 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v2 4/6] usb: typec: tipd: Add support for Apple CD321X
Message-ID: <YVF616Ga8jf2tWYJ@kuha.fi.intel.com>
References: <20210923181321.3044-1-sven@svenpeter.dev>
 <20210923181321.3044-5-sven@svenpeter.dev>
 <YU3jtIvYOk/IHUWn@kuha.fi.intel.com>
 <41c29255-ba7b-4385-9637-0cef8ecb4be1@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c29255-ba7b-4385-9637-0cef8ecb4be1@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Fri, Sep 24, 2021 at 04:58:52PM +0200, Sven Peter wrote:
> > Couldn't you just use the compatible property and local variable here?
> >
> >         irq_handler_t irq_handler = tps6598x_interrupt;
> >         struct device_node *np = client->dev.of_node;
> >
> >         if (np && of_device_is_compatible(np, "apple,cd321x")) {
> >                 /* CD321X chips have all interrupts masked initially */
> >                 ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
> >                                         APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
> >                                         APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
> >                                         APPLE_CD_REG_INT_PLUG_EVENT);
> >                 if (ret)
> >                         return ret;
> >
> >                 irq_handler = cd321x_interrupt;
> >         }
> >
> > 	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> > 					irq_handler,
> > 					IRQF_SHARED | IRQF_ONESHOT,
> > 					dev_name(&client->dev), tps);
> >
> > I did not go over the whole series yet, so I may have missed
> > something.
> 
> Sure, that will work and get rid of the slightly awkward and redundant interrupt/enum
> combination. I'll wait for your comments for the rest of the series and do that for v3 then :)

The rest of the series look OK to me.

thanks,

-- 
heikki
