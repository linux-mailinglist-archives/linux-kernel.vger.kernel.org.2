Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888F7455C46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 14:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhKRNJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 08:09:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:46919 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230024AbhKRNIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:08:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="214210337"
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="214210337"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 05:05:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="646557254"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 18 Nov 2021 05:05:11 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 18 Nov 2021 15:05:10 +0200
Date:   Thu, 18 Nov 2021 15:05:10 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: tipd: Fix typo in
 cd321x_switch_power_state
Message-ID: <YZZPhsN2VqVtM8Yg@kuha.fi.intel.com>
References: <20211117151450.207168-1-marcan@marcan.st>
 <20211117151450.207168-2-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117151450.207168-2-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 12:14:49AM +0900, Hector Martin wrote:
> SPSS should've been SSPS.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index fb8ef12bbe9c..4da5a0b2aed2 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -653,7 +653,7 @@ static int cd321x_switch_power_state(struct tps6598x *tps, u8 target_state)
>  	if (state == target_state)
>  		return 0;
>  
> -	ret = tps6598x_exec_cmd(tps, "SPSS", sizeof(u8), &target_state, 0, NULL);
> +	ret = tps6598x_exec_cmd(tps, "SSPS", sizeof(u8), &target_state, 0, NULL);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.33.0

-- 
heikki
