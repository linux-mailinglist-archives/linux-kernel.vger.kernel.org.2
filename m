Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629F33A67EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhFNNcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:32:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3232 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbhFNNcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:32:07 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3XBN2YHHz6G9K3;
        Mon, 14 Jun 2021 21:20:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 15:30:03 +0200
Received: from localhost (10.52.124.209) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 14:30:02 +0100
Date:   Mon, 14 Jun 2021 14:29:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <virtualization@lists.linux-foundation.org>,
        <virtio-dev@lists.oasis-open.org>, <sudeep.holla@arm.com>,
        <james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
        <etienne.carriere@linaro.org>, <vincent.guittot@linaro.org>,
        <souvik.chakravarty@arm.com>, <igor.skalkin@opensynergy.com>,
        <peter.hilber@opensynergy.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        <Vasyl.Vavrychuk@opensynergy.com>,
        <Andriy.Tryshnivskyy@opensynergy.com>
Subject: Re: [PATCH v4 03/16] firmware: arm_scmi: Add transport optional
 init/exit support
Message-ID: <20210614142956.000030f5@Huawei.com>
In-Reply-To: <20210611165937.701-4-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
        <20210611165937.701-4-cristian.marussi@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.209]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 17:59:24 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Some SCMI transport could need to perform some transport specific setup
> before they can be used by the SCMI core transport layer: typically this
> early setup consists in registering with some other kernel subsystem.
> 
> Add the optional capability for a transport to provide a couple of .init
> and .exit functions that are assured to be called early during the SCMI
> core initialization phase, well before the SCMI core probing step.
> 
> [ Peter: Adapted RFC patch by Cristian for submission to upstream. ]
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> [ Cristian: Fixed scmi_transports_exit point of invocation ]
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Drive by comment inline.  Feel free to ignore ;)

Jonathan

> ---
>  drivers/firmware/arm_scmi/common.h |  8 ++++
>  drivers/firmware/arm_scmi/driver.c | 59 ++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 7c2b9fd7e929..6bb734e0e3ac 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -321,6 +321,12 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
>  /**
>   * struct scmi_desc - Description of SoC integration
>   *
> + * @init: An optional function that a transport can provide to initialize some
> + *	  transport-specific setup during SCMI core initialization, so ahead of
> + *	  SCMI core probing.
> + * @exit: An optional function that a transport can provide to de-initialize
> + *	  some transport-specific setup during SCMI core de-initialization, so
> + *	  after SCMI core removal.
>   * @ops: Pointer to the transport specific ops structure
>   * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
>   * @max_msg: Maximum number of messages that can be pending
> @@ -328,6 +334,8 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
>   * @max_msg_size: Maximum size of data per message that can be handled.
>   */
>  struct scmi_desc {
> +	int (*init)(void);
> +	void (*exit)(void);
>  	const struct scmi_transport_ops *ops;
>  	int max_rx_timeout_ms;
>  	int max_msg;
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index f15d75af87ea..20f8f0581f3a 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -1594,10 +1594,67 @@ static struct platform_driver scmi_driver = {
>  	.remove = scmi_remove,
>  };
>  
> +/**
> + * __scmi_transports_setup  - Common helper to call transport-specific
> + * .init/.exit code if provided.
> + *
> + * @init: A flag to distinguish between init and exit.
> + *
> + * Note that, if provided, we invoke .init/.exit functions for all the
> + * transports currently compiled in.
> + *
> + * Return: 0 on Success.
> + */
> +static inline int __scmi_transports_setup(bool init)
> +{
> +	int ret = 0;
> +	const struct of_device_id *trans;
> +
> +	for (trans = scmi_of_match; trans->data; trans++) {
> +		const struct scmi_desc *tdesc = trans->data;
> +
> +		if ((init && !tdesc->init) || (!init && !tdesc->exit))
> +			continue;
> +
> +		pr_debug("SCMI %sInitializing %s transport\n",
> +			 init ? "" : "De-", trans->compatible);

Clever formatting can makes grepping for messages harder.

Perhaps
		if (init)
			pr_debug("SCMI Initializing %s transport\n",
				 trans->compatible);
		else
			pr_debug("SCMI Deinitializing %s transport\n",
				 trans->compatible);

would be nicer even though it burns some lines. Also avoids somewhat
ugly capitalization : De-Initializing xxx transport.

You could combine it with the convenient if(init) below

> +
> +		if (init)
> +			ret = tdesc->init();
> +		else
> +			tdesc->exit();
> +
> +		if (ret) {
> +			pr_err("SCMI transport %s FAILED initialization!\n",
> +			       trans->compatible);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int __init scmi_transports_init(void)
> +{
> +	return __scmi_transports_setup(true);
> +}
> +
> +static void __exit scmi_transports_exit(void)
> +{
> +	__scmi_transports_setup(false);
> +}
> +
>  static int __init scmi_driver_init(void)
>  {
> +	int ret;
> +
>  	scmi_bus_init();
>  
> +	/* Initialize any compiled-in transport which provided an init/exit */
> +	ret = scmi_transports_init();
> +	if (ret)
> +		return ret;
> +
>  	scmi_base_register();
>  
>  	scmi_clock_register();
> @@ -1626,6 +1683,8 @@ static void __exit scmi_driver_exit(void)
>  
>  	scmi_bus_exit();
>  
> +	scmi_transports_exit();
> +
>  	platform_driver_unregister(&scmi_driver);
>  }
>  module_exit(scmi_driver_exit);

