Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7FE40C057
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhIOHVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:21:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:7618 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhIOHVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:21:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="201746275"
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="201746275"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 00:20:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="610052812"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2021 00:20:10 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 15 Sep 2021 10:20:09 +0300
Date:   Wed, 15 Sep 2021 10:20:09 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: typec: tipd: Don't read/write more bytes
 than required
Message-ID: <YUGeqXb00vgyPrsD@kuha.fi.intel.com>
References: <20210914140235.65955-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914140235.65955-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:02:33PM +0200, Sven Peter wrote:
> tps6598x_block_read/write always read 65 bytes of data even when much
> less is required when I2C_FUNC_I2C is used. Reduce this to the correct
> number.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> no changes for v2
> 
>  drivers/usb/typec/tipd/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 21b3ae25c76d..c18ec3785592 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -123,7 +123,7 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
>  	if (!tps->i2c_protocol)
>  		return regmap_raw_read(tps->regmap, reg, val, len);
>  
> -	ret = regmap_raw_read(tps->regmap, reg, data, sizeof(data));
> +	ret = regmap_raw_read(tps->regmap, reg, data, len + 1);
>  	if (ret)
>  		return ret;
>  
> @@ -145,7 +145,7 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
>  	data[0] = len;
>  	memcpy(&data[1], val, len);
>  
> -	return regmap_raw_write(tps->regmap, reg, data, sizeof(data));
> +	return regmap_raw_write(tps->regmap, reg, data, len + 1);
>  }
>  
>  static inline int tps6598x_read16(struct tps6598x *tps, u8 reg, u16 *val)
> -- 
> 2.25.1

thanks,

-- 
heikki
