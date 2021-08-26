Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD5A3F89C6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhHZOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:08:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:51930 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHZOIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:08:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="197986110"
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="197986110"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 07:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="598493298"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 26 Aug 2021 07:06:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Aug 2021 17:06:40 +0300
Date:   Thu, 26 Aug 2021 17:06:40 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Fix spelling mistake "atleast" -> "at
 least"
Message-ID: <YSef8I5zsn6S5ebe@kuha.fi.intel.com>
References: <20210826123959.14838-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826123959.14838-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 01:39:59PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are spelling mistakes in a comment and a literal string.
> Fix them.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 049f4c61ee82..b981fc39fa3c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -278,7 +278,7 @@ struct pd_mode_data {
>   * @req_max_curr: Requested max current of the port partner
>   * @req_out_volt: Requested output voltage to the port partner
>   * @req_op_curr: Requested operating current to the port partner
> - * @supported: Parter has atleast one APDO hence supports PPS
> + * @supported: Parter has at least one APDO hence supports PPS
>   * @active: PPS mode is active
>   */
>  struct pd_pps_data {
> @@ -2050,7 +2050,7 @@ enum pdo_err {
>  
>  static const char * const pdo_err_msg[] = {
>  	[PDO_ERR_NO_VSAFE5V] =
> -	" err: source/sink caps should atleast have vSafe5V",
> +	" err: source/sink caps should at least have vSafe5V",
>  	[PDO_ERR_VSAFE5V_NOT_FIRST] =
>  	" err: vSafe5V Fixed Supply Object Shall always be the first object",
>  	[PDO_ERR_PDO_TYPE_NOT_IN_ORDER] =
> -- 
> 2.32.0

-- 
heikki
