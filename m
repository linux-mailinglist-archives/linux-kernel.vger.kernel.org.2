Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5E83281F4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhCAPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:12:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:20397 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236961AbhCAPL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:11:28 -0500
IronPort-SDR: 4lEsIUQXacpHDdIau4IxPHgT9b5VJe3atEQMf4+OQ8PMjt7Z7S2bcdyKdqwRZ33BLsVFNa+/oC
 itScZ/uT2qig==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="173622187"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="173622187"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 07:09:30 -0800
IronPort-SDR: XFQ7a6oDv8yaAyED/Ca8evpTqMwf886VYsy5RIoyZhkvwOLyO9vrIT3rbEd8cA3GYgd7zYnYnC
 /PsXycWyiPPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="505098256"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Mar 2021 07:09:27 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 01 Mar 2021 17:09:26 +0200
Date:   Mon, 1 Mar 2021 17:09:26 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 1/4] usb: typec: tps6598x: Add trace event for IRQ
 events
Message-ID: <YD0DplEVfdPHdi4O@kuha.fi.intel.com>
References: <cover.1613389531.git.agx@sigxcpu.org>
 <11444ae487d69da98ec20a18f2e49259e68319e3.1613389531.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11444ae487d69da98ec20a18f2e49259e68319e3.1613389531.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 12:46:42PM +0100, Guido Günther wrote:
> Allow to get irq event information via the tracing framework.  This
> allows to inspect USB-C negotiation at runtime.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/Makefile         |  3 +
>  drivers/usb/typec/tps6598x.c       |  9 ++-
>  drivers/usb/typec/tps6598x.h       | 64 ++++++++++++++++++++
>  drivers/usb/typec/tps6598x_trace.h | 97 ++++++++++++++++++++++++++++++
>  4 files changed, 170 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/usb/typec/tps6598x.h
>  create mode 100644 drivers/usb/typec/tps6598x_trace.h
> 
> diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> index d03b48c4b864..27aa12129190 100644
> --- a/drivers/usb/typec/Makefile
> +++ b/drivers/usb/typec/Makefile
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> +# define_trace.h needs to know how to find our header
> +CFLAGS_tps6598x.o		:= -I$(src)
> +
>  obj-$(CONFIG_TYPEC)		+= typec.o
>  typec-y				:= class.o mux.o bus.o
>  obj-$(CONFIG_TYPEC)		+= altmodes/
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index 6e6ef6317523..bc34b35e909f 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -6,6 +6,8 @@
>   * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>   */
>  
> +#include "tps6598x.h"
> +
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
>  #include <linux/module.h>
> @@ -15,6 +17,9 @@
>  #include <linux/usb/typec.h>
>  #include <linux/usb/role.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include "tps6598x_trace.h"
> +
>  /* Register offsets */
>  #define TPS_REG_VID			0x00
>  #define TPS_REG_MODE			0x03
> @@ -32,9 +37,6 @@
>  #define TPS_REG_POWER_STATUS		0x3f
>  #define TPS_REG_RX_IDENTITY_SOP		0x48
>  
> -/* TPS_REG_INT_* bits */
> -#define TPS_REG_INT_PLUG_EVENT		BIT(3)
> -
>  /* TPS_REG_STATUS bits */
>  #define TPS_STATUS_PLUG_PRESENT		BIT(0)
>  #define TPS_STATUS_ORIENTATION		BIT(4)
> @@ -428,6 +430,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  		dev_err(tps->dev, "%s: failed to read events\n", __func__);
>  		goto err_unlock;
>  	}
> +	trace_tps6598x_irq(event1, event2);
>  
>  	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
>  	if (ret) {
> diff --git a/drivers/usb/typec/tps6598x.h b/drivers/usb/typec/tps6598x.h
> new file mode 100644
> index 000000000000..b83b8a6a1504
> --- /dev/null
> +++ b/drivers/usb/typec/tps6598x.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Driver for TI TPS6598x USB Power Delivery controller family
> + *
> + * Copyright (C) 2017, Intel Corporation
> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +
> +#ifndef __TPS6598X_H__
> +#define __TPS6598X_H__
> +
> +
> +/* TPS_REG_INT_* bits */
> +#define TPS_REG_INT_USER_VID_ALT_MODE_OTHER_VDM		BIT_ULL(27+32)
> +#define TPS_REG_INT_USER_VID_ALT_MODE_ATTN_VDM		BIT_ULL(26+32)
> +#define TPS_REG_INT_USER_VID_ALT_MODE_EXIT		BIT_ULL(25+32)
> +#define TPS_REG_INT_USER_VID_ALT_MODE_ENTERED		BIT_ULL(24+32)
> +#define TPS_REG_INT_EXIT_MODES_COMPLETE			BIT_ULL(20+32)
> +#define TPS_REG_INT_DISCOVER_MODES_COMPLETE		BIT_ULL(19+32)
> +#define TPS_REG_INT_VDM_MSG_SENT			BIT_ULL(18+32)
> +#define TPS_REG_INT_VDM_ENTERED_MODE			BIT_ULL(17+32)
> +#define TPS_REG_INT_ERROR_UNABLE_TO_SOURCE		BIT_ULL(14+32)
> +#define TPS_REG_INT_SRC_TRANSITION			BIT_ULL(10+32)
> +#define TPS_REG_INT_ERROR_DISCHARGE_FAILED		BIT_ULL(9+32)
> +#define TPS_REG_INT_ERROR_MESSAGE_DATA			BIT_ULL(7+32)
> +#define TPS_REG_INT_ERROR_PROTOCOL_ERROR		BIT_ULL(6+32)
> +#define TPS_REG_INT_ERROR_MISSING_GET_CAP_MESSAGE	BIT_ULL(4+32)
> +#define TPS_REG_INT_ERROR_POWER_EVENT_OCCURRED		BIT_ULL(3+32)
> +#define TPS_REG_INT_ERROR_CAN_PROVIDE_PWR_LATER		BIT_ULL(2+32)
> +#define TPS_REG_INT_ERROR_CANNOT_PROVIDE_PWR		BIT_ULL(1+32)
> +#define TPS_REG_INT_ERROR_DEVICE_INCOMPATIBLE		BIT_ULL(0+32)
> +#define TPS_REG_INT_CMD2_COMPLETE			BIT(31)
> +#define TPS_REG_INT_CMD1_COMPLETE			BIT(30)
> +#define TPS_REG_INT_ADC_HIGH_THRESHOLD			BIT(29)
> +#define TPS_REG_INT_ADC_LOW_THRESHOLD			BIT(28)
> +#define TPS_REG_INT_PD_STATUS_UPDATE			BIT(27)
> +#define TPS_REG_INT_STATUS_UPDATE			BIT(26)
> +#define TPS_REG_INT_DATA_STATUS_UPDATE			BIT(25)
> +#define TPS_REG_INT_POWER_STATUS_UPDATE			BIT(24)
> +#define TPS_REG_INT_PP_SWITCH_CHANGED			BIT(23)
> +#define TPS_REG_INT_HIGH_VOLTAGE_WARNING		BIT(22)
> +#define TPS_REG_INT_USB_HOST_PRESENT_NO_LONGER		BIT(21)
> +#define TPS_REG_INT_USB_HOST_PRESENT			BIT(20)
> +#define TPS_REG_INT_GOTO_MIN_RECEIVED			BIT(19)
> +#define TPS_REG_INT_PR_SWAP_REQUESTED			BIT(17)
> +#define TPS_REG_INT_SINK_CAP_MESSAGE_READY		BIT(15)
> +#define TPS_REG_INT_SOURCE_CAP_MESSAGE_READY		BIT(14)
> +#define TPS_REG_INT_NEW_CONTRACT_AS_PROVIDER		BIT(13)
> +#define TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER		BIT(12)
> +#define TPS_REG_INT_VDM_RECEIVED			BIT(11)
> +#define TPS_REG_INT_ATTENTION_RECEIVED			BIT(10)
> +#define TPS_REG_INT_OVERCURRENT				BIT(9)
> +#define TPS_REG_INT_BIST				BIT(8)
> +#define TPS_REG_INT_RDO_RECEIVED_FROM_SINK		BIT(7)
> +#define TPS_REG_INT_DR_SWAP_COMPLETE			BIT(5)
> +#define TPS_REG_INT_PR_SWAP_COMPLETE			BIT(4)
> +#define TPS_REG_INT_PLUG_EVENT				BIT(3)
> +#define TPS_REG_INT_HARD_RESET				BIT(1)
> +#define TPS_REG_INT_PD_SOFT_RESET			BIT(0)
> +
> +#endif /* __TPS6598X_H__ */
> diff --git a/drivers/usb/typec/tps6598x_trace.h b/drivers/usb/typec/tps6598x_trace.h
> new file mode 100644
> index 000000000000..4ec96e3b2c3e
> --- /dev/null
> +++ b/drivers/usb/typec/tps6598x_trace.h
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Driver for TI TPS6598x USB Power Delivery controller family
> + *
> + * Copyright (C) 2020 Purism SPC
> + * Author: Guido Günther <agx@sigxcpu.org>
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM tps6598x
> +
> +#if !defined(_TPS6598x_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TPS6598X_TRACE_H_
> +
> +#include "tps6598x.h"
> +
> +#include <linux/stringify.h>
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +
> +#define show_irq_flags(flags) \
> +	__print_flags_u64(flags, "|", \
> +		{ TPS_REG_INT_PD_SOFT_RESET,			"PD_SOFT_RESET" }, \
> +		{ TPS_REG_INT_HARD_RESET,			"HARD_RESET" }, \
> +		{ TPS_REG_INT_PLUG_EVENT,			"PLUG_EVENT" }, \
> +		{ TPS_REG_INT_PR_SWAP_COMPLETE,			"PR_SWAP_COMPLETE" }, \
> +		{ TPS_REG_INT_DR_SWAP_COMPLETE,			"DR_SWAP_COMPLETE" }, \
> +		{ TPS_REG_INT_RDO_RECEIVED_FROM_SINK,		"RDO_RECEIVED_FROM_SINK" }, \
> +		{ TPS_REG_INT_BIST,				"BIST" }, \
> +		{ TPS_REG_INT_OVERCURRENT,			"OVERCURRENT" }, \
> +		{ TPS_REG_INT_ATTENTION_RECEIVED,		"ATTENTION_RECEIVED" }, \
> +		{ TPS_REG_INT_VDM_RECEIVED,			"VDM_RECEIVED" }, \
> +		{ TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER,		"NEW_CONTRACT_AS_CONSUMER" }, \
> +		{ TPS_REG_INT_NEW_CONTRACT_AS_PROVIDER,		"NEW_CONTRACT_AS_PROVIDER" }, \
> +		{ TPS_REG_INT_SOURCE_CAP_MESSAGE_READY,		"SOURCE_CAP_MESSAGE_READY" }, \
> +		{ TPS_REG_INT_SINK_CAP_MESSAGE_READY,		"SINK_CAP_MESSAGE_READY" }, \
> +		{ TPS_REG_INT_PR_SWAP_REQUESTED,		"PR_SWAP_REQUESTED" }, \
> +		{ TPS_REG_INT_GOTO_MIN_RECEIVED,		"GOTO_MIN_RECEIVED" }, \
> +		{ TPS_REG_INT_USB_HOST_PRESENT,			"USB_HOST_PRESENT" }, \
> +		{ TPS_REG_INT_USB_HOST_PRESENT_NO_LONGER,	"USB_HOST_PRESENT_NO_LONGER" }, \
> +		{ TPS_REG_INT_HIGH_VOLTAGE_WARNING,		"HIGH_VOLTAGE_WARNING" }, \
> +		{ TPS_REG_INT_PP_SWITCH_CHANGED,		"PP_SWITCH_CHANGED" }, \
> +		{ TPS_REG_INT_POWER_STATUS_UPDATE,		"POWER_STATUS_UPDATE" }, \
> +		{ TPS_REG_INT_DATA_STATUS_UPDATE,		"DATA_STATUS_UPDATE" }, \
> +		{ TPS_REG_INT_STATUS_UPDATE,			"STATUS_UPDATE" }, \
> +		{ TPS_REG_INT_PD_STATUS_UPDATE,			"PD_STATUS_UPDATE" }, \
> +		{ TPS_REG_INT_ADC_LOW_THRESHOLD,		"ADC_LOW_THRESHOLD" }, \
> +		{ TPS_REG_INT_ADC_HIGH_THRESHOLD,		"ADC_HIGH_THRESHOLD" }, \
> +		{ TPS_REG_INT_CMD1_COMPLETE,			"CMD1_COMPLETE" }, \
> +		{ TPS_REG_INT_CMD2_COMPLETE,			"CMD2_COMPLETE" }, \
> +		{ TPS_REG_INT_ERROR_DEVICE_INCOMPATIBLE,	"ERROR_DEVICE_INCOMPATIBLE" }, \
> +		{ TPS_REG_INT_ERROR_CANNOT_PROVIDE_PWR,		"ERROR_CANNOT_PROVIDE_PWR" }, \
> +		{ TPS_REG_INT_ERROR_CAN_PROVIDE_PWR_LATER,	"ERROR_CAN_PROVIDE_PWR_LATER" }, \
> +		{ TPS_REG_INT_ERROR_POWER_EVENT_OCCURRED,	"ERROR_POWER_EVENT_OCCURRED" }, \
> +		{ TPS_REG_INT_ERROR_MISSING_GET_CAP_MESSAGE,	"ERROR_MISSING_GET_CAP_MESSAGE" }, \
> +		{ TPS_REG_INT_ERROR_PROTOCOL_ERROR,		"ERROR_PROTOCOL_ERROR" }, \
> +		{ TPS_REG_INT_ERROR_MESSAGE_DATA,		"ERROR_MESSAGE_DATA" }, \
> +		{ TPS_REG_INT_ERROR_DISCHARGE_FAILED,		"ERROR_DISCHARGE_FAILED" }, \
> +		{ TPS_REG_INT_SRC_TRANSITION,			"SRC_TRANSITION" }, \
> +		{ TPS_REG_INT_ERROR_UNABLE_TO_SOURCE,		"ERROR_UNABLE_TO_SOURCE" }, \
> +		{ TPS_REG_INT_VDM_ENTERED_MODE,			"VDM_ENTERED_MODE" }, \
> +		{ TPS_REG_INT_VDM_MSG_SENT,			"VDM_MSG_SENT" }, \
> +		{ TPS_REG_INT_DISCOVER_MODES_COMPLETE,		"DISCOVER_MODES_COMPLETE" }, \
> +		{ TPS_REG_INT_EXIT_MODES_COMPLETE,		"EXIT_MODES_COMPLETE" }, \
> +		{ TPS_REG_INT_USER_VID_ALT_MODE_ENTERED,	"USER_VID_ALT_MODE_ENTERED" }, \
> +		{ TPS_REG_INT_USER_VID_ALT_MODE_EXIT,		"USER_VID_ALT_MODE_EXIT" }, \
> +		{ TPS_REG_INT_USER_VID_ALT_MODE_ATTN_VDM,	"USER_VID_ALT_MODE_ATTN_VDM" }, \
> +		{ TPS_REG_INT_USER_VID_ALT_MODE_OTHER_VDM,	"USER_VID_ALT_MODE_OTHER_VDM" })
> +
> +TRACE_EVENT(tps6598x_irq,
> +	    TP_PROTO(u64 event1,
> +		     u64 event2),
> +	    TP_ARGS(event1, event2),
> +
> +	    TP_STRUCT__entry(
> +			     __field(u64, event1)
> +			     __field(u64, event2)
> +			     ),
> +
> +	    TP_fast_assign(
> +			   __entry->event1 = event1;
> +			   __entry->event2 = event2;
> +			   ),
> +
> +	    TP_printk("event1=%s, event2=%s",
> +		      show_irq_flags(__entry->event1),
> +		      show_irq_flags(__entry->event2))
> +);
> +
> +#endif /* _TPS6598X_TRACE_H_ */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_FILE tps6598x_trace
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#include <trace/define_trace.h>
> -- 
> 2.30.0

thanks,

-- 
heikki
