Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC29639D88C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFGJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:22:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:36156 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhFGJWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:22:12 -0400
IronPort-SDR: oqGam3Kis1j8g0gcDTRMb6xwoTFuVz771MdcQz+mGneCsCdCyLw5a3i1tpTfDuMq/GsZMrSUjS
 Rv6nm71e3Hdw==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="204610344"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="204610344"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:20:21 -0700
IronPort-SDR: z4C20yGvCTYUWBw0FSST4DuxuboqnJjtaHIEIzZAUosGdxQVwZg1AqwQuW1gWV8yFsxfTxYNJQ
 7NiU36d6CZyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="551816159"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jun 2021 02:20:18 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Jun 2021 12:20:17 +0300
Date:   Mon, 7 Jun 2021 12:20:17 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Do not finish VDM AMS for retrying
 Responses
Message-ID: <YL3k0aot51j3ntNY@kuha.fi.intel.com>
References: <20210606081452.764032-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606081452.764032-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 04:14:52PM +0800, Kyle Tso wrote:
> If the VDM responses couldn't be sent successfully, it doesn't need to
> finish the AMS until the retry count reaches the limit.
> 
> Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0db685d5d9c0..08fabe1fc31d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1965,6 +1965,9 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  			tcpm_log(port, "VDM Tx error, retry");
>  			port->vdm_retries++;
>  			port->vdm_state = VDM_STATE_READY;
> +			if (PD_VDO_SVDM(vdo_hdr) && PD_VDO_CMDT(vdo_hdr) == CMDT_INIT)
> +				tcpm_ams_finish(port);
> +		} else {
>  			tcpm_ams_finish(port);
>  		}
>  		break;
> -- 
> 2.32.0.rc1.229.g3e70b5a671-goog

-- 
heikki
