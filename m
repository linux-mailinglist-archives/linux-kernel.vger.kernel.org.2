Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE7541347D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhIUNlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:41:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:27587 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233096AbhIUNlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:41:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="308909930"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="308909930"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 06:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="613006988"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 21 Sep 2021 06:34:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Sep 2021 16:34:22 +0300
Date:   Tue, 21 Sep 2021 16:34:22 +0300
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
Subject: Re: [RFT PATCH 5/9] usb: typec: tipd: Allow to configure irq bits
Message-ID: <YUnfXkVHbgeqV9V2@kuha.fi.intel.com>
References: <20210918120934.28252-1-sven@svenpeter.dev>
 <20210918120934.28252-6-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918120934.28252-6-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 02:09:30PM +0200, Sven Peter wrote:
> The Apple variant of the TI TPS6598x chip uses different interrupt
> numbers. Prepare for that by allowing those to be configured depending
> on the compatible.

OK, so I think this justifies having a completely separate irq
handler for your board.

> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/usb/typec/tipd/core.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 4a6d66250fef..d191e7435018 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -80,6 +80,10 @@ static const char *const modes[] = {
>  struct tps6598x_hw {
>  	bool use_int1;
>  	bool use_int2;
> +	unsigned int irq_power_status_update;
> +	unsigned int irq_data_status_update;
> +	unsigned int irq_plug_event;
> +	void (*irq_trace)(u64 event1, u64 event2);
>  };

Then I believe you don't need any of that.


thanks,

-- 
heikki
