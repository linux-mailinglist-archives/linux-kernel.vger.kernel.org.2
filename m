Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EFE38A13A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhETJ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:29:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:43472 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232033AbhETJ1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:27:51 -0400
IronPort-SDR: 0HmTuJ8TFfZz1rbDjf4oorW0Y1Q58IRBF5BrkjuSx9FZoqM5LqpDDOq8k4SjLNiGwSsIcDOS85
 5yYBdAtxN70g==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="200885253"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="200885253"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 02:26:29 -0700
IronPort-SDR: 9bZR5nKO4+gRPM6kklpXpvUL/ms8Pqa9X7zUO/Z/mmy/MpSdvyNgYYtgWoS48CmE267n1hvQUD
 7cHdSNPQNZ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543394127"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 20 May 2021 02:26:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 20 May 2021 12:26:25 +0300
Date:   Thu, 20 May 2021 12:26:25 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] usb: typec: wcove: Use LE to CPU conversion when
 accessing msg->header
Message-ID: <YKYrQXXk/X72iI+0@kuha.fi.intel.com>
References: <20210519085534.48732-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519085534.48732-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 11:55:34AM +0300, Andy Shevchenko wrote:
> As LKP noticed the Sparse is not happy about strict type handling:
>    .../typec/tcpm/wcove.c:380:50: sparse:     expected unsigned short [usertype] header
>    .../typec/tcpm/wcove.c:380:50: sparse:     got restricted __le16 const [usertype] header
> 
> Fix this by switching to use pd_header_cnt_le() instead of pd_header_cnt()
> in the affected code.
> 
> Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/wcove.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
> index 79ae63950050..5d125339687a 100644
> --- a/drivers/usb/typec/tcpm/wcove.c
> +++ b/drivers/usb/typec/tcpm/wcove.c
> @@ -378,7 +378,7 @@ static int wcove_pd_transmit(struct tcpc_dev *tcpc,
>  		const u8 *data = (void *)msg;
>  		int i;
>  
> -		for (i = 0; i < pd_header_cnt(msg->header) * 4 + 2; i++) {
> +		for (i = 0; i < pd_header_cnt_le(msg->header) * 4 + 2; i++) {
>  			ret = regmap_write(wcove->regmap, USBC_TX_DATA + i,
>  					   data[i]);
>  			if (ret)
> -- 
> 2.30.2

-- 
heikki
