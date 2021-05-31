Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA43965D1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhEaQtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232586AbhEaO4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622472896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZkFKCD59O1km9dff9RKW75/5mn/A20J+nmsb6PZgEk=;
        b=gslPs33Tw1dlHs+iNO189spnWUVCZbFPYWL3sFe/In7xm8WN+IjEsNdtrachJdF8+HpoJk
        W27DBf6SngvTeTr6nA7DbrMYtxHuEQznjkHsvHznEAH8TnGyplDGtnT4D55fMAte4waJN5
        TsL5oBjW/PqP1efOdoCiI7hyrgXxqNc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-2gPCXGGcPJiPGkkQqHlAxQ-1; Mon, 31 May 2021 10:54:55 -0400
X-MC-Unique: 2gPCXGGcPJiPGkkQqHlAxQ-1
Received: by mail-ej1-f71.google.com with SMTP id am5-20020a1709065685b02903eef334e563so866014ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 07:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bZkFKCD59O1km9dff9RKW75/5mn/A20J+nmsb6PZgEk=;
        b=r4XmfGui5K0/sX2IG8rwVTBxNbPo5BGmlWzyrfDGQHS0lYQ94JTKhfefF4hICp/cwz
         E0KnrX5c5c/tZFvh/BV52+/IeqdqkayUSrs5p+7mI8eP4Bk1AF/zpBLyA+gCo/pzSAk0
         syxCn1CJAx43Xe8douHfyorko1IaWQC3yMPY4L6ljdeRcUDXs5iObAmU+mS2jdoi3W0L
         m6wpT4qI/qfzPTOG1+k/m/rrjGQcvkK61ihagfWb99j4Oab1DA04ZkBX3u8b6MfbbXVI
         r8CdGorXxot+++IiLkuI5xjTY3Wo5/Rpqz/8aRJcTGdF9iuIWE14/BeanGtsysuaHLhv
         f66w==
X-Gm-Message-State: AOAM531rqZO8D8HEZ5CSPDIGHBUc5VwBmvs670wk4mB5DYS/8r1yT7bu
        voJbVkhMQlRYoNEjesIefqfA38jhVi3p8HvE7/LMd12dkOa9gAJwHAJcbKmocduT9DoifFVRt17
        +rEcJjSdRnF6eiAT3gpPbXRqb
X-Received: by 2002:a50:a404:: with SMTP id u4mr26251469edb.112.1622472893968;
        Mon, 31 May 2021 07:54:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqHvAcQMUcWRuJ4XV5mK8k/uvJNlbNTAcpMZwGITv14/3vJ29M7RzFSMW+SIWTBo+xku847A==
X-Received: by 2002:a50:a404:: with SMTP id u4mr26251445edb.112.1622472893608;
        Mon, 31 May 2021 07:54:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i2sm6716586edc.96.2021.05.31.07.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 07:54:53 -0700 (PDT)
Subject: Re: [PATCH 1/1] ishtp: Add support for Intel ishtp eclite driver
To:     sumesh.k.naduvalath@intel.com, mgross@linux.intel.com,
        srinivas.pandruvada@linux.intel.com
Cc:     srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, ganapathi.chinnu@intel.com,
        nachiketa.kumar@intel.com
References: <20210531120415.14480-1-sumesh.k.naduvalath@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e28a9a7c-ec02-f71d-da6a-270f2dcbd58f@redhat.com>
Date:   Mon, 31 May 2021 16:54:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531120415.14480-1-sumesh.k.naduvalath@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you, I've done a quick review, which has already spotted quite
a few issues. Note I will probably do a more thorough review later
which mind find more issues, but lets start with fixing the serious
issues which this review has found.

I've a whole bunch of review remarks inline, please post a new
version fixing these.

On 5/31/21 2:04 PM, sumesh.k.naduvalath@intel.com wrote:
> From: "K Naduvalath, Sumesh" <sumesh.k.naduvalath@intel.com>
> 
> This driver is for accessing the PSE(Programmable Service Engine), an

Put a space between "PSE" and the '(' please.

> Embedded Controller like IP, using ISHTP(Integratd Sensor Hub Transport

Put a space between "ISHTP" and the '(' please. Also replace "Integratd"
with "Integrated"

> Protocol) to get battery, thermal and UCSI(USB Type-C Connector System

Put a space between "UCSI" and the '(' please.

> Software Interface) related data from the platform.
> 
> Signed-off-by: K Naduvalath, Sumesh <sumesh.k.naduvalath@intel.com>
> Reviewed-by: Mark Gross <mgross@linux.inel.com>

There is a typo in the email address of Mark, please correct this.

> ---
>  MAINTAINERS                               |   6 +
>  drivers/platform/x86/Kconfig              |  13 +
>  drivers/platform/x86/Makefile             |   1 +
>  drivers/platform/x86/intel_ishtp_eclite.c | 664 ++++++++++++++++++++++
>  4 files changed, 684 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 503fd21901f1..cf32033cb754 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9242,6 +9242,12 @@ F:	Documentation/admin-guide/media/ipu3_rcb.svg
>  F:	Documentation/userspace-api/media/v4l/pixfmt-meta-intel-ipu3.rst
>  F:	drivers/staging/media/ipu3/
>  
> +INTEL ISHTP ECLITE DRIVER
> +M:	Sumesh K Naduvalath <sumesh.k.naduvalath@intel.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Supported
> +F:	drivers/platform/x86/intel_ishtp_eclite.c
> +
>  INTEL IXP4XX QMGR, NPE, ETHERNET and HSS SUPPORT
>  M:	Krzysztof Halasa <khalasa@piap.pl>
>  S:	Maintained
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 60592fb88e7a..cfa2cb150909 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1180,6 +1180,19 @@ config INTEL_CHTDC_TI_PWRBTN
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called intel_chtdc_ti_pwrbtn.
>  
> +config INTEL_ISHTP_ECLITE
> +	tristate "Intel ISHTP eclite controller"
> +	depends on INTEL_ISH_HID
> +	depends on ACPI
> +	help
> +	  This driver is for accessing the PSE(Programmable Service Engine),
> +	  an Embedded Controller like IP, using ISHTP(Integratd Sensor Hub
> +	  Transport Protocol) to get battery, thermal and UCSI (USB Type-C
> +          Connector System Software Interface) related data from the platform.

This text has all the same issues as the commit message. Also please explain
on what sort of systems this functionality is typically found/used so that
users will have a better idea if this is something which they should enable
on their systems.

> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called intel_ishtp_eclite
> +
>  config INTEL_MRFLD_PWRBTN
>  	tristate "Intel Merrifield Basin Cove power button driver"
>  	depends on INTEL_SOC_PMIC_MRFLD
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index dcc8cdb95b4d..72ef4761b762 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
>  obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
>  obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
>  obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
> +obj-$(CONFIG_INTEL_ISHTP_ECLITE)	+= intel_ishtp_eclite.o
>  
>  # MSI
>  obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
> diff --git a/drivers/platform/x86/intel_ishtp_eclite.c b/drivers/platform/x86/intel_ishtp_eclite.c
> new file mode 100644
> index 000000000000..2956d678a420
> --- /dev/null
> +++ b/drivers/platform/x86/intel_ishtp_eclite.c
> @@ -0,0 +1,664 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Intel ECLite opregion driver for talking to ECLite firmware running on
> + * Intel Integrated Sensor Hub (ISH) using ISH Transport Protocol (ISHTP)
> + *
> + * Copyright (c) 2021, Intel Corporation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/intel-ish-client-if.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/suspend.h>
> +#include <linux/types.h>
> +#include <linux/uuid.h>
> +#include <linux/uaccess.h>
> +
> +#define ECLITE_DATA_OPREGION_ID	0x9E
> +#define ECLITE_CMD_OPREGION_ID	0x9F
> +
> +#define ECL_MSG_DATA	0x1
> +#define ECL_MSG_EVENT	0x2
> +
> +#define ECL_ISH_READ	0x1
> +#define ECL_ISH_WRITE	0x2
> +#define ECL_ISH_HEADER_VERSION	0
> +
> +#define ECL_CL_RX_RING_SIZE	16
> +#define ECL_CL_TX_RING_SIZE	8
> +
> +#define ECL_DATA_OPR_BUFLEN	384
> +#define ECL_EVENTS_NOTIFY	333
> +
> +#define cmd_opr_offsetof(element)	offsetof(struct opregion_cmd, element)
> +#define cl_data_to_dev(opr_dev)	ishtp_device((opr_dev)->cl_device)
> +
> +#ifndef BITS_TO_BYTES
> +#define BITS_TO_BYTES(x) ((x) / 8)
> +#endif
> +
> +struct opregion_cmd {
> +	unsigned int command;
> +	unsigned int offset;
> +	unsigned int length;
> +	unsigned int event_id;
> +};
> +
> +struct opregion_data {
> +	char data[ECL_DATA_OPR_BUFLEN];
> +};
> +
> +struct opregion_context {
> +	struct opregion_cmd cmd_area;
> +	struct opregion_data data_area;
> +};
> +
> +struct ecl_message_header {
> +	unsigned int version:2;
> +	unsigned int data_type:2;
> +	unsigned int request_type:2;
> +	unsigned int offset:9;
> +	unsigned int data_len:9;
> +	unsigned int event:8;
> +};
> +
> +struct ecl_message {
> +	struct ecl_message_header header;
> +	char payload[ECL_DATA_OPR_BUFLEN];
> +};
> +
> +struct ishtp_opregion_dev {
> +	struct opregion_context opr_context;
> +	struct ishtp_cl *ecl_ishtp_cl;
> +	struct ishtp_cl_device *cl_device;
> +	struct ishtp_fw_client *fw_client;
> +	struct ishtp_cl_rb *rb;
> +	struct acpi_handle *acpi_handle;
> +	unsigned int dsm_event_id;
> +	unsigned int ish_link_ready;
> +	unsigned int ish_read_done;
> +	unsigned int acpi_init_done;
> +	wait_queue_head_t read_wait;
> +	struct work_struct event_work;
> +	struct work_struct reset_work;
> +};
> +
> +/* eclite ishtp client UUID: 6a19cc4b-d760-4de3-b14d-f25ebd0fbcd9 */
> +static const guid_t ecl_ishtp_guid =
> +	GUID_INIT(0x6a19cc4b, 0xd760, 0x4de3,
> +		  0xb1, 0x4d, 0xf2, 0x5e, 0xbd, 0xf, 0xbc, 0xd9);
> +
> +/* ACPI DSM UUID: 91d936a7-1f01-49c6-a6b4-72f00ad8d8a5 */
> +static const guid_t ecl_acpi_guid =
> +	GUID_INIT(0x91d936a7, 0x1f01, 0x49c6, 0xa6,
> +		  0xb4, 0x72, 0xf0, 0x0a, 0xd8, 0xd8, 0xa5);
> +
> +/**
> + * ecl_ish_cl_read() - Read data from eclite FW
> + *
> + * @opr_dev:  pointer to opregion device
> + *
> + * This function issues a read request to eclite FW and waits until it
> + * receives a response. When response is received the read data is copied to
> + * opregion buffer.
> + */
> +static int ecl_ish_cl_read(struct ishtp_opregion_dev *opr_dev)
> +{
> +	struct ecl_message_header header;
> +	int len, rv;
> +
> +	if (!opr_dev->ish_link_ready)
> +		return -EIO;
> +
> +	header.version = ECL_ISH_HEADER_VERSION;
> +	header.data_type = ECL_MSG_DATA;
> +	header.request_type = ECL_ISH_READ;
> +	header.offset = opr_dev->opr_context.cmd_area.offset;
> +	header.data_len = opr_dev->opr_context.cmd_area.length;

You should check here that offset + data_len does not exceed
ECL_DATA_OPR_BUFLEN.

> +	header.event = opr_dev->opr_context.cmd_area.event_id;
> +	len = sizeof(header);
> +
> +	opr_dev->ish_read_done = false;
> +	rv = ishtp_cl_send(opr_dev->ecl_ishtp_cl, (uint8_t *)&header, len);
> +	if (rv) {
> +		dev_err(cl_data_to_dev(opr_dev), "ish-read : send failed\n");
> +		return -EIO;
> +	}
> +
> +	dev_dbg(cl_data_to_dev(opr_dev),
> +		"[ish_rd] Req: off : %x, len : %x\n",
> +		header.offset,
> +		header.data_len);
> +
> +	rv = wait_event_interruptible_timeout(opr_dev->read_wait,
> +					      opr_dev->ish_read_done,
> +					      2 * HZ);
> +	if (!rv) {
> +		dev_err(cl_data_to_dev(opr_dev),
> +			"[ish_rd] No response from firmware\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ecl_ish_cl_write() - This function writes data to eclite FW.
> + *
> + * @opr_dev:  pointer to opregion device
> + *
> + * This function writes data to eclite FW.
> + */
> +static int ecl_ish_cl_write(struct ishtp_opregion_dev *opr_dev)
> +{
> +	struct ecl_message message;
> +	int len;
> +
> +	if (!opr_dev->ish_link_ready)
> +		return -EIO;
> +
> +	message.header.version = ECL_ISH_HEADER_VERSION;
> +	message.header.data_type = ECL_MSG_DATA;
> +	message.header.request_type = ECL_ISH_WRITE;
> +	message.header.offset = opr_dev->opr_context.cmd_area.offset;
> +	message.header.data_len = opr_dev->opr_context.cmd_area.length;
> +	message.header.event = opr_dev->opr_context.cmd_area.event_id;
> +	len = sizeof(struct ecl_message_header) + message.header.data_len;
> +

You should check here that offset + data_len does not exceed ECL_DATA_OPR_BUFLEN,
before doing the memcpy.

> +	memcpy(message.payload,
> +	       opr_dev->opr_context.data_area.data + message.header.offset,
> +	       message.header.data_len);
> +
> +	dev_dbg(cl_data_to_dev(opr_dev),
> +		"[ish_wr] off : %x, len : %x\n",
> +		message.header.offset,
> +		message.header.data_len);
> +
> +	return ishtp_cl_send(opr_dev->ecl_ishtp_cl, (uint8_t *)&message, len);
> +}
> +
> +static acpi_status
> +ecl_opregion_cmd_handler(u32 function, acpi_physical_address address,
> +			 u32 bits, u64 *value64,
> +			 void *handler_context, void *region_context)
> +{
> +	struct ishtp_opregion_dev *opr_dev;
> +	struct opregion_cmd *cmd;
> +
> +	if (!region_context || !value64)
> +		return AE_BAD_PARAMETER;
> +
> +	if (function == ACPI_READ)
> +		return AE_ERROR;
> +
> +	opr_dev = (struct ishtp_opregion_dev *)region_context;
> +	cmd = &opr_dev->opr_context.cmd_area;

This is shared between all threads, we have had issues with
sharing opregion context between threads like this in the past.

What is stopping ACPI code from trying to use the opr_context
from multiple threads at the same time, messing things up?

I'm especially worried about the offset + data_len used in
various places, even if we add checks for this, this could
be changed underneath us by another thread.

You should add a mutex to the opr_dev and lock it in this
function so that the cmd struct cannot be changed underneath
us while we are processing it.

Note this does not fully protect against races like this:

1. Thread a sets offset
2. Thread b sets a different offset
3. Thread a writes ECL_ISH_READ to command.

This will result in thread a getting the data at the offset
specified by thread b, rather then at the offset which it
requested. But there is nothing we can do about that, that needs
to be solved with synchronization at the AML level.





> +
> +	switch (address) {
> +	case cmd_opr_offsetof(command):
> +		cmd->command = (u32)*value64;
> +
> +		if (cmd->command == ECL_ISH_READ)
> +			return ecl_ish_cl_read(opr_dev);
> +		else if (cmd->command == ECL_ISH_WRITE)
> +			return ecl_ish_cl_write(opr_dev);
> +
> +		return AE_ERROR;
> +
> +	case cmd_opr_offsetof(offset):
> +		cmd->offset = (u32)*value64;
> +		break;
> +	case cmd_opr_offsetof(length):
> +		cmd->length = (u32)*value64;
> +		break;
> +	case cmd_opr_offsetof(event_id):
> +		cmd->event_id = (u32)*value64;
> +		break;
> +	default:
> +		return AE_ERROR;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +static acpi_status
> +ecl_opregion_data_handler(u32 function, acpi_physical_address address,
> +			  u32 bits, u64 *value64,
> +			  void *handler_context, void *region_context)
> +{
> +	struct ishtp_opregion_dev *opr_dev;
> +	unsigned int bytes = BITS_TO_BYTES(bits);
> +	void *data_addr;
> +
> +	if (!region_context || !value64)
> +		return AE_BAD_PARAMETER;
> +
> +	if (address + bytes > ECL_DATA_OPR_BUFLEN)
> +		return AE_BAD_PARAMETER;
> +
> +	opr_dev = (struct ishtp_opregion_dev *)region_context;
> +	data_addr = &opr_dev->opr_context.data_area.data[address];
> +
> +	if (function == ACPI_READ)
> +		memcpy(value64, data_addr, bytes);
> +	else if (function == ACPI_WRITE)
> +		memcpy(data_addr, value64, bytes);

What if bits is not a multiple of 8? Then we have just overwritten
a bunch of bits which the caller did not request us to do.

Since the caller specifies bits, this should really do a read-modify-write
of the last byte when there are any "leftover" bits. ?  What does the
documentation say about this?

> +	else
> +		return AE_BAD_PARAMETER;
> +
> +	return AE_OK;
> +}
> +
> +static int acpi_opregion_init(struct ishtp_opregion_dev *opr_dev)
> +{
> +	acpi_status status;
> +	struct acpi_device *adev;
> +
> +	/* Find ECLite device and install opregion handlers */
> +	adev = acpi_dev_get_first_match_dev("INTC1035", NULL, -1);
> +	if (!adev) {
> +		dev_err(cl_data_to_dev(opr_dev), "eclite ACPI device not found\n");
> +		return -ENODEV;
> +	}
> +
> +	opr_dev->acpi_handle = adev->handle;

acpi_opregion_init() seem to get called on every resume, doing the
lookup is only necessary once, after that the cached value in opr_dev->acpi_handle
can be reused.

More importantly this whole dance of unregistering + re-registering the
opregion seems unnecessary. You already have ish_link_ready in case the
opregion gets called before things are ready; and if the opregion is called
when the link is not ready, still having the opregion handler in place
allows you to log a sensible error about what is going on which is what
we want.

> +	acpi_dev_put(adev);
> +
> +	status = acpi_install_address_space_handler(opr_dev->acpi_handle,
> +						    ECLITE_CMD_OPREGION_ID,
> +						    ecl_opregion_cmd_handler,
> +						    NULL, opr_dev);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(cl_data_to_dev(opr_dev),
> +			"cmd space handler install failed\n");
> +		return -ENODEV;
> +	}
> +
> +	status = acpi_install_address_space_handler(opr_dev->acpi_handle,
> +						    ECLITE_DATA_OPREGION_ID,
> +						    ecl_opregion_data_handler,
> +						    NULL, opr_dev);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(cl_data_to_dev(opr_dev),
> +			"data space handler install failed\n");
> +
> +		acpi_remove_address_space_handler(opr_dev->acpi_handle,
> +						  ECLITE_CMD_OPREGION_ID,
> +						  ecl_opregion_cmd_handler);
> +		return -ENODEV;
> +	}
> +	opr_dev->acpi_init_done = true;
> +
> +	dev_dbg(cl_data_to_dev(opr_dev), "Opregion handlers are installed\n");
> +
> +	return 0;
> +}
> +
> +static void acpi_opregion_deinit(struct ishtp_opregion_dev *opr_dev)
> +{
> +	acpi_remove_address_space_handler(opr_dev->acpi_handle,
> +					  ECLITE_CMD_OPREGION_ID,
> +					  ecl_opregion_cmd_handler);
> +
> +	acpi_remove_address_space_handler(opr_dev->acpi_handle,
> +					  ECLITE_DATA_OPREGION_ID,
> +					  ecl_opregion_data_handler);
> +	opr_dev->acpi_init_done = false;
> +}
> +
> +static void ecl_acpi_invoke_dsm(struct work_struct *work)
> +{
> +	struct ishtp_opregion_dev *opr_dev;
> +	union acpi_object *obj;
> +
> +	opr_dev = container_of(work, struct ishtp_opregion_dev, event_work);
> +	if (!opr_dev->acpi_init_done)

This should probably be replaced by ish_link_ready and you should probably
log an error when this happens.

> +		return;
> +
> +	obj = acpi_evaluate_dsm(opr_dev->acpi_handle, &ecl_acpi_guid, 0,
> +				opr_dev->dsm_event_id, NULL);
> +	if (!obj) {
> +		dev_warn(cl_data_to_dev(opr_dev), "_DSM fn call failed\n");
> +		return;
> +	}
> +
> +	dev_dbg(cl_data_to_dev(opr_dev), "Exec DSM function code: %d success\n",
> +		opr_dev->dsm_event_id);
> +
> +	ACPI_FREE(obj);
> +}
> +
> +static void ecl_ish_process_rx_data(struct ishtp_opregion_dev *opr_dev)
> +{
> +	struct ecl_message *message =
> +		(struct ecl_message *)opr_dev->rb->buffer.data;
> +
> +	dev_dbg(cl_data_to_dev(opr_dev),
> +		"[ish_rd] Resp: off : %x, len : %x\n",
> +		message->header.offset,
> +		message->header.data_len);
> +

You should check here that offset + data_len does not exceed ECL_DATA_OPR_BUFLEN,
before doing the memcpy.

> +	memcpy(opr_dev->opr_context.data_area.data + message->header.offset,
> +	       message->payload, message->header.data_len);
> +
> +	opr_dev->ish_read_done = true;
> +	wake_up_interruptible(&opr_dev->read_wait);
> +}
> +
> +static void ecl_ish_process_rx_event(struct ishtp_opregion_dev *opr_dev)
> +{
> +	struct ecl_message_header *header =
> +		(struct ecl_message_header *)opr_dev->rb->buffer.data;
> +
> +	dev_dbg(cl_data_to_dev(opr_dev),
> +		"[ish_ev] Evt received: %8x\n", header->event);
> +
> +	opr_dev->dsm_event_id = header->event;
> +	schedule_work(&opr_dev->event_work);
> +}
> +
> +static int ecl_ish_cl_enable_events(struct ishtp_opregion_dev *opr_dev,
> +				    bool config_enable)
> +{
> +	struct ecl_message message;
> +	int len;
> +
> +	message.header.version = ECL_ISH_HEADER_VERSION;
> +	message.header.data_type = ECL_MSG_DATA;
> +	message.header.request_type = ECL_ISH_WRITE;
> +	message.header.offset = ECL_EVENTS_NOTIFY;
> +	message.header.data_len = 1;
> +	message.payload[0] = config_enable;
> +
> +	len = sizeof(struct ecl_message_header) + message.header.data_len;
> +
> +	return ishtp_cl_send(opr_dev->ecl_ishtp_cl, (uint8_t *)&message, len);
> +}
> +
> +static void ecl_ishtp_cl_event_cb(struct ishtp_cl_device *cl_device)
> +{
> +	struct ishtp_cl *ecl_ishtp_cl = ishtp_get_drvdata(cl_device);
> +	struct ishtp_opregion_dev *opr_dev;
> +	struct ecl_message_header *header;
> +	struct ishtp_cl_rb *rb;
> +
> +	opr_dev = ishtp_get_client_data(ecl_ishtp_cl);
> +	while ((rb = ishtp_cl_rx_get_rb(opr_dev->ecl_ishtp_cl)) != NULL) {
> +		opr_dev->rb = rb;
> +		header = (struct ecl_message_header *)rb->buffer.data;
> +
> +		if (header->data_type == ECL_MSG_DATA)
> +			ecl_ish_process_rx_data(opr_dev);
> +		else if (header->data_type == ECL_MSG_EVENT)
> +			ecl_ish_process_rx_event(opr_dev);
> +		else
> +			/* got an event with wrong data_type, ignore it */
> +			dev_err(cl_data_to_dev(opr_dev),
> +				"[ish_cb] Received wrong data_type\n");
> +
> +		ishtp_cl_io_rb_recycle(rb);
> +	}
> +}
> +
> +static int ecl_ishtp_cl_init(struct ishtp_cl *ecl_ishtp_cl)
> +{
> +	struct ishtp_opregion_dev *opr_dev =
> +		ishtp_get_client_data(ecl_ishtp_cl);
> +	struct ishtp_fw_client *fw_client;
> +	struct ishtp_device *dev;
> +	int rv;
> +
> +	rv = ishtp_cl_link(ecl_ishtp_cl);
> +	if (rv) {
> +		dev_err(cl_data_to_dev(opr_dev), "ishtp_cl_link failed\n");
> +		return	rv;
> +	}
> +
> +	dev = ishtp_get_ishtp_device(ecl_ishtp_cl);
> +
> +	/* Connect to FW client */
> +	ishtp_set_tx_ring_size(ecl_ishtp_cl, ECL_CL_TX_RING_SIZE);
> +	ishtp_set_rx_ring_size(ecl_ishtp_cl, ECL_CL_RX_RING_SIZE);
> +
> +	fw_client = ishtp_fw_cl_get_client(dev, &ecl_ishtp_guid);
> +	if (!fw_client) {
> +		dev_err(cl_data_to_dev(opr_dev), "fw client not found\n");
> +		return -ENOENT;
> +	}
> +
> +	ishtp_cl_set_fw_client_id(ecl_ishtp_cl,
> +				  ishtp_get_fw_client_id(fw_client));
> +
> +	ishtp_set_connection_state(ecl_ishtp_cl, ISHTP_CL_CONNECTING);
> +
> +	rv = ishtp_cl_connect(ecl_ishtp_cl);
> +	if (rv) {
> +		dev_err(cl_data_to_dev(opr_dev), "client connect failed\n");
> +
> +		ishtp_cl_unlink(ecl_ishtp_cl);
> +		return rv;
> +	}
> +
> +	dev_dbg(cl_data_to_dev(opr_dev), "Host connected to fw client\n");
> +
> +	return 0;
> +}
> +
> +static void ecl_ishtp_cl_deinit(struct ishtp_cl *ecl_ishtp_cl)
> +{
> +	ishtp_cl_unlink(ecl_ishtp_cl);
> +	ishtp_cl_flush_queues(ecl_ishtp_cl);
> +	ishtp_cl_free(ecl_ishtp_cl);
> +}
> +
> +static void ecl_ishtp_cl_reset_handler(struct work_struct *work)
> +{
> +	struct ishtp_opregion_dev *opr_dev;
> +	struct ishtp_cl_device *cl_device;
> +	struct ishtp_cl *ecl_ishtp_cl;
> +	int rv;
> +	int retry;
> +
> +	opr_dev = container_of(work, struct ishtp_opregion_dev, reset_work);
> +
> +	opr_dev->ish_link_ready = false;
> +
> +	cl_device = opr_dev->cl_device;
> +	ecl_ishtp_cl = opr_dev->ecl_ishtp_cl;
> +
> +	ecl_ishtp_cl_deinit(ecl_ishtp_cl);
> +
> +	ecl_ishtp_cl = ishtp_cl_allocate(cl_device);
> +	if (!ecl_ishtp_cl)
> +		return;

Is this whole freeing + re-alloc of the ISHTP client here
really necessary ? This seems like overkill.

> +
> +	ishtp_set_drvdata(cl_device, ecl_ishtp_cl);
> +	ishtp_set_client_data(ecl_ishtp_cl, opr_dev);
> +
> +	opr_dev->ecl_ishtp_cl = ecl_ishtp_cl;
> +
> +	for (retry = 0; retry < 3; ++retry) {
> +		rv = ecl_ishtp_cl_init(ecl_ishtp_cl);
> +		if (!rv)
> +			break;
> +	}
> +	if (rv) {
> +		ishtp_cl_free(ecl_ishtp_cl);
> +		opr_dev->ecl_ishtp_cl = NULL;
> +		dev_err(cl_data_to_dev(opr_dev),
> +			"[ish_rst] Reset failed. Link not ready.\n");
> +		return;
> +	}
> +
> +	ishtp_register_event_cb(cl_device, ecl_ishtp_cl_event_cb);
> +	dev_info(cl_data_to_dev(opr_dev),
> +		 "[ish_rst] Reset Success. Link ready.\n");
> +
> +	opr_dev->ish_link_ready = true;
> +
> +	if (opr_dev->acpi_init_done)
> +		return;
> +
> +	rv = acpi_opregion_init(opr_dev);
> +	if (rv) {
> +		dev_err(cl_data_to_dev(opr_dev),
> +			"ACPI opregion init failed\n");
> +	}
> +}
> +
> +static int ecl_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
> +{
> +	struct ishtp_cl *ecl_ishtp_cl;
> +	struct ishtp_opregion_dev *opr_dev;
> +	int rv;
> +
> +	opr_dev = devm_kzalloc(ishtp_device(cl_device), sizeof(*opr_dev),
> +			       GFP_KERNEL);
> +	if (!opr_dev)
> +		return -ENOMEM;
> +
> +	ecl_ishtp_cl = ishtp_cl_allocate(cl_device);
> +	if (!ecl_ishtp_cl)
> +		return -ENOMEM;
> +
> +	ishtp_set_drvdata(cl_device, ecl_ishtp_cl);
> +	ishtp_set_client_data(ecl_ishtp_cl, opr_dev);
> +	opr_dev->ecl_ishtp_cl = ecl_ishtp_cl;
> +	opr_dev->cl_device = cl_device;
> +
> +	init_waitqueue_head(&opr_dev->read_wait);
> +	INIT_WORK(&opr_dev->event_work, ecl_acpi_invoke_dsm);
> +	INIT_WORK(&opr_dev->reset_work, ecl_ishtp_cl_reset_handler);
> +
> +	/* Initialize ish client device */
> +	rv = ecl_ishtp_cl_init(ecl_ishtp_cl);
> +	if (rv) {
> +		dev_err(cl_data_to_dev(opr_dev), "Client init failed\n");
> +		goto err_exit;
> +	}
> +
> +	dev_dbg(cl_data_to_dev(opr_dev), "eclite-ishtp client initialised\n");
> +
> +	/* Register a handler for eclite fw events */
> +	ishtp_register_event_cb(cl_device, ecl_ishtp_cl_event_cb);
> +
> +	ishtp_get_device(cl_device);

This seems weird, normally in the device-model a driver being bound to
a device guarantees that that device cannot go away before the
remove callback of the driver is called.

So it seems to me that this call + the put in both the err_exit and
ecl_ishtp_cl_remove() cases can be dropped.

> +
> +	opr_dev->ish_link_ready = true;
> +
> +	/* Now find ACPI device and init opregion handlers */
> +	rv = acpi_opregion_init(opr_dev);
> +	if (rv) {
> +		dev_err(cl_data_to_dev(opr_dev), "ACPI opregion init failed\n");
> +
> +		goto err_exit;
> +	}
> +
> +	/* Reprobe devices depending on ECLite - battery, fan, etc. */
> +	acpi_walk_dep_device_list(opr_dev->acpi_handle);
> +
> +	return 0;
> +err_exit:
> +	ishtp_set_connection_state(ecl_ishtp_cl, ISHTP_CL_DISCONNECTING);
> +	ishtp_cl_disconnect(ecl_ishtp_cl);
> +	ecl_ishtp_cl_deinit(ecl_ishtp_cl);
> +
> +	ishtp_put_device(cl_device);
> +
> +	return rv;
> +}
> +
> +static int ecl_ishtp_cl_remove(struct ishtp_cl_device *cl_device)
> +{
> +	struct ishtp_cl *ecl_ishtp_cl = ishtp_get_drvdata(cl_device);
> +	struct ishtp_opregion_dev *opr_dev =
> +		ishtp_get_client_data(ecl_ishtp_cl);
> +
> +	if (opr_dev->acpi_init_done)
> +		acpi_opregion_deinit(opr_dev);
> +
> +	cancel_work_sync(&opr_dev->reset_work);
> +	cancel_work_sync(&opr_dev->event_work);
> +
> +	ishtp_set_connection_state(ecl_ishtp_cl, ISHTP_CL_DISCONNECTING);
> +	ishtp_cl_disconnect(ecl_ishtp_cl);
> +	ecl_ishtp_cl_deinit(ecl_ishtp_cl);
> +
> +	ishtp_put_device(cl_device);
> +
> +	return 0;
> +}
> +
> +static int ecl_ishtp_cl_reset(struct ishtp_cl_device *cl_device)
> +{
> +	struct ishtp_cl *ecl_ishtp_cl = ishtp_get_drvdata(cl_device);
> +	struct ishtp_opregion_dev *opr_dev =
> +		ishtp_get_client_data(ecl_ishtp_cl);
> +
> +	schedule_work(&opr_dev->reset_work);
> +
> +	return 0;
> +}
> +
> +static int ecl_ishtp_cl_suspend(struct device *device)
> +{
> +	struct ishtp_cl_device *cl_device = ishtp_dev_to_cl_device(device);
> +	struct ishtp_cl *ecl_ishtp_cl = ishtp_get_drvdata(cl_device);
> +	struct ishtp_opregion_dev *opr_dev =
> +		ishtp_get_client_data(ecl_ishtp_cl);
> +
> +	if (acpi_target_system_state() == ACPI_STATE_S0)
> +		return 0;
> +
> +	acpi_opregion_deinit(opr_dev);
> +	ecl_ish_cl_enable_events(opr_dev, false);
> +
> +	return 0;
> +}
> +
> +static int ecl_ishtp_cl_resume(struct device *device)
> +{
> +	/* A reset is expected to call after an Sx. At this point
> +	 * we are not sure if the link is up or not to restore anything,
> +	 * so do nothing in resume path
> +	 */
> +	return 0;

This seems very wrong, this means that there are no resume ordering
guarantees meaning that drivers which are ordered to resume
after this driver, because they rely on the opregion may end up not being
able to use the opregion leading to all kind of issues.

IMHO what should happen here is that this driver waits for the
EClite to become ready here. Which probably means that it itself
should be only resumed after the ISH HID driver is, but I assume
that the ISH device is a parent of this device, so that ordering should
be correct automatically.

TBH the whole lets just not resume and do a reset instead and
then just tearing down the entire ISHTP client struct and setting
up a new one from scratch, just feels very wrong.  At a minimum the
teardown + bringup needs to happen before the resume callback completes,
but ideally this would be replaced by a much lighter resume solution.

Till this is fixed so that the device is guaranteed to be fully functional
once its resume callback has completed this code can not be merged,
so NACK to this patch for now.

Regards,

Hans




> +}
> +
> +static const struct dev_pm_ops ecl_ishtp_pm_ops = {
> +	.suspend = ecl_ishtp_cl_suspend,
> +	.resume = ecl_ishtp_cl_resume,
> +};
> +
> +static struct ishtp_cl_driver ecl_ishtp_cl_driver = {
> +	.name = "ishtp-eclite",
> +	.guid = &ecl_ishtp_guid,
> +	.probe = ecl_ishtp_cl_probe,
> +	.remove = ecl_ishtp_cl_remove,
> +	.reset = ecl_ishtp_cl_reset,
> +	.driver.pm = &ecl_ishtp_pm_ops,
> +};
> +
> +static int __init ecl_ishtp_init(void)
> +{
> +	return ishtp_cl_driver_register(&ecl_ishtp_cl_driver, THIS_MODULE);
> +}
> +
> +static void __exit ecl_ishtp_exit(void)
> +{
> +	return ishtp_cl_driver_unregister(&ecl_ishtp_cl_driver);
> +}
> +
> +late_initcall(ecl_ishtp_init);
> +module_exit(ecl_ishtp_exit);
> +
> +MODULE_DESCRIPTION("ISH ISHTP eclite client opregion driver");
> +MODULE_AUTHOR("K Naduvalath, Sumesh <sumesh.k.naduvalath@intel.com>");
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("ishtp:*");
> 

