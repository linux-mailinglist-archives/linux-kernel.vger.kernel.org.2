Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA23144B253
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbhKISIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241601AbhKISIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:08:01 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3968CC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 10:05:14 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so28894599otv.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ea1Ygytm9WwNWrADrVVx1H/iSgIyMBYVyduVUUcPhQU=;
        b=KZhRPVnqzHRN14gHZ17on84P4rBej74U7m89/lI096r6Px6FPddR5WIJsZucIu/g+0
         tdZCsEed7OPJHb8k/cOsRd71L/l/O2llzqfOmWPcyDk9BDo9GM0PZ0Oc/ET9fuRm1ii3
         R+mHrxkfpcaYuq7N30HDf87BzXVLG6JnzG8cN+ERbdPMPTIMNnX6l/ndBAf51eXYshqK
         VwmyCK8pJuexxno+mych6YSamu5gdkWcBkdi2PHn+nwFjniEuo6d1Xmf8f+M1xXFdlKl
         oKuwDJvn5T1Q5H7PM6zaZPgbYgH1RJizUdhFJ9YSNMgXOzf4O8h8Oo7eNzc/jSzxB2HM
         uHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ea1Ygytm9WwNWrADrVVx1H/iSgIyMBYVyduVUUcPhQU=;
        b=bRo2gbbO7hzFDupfoRtwiFVD441ojiMD51KiZjlQthv9C9KrvZKwxwv9LNQMLYe/8+
         Hz0kmjm67j06F7V9A/U3cXYzNip6pgtpYn09wAPfFkIb2Q2FjNW/5qmsBBrNOSGD4vgQ
         SO1hlw0wsi+lARPze7l1rzy5pSgiRSEQk2JTPaADQ/2dvLovTSRNwUKhCnLog7EJqBAE
         xt1AJcnjwNncOnzmnnWLN3c6YV/nQClOiOsfFYlH2amuzCuOs6oVlSb1I/y0ogZMYbFL
         aY4Zsxqi/WoETReOZcGWhUJDdC6kH6dQv1oXkjobcS216qkKt/6B/UGoEoeR+otuZu20
         UbLw==
X-Gm-Message-State: AOAM532v2fW1ff3Io6vqAgPr/YMrZgaB3e8gJTzXwaycv3PJ0dGXGyqL
        V5wyL7ZGg+wpoqbdVzWfBMhufg==
X-Google-Smtp-Source: ABdhPJxjlvODNgwumNSc2TEiWv8cMyvWTVmX27GjcmJQixUhMYkmNF3+klhtuCCzLGge5WSCcs2orw==
X-Received: by 2002:a9d:2ab:: with SMTP id 40mr7869415otl.208.1636481113492;
        Tue, 09 Nov 2021 10:05:13 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d6sm2855945otb.4.2021.11.09.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 10:05:12 -0800 (PST)
Date:   Tue, 9 Nov 2021 10:06:46 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] rpmsg: add syslog driver
Message-ID: <YYq4tjyv0qh+Zpqe@ripper>
References: <20211109083926.32052-1-christian.gmeiner@gmail.com>
 <20211109083926.32052-2-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083926.32052-2-christian.gmeiner@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09 Nov 00:39 PST 2021, Christian Gmeiner wrote:

> Allows the remote firmware to log into syslog.
> 

This allows the remote firmware to print log messages in the kernel log,
not the syslog (although your system might inject the kernel log into
the syslog as well)

> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/rpmsg/Kconfig        |  8 +++++
>  drivers/rpmsg/Makefile       |  1 +
>  drivers/rpmsg/rpmsg_syslog.c | 65 ++++++++++++++++++++++++++++++++++++

drivers/rpmsg is for rpmsg bus and transport drivers. Client drivers
should live elsewhere.

But perhaps, rather than having a driver for this, you could simply use
rpmsg_char and a userspace tool; if you want to get the remote processor
logs into syslog, instead of the kernel log?

>  3 files changed, 74 insertions(+)
>  create mode 100644 drivers/rpmsg/rpmsg_syslog.c
> 
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index 0b4407abdf13..801f9956ec21 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -73,4 +73,12 @@ config RPMSG_VIRTIO
>  	select RPMSG_NS
>  	select VIRTIO
>  
> +config RPMSG_SYSLOG
> +	tristate "SYSLOG device interface"
> +	depends on RPMSG
> +	help
> +	  Say Y here to export rpmsg endpoints as device files, usually found
> +	  in /dev. They make it possible for user-space programs to send and
> +	  receive rpmsg packets.
> +
>  endmenu
> diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
> index 8d452656f0ee..75b2ec7133a5 100644
> --- a/drivers/rpmsg/Makefile
> +++ b/drivers/rpmsg/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
>  obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
>  obj-$(CONFIG_RPMSG_QCOM_SMD)	+= qcom_smd.o
>  obj-$(CONFIG_RPMSG_VIRTIO)	+= virtio_rpmsg_bus.o
> +obj-$(CONFIG_RPMSG_SYSLOG)	+= rpmsg_syslog.o
> diff --git a/drivers/rpmsg/rpmsg_syslog.c b/drivers/rpmsg/rpmsg_syslog.c
> new file mode 100644
> index 000000000000..b3fdae495fd9
> --- /dev/null
> +++ b/drivers/rpmsg/rpmsg_syslog.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/rpmsg.h>
> +
> +static int rpmsg_syslog_cb(struct rpmsg_device *rpdev, void *data, int len,
> +			   void *priv, u32 src)
> +{
> +	const char *buffer = data;
> +
> +	switch (buffer[0]) {
> +	case 'e':
> +		dev_err(&rpdev->dev, "%s", buffer + 1);
> +		break;
> +	case 'w':
> +		dev_warn(&rpdev->dev, "%s", buffer + 1);
> +		break;
> +	case 'i':
> +		dev_info(&rpdev->dev, "%s", buffer + 1);
> +		break;
> +	default:
> +		dev_info(&rpdev->dev, "%s", buffer);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rpmsg_syslog_probe(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_endpoint *syslog_ept;
> +	struct rpmsg_channel_info syslog_chinfo = {
> +		.src = 42,
> +		.dst = 42,
> +		.name = "syslog",
> +	};
> +
> +	/*
> +	 * Create the syslog service endpoint associated to the RPMsg
> +	 * device. The endpoint will be automatically destroyed when the RPMsg
> +	 * device will be deleted.
> +	 */
> +	syslog_ept = rpmsg_create_ept(rpdev, rpmsg_syslog_cb, NULL, syslog_chinfo);

The rpmsg_device_id below should cause the device to probe on the
presence of a "syslog" channel announcement, so why are you creating a
new endpoint with the same here?

Why aren't you just specifying the callback of the driver?

> +	if (!syslog_ept) {
> +		dev_err(&rpdev->dev, "failed to create the syslog ept\n");
> +		return -ENOMEM;
> +	}
> +	rpdev->ept = syslog_ept;
> +
> +	return 0;
> +}
> +
> +static struct rpmsg_device_id rpmsg_driver_syslog_id_table[] = {
> +	{ .name = "syslog" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(rpmsg, rpmsg_driver_syslog_id_table);
> +
> +static struct rpmsg_driver rpmsg_syslog_client = {
> +	.drv.name       = KBUILD_MODNAME,
> +	.id_table       = rpmsg_driver_syslog_id_table,
> +	.probe          = rpmsg_syslog_probe,
> +};
> +module_rpmsg_driver(rpmsg_syslog_client);

I would expect that building this as a module gives you complaints about
lacking MODULE_LICENSE().

Regards,
Bjorn

> -- 
> 2.33.1
> 
