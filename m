Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9019F30A82A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhBAM5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:57:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:16603 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhBAM52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:57:28 -0500
IronPort-SDR: 3xYD5opazcBhMvMZ6SbBJ3UaLpMQ6Dhj7sKp9Zf3sr+SvqYJzbLPKn/VC2t7BHowH5H9WGTefq
 E3/7rbAvhPdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="160444627"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="160444627"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 04:55:42 -0800
IronPort-SDR: 3UsmtFbxj0oAnbcLa0/rYvgzjTkuLNPHRU96t6Z0hkhblKmousOB6nocmUebKww6X1lOwVi8h3
 LDzZa+fvCeJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="478950119"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Feb 2021 04:55:39 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 01 Feb 2021 14:55:39 +0200
Date:   Mon, 1 Feb 2021 14:55:39 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     enric.balletbo@collabora.com, pmalani@chromium.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@google.com
Subject: Re: [PATCH 6/6] platform/chrome: cros_ec_typec: Set opmode to PD on
 SOP connected
Message-ID: <20210201125539.GF2465@kuha.fi.intel.com>
References: <20210129061406.2680146-1-bleung@chromium.org>
 <20210129061406.2680146-7-bleung@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129061406.2680146-7-bleung@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:14:06PM -0800, Benson Leung wrote:
> When SOP Discovery is done, set the opmode to PD if status indicates
> SOP is connected.
> 
> SOP connected indicates a PD contract is in place, and is a solid
> indication we have transitioned to PD power negotiation, either as
> source or sink.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 6bc6fafd54a4..a7778258d0a0 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -900,6 +900,9 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>  			dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
>  		else
>  			typec->ports[port_num]->sop_disc_done = true;
> +
> +		if (resp.sop_connected)
> +			typec_set_pwr_opmode(typec->ports[port_num]->port, TYPEC_PWR_MODE_PD);
>  	}
>  
>  	if (resp.events & PD_STATUS_EVENT_SOP_PRIME_DISC_DONE &&
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
