Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A3348A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhCYHki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:40:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:10224 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCYHk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:40:28 -0400
IronPort-SDR: jD/w9dOSIi/ay5XLdyA54C0LGzwIHEKxem+/HcqFVwCdU/4MWQ81alAcEiM35E4yHi1gE0qF5J
 dxlSni8h+HRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170853601"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="170853601"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 00:40:28 -0700
IronPort-SDR: GVekWx7kPDY73STpZ3EHRlJnACOfhkvtLCeJcvZRgCxPFFcsFFTC1eVyiBioZgk6SPYrxstpGZ
 JTklhoQRxwww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="514505130"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 25 Mar 2021 00:40:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Mar 2021 09:40:22 +0200
Date:   Thu, 25 Mar 2021 09:40:22 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux@roeck-us.net, abhilash.k.v@intel.com, mrana@codeaurora.org,
        lee.jones@linaro.org, bberg@redhat.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] usb: typec: Fix a typo
Message-ID: <YFw+ZmzxT6DBOoMR@kuha.fi.intel.com>
References: <20210325051023.27914-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325051023.27914-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:40:23AM +0530, Bhaskar Chowdhury wrote:
> 
> s/Acknowlege/Acknowledge/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 244270755ae6..282c3c825c13 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -63,7 +63,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
>  	u16 error;
>  	int ret;
> 
> -	/* Acknowlege the command that failed */
> +	/* Acknowledge the command that failed */
>  	ret = ucsi_acknowledge_command(ucsi);
>  	if (ret)
>  		return ret;
> --
> 2.30.1

-- 
heikki
