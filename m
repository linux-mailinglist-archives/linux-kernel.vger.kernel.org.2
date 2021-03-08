Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5B93306ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 05:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhCHEjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 23:39:04 -0500
Received: from foss.arm.com ([217.140.110.172]:59226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234223AbhCHEim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 23:38:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75D69D6E;
        Sun,  7 Mar 2021 20:38:41 -0800 (PST)
Received: from bogus (unknown [10.57.15.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292CD3F73C;
        Sun,  7 Mar 2021 20:38:37 -0800 (PST)
Date:   Mon, 8 Mar 2021 04:38:30 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 01/37] firmware: arm_scmi: review protocol
 registration interface
Message-ID: <20210308043830.ln7nryxgnr3f4opj@bogus>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202221555.41167-2-cristian.marussi@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 10:15:19PM +0000, Cristian Marussi wrote:
> Extend common protocol registration routines and provide some new generic
> protocols get/put helpers that can track protocols usage and automatically
> perform the proper initialization and de-initialization on demand when
> required.
>
> Convert all standard protocols to use this new registration scheme while
> keeping them all still using the usual initialization logic bound to SCMI
> devices probing.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v2 --> v3
> - removed new Base protocol initialization, it will be re-introduced
>   later with all other protocols
> ---
>  drivers/firmware/arm_scmi/base.c    |   8 ++
>  drivers/firmware/arm_scmi/bus.c     |  61 ++++++++---
>  drivers/firmware/arm_scmi/clock.c   |  10 +-
>  drivers/firmware/arm_scmi/common.h  |  30 +++++-
>  drivers/firmware/arm_scmi/driver.c  | 159 +++++++++++++++++++++++++++-
>  drivers/firmware/arm_scmi/perf.c    |  10 +-
>  drivers/firmware/arm_scmi/power.c   |  10 +-
>  drivers/firmware/arm_scmi/reset.c   |  10 +-
>  drivers/firmware/arm_scmi/sensors.c |   8 +-
>  drivers/firmware/arm_scmi/system.c  |   8 +-
>  drivers/firmware/arm_scmi/voltage.c |   8 +-
>  include/linux/scmi_protocol.h       |   6 +-
>  12 files changed, 296 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> index 1377ec76a45d..044aa9e3ebb0 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -16,7 +16,7 @@
>  #include "common.h"
>
>  static DEFINE_IDA(scmi_bus_id);
> -static DEFINE_IDR(scmi_protocols);
> +static DEFINE_IDR(scmi_available_protocols);

[nit] Any particular reason for this name change ? Does it hold refer to
something different from before ? IIRC, this is list of registered protocols ?
Available might refer to the ones advertised to be present by the platform
firmware ?

>  static DEFINE_SPINLOCK(protocol_lock);
>
>  static const struct scmi_device_id *
> @@ -51,13 +51,29 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
>  	return 0;
>  }
>
> +const struct scmi_protocol *scmi_get_protocol(int protocol_id)
> +{
> +	const struct scmi_protocol *proto;
> +
> +	proto = idr_find(&scmi_available_protocols, protocol_id);
> +	if (!proto) {
> +		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
> +		return NULL;
> +	}
> +
> +	pr_debug("GOT SCMI Protocol 0x%x\n", protocol_id);
> +

[nit] For sake of consistency, s/GOT/Found/


[..]

> @@ -194,26 +210,45 @@ void scmi_set_handle(struct scmi_device *scmi_dev)
>  	scmi_dev->handle = scmi_handle_get(&scmi_dev->dev);
>  }
>
> -int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn)
> +int scmi_protocol_register(const struct scmi_protocol *proto)
>  {
>  	int ret;
>
> +	if (!proto) {
> +		pr_err("invalid protocol\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!proto->init && !proto->init_instance) {
> +		pr_err("missing .init() for protocol 0x%x\n", proto->id);


s/.init()/init as it can be init_instance too ?

> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 4645677d86f1..e8c84cff9922 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -2,7 +2,7 @@
>  /*
>   * System Control and Management Interface (SCMI) Clock Protocol
>   *
> - * Copyright (C) 2018 ARM Ltd.
> + * Copyright (C) 2018-2020 ARM Ltd.

2021 perhaps ? Few instances are not updated, I prefer to be consistent
across all modified scmi firmware driver files.


Other than these minor comments, the other changes looks good to me.

--
Regards,
Sudeep
