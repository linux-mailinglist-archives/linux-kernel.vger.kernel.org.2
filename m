Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A4D40C06B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbhIOHY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:24:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:45245 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236486AbhIOHYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:24:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="219060255"
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="219060255"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 00:23:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="610053522"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2021 00:23:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 15 Sep 2021 10:23:04 +0300
Date:   Wed, 15 Sep 2021 10:23:04 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: tipd: Remove WARN_ON in
 tps6598x_block_read
Message-ID: <YUGfWGLlH3q4hkVL@kuha.fi.intel.com>
References: <20210914140235.65955-1-sven@svenpeter.dev>
 <20210914140235.65955-3-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914140235.65955-3-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:02:35PM +0200, Sven Peter wrote:
> Calling tps6598x_block_read with a higher than allowed len can be
> handled by just returning an error. There's no need to crash systems
> with panic-on-warn enabled.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v1 -> v2:
>  - added this patch to also remove the WARN_ON in tps6598x_block_read
>    as suggested by greg k-h
> 
>  drivers/usb/typec/tipd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 8c79ba17a157..93e56291f0cf 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -117,7 +117,7 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
>  	u8 data[TPS_MAX_LEN + 1];
>  	int ret;
>  
> -	if (WARN_ON(len + 1 > sizeof(data)))
> +	if (len + 1 > sizeof(data))
>  		return -EINVAL;
>  
>  	if (!tps->i2c_protocol)
> -- 
> 2.25.1

thanks,

-- 
heikki
