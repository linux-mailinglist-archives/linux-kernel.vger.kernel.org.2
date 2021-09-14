Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459A740AAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhINJWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhINJWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:22:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C8FF60ED7;
        Tue, 14 Sep 2021 09:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631611279;
        bh=/o3FK+9c3o+eV9htHp9C/KhGX0C5wFlWSRnqjC+pM4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEniEjEba0EHFsv9Zaqu9GoOSQKkonmJRfmr2Hvl3F+MZcuDakX3R7HFNWbi428Kk
         sSyRojwn/yF131n7YARTqOd/KdmpayBzzH9arAqXr24hIWlIAZy93e5ehPwCpobTbd
         KYBhT6g7yCoVgzVkFArtKJDbpJe9ljSqEnN/Z/ZQ=
Date:   Tue, 14 Sep 2021 11:21:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronak Jain <ronak.jain@xilinx.com>
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        lakshmi.sai.krishna.potthuri@xilinx.com
Subject: Re: [PATCH v2 3/3] firmware: xilinx: Add sysfs support for feature
 config
Message-ID: <YUBpjUGaB3G72wRa@kroah.com>
References: <20210913083955.27146-1-ronak.jain@xilinx.com>
 <20210913083955.27146-4-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913083955.27146-4-ronak.jain@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:39:55AM -0700, Ronak Jain wrote:
> Add support for sysfs interface for runtime features configuration.
>  The user can configure the features at runtime. First the user need
>  to select the config id of the supported features and then the user
>  can configure the parameters of the feature based on the config id.
>  So far the support is added for the over temperature and external
>  watchdog features.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
> Changes in v2:
> - Update commit message
> ---
>  drivers/firmware/xilinx/zynqmp.c | 71 ++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 875d13bc1a57..a1434dd368f2 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1361,6 +1361,75 @@ static DEVICE_ATTR_RW(pggs1);
>  static DEVICE_ATTR_RW(pggs2);
>  static DEVICE_ATTR_RW(pggs3);
>  
> +static atomic_t feature_conf_id;

Why does this have to be an atomic?

And shouldn't this be per-device, not global to all devices in the
system?

> +
> +static ssize_t feature_config_id_show(struct device *device,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", atomic_read(&feature_conf_id));
> +}
> +
> +static ssize_t feature_config_id_store(struct device *device,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	u32 config_id;
> +	int ret;
> +
> +	if (!buf)
> +		return -EINVAL;

How can there ever be a NULL buffer?

No need to check for impossible things.

thanks,

greg k-h
