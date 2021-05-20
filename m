Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E893738A21D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhETJiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:38:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:43441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232798AbhETJgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:36:10 -0400
IronPort-SDR: Esu2JEOBwudslraAcHnkOF9vHjC1L1/CKDGGZGU6Xi7wPejJ6GijnrvlWDp1ez2XQ/Q9Tt8Lw1
 DpBjHDXWxmTw==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="200885392"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="200885392"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 02:27:39 -0700
IronPort-SDR: +sUa9gM+/Z1y98mtmoOMZfbqht1iPHqMV+zajcgvCrVHikBZi210qjFXmJVsQgoFeqKsS9r5mL
 qnw74XFPfh3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543394301"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 20 May 2021 02:27:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 20 May 2021 12:27:36 +0300
Date:   Thu, 20 May 2021 12:27:36 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH v2 1/1] usb: typec: tcpm: Use LE to CPU conversion when
 accessing msg->header
Message-ID: <YKYriLzi0ylBrWL+@kuha.fi.intel.com>
References: <20210519100358.64018-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519100358.64018-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 01:03:58PM +0300, Andy Shevchenko wrote:
> Sparse is not happy about strict type handling:
>   .../typec/tcpm/tcpm.c:2720:27: warning: restricted __le16 degrades to integer
>   .../typec/tcpm/tcpm.c:2814:32: warning: restricted __le16 degrades to integer
> 
> Fix this by converting LE to CPU before use.
> 
> Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
> Fixes: 64f7c494a3c0 ("typec: tcpm: Add support for sink PPS related messages")
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2: fixed subject prefix
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 64133e586c64..8fdfd7f65ad7 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2717,7 +2717,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>  	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
>  	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
>  
> -	if (!(msg->ext_msg.header & PD_EXT_HDR_CHUNKED)) {
> +	if (!(le16_to_cpu(msg->ext_msg.header) & PD_EXT_HDR_CHUNKED)) {
>  		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
>  		tcpm_log(port, "Unchunked extended messages unsupported");
>  		return;
> @@ -2811,7 +2811,7 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
>  				 "Data role mismatch, initiating error recovery");
>  			tcpm_set_state(port, ERROR_RECOVERY, 0);
>  		} else {
> -			if (msg->header & PD_HEADER_EXT_HDR)
> +			if (le16_to_cpu(msg->header) & PD_HEADER_EXT_HDR)
>  				tcpm_pd_ext_msg_request(port, msg);
>  			else if (cnt)
>  				tcpm_pd_data_request(port, msg);
> -- 
> 2.30.2

-- 
heikki
