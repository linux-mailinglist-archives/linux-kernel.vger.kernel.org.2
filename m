Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6482387A07
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349661AbhERNd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349647AbhERNd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:33:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A13E610E9;
        Tue, 18 May 2021 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621344757;
        bh=WHo6QBmkSyx8hQ50l30tvg1a5wCD4yRDATz2V4Cn3FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dF8TbXGB95ifSseYQ5aDTk0edBB0shWvN6ILOIiau6TFcD0k7Xlv+CCAyRYPF6AJ6
         l3+XnHFQSQ17ZAIu1asOX5bPi6CTRrGP6arjuvBTUQdLsdByaF7vlzS2H++D6fNtHd
         6rQNFUyNTNLPvEWChV+tEsvJs5tX1Sl2RpVnOCS4=
Date:   Tue, 18 May 2021 15:32:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v1 1/2] usb: typec: tcpm: Expose tcpm logs through a misc
 device
Message-ID: <YKPB81XXSVTDqMJy@kroah.com>
References: <20210517233609.610248-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517233609.610248-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 04:36:08PM -0700, Badhri Jagan Sridharan wrote:
> Although TCPM logs were primarily focussed to aid developers
> during bringup, TCPM logs have proved to be critical even
> post-bringup as it provides a good starting point to triage
> interoperability issues with accessories. TCPM logs
> are exposed through debugfs filesystem. For systems that
> don't mount debugfs by default, this change introduces a
> module parameter log_misc_dev which when set exports the
> tcpm logs through a misc device. This change also leaves
> the option of exporting tcpm logs through debugfs for
> backwards compatibility.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 98 +++++++++++++++++++++++++----------
>  1 file changed, 72 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index c4fdc00a3bc8..b79194919b27 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -12,6 +12,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
> +#include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/power_supply.h>
> @@ -33,6 +34,10 @@
>  
>  #include <uapi/linux/sched/types.h>
>  
> +static bool modparam_log_misc_dev;
> +module_param_named(log_misc_dev, modparam_log_misc_dev, bool, 0444);
> +MODULE_PARM_DESC(log_misc_dev, "Expose tcpm logs through misc device");
> +
>  #define FOREACH_STATE(S)			\
>  	S(INVALID_STATE),			\
>  	S(TOGGLING),			\
> @@ -465,13 +470,15 @@ struct tcpm_port {
>  	 * SNK_READY for non-pd link.
>  	 */
>  	bool slow_charger_loop;
> -#ifdef CONFIG_DEBUG_FS
> +
>  	struct dentry *dentry;
>  	struct mutex logbuffer_lock;	/* log buffer access lock */
>  	int logbuffer_head;
>  	int logbuffer_tail;
>  	u8 *logbuffer[LOG_BUFFER_ENTRIES];
> -#endif
> +
> +	/* TCPM logs are exposed through misc device when modparam_log_misc_dev is set. */
> +	struct miscdevice misc;

From a technical point of view, this is not ok as now you have 2
different things controlling the lifecycle/lifespan of this structure,
making it impossible to audit and actually figure out what is happening
when.  Please do not do that.

greg k-h
