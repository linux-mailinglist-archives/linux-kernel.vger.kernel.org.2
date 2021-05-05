Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F7D3735E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 09:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhEEH4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 03:56:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:58067 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhEEH4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 03:56:47 -0400
IronPort-SDR: 52q8hMBxlRws8WsFsvqQ43CsS1DM4fQAf9qDezOJ1+f2jvBpK8oOcC10D82iM+PiY5rKL/L1sw
 +GvphFEWBTFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198211387"
X-IronPort-AV: E=Sophos;i="5.82,274,1613462400"; 
   d="scan'208";a="198211387"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 00:55:49 -0700
IronPort-SDR: JFW7fBU8pfn+6g7Q1t7I1JWmKO19KiQ0CvsLpBbOgPskBxlWiyQt82cn7FrdX5aGQ12E6KY1uc
 fs9lNPbFogOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,274,1613462400"; 
   d="scan'208";a="531619823"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 05 May 2021 00:55:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 05 May 2021 10:55:46 +0300
Date:   Wed, 5 May 2021 10:55:46 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Fix wrong handling in GET_SINK_CAP
Message-ID: <YJJPgiCDS59GzBRY@kuha.fi.intel.com>
References: <20210503171849.2605302-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503171849.2605302-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 01:18:49AM +0800, Kyle Tso wrote:
> After receiving Sink Capabilities Message in GET_SINK_CAP AMS, it is
> incorrect to call tcpm_pd_handle_state because the Message is expected
> and the current state is not Ready states. The result of this incorrect
> operation ends in Soft Reset which is definitely wrong. Simply
> forwarding to Ready States is enough to finish the AMS.
> 
> Fixes: 8dea75e11380 ("usb: typec: tcpm: Protocol Error handling")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index c4fdc00a3bc8..68e04e397e92 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2390,7 +2390,7 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>  		port->nr_sink_caps = cnt;
>  		port->sink_cap_done = true;
>  		if (port->ams == GET_SINK_CAPABILITIES)
> -			tcpm_pd_handle_state(port, ready_state(port), NONE_AMS, 0);
> +			tcpm_set_state(port, ready_state(port), 0);
>  		/* Unexpected Sink Capabilities */
>  		else
>  			tcpm_pd_handle_msg(port,
> -- 
> 2.31.1.527.g47e6f16901-goog

-- 
heikki
