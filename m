Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF634005C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCRHmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:42:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:59838 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhCRHl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:41:59 -0400
IronPort-SDR: 7Twwqr3sOqbmWOEIi1A5as1GdBxI0ZFo7X7Ta6EbGZQ0q2aeypeVd+1SlfQpZzKF0pYkombHPD
 KvTqAZK+5A+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="186269621"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="186269621"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 00:41:58 -0700
IronPort-SDR: Wnxfl3+DqgPS6PDD17VM9VTB5jZx8NrejtZeowvbhM/pzPWlvqtV6uaq1itfLjoaqvClVI8mN2
 +DcUnJPji8Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="512016888"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 18 Mar 2021 00:41:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 18 Mar 2021 09:41:55 +0200
Date:   Thu, 18 Mar 2021 09:41:55 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpci: Added few missing TCPCI register
 definitions
Message-ID: <YFMEQ6WQf73d5uhU@kuha.fi.intel.com>
References: <20210316221304.391206-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316221304.391206-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 03:13:04PM -0700, Badhri Jagan Sridharan wrote:
> This change adds some of the register bit definitions from the TCPCI spec:
> https://www.usb.org/sites/default/files/documents/
> usb-port_controller_specification_rev2.0_v1.0_0.pdf
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index 57b6e24e0a0c..2be7a77d400e 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -47,7 +47,10 @@
>  
>  #define TCPC_TCPC_CTRL			0x19
>  #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
> +#define PLUG_ORNT_CC1			0
> +#define PLUG_ORNT_CC2			1
>  #define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
> +#define TCPC_TCPC_CTRL_EN_LK4CONN_ALRT	BIT(6)
>  
>  #define TCPC_EXTENDED_STATUS		0x20
>  #define TCPC_EXTENDED_STATUS_VSAFE0V	BIT(0)
> @@ -74,21 +77,28 @@
>  #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
>  #define TCPC_POWER_CTRL_BLEED_DISCHARGE	BIT(3)
>  #define TCPC_POWER_CTRL_AUTO_DISCHARGE	BIT(4)
> +#define TCPC_DIS_VOLT_ALRM		BIT(5)
> +#define TCPC_POWER_CTRL_VBUS_VOLT_MON	BIT(6)
>  #define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
>  
>  #define TCPC_CC_STATUS			0x1d
>  #define TCPC_CC_STATUS_TOGGLING		BIT(5)
>  #define TCPC_CC_STATUS_TERM		BIT(4)
> +#define TCPC_CC_STATUS_TERM_RP		0
> +#define TCPC_CC_STATUS_TERM_RD		1
> +#define TCPC_CC_STATE_SRC_OPEN		0
>  #define TCPC_CC_STATUS_CC2_SHIFT	2
>  #define TCPC_CC_STATUS_CC2_MASK		0x3
>  #define TCPC_CC_STATUS_CC1_SHIFT	0
>  #define TCPC_CC_STATUS_CC1_MASK		0x3
>  
>  #define TCPC_POWER_STATUS		0x1e
> +#define TCPC_POWER_STATUS_DBG_ACC_CON	BIT(7)
>  #define TCPC_POWER_STATUS_UNINIT	BIT(6)
>  #define TCPC_POWER_STATUS_SOURCING_VBUS	BIT(4)
>  #define TCPC_POWER_STATUS_VBUS_DET	BIT(3)
>  #define TCPC_POWER_STATUS_VBUS_PRES	BIT(2)
> +#define TCPC_POWER_STATUS_SINKING_VBUS	BIT(0)
>  
>  #define TCPC_FAULT_STATUS		0x1f
>  
> @@ -121,6 +131,10 @@
>  #define TCPC_RX_DETECT			0x2f
>  #define TCPC_RX_DETECT_HARD_RESET	BIT(5)
>  #define TCPC_RX_DETECT_SOP		BIT(0)
> +#define TCPC_RX_DETECT_SOP1		BIT(1)
> +#define TCPC_RX_DETECT_SOP2		BIT(2)
> +#define TCPC_RX_DETECT_DBG1		BIT(3)
> +#define TCPC_RX_DETECT_DBG2		BIT(4)
>  
>  #define TCPC_RX_BYTE_CNT		0x30
>  #define TCPC_RX_BUF_FRAME_TYPE		0x31
> @@ -139,6 +153,8 @@
>  #define TCPC_TX_DATA			0x54 /* through 0x6f */
>  
>  #define TCPC_VBUS_VOLTAGE			0x70
> +#define TCPC_VBUS_VOLTAGE_MASK			0x3ff
> +#define TCPC_VBUS_VOLTAGE_LSB_MV		25
>  #define TCPC_VBUS_SINK_DISCONNECT_THRESH	0x72
>  #define TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB_MV	25
>  #define TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX	0x3ff
> -- 
> 2.31.0.rc2.261.g7f71774620-goog

-- 
heikki
