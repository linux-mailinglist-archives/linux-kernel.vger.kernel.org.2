Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576B53A07CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhFHXf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:35:28 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56497 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbhFHXf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:35:27 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 77F6E20002;
        Tue,  8 Jun 2021 23:33:27 +0000 (UTC)
Date:   Wed, 9 Jun 2021 01:33:26 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     slongerbeam@gmail.com, vitor.soares@synopsys.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        mparab@cadence.com, praneeth@ti.com
Subject: Re: [PATCH v10 6/7] i3c: master: sysfs key for acquire bus
Message-ID: <YL/+RvUEqniqcwRt@piout.net>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
 <1606717202-4206-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606717202-4206-1-git-send-email-pthombar@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2020 07:20:02+0100, Parshuram Thombare wrote:
> Added support to acquire I3C bus through sysfs interface.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  drivers/i3c/master.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index c01ba00..beb7495 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -581,6 +581,23 @@ static ssize_t i2c_scl_frequency_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(i2c_scl_frequency);
>  
> +static ssize_t i3c_acquire_bus_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct i3c_master_controller *master = dev_to_i3cmaster(dev);
> +	int ret;
> +
> +	i3c_bus_normaluse_lock(&master->bus);
> +	ret = i3c_master_acquire_bus(master);
> +	i3c_bus_normaluse_unlock(&master->bus);
> +	if (!ret)
> +		i3c_master_enable_mr_events(master);
> +
> +	return ret ?: count;
> +}
> +static DEVICE_ATTR_WO(i3c_acquire_bus);
> +

I'm wondering whether we should allow userspace to actually control
that. Shouldn't we simply request mastership when a driver needs to talk
to a device on the bus? Is it really useful to have that until there is
an i3c-dev userspace interface?

>  static struct attribute *i3c_masterdev_attrs[] = {
>  	&dev_attr_mode.attr,
>  	&dev_attr_current_master.attr,
> @@ -591,6 +608,7 @@ static ssize_t i2c_scl_frequency_show(struct device *dev,
>  	&dev_attr_pid.attr,
>  	&dev_attr_dynamic_address.attr,
>  	&dev_attr_hdrcap.attr,
> +	&dev_attr_i3c_acquire_bus.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(i3c_masterdev);
> -- 
> 1.7.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
