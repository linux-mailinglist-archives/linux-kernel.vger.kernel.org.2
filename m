Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0878438796C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbhERNCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:02:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:40590 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhERNCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:02:10 -0400
IronPort-SDR: FImeF/Y0H+Ff0yChdUEFQlecQmyMs2vVfLAOXvja33uM4ecUak6fB1/p0Xol/FhQVGAJrqo9B5
 sc5tTFfUlJzg==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="180980738"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="180980738"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 06:00:52 -0700
IronPort-SDR: qFzsLQeB4x4Mb8vs7yC9KZonpGaioDnVZuAEFIVLyaxK5QsuOCANMjRLtHkXvVA3dj6YsGelWt
 LCvksd8PlFvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="541957566"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 18 May 2021 06:00:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 18 May 2021 16:00:48 +0300
Date:   Tue, 18 May 2021 16:00:48 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v1 1/2] usb: typec: tcpm: Expose tcpm logs through a misc
 device
Message-ID: <YKO6gANJ0Meaavas@kuha.fi.intel.com>
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

This does not look correct to me. At the very least you need to now
document your misc device interface. Why are you removing the choice
whether to enable this or not? The module parameter does also not
sound like a good idea at all.

I'm really not sure about this. This is just a poor man's debugfs that
removes any choice of enabling it. Since clearly debugging related
information is what you are after here, debugfs really should be
enough for you.

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
>  };
>  
>  struct pd_rx_event {
> @@ -565,8 +572,6 @@ static bool tcpm_port_is_disconnected(struct tcpm_port *port)
>   * Logging
>   */
>  
> -#ifdef CONFIG_DEBUG_FS
> -
>  static bool tcpm_log_full(struct tcpm_port *port)
>  {
>  	return port->logbuffer_tail ==
> @@ -626,6 +631,9 @@ static void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
>  {
>  	va_list args;
>  
> +	if (!modparam_log_misc_dev && !IS_ENABLED(CONFIG_DEBUG_FS))
> +		return;
> +
>  	/* Do not log while disconnected and unattached */
>  	if (tcpm_port_is_disconnected(port) &&
>  	    (port->state == SRC_UNATTACHED || port->state == SNK_UNATTACHED ||
> @@ -642,6 +650,9 @@ static void tcpm_log_force(struct tcpm_port *port, const char *fmt, ...)
>  {
>  	va_list args;
>  
> +	if (!modparam_log_misc_dev && !IS_ENABLED(CONFIG_DEBUG_FS))
> +		return;
> +
>  	va_start(args, fmt);
>  	_tcpm_log(port, fmt, args);
>  	va_end(args);
> @@ -651,6 +662,9 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
>  {
>  	int i;
>  
> +	if (!modparam_log_misc_dev && !IS_ENABLED(CONFIG_DEBUG_FS))
> +		return;
> +
>  	for (i = 0; i < port->nr_source_caps; i++) {
>  		u32 pdo = port->source_caps[i];
>  		enum pd_pdo_type type = pdo_type(pdo);
> @@ -708,7 +722,7 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
>  	}
>  }
>  
> -static int tcpm_debug_show(struct seq_file *s, void *v)
> +static int tcpm_log_show(struct seq_file *s, void *v)
>  {
>  	struct tcpm_port *port = (struct tcpm_port *)s->private;
>  	int tail;
> @@ -725,23 +739,59 @@ static int tcpm_debug_show(struct seq_file *s, void *v)
>  
>  	return 0;
>  }
> -DEFINE_SHOW_ATTRIBUTE(tcpm_debug);
> +DEFINE_SHOW_ATTRIBUTE(tcpm_log);
>  
> -static void tcpm_debugfs_init(struct tcpm_port *port)
> +static int tcpm_log_dev_open(struct inode *inode, struct file *file)
> +{
> +	struct tcpm_port *port = container_of(file->private_data, struct tcpm_port, misc);
> +
> +	inode->i_private = port;
> +	file->private_data = NULL;
> +	return single_open(file, tcpm_log_show, inode->i_private);
> +}
> +
> +static const struct file_operations tcpm_log_dev_operations = {
> +	.owner = THIS_MODULE,
> +	.open = tcpm_log_dev_open,
> +	.read = seq_read,
> +	.release = single_release,
> +};
> +
> +static int tcpm_log_init(struct tcpm_port *port)
>  {
>  	char name[NAME_MAX];
> +	int ret;
> +
> +	if (!modparam_log_misc_dev && !IS_ENABLED(CONFIG_DEBUG_FS))
> +		return 0;
>  
>  	mutex_init(&port->logbuffer_lock);
>  	snprintf(name, NAME_MAX, "tcpm-%s", dev_name(port->dev));
> +	if (modparam_log_misc_dev) {
> +		port->misc.minor = MISC_DYNAMIC_MINOR;
> +		port->misc.name = name;
> +		port->misc.fops = &tcpm_log_dev_operations;
> +
> +		ret = misc_register(&port->misc);
> +		if (ret < 0)
> +			dev_err(port->dev, "error while doing misc_register ret=%d\n", ret);
> +		return ret;
> +	}
> +
>  	port->dentry = debugfs_create_dir(name, usb_debug_root);
>  	debugfs_create_file("log", S_IFREG | 0444, port->dentry, port,
> -			    &tcpm_debug_fops);
> +			    &tcpm_log_fops);
> +
> +	return 0;
>  }
>  
> -static void tcpm_debugfs_exit(struct tcpm_port *port)
> +static void tcpm_log_exit(struct tcpm_port *port)
>  {
>  	int i;
>  
> +	if (!modparam_log_misc_dev && !IS_ENABLED(CONFIG_DEBUG_FS))
> +		return;
> +
>  	mutex_lock(&port->logbuffer_lock);
>  	for (i = 0; i < LOG_BUFFER_ENTRIES; i++) {
>  		kfree(port->logbuffer[i]);
> @@ -749,21 +799,14 @@ static void tcpm_debugfs_exit(struct tcpm_port *port)
>  	}
>  	mutex_unlock(&port->logbuffer_lock);
>  
> +	if (modparam_log_misc_dev) {
> +		misc_deregister(&port->misc);
> +		return;
> +	}
> +
>  	debugfs_remove(port->dentry);
>  }
>  
> -#else
> -
> -__printf(2, 3)
> -static void tcpm_log(const struct tcpm_port *port, const char *fmt, ...) { }
> -__printf(2, 3)
> -static void tcpm_log_force(struct tcpm_port *port, const char *fmt, ...) { }
> -static void tcpm_log_source_caps(struct tcpm_port *port) { }
> -static void tcpm_debugfs_init(const struct tcpm_port *port) { }
> -static void tcpm_debugfs_exit(const struct tcpm_port *port) { }
> -
> -#endif
> -
>  static void tcpm_set_cc(struct tcpm_port *port, enum typec_cc_status cc)
>  {
>  	tcpm_log(port, "cc:=%d", cc);
> @@ -6135,11 +6178,13 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	init_completion(&port->tx_complete);
>  	init_completion(&port->swap_complete);
>  	init_completion(&port->pps_complete);
> -	tcpm_debugfs_init(port);
> +	err = tcpm_log_init(port);
> +	if (err < 0)
> +		goto out_destroy_wq;
>  
>  	err = tcpm_fw_get_caps(port, tcpc->fwnode);
>  	if (err < 0)
> -		goto out_destroy_wq;
> +		goto out_unreg_log;
>  
>  	port->try_role = port->typec_caps.prefer_role;
>  
> @@ -6157,7 +6202,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	port->role_sw = usb_role_switch_get(port->dev);
>  	if (IS_ERR(port->role_sw)) {
>  		err = PTR_ERR(port->role_sw);
> -		goto out_destroy_wq;
> +		goto out_unreg_log;
>  	}
>  
>  	err = devm_tcpm_psy_register(port);
> @@ -6184,8 +6229,9 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  
>  out_role_sw_put:
>  	usb_role_switch_put(port->role_sw);
> +out_unreg_log:
> +	tcpm_log_exit(port);
>  out_destroy_wq:
> -	tcpm_debugfs_exit(port);
>  	kthread_destroy_worker(port->wq);
>  	return ERR_PTR(err);
>  }
> @@ -6200,7 +6246,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
>  		typec_unregister_altmode(port->port_altmode[i]);
>  	typec_unregister_port(port->typec_port);
>  	usb_role_switch_put(port->role_sw);
> -	tcpm_debugfs_exit(port);
> +	tcpm_log_exit(port);
>  	kthread_destroy_worker(port->wq);
>  }
>  EXPORT_SYMBOL_GPL(tcpm_unregister_port);
> -- 
> 2.31.1.751.gd2f1c929bd-goog

-- 
heikki
