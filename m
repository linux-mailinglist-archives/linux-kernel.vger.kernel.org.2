Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4259A40C05D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhIOHWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:22:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:45057 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231317AbhIOHWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:22:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="219059800"
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="219059800"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 00:21:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="610053032"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2021 00:21:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 15 Sep 2021 10:21:19 +0300
Date:   Wed, 15 Sep 2021 10:21:19 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: tipd: Add an additional overflow check
Message-ID: <YUGe71k7pHJMh95Y@kuha.fi.intel.com>
References: <20210914140235.65955-1-sven@svenpeter.dev>
 <20210914140235.65955-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914140235.65955-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:02:34PM +0200, Sven Peter wrote:
> tps6598x_block_read already checks for the maximum length of the read
> but tps6598x_block_write does not. Add the symmetric check there as
> well.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v1 -> v2:
>  - removed the WARN_ON to not crash machines running with panic-on-warn
>    as pointed out by greg k-h
> 
>  drivers/usb/typec/tipd/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index c18ec3785592..8c79ba17a157 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -139,6 +139,9 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
>  {
>  	u8 data[TPS_MAX_LEN + 1];
>  
> +	if (len + 1 > sizeof(data))
> +		return -EINVAL;
> +
>  	if (!tps->i2c_protocol)
>  		return regmap_raw_write(tps->regmap, reg, val, len);
>  
> -- 
> 2.25.1

thanks,

-- 
heikki
