Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D87E382961
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhEQKHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:07:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:41123 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236246AbhEQKFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:05:13 -0400
IronPort-SDR: g7c7I544wzJUeinwcoEhXBdffFgs6djehp3XZhUX0J4z/q1NHq5OZKUIdOHcRlSaFbzHL+FE1+
 J7LEtmI8qQZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="187553910"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="187553910"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 03:03:12 -0700
IronPort-SDR: kZNTTthMfvbbPPIVssJaJx+qwAK2hlN8SoTd0BTCz0R9wEVD0W1AcI6p2yq+b318rPp/4G9MbR
 bDfmv187Yz+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="540359445"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 May 2021 03:03:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 May 2021 13:03:09 +0300
Date:   Mon, 17 May 2021 13:03:09 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Berg <bberg@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Clear pending after acking connector
 change
Message-ID: <YKI/XT8qpZDjDuqs@kuha.fi.intel.com>
References: <20210516040953.622409-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516040953.622409-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 09:09:53PM -0700, Bjorn Andersson wrote:
> It's possible that the interrupt handler for the UCSI driver signals a
> connector changes after the handler clears the PENDING bit, but before
> it has sent the acknowledge request. The result is that the handler is
> invoked yet again, to ack the same connector change.
> 
> At least some versions of the Qualcomm UCSI firmware will not handle the
> second - "spurious" - acknowledgment gracefully. So make sure to not
> clear the pending flag until the change is acknowledged.
> 
> Any connector changes coming in after the acknowledgment, that would
> have the pending flag incorrectly cleared, would afaict be covered by
> the subsequent connector status check.
> 
> Fixes: 217504a05532 ("usb: typec: ucsi: Work around PPM losing change information")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I'm OK with this if Bejamin does not see any problems with it. I'll
wait for his comments before giving my reviewed-by tag.

That workaround (commit 217504a05532) is unfortunately too fragile.
I'm going to now separate the processing of the connector state from
the event handler (interrupt handler). That way we should be fairly
sure we don't loose any of the connector states even if an event is
generated while we are still in the middle of processing the previous
one(s), and at the same time be sure that we also don't confuse the
firmware.

So the event handler shall after that only read the connector status,
schedule the unique job where it's processed and ACK the event.
Nothing else.

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 282c3c825c13..f451ce0132a9 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -694,8 +694,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  	ucsi_send_command(con->ucsi, command, NULL, 0);
>  
>  	/* 3. ACK connector change */
> -	clear_bit(EVENT_PENDING, &ucsi->flags);
>  	ret = ucsi_acknowledge_connector_change(ucsi);
> +	clear_bit(EVENT_PENDING, &ucsi->flags);
>  	if (ret) {
>  		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
>  		goto out_unlock;
> -- 
> 2.29.2

thanks,

-- 
heikki
