Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2106033AD90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhCOIeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:34:08 -0400
Received: from foss.arm.com ([217.140.110.172]:52238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhCOIdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:33:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 016401FB;
        Mon, 15 Mar 2021 01:33:37 -0700 (PDT)
Received: from bogus (unknown [10.163.67.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AEE43F70D;
        Mon, 15 Mar 2021 01:33:33 -0700 (PDT)
Date:   Mon, 15 Mar 2021 08:33:27 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 37/37] firmware: arm_scmi: add dynamic scmi devices
 creation
Message-ID: <20210315083327.p6gculrdl3vlavhp@bogus>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-38-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202221555.41167-38-cristian.marussi@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

Sorry for the delay.

On Tue, Feb 02, 2021 at 10:15:55PM +0000, Cristian Marussi wrote:
> Having added the support for SCMI protocols as modules in order to let
> vendors extend the SCMI core with their own additions it seems odd to
> then force SCMI drivers built on top to use a static device table to
> declare their devices since this way any new SCMI drivers addition
> would need the core SCMI device table to be updated too.
>
> Remove the static core device table and let SCMI drivers to simply declare
> which device/protocol pair they need at initialization time: the core will
> then take care to generate such devices dynamically during platform
> initialization or at module loading time, as long as the requested
> underlying protocol is defined in the DT.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v4 --> v5
> - using klist instead of custom lists
> v3 --> v4
> - add a few comments
> ---
>  drivers/firmware/arm_scmi/bus.c    |  30 +++
>  drivers/firmware/arm_scmi/common.h |   5 +
>  drivers/firmware/arm_scmi/driver.c | 309 +++++++++++++++++++++++++----
>  3 files changed, 310 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> index 88e5057f4e85..88149a46e6d9 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -51,6 +51,31 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
>  	return 0;
>  }
>
> +static int scmi_match_by_id_table(struct device *dev, void *data)
> +{
> +	struct scmi_device *sdev = to_scmi_dev(dev);
> +	struct scmi_device_id *id_table = data;
> +
> +	return sdev->protocol_id == id_table->protocol_id &&
> +		!strcmp(sdev->name, id_table->name);
> +}
> +
> +struct scmi_device *scmi_find_child_dev(struct device *parent,
> +					int prot_id, const char *name)
> +{
> +	struct scmi_device_id id_table;
> +	struct device *dev;
> +
> +	id_table.protocol_id = prot_id;
> +	id_table.name = name;
> +
> +	dev = device_find_child(parent, &id_table, scmi_match_by_id_table);
> +	if (!dev)
> +		return NULL;
> +
> +	return to_scmi_dev(dev);
> +}
> +
>  const struct scmi_protocol *scmi_get_protocol(int protocol_id)
>  {
>  	const struct scmi_protocol *proto;
> @@ -114,6 +139,10 @@ int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
>  {
>  	int retval;
>
> +	retval = scmi_request_protocol_device(driver->id_table);
> +	if (retval)
> +		return retval;
> +
>  	driver->driver.bus = &scmi_bus_type;
>  	driver->driver.name = driver->name;
>  	driver->driver.owner = owner;
> @@ -130,6 +159,7 @@ EXPORT_SYMBOL_GPL(scmi_driver_register);
>  void scmi_driver_unregister(struct scmi_driver *driver)
>  {
>  	driver_unregister(&driver->driver);
> +	scmi_unrequest_protocol_device(driver->id_table);
>  }
>  EXPORT_SYMBOL_GPL(scmi_driver_unregister);
>
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 1e2046c61d43..9a0519db4865 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -307,6 +307,11 @@ struct scmi_transport_ops {
>  	bool (*poll_done)(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer);
>  };
>
> +int scmi_request_protocol_device(const struct scmi_device_id *id_table);
> +void scmi_unrequest_protocol_device(const struct scmi_device_id *id_table);

Sorry for being pedantic, I don't like these names. I would prefer
something like scmi_protocol_device_{create,destroy/delete}_request.
The action the function does needs to be at the end of the function name.
Atleast that is something I follow. I haven't checked all the previous
patches, just this function made to look at both the name style and the
name itself.


> +struct scmi_device *scmi_find_child_dev(struct device *parent,
> +					int prot_id, const char *name);
> +

scmi_child_dev_find based on what I mentioned above. Please change all
other non-static functions even if I have not mentioned. Try to cover
all the new functions introduced in this series, existing ones we can
take up later.

>  /**
>   * struct scmi_desc - Description of SoC integration
>   *
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index dcdfd94b47f7..9fc979e3b16f 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/ktime.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> @@ -56,6 +57,14 @@ static DEFINE_MUTEX(scmi_list_mutex);
>  /* Track the unique id for the transfers for debug & profiling purpose */
>  static atomic_t transfer_last_id;
>
> +static DEFINE_IDR(scmi_requested_devices);
> +static DEFINE_MUTEX(scmi_requested_devices_mtx);
> +
> +struct scmi_requested_dev {
> +	const struct scmi_device_id *id_table;
> +	struct list_head node;
> +};
> +
>  /**
>   * struct scmi_xfers_info - Structure to manage transfer information
>   *
> @@ -113,6 +122,8 @@ struct scmi_protocol_instance {
>   * @protocols_mtx: A mutex to protect protocols instances initialization.
>   * @protocols_imp: List of protocols implemented, currently maximum of
>   *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
> + * @active_protocols: IDR storing device_nodes for protocols actually defined
> + *		      in the DT and confirmed as implemented by fw.
>   * @notify_priv: Pointer to private data structure specific to notifications.
>   * @node: List head
>   * @users: Number of users of this instance
> @@ -130,6 +141,7 @@ struct scmi_info {
>  	/* Ensure mutual exclusive access to protocols instance array */
>  	struct mutex protocols_mtx;
>  	u8 *protocols_imp;
> +	struct idr active_protocols;
>  	void *notify_priv;
>  	struct list_head node;
>  	int users;
> @@ -936,6 +948,13 @@ static void scmi_devm_put_protocol(struct scmi_device *sdev, u8 protocol_id)
>  	WARN_ON(ret);
>  }
>
> +static inline
> +struct scmi_handle *scmi_handle_get_from_info(struct scmi_info *info)
> +{
> +	info->users++;

Doesn't it race with anything ? I have already forgotten how this is used
and in what context this gets called.

> +	return &info->handle;
> +}
> +
>  /**
>   * scmi_handle_get() - Get the SCMI handle for a device
>   *
> @@ -957,8 +976,7 @@ struct scmi_handle *scmi_handle_get(struct device *dev)
>  	list_for_each(p, &scmi_list) {
>  		info = list_entry(p, struct scmi_info, node);
>  		if (dev->parent == info->dev) {
> -			handle = &info->handle;
> -			info->users++;
> +			handle = scmi_handle_get_from_info(info);

Ah here it is. Any particular reasons for moving it to separate function ?

--
Regards,
Sudeep
