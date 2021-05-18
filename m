Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7223879C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbhERNXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:23:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:19852 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239145AbhERNXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:23:00 -0400
IronPort-SDR: 23vcItRAxiDb891lccTU+SugZV76QngrXwMHEJX88s+uqJj1GNvyjyy2wOr4dxmNXtrb+Gh7H6
 zSieIi4+AfVg==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200757601"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200757601"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 06:21:41 -0700
IronPort-SDR: 4bGDGseiObzXiKwHJf1DPK6x64dFnfXh/xvr7Wy75qwv4McYR4hcfrNR98GPwPdnwByyK9uMbH
 YruVNPhhvHiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="541970157"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 18 May 2021 06:21:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 18 May 2021 16:21:37 +0300
Date:   Tue, 18 May 2021 16:21:37 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Berg <bberg@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Clear pending after acking connector
 change
Message-ID: <YKO/YWQTuctw8Dp/@kuha.fi.intel.com>
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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

-- 
heikki
