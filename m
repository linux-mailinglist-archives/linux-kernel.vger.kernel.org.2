Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9D447523
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhKGTJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:09:42 -0500
Received: from vps.xff.cz ([195.181.215.36]:41350 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhKGTJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1636311444; bh=wy8oGQ/IddhtpuNDv1H1qik8p/4msedKxLoUzVvtIP4=;
        h=Date:From:To:Subject:X-My-GPG-KeyId:References:From;
        b=oqFaWNSlHR1aVbQM9c1jy+nJb8eLvHo3CuYpIvlBCHpMK3Wa33pG0F4YRm4PG66Zs
         heNvziTOwtGUw9PO2wpD5fkhQQZZjNVxvoKg9hZl7zn3sV2I+0xYmcJaAK5EvcxDXo
         GzKuDSdtsDuXkpk0WaARiHR0HelWEHp3RxiSzdyM=
Date:   Sun, 7 Nov 2021 19:57:24 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/15] usb: typec: fusb302: Fix masking of comparator and
 bc_lvl interrupts
Message-ID: <20211107185724.ik6wthsl3e6qlbj3@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20211107185435.2540185-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107185435.2540185-1-megous@megous.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 07, 2021 at 07:54:33PM +0100, megous hlavni wrote:
> The masks are swapped (interrupts are enabled when the mask is 0).

Please ignore the 06/15 in the subject. This is just a single patch
from my local series and I forgot to edit the subject.

kind regards,
	o.

> This caused inability of the driver to recognize cable unplug events
> in host mode (where only comparator interrupt is generated, and VBUS
> interrupt is not).
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  drivers/usb/typec/tcpm/fusb302.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 7a2a17866a823..72f9001b07921 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -669,25 +669,27 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum typec_cc_status cc)
>  		ret = fusb302_i2c_mask_write(chip, FUSB_REG_MASK,
>  					     FUSB_REG_MASK_BC_LVL |
>  					     FUSB_REG_MASK_COMP_CHNG,
> -					     FUSB_REG_MASK_COMP_CHNG);
> +					     FUSB_REG_MASK_BC_LVL);
>  		if (ret < 0) {
>  			fusb302_log(chip, "cannot set SRC interrupt, ret=%d",
>  				    ret);
>  			goto done;
>  		}
>  		chip->intr_comp_chng = true;
> +		chip->intr_bc_lvl = false;
>  		break;
>  	case TYPEC_CC_RD:
>  		ret = fusb302_i2c_mask_write(chip, FUSB_REG_MASK,
>  					     FUSB_REG_MASK_BC_LVL |
>  					     FUSB_REG_MASK_COMP_CHNG,
> -					     FUSB_REG_MASK_BC_LVL);
> +					     FUSB_REG_MASK_COMP_CHNG);
>  		if (ret < 0) {
>  			fusb302_log(chip, "cannot set SRC interrupt, ret=%d",
>  				    ret);
>  			goto done;
>  		}
>  		chip->intr_bc_lvl = true;
> +		chip->intr_comp_chng = false;
>  		break;
>  	default:
>  		break;
> -- 
> 2.33.1
> 
