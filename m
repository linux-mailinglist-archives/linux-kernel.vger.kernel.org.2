Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D09037355D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 09:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhEEHKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 03:10:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:54759 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhEEHKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 03:10:10 -0400
IronPort-SDR: McIZGlyOuyYdhfyaFQiNoUzLYBg6oh2hgXzAih3vrhQ8Rm9IJlCcZkwPGLNktJxqe7XO0PcIhe
 /IfoGdtgkIkA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198205431"
X-IronPort-AV: E=Sophos;i="5.82,274,1613462400"; 
   d="scan'208";a="198205431"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 00:09:13 -0700
IronPort-SDR: 0BfBgwvYWuJttFEZtHkOLR6qKcxdi9n4cFiuDP3tXE3yKFScIjQ/xbgIWyuNO5Op0g1a7wGz6k
 6Szs5oEWvjXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,274,1613462400"; 
   d="scan'208";a="531604618"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 05 May 2021 00:09:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 05 May 2021 10:09:08 +0300
Date:   Wed, 5 May 2021 10:09:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] usb: typec: ucsi: Put fwnode in any case during
 ->probe()
Message-ID: <YJJElG8aneXeC/Ij@kuha.fi.intel.com>
References: <20210504222337.3151726-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504222337.3151726-1-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, May 05, 2021 at 01:23:37AM +0300, Andy Shevchenko wrote:
> device_for_each_child_node() bumps a reference counting of a returned variable.
> We have to balance it whenever we return to the caller.
> 
> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 282c3c825c13..0e1cec346e0f 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -999,6 +999,7 @@ static const struct typec_operations ucsi_ops = {
>  	.pr_set = ucsi_pr_swap
>  };
>  
> +/* Caller must call fwnode_handle_put() after use */
>  static struct fwnode_handle *ucsi_find_fwnode(struct ucsi_connector *con)
>  {
>  	struct fwnode_handle *fwnode;
> @@ -1033,7 +1034,7 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>  	command |= UCSI_CONNECTOR_NUMBER(con->num);
>  	ret = ucsi_send_command(ucsi, command, &con->cap, sizeof(con->cap));
>  	if (ret < 0)
> -		goto out;
> +		goto out_unlock;
>  
>  	if (con->cap.op_mode & UCSI_CONCAP_OPMODE_DRP)
>  		cap->data = TYPEC_PORT_DRD;
> @@ -1151,6 +1152,8 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>  	trace_ucsi_register_port(con->num, &con->status);
>  
>  out:
> +	fwnode_handle_put(cap->fwnode);
> +out_unlock:
>  	mutex_unlock(&con->lock);
>  	return ret;
>  }
> -- 
> 2.31.1

thanks,

-- 
heikki
