Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7EE34EBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhC3PMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232203AbhC3PLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617117106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlnMpLxiu5ou+c6Wma77sONVdD/+NIrvU4C5mOomsok=;
        b=FdonyuNNyQrBaxkIlm6qBsVwx1DcoF++nHSZVMbo/7B+L7rxeQR9cugNmgZiJobm2rBimP
        CLGviWMldDhWoUzGiCeIBFfQbijNrYc7DFdrQUKzMJgsc/Q8gSPhFydXui27yqjpgOpg4p
        xew8oCnZ42Tmlk4L8BgK11yj7ltivfw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-QvPx5VWRMcqx4KaC852HWA-1; Tue, 30 Mar 2021 11:11:41 -0400
X-MC-Unique: QvPx5VWRMcqx4KaC852HWA-1
Received: by mail-qk1-f198.google.com with SMTP id p133so14611966qka.17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QlnMpLxiu5ou+c6Wma77sONVdD/+NIrvU4C5mOomsok=;
        b=IQ/nDbcxHxBOAaOqdd/ahXPUa7RHzdAOzAtI/syZwiOIPo5SBREBbS/6s67Nimgpd0
         CEKQm5LzgnVKnQGz4nsBDhapvppqxmiUiu3w9cihZyw2rt7wIrMuUBO1iboAwpsRrSMC
         UMYUoaZLVtM5ZfNlvhQWCUjiodqkqx9B7anKB7ModePdsgFZznubwYQlHbdQnRAEUbIt
         N9Q1NG2gEFj/MzYa8BHN9NEzfvlMquL9CE+hitPQsYAVd8rNDJG/rnREAaOSfJQUQzBu
         YVnjpc/qTKuF3Jvp2jnl0fGZ+w8MVXZtjENDZMMyQM9cN4BRbH6W0e//kTsSsT7gI8tX
         nPtg==
X-Gm-Message-State: AOAM531K+bD1thDtBeblCnI3Fusp/S2pSsbMWLG91sv8hsFgOqTeiABl
        JgMg49HyOvDVyh7SPHjGuKg8SyaCv5KW/E+IRSflQKVrCOviZuy2O6gTXRzo9vBR36GXLUJr8a7
        VC8Le+GXvZYK24znG+grU/nxu
X-Received: by 2002:ae9:e40b:: with SMTP id q11mr31342189qkc.318.1617117099449;
        Tue, 30 Mar 2021 08:11:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKmJCdI9KqGJW9+aFuD2NRPLdFBdskEy7wGVhMbHKSenqEZFTqXRVlSSFgHJh6JrazTfj/zQ==
X-Received: by 2002:ae9:e40b:: with SMTP id q11mr31342136qkc.318.1617117098959;
        Tue, 30 Mar 2021 08:11:38 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d24sm15432337qkl.49.2021.03.30.08.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 08:11:38 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 07/20] fpga: xrt: root driver infrastructure
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org,
        Max Zhen <max.zhen@xilinx.com>
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-8-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <972b7e77-d958-edc0-8da1-eca22f1407a8@redhat.com>
Date:   Tue, 30 Mar 2021 08:11:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-8-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was split from 'fpga: xrt: platform driver infrastructure'

and fpga: xrt: managment physical function driver (root)


On 3/23/21 10:29 PM, Lizhi Hou wrote:
> Contains common code for all root drivers and handles root calls from
> platform drivers. This is part of root driver infrastructure.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/fpga/xrt/include/events.h  |  45 +++
>  drivers/fpga/xrt/include/xroot.h   | 117 ++++++
>  drivers/fpga/xrt/lib/subdev_pool.h |  53 +++
>  drivers/fpga/xrt/lib/xroot.c       | 589 +++++++++++++++++++++++++++++
>  4 files changed, 804 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/events.h
>  create mode 100644 drivers/fpga/xrt/include/xroot.h
>  create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
>  create mode 100644 drivers/fpga/xrt/lib/xroot.c
>
> diff --git a/drivers/fpga/xrt/include/events.h b/drivers/fpga/xrt/include/events.h
> new file mode 100644
> index 000000000000..775171a47c8e
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/events.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
ok
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_EVENTS_H_
> +#define _XRT_EVENTS_H_
ok
> +
> +#include "subdev_id.h"
> +
> +/*
> + * Event notification.
> + */
> +enum xrt_events {
> +	XRT_EVENT_TEST = 0, /* for testing */
> +	/*
> +	 * Events related to specific subdev
> +	 * Callback arg: struct xrt_event_arg_subdev
> +	 */
> +	XRT_EVENT_POST_CREATION,
> +	XRT_EVENT_PRE_REMOVAL,
> +	/*
> +	 * Events related to change of the whole board
> +	 * Callback arg: <none>
> +	 */
> +	XRT_EVENT_PRE_HOT_RESET,
> +	XRT_EVENT_POST_HOT_RESET,
> +	XRT_EVENT_PRE_GATE_CLOSE,
> +	XRT_EVENT_POST_GATE_OPEN,
> +};
> +
> +struct xrt_event_arg_subdev {
> +	enum xrt_subdev_id xevt_subdev_id;
> +	int xevt_subdev_instance;
> +};
> +
> +struct xrt_event {
> +	enum xrt_events xe_evt;
> +	struct xrt_event_arg_subdev xe_subdev;
> +};
> +
> +#endif	/* _XRT_EVENTS_H_ */
> diff --git a/drivers/fpga/xrt/include/xroot.h b/drivers/fpga/xrt/include/xroot.h
> new file mode 100644
> index 000000000000..91c0aeb30bf8
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xroot.h
> @@ -0,0 +1,117 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_ROOT_H_
> +#define _XRT_ROOT_H_
> +
> +#include <linux/platform_device.h>
> +#include <linux/pci.h>
> +#include "subdev_id.h"
> +#include "events.h"
> +
> +typedef bool (*xrt_subdev_match_t)(enum xrt_subdev_id,
> +	struct platform_device *, void *);
> +#define XRT_SUBDEV_MATCH_PREV	((xrt_subdev_match_t)-1)
> +#define XRT_SUBDEV_MATCH_NEXT	((xrt_subdev_match_t)-2)
> +
> +/*
> + * Root calls.
> + */
> +enum xrt_root_cmd {
> +	/* Leaf actions. */
> +	XRT_ROOT_GET_LEAF = 0,
> +	XRT_ROOT_PUT_LEAF,
> +	XRT_ROOT_GET_LEAF_HOLDERS,
> +
> +	/* Group actions. */
> +	XRT_ROOT_CREATE_GROUP,
> +	XRT_ROOT_REMOVE_GROUP,
> +	XRT_ROOT_LOOKUP_GROUP,
> +	XRT_ROOT_WAIT_GROUP_BRINGUP,
> +
> +	/* Event actions. */
> +	XRT_ROOT_EVENT_SYNC,
> +	XRT_ROOT_EVENT_ASYNC,
> +
> +	/* Device info. */
> +	XRT_ROOT_GET_RESOURCE,
> +	XRT_ROOT_GET_ID,
> +
> +	/* Misc. */
> +	XRT_ROOT_HOT_RESET,
> +	XRT_ROOT_HWMON,
> +};
> +
> +struct xrt_root_get_leaf {
> +	struct platform_device *xpigl_caller_pdev;
> +	xrt_subdev_match_t xpigl_match_cb;
> +	void *xpigl_match_arg;
> +	struct platform_device *xpigl_tgt_pdev;
> +};
> +
> +struct xrt_root_put_leaf {
> +	struct platform_device *xpipl_caller_pdev;
> +	struct platform_device *xpipl_tgt_pdev;
> +};
> +
> +struct xrt_root_lookup_group {
> +	struct platform_device *xpilp_pdev; /* caller's pdev */
> +	xrt_subdev_match_t xpilp_match_cb;
> +	void *xpilp_match_arg;
> +	int xpilp_grp_inst;
> +};
> +
> +struct xrt_root_get_holders {
> +	struct platform_device *xpigh_pdev; /* caller's pdev */
> +	char *xpigh_holder_buf;
> +	size_t xpigh_holder_buf_len;
> +};
> +
> +struct xrt_root_get_res {
> +	struct resource *xpigr_res;
> +};
> +
> +struct xrt_root_get_id {
> +	unsigned short  xpigi_vendor_id;
> +	unsigned short  xpigi_device_id;
> +	unsigned short  xpigi_sub_vendor_id;
> +	unsigned short  xpigi_sub_device_id;
> +};
> +
> +struct xrt_root_hwmon {
> +	bool xpih_register;
> +	const char *xpih_name;
> +	void *xpih_drvdata;
> +	const struct attribute_group **xpih_groups;
> +	struct device *xpih_hwmon_dev;
> +};
> +
> +/*
> + * Callback for leaf to make a root request. Arguments are: parent device, parent cookie, req,
> + * and arg.
> + */
> +typedef int (*xrt_subdev_root_cb_t)(struct device *, void *, u32, void *);
> +int xrt_subdev_root_request(struct platform_device *self, u32 cmd, void *arg);
> +
> +/*
> + * Defines physical function (MPF / UPF) specific operations
> + * needed in common root driver.
> + */
> +struct xroot_physical_function_callback {
> +	void (*xpc_hot_reset)(struct pci_dev *pdev);
> +};
> +
> +int xroot_probe(struct pci_dev *pdev, struct xroot_physical_function_callback *cb, void **root);
> +void xroot_remove(void *root);
> +bool xroot_wait_for_bringup(void *root);
> +int xroot_add_vsec_node(void *root, char *dtb);
> +int xroot_create_group(void *xr, char *dtb);
> +int xroot_add_simple_node(void *root, char *dtb, const char *endpoint);
> +void xroot_broadcast(void *root, enum xrt_events evt);
> +
> +#endif	/* _XRT_ROOT_H_ */
> diff --git a/drivers/fpga/xrt/lib/subdev_pool.h b/drivers/fpga/xrt/lib/subdev_pool.h
> new file mode 100644
> index 000000000000..09d148e4e7ea
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/subdev_pool.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_SUBDEV_POOL_H_
> +#define _XRT_SUBDEV_POOL_H_
> +
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include "xroot.h"
> +
> +/*
> + * The struct xrt_subdev_pool manages a list of xrt_subdevs for root and group drivers.
> + */
> +struct xrt_subdev_pool {
> +	struct list_head xsp_dev_list;
> +	struct device *xsp_owner;
> +	struct mutex xsp_lock; /* pool lock */
> +	bool xsp_closing;
> +};
> +
> +/*
> + * Subdev pool helper functions for root and group drivers only.
> + */
> +void xrt_subdev_pool_init(struct device *dev,
> +			  struct xrt_subdev_pool *spool);
> +void xrt_subdev_pool_fini(struct xrt_subdev_pool *spool);
> +int xrt_subdev_pool_get(struct xrt_subdev_pool *spool,
> +			xrt_subdev_match_t match,
> +			void *arg, struct device *holder_dev,
> +			struct platform_device **pdevp);
> +int xrt_subdev_pool_put(struct xrt_subdev_pool *spool,
> +			struct platform_device *pdev,
> +			struct device *holder_dev);
> +int xrt_subdev_pool_add(struct xrt_subdev_pool *spool,
> +			enum xrt_subdev_id id, xrt_subdev_root_cb_t pcb,
> +			void *pcb_arg, char *dtb);
> +int xrt_subdev_pool_del(struct xrt_subdev_pool *spool,
> +			enum xrt_subdev_id id, int instance);
> +ssize_t xrt_subdev_pool_get_holders(struct xrt_subdev_pool *spool,
> +				    struct platform_device *pdev,
> +				    char *buf, size_t len);
> +
> +void xrt_subdev_pool_trigger_event(struct xrt_subdev_pool *spool,
> +				   enum xrt_events evt);
> +void xrt_subdev_pool_handle_event(struct xrt_subdev_pool *spool,
> +				  struct xrt_event *evt);
> +
> +#endif	/* _XRT_SUBDEV_POOL_H_ */
> diff --git a/drivers/fpga/xrt/lib/xroot.c b/drivers/fpga/xrt/lib/xroot.c
> new file mode 100644
> index 000000000000..03407272650f
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xroot.c
> @@ -0,0 +1,589 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA Root Functions
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/hwmon.h>
> +#include "xroot.h"
> +#include "subdev_pool.h"
> +#include "group.h"
> +#include "metadata.h"
> +
> +#define XROOT_PDEV(xr)		((xr)->pdev)
> +#define XROOT_DEV(xr)		(&(XROOT_PDEV(xr)->dev))
> +#define xroot_err(xr, fmt, args...)	\
> +	dev_err(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
> +#define xroot_warn(xr, fmt, args...)	\
> +	dev_warn(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
> +#define xroot_info(xr, fmt, args...)	\
> +	dev_info(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
> +#define xroot_dbg(xr, fmt, args...)	\
> +	dev_dbg(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
> +
> +#define XRT_VSEC_ID		0x20
> +

'root' is an abstraction, 'pci' is an implementation.

Consider splitting.

I think this will be part of the pseudo bus, so figure out how to do root there.


> +#define XROOT_GROUP_FIRST		(-1)
> +#define XROOT_GROUP_LAST		(-2)
> +
> +static int xroot_root_cb(struct device *, void *, u32, void *);
> +
> +struct xroot_evt {
> +	struct list_head list;
> +	struct xrt_event evt;
> +	struct completion comp;
> +	bool async;
> +};
> +
> +struct xroot_events {
> +	struct mutex evt_lock; /* event lock */
> +	struct list_head evt_list;
> +	struct work_struct evt_work;
> +};
> +
> +struct xroot_groups {
> +	struct xrt_subdev_pool pool;
> +	struct work_struct bringup_work;
add a comment that these two elements are counters or append '_cnt' or similar to name
> +	atomic_t bringup_pending;
> +	atomic_t bringup_failed;
> +	struct completion bringup_comp;
> +};
> +
> +struct xroot {
> +	struct pci_dev *pdev;
> +	struct xroot_events events;
> +	struct xroot_groups groups;
> +	struct xroot_physical_function_callback pf_cb;
ok
> +};
> +
> +struct xroot_group_match_arg {
> +	enum xrt_subdev_id id;
> +	int instance;
> +};
> +
> +static bool xroot_group_match(enum xrt_subdev_id id, struct platform_device *pdev, void *arg)
> +{
> +	struct xroot_group_match_arg *a = (struct xroot_group_match_arg *)arg;
> +
> +	/* pdev->id is the instance of the subdev. */
ok
> +	return id == a->id && pdev->id == a->instance;
> +}
> +
> +static int xroot_get_group(struct xroot *xr, int instance, struct platform_device **grpp)
> +{
> +	int rc = 0;
> +	struct xrt_subdev_pool *grps = &xr->groups.pool;
> +	struct device *dev = DEV(xr->pdev);
> +	struct xroot_group_match_arg arg = { XRT_SUBDEV_GRP, instance };
> +
> +	if (instance == XROOT_GROUP_LAST) {
> +		rc = xrt_subdev_pool_get(grps, XRT_SUBDEV_MATCH_NEXT,
> +					 *grpp, dev, grpp);
> +	} else if (instance == XROOT_GROUP_FIRST) {
> +		rc = xrt_subdev_pool_get(grps, XRT_SUBDEV_MATCH_PREV,
> +					 *grpp, dev, grpp);
> +	} else {
> +		rc = xrt_subdev_pool_get(grps, xroot_group_match,
> +					 &arg, dev, grpp);
> +	}
> +
> +	if (rc && rc != -ENOENT)
> +		xroot_err(xr, "failed to hold group %d: %d", instance, rc);
> +	return rc;
> +}
> +
> +static void xroot_put_group(struct xroot *xr, struct platform_device *grp)
> +{
> +	int inst = grp->id;
> +	int rc = xrt_subdev_pool_put(&xr->groups.pool, grp, DEV(xr->pdev));
> +
> +	if (rc)
> +		xroot_err(xr, "failed to release group %d: %d", inst, rc);
> +}
> +
> +static int xroot_trigger_event(struct xroot *xr, struct xrt_event *e, bool async)
> +{
> +	struct xroot_evt *enew = vzalloc(sizeof(*enew));
> +
> +	if (!enew)
> +		return -ENOMEM;
> +
> +	enew->evt = *e;
> +	enew->async = async;
> +	init_completion(&enew->comp);
> +
> +	mutex_lock(&xr->events.evt_lock);
> +	list_add(&enew->list, &xr->events.evt_list);
> +	mutex_unlock(&xr->events.evt_lock);
> +
> +	schedule_work(&xr->events.evt_work);
> +
> +	if (async)
> +		return 0;
> +
> +	wait_for_completion(&enew->comp);
> +	vfree(enew);
> +	return 0;
> +}
> +
> +static void
> +xroot_group_trigger_event(struct xroot *xr, int inst, enum xrt_events e)
> +{
> +	int ret;
> +	struct platform_device *pdev = NULL;
> +	struct xrt_event evt = { 0 };
> +
> +	WARN_ON(inst < 0);
> +	/* Only triggers subdev specific events. */
> +	if (e != XRT_EVENT_POST_CREATION && e != XRT_EVENT_PRE_REMOVAL) {
> +		xroot_err(xr, "invalid event %d", e);
> +		return;
> +	}
> +
> +	ret = xroot_get_group(xr, inst, &pdev);
> +	if (ret)
> +		return;
> +
> +	/* Triggers event for children, first. */
> +	xleaf_call(pdev, XRT_GROUP_TRIGGER_EVENT, (void *)(uintptr_t)e);
ok
> +
> +	/* Triggers event for itself. */
> +	evt.xe_evt = e;
> +	evt.xe_subdev.xevt_subdev_id = XRT_SUBDEV_GRP;
> +	evt.xe_subdev.xevt_subdev_instance = inst;
> +	xroot_trigger_event(xr, &evt, false);
> +
> +	xroot_put_group(xr, pdev);
> +}
> +
> +int xroot_create_group(void *root, char *dtb)
> +{
> +	struct xroot *xr = (struct xroot *)root;
> +	int ret;
> +
> +	atomic_inc(&xr->groups.bringup_pending);
> +	ret = xrt_subdev_pool_add(&xr->groups.pool, XRT_SUBDEV_GRP, xroot_root_cb, xr, dtb);
> +	if (ret >= 0) {
> +		schedule_work(&xr->groups.bringup_work);
> +	} else {
> +		atomic_dec(&xr->groups.bringup_pending);
> +		atomic_inc(&xr->groups.bringup_failed);
> +		xroot_err(xr, "failed to create group: %d", ret);
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xroot_create_group);
> +
> +static int xroot_destroy_single_group(struct xroot *xr, int instance)
> +{
ok as-is
> +	struct platform_device *pdev = NULL;
> +	int ret;
> +
> +	WARN_ON(instance < 0);
> +	ret = xroot_get_group(xr, instance, &pdev);
> +	if (ret)
> +		return ret;
> +
> +	xroot_group_trigger_event(xr, instance, XRT_EVENT_PRE_REMOVAL);
> +
> +	/* Now tear down all children in this group. */
> +	ret = xleaf_call(pdev, XRT_GROUP_FINI_CHILDREN, NULL);
> +	xroot_put_group(xr, pdev);
> +	if (!ret)
> +		ret = xrt_subdev_pool_del(&xr->groups.pool, XRT_SUBDEV_GRP, instance);
> +
> +	return ret;
> +}
> +
> +static int xroot_destroy_group(struct xroot *xr, int instance)
> +{
> +	struct platform_device *target = NULL;
> +	struct platform_device *deps = NULL;
> +	int ret;
> +
> +	WARN_ON(instance < 0);
> +	/*
> +	 * Make sure target group exists and can't go away before
> +	 * we remove it's dependents
> +	 */
> +	ret = xroot_get_group(xr, instance, &target);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Remove all groups depend on target one.
> +	 * Assuming subdevs in higher group ID can depend on ones in
> +	 * lower ID groups, we remove them in the reservse order.
> +	 */
> +	while (xroot_get_group(xr, XROOT_GROUP_LAST, &deps) != -ENOENT) {
> +		int inst = deps->id;
> +
> +		xroot_put_group(xr, deps);
> +		/* Reached the target group instance, stop here. */
ok
> +		if (instance == inst)
> +			break;
> +		xroot_destroy_single_group(xr, inst);
> +		deps = NULL;
> +	}
> +
> +	/* Now we can remove the target group. */
> +	xroot_put_group(xr, target);
> +	return xroot_destroy_single_group(xr, instance);
> +}
> +
> +static int xroot_lookup_group(struct xroot *xr,
> +			      struct xrt_root_lookup_group *arg)
> +{
> +	int rc = -ENOENT;
> +	struct platform_device *grp = NULL;
> +
> +	while (rc < 0 && xroot_get_group(xr, XROOT_GROUP_LAST, &grp) != -ENOENT) {
> +		if (arg->xpilp_match_cb(XRT_SUBDEV_GRP, grp, arg->xpilp_match_arg))
> +			rc = grp->id;
> +		xroot_put_group(xr, grp);
> +	}
> +	return rc;
> +}
> +
> +static void xroot_event_work(struct work_struct *work)
> +{
> +	struct xroot_evt *tmp;
> +	struct xroot *xr = container_of(work, struct xroot, events.evt_work);
> +
> +	mutex_lock(&xr->events.evt_lock);
> +	while (!list_empty(&xr->events.evt_list)) {
> +		tmp = list_first_entry(&xr->events.evt_list, struct xroot_evt, list);
> +		list_del(&tmp->list);
> +		mutex_unlock(&xr->events.evt_lock);
> +
> +		xrt_subdev_pool_handle_event(&xr->groups.pool, &tmp->evt);
> +
> +		if (tmp->async)
> +			vfree(tmp);
> +		else
> +			complete(&tmp->comp);
> +
> +		mutex_lock(&xr->events.evt_lock);
> +	}
> +	mutex_unlock(&xr->events.evt_lock);
> +}
> +
> +static void xroot_event_init(struct xroot *xr)
> +{
> +	INIT_LIST_HEAD(&xr->events.evt_list);
> +	mutex_init(&xr->events.evt_lock);
> +	INIT_WORK(&xr->events.evt_work, xroot_event_work);
> +}
> +
> +static void xroot_event_fini(struct xroot *xr)
> +{
> +	flush_scheduled_work();
> +	WARN_ON(!list_empty(&xr->events.evt_list));
> +}
> +
> +static int xroot_get_leaf(struct xroot *xr, struct xrt_root_get_leaf *arg)
> +{
> +	int rc = -ENOENT;
> +	struct platform_device *grp = NULL;
> +
> +	while (rc && xroot_get_group(xr, XROOT_GROUP_LAST, &grp) != -ENOENT) {
> +		rc = xleaf_call(grp, XRT_GROUP_GET_LEAF, arg);
> +		xroot_put_group(xr, grp);
> +	}
> +	return rc;
> +}
> +
> +static int xroot_put_leaf(struct xroot *xr, struct xrt_root_put_leaf *arg)
> +{
> +	int rc = -ENOENT;
> +	struct platform_device *grp = NULL;
> +
> +	while (rc && xroot_get_group(xr, XROOT_GROUP_LAST, &grp) != -ENOENT) {
> +		rc = xleaf_call(grp, XRT_GROUP_PUT_LEAF, arg);
> +		xroot_put_group(xr, grp);
> +	}
> +	return rc;
> +}
> +
> +static int xroot_root_cb(struct device *dev, void *parg, enum xrt_root_cmd cmd, void *arg)
> +{
> +	struct xroot *xr = (struct xroot *)parg;
> +	int rc = 0;
> +
> +	switch (cmd) {
> +	/* Leaf actions. */
> +	case XRT_ROOT_GET_LEAF: {
> +		struct xrt_root_get_leaf *getleaf = (struct xrt_root_get_leaf *)arg;
> +
> +		rc = xroot_get_leaf(xr, getleaf);
> +		break;
> +	}
> +	case XRT_ROOT_PUT_LEAF: {
> +		struct xrt_root_put_leaf *putleaf = (struct xrt_root_put_leaf *)arg;
> +
> +		rc = xroot_put_leaf(xr, putleaf);
> +		break;
> +	}
> +	case XRT_ROOT_GET_LEAF_HOLDERS: {
> +		struct xrt_root_get_holders *holders = (struct xrt_root_get_holders *)arg;
> +
> +		rc = xrt_subdev_pool_get_holders(&xr->groups.pool,
> +						 holders->xpigh_pdev,
> +						 holders->xpigh_holder_buf,
> +						 holders->xpigh_holder_buf_len);
> +		break;
> +	}
> +
> +	/* Group actions. */
> +	case XRT_ROOT_CREATE_GROUP:
> +		rc = xroot_create_group(xr, (char *)arg);
> +		break;
> +	case XRT_ROOT_REMOVE_GROUP:
> +		rc = xroot_destroy_group(xr, (int)(uintptr_t)arg);
> +		break;
> +	case XRT_ROOT_LOOKUP_GROUP: {
> +		struct xrt_root_lookup_group *getgrp = (struct xrt_root_lookup_group *)arg;
> +
> +		rc = xroot_lookup_group(xr, getgrp);
> +		break;
> +	}
> +	case XRT_ROOT_WAIT_GROUP_BRINGUP:
> +		rc = xroot_wait_for_bringup(xr) ? 0 : -EINVAL;
> +		break;
> +
> +	/* Event actions. */
> +	case XRT_ROOT_EVENT_SYNC:
> +	case XRT_ROOT_EVENT_ASYNC: {
> +		bool async = (cmd == XRT_ROOT_EVENT_ASYNC);
> +		struct xrt_event *evt = (struct xrt_event *)arg;
> +
> +		rc = xroot_trigger_event(xr, evt, async);
> +		break;
> +	}
> +
> +	/* Device info. */
> +	case XRT_ROOT_GET_RESOURCE: {
> +		struct xrt_root_get_res *res = (struct xrt_root_get_res *)arg;
> +
> +		res->xpigr_res = xr->pdev->resource;
> +		break;
> +	}
> +	case XRT_ROOT_GET_ID: {
> +		struct xrt_root_get_id *id = (struct xrt_root_get_id *)arg;
> +
> +		id->xpigi_vendor_id = xr->pdev->vendor;
> +		id->xpigi_device_id = xr->pdev->device;
> +		id->xpigi_sub_vendor_id = xr->pdev->subsystem_vendor;
> +		id->xpigi_sub_device_id = xr->pdev->subsystem_device;
> +		break;
> +	}
> +
> +	/* MISC generic PCIE driver functions. */
> +	case XRT_ROOT_HOT_RESET: {
> +		xr->pf_cb.xpc_hot_reset(xr->pdev);
> +		break;
> +	}
> +	case XRT_ROOT_HWMON: {
> +		struct xrt_root_hwmon *hwmon = (struct xrt_root_hwmon *)arg;
> +
> +		if (hwmon->xpih_register) {
> +			hwmon->xpih_hwmon_dev =
> +				hwmon_device_register_with_info(DEV(xr->pdev),
> +								hwmon->xpih_name,
> +								hwmon->xpih_drvdata,
> +								NULL,
> +								hwmon->xpih_groups);
> +		} else {
> +			hwmon_device_unregister(hwmon->xpih_hwmon_dev);
> +		}
> +		break;
> +	}
> +
> +	default:
> +		xroot_err(xr, "unknown IOCTL cmd %d", cmd);
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +static void xroot_bringup_group_work(struct work_struct *work)
> +{
> +	struct platform_device *pdev = NULL;
> +	struct xroot *xr = container_of(work, struct xroot, groups.bringup_work);
> +
> +	while (xroot_get_group(xr, XROOT_GROUP_FIRST, &pdev) != -ENOENT) {
> +		int r, i;
> +
> +		i = pdev->id;
> +		r = xleaf_call(pdev, XRT_GROUP_INIT_CHILDREN, NULL);
> +		xroot_put_group(xr, pdev);
> +		if (r == -EEXIST)
> +			continue; /* Already brough up, nothing to do. */
> +		if (r)
> +			atomic_inc(&xr->groups.bringup_failed);
> +
> +		xroot_group_trigger_event(xr, i, XRT_EVENT_POST_CREATION);
> +
> +		if (atomic_dec_and_test(&xr->groups.bringup_pending))
> +			complete(&xr->groups.bringup_comp);
> +	}
> +}
> +
> +static void xroot_groups_init(struct xroot *xr)
ok
> +{
> +	xrt_subdev_pool_init(DEV(xr->pdev), &xr->groups.pool);
> +	INIT_WORK(&xr->groups.bringup_work, xroot_bringup_group_work);
> +	atomic_set(&xr->groups.bringup_pending, 0);
> +	atomic_set(&xr->groups.bringup_failed, 0);
> +	init_completion(&xr->groups.bringup_comp);
> +}
> +
> +static void xroot_groups_fini(struct xroot *xr)
> +{
> +	flush_scheduled_work();
> +	xrt_subdev_pool_fini(&xr->groups.pool);
> +}
> +
> +int xroot_add_vsec_node(void *root, char *dtb)
> +{
> +	struct xroot *xr = (struct xroot *)root;
> +	struct device *dev = DEV(xr->pdev);
> +	struct xrt_md_endpoint ep = { 0 };
> +	int cap = 0, ret = 0;
> +	u32 off_low, off_high, vsec_bar, header;
> +	u64 vsec_off;
> +
> +	while ((cap = pci_find_next_ext_capability(xr->pdev, cap, PCI_EXT_CAP_ID_VNDR))) {
> +		pci_read_config_dword(xr->pdev, cap + PCI_VNDR_HEADER, &header);
> +		if (PCI_VNDR_HEADER_ID(header) == XRT_VSEC_ID)
> +			break;
> +	}
> +	if (!cap) {
> +		xroot_info(xr, "No Vendor Specific Capability.");
> +		return -ENOENT;
> +	}
> +
> +	if (pci_read_config_dword(xr->pdev, cap + 8, &off_low) ||
> +	    pci_read_config_dword(xr->pdev, cap + 12, &off_high)) {
> +		xroot_err(xr, "pci_read vendor specific failed.");
> +		return -EINVAL;
> +	}
> +
> +	ep.ep_name = XRT_MD_NODE_VSEC;
> +	ret = xrt_md_add_endpoint(dev, dtb, &ep);
> +	if (ret) {
> +		xroot_err(xr, "add vsec metadata failed, ret %d", ret);
> +		goto failed;
> +	}
> +
> +	vsec_bar = cpu_to_be32(off_low & 0xf);
> +	ret = xrt_md_set_prop(dev, dtb, XRT_MD_NODE_VSEC, NULL,
> +			      XRT_MD_PROP_BAR_IDX, &vsec_bar, sizeof(vsec_bar));
> +	if (ret) {
> +		xroot_err(xr, "add vsec bar idx failed, ret %d", ret);
> +		goto failed;
> +	}
> +
> +	vsec_off = cpu_to_be64(((u64)off_high << 32) | (off_low & ~0xfU));
> +	ret = xrt_md_set_prop(dev, dtb, XRT_MD_NODE_VSEC, NULL,
> +			      XRT_MD_PROP_OFFSET, &vsec_off, sizeof(vsec_off));
> +	if (ret) {
> +		xroot_err(xr, "add vsec offset failed, ret %d", ret);
> +		goto failed;
> +	}
> +
> +failed:
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xroot_add_vsec_node);
> +
> +int xroot_add_simple_node(void *root, char *dtb, const char *endpoint)
> +{
> +	struct xroot *xr = (struct xroot *)root;
> +	struct device *dev = DEV(xr->pdev);
> +	struct xrt_md_endpoint ep = { 0 };
> +	int ret = 0;
> +
> +	ep.ep_name = endpoint;
> +	ret = xrt_md_add_endpoint(dev, dtb, &ep);
> +	if (ret)
> +		xroot_err(xr, "add %s failed, ret %d", endpoint, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xroot_add_simple_node);
> +
> +bool xroot_wait_for_bringup(void *root)
> +{
> +	struct xroot *xr = (struct xroot *)root;
> +
> +	wait_for_completion(&xr->groups.bringup_comp);
> +	return atomic_read(&xr->groups.bringup_failed) == 0;

ok

Tom

> +}
> +EXPORT_SYMBOL_GPL(xroot_wait_for_bringup);
> +
> +int xroot_probe(struct pci_dev *pdev, struct xroot_physical_function_callback *cb, void **root)
> +{
> +	struct device *dev = DEV(pdev);
> +	struct xroot *xr = NULL;
> +
> +	dev_info(dev, "%s: probing...", __func__);
> +
> +	xr = devm_kzalloc(dev, sizeof(*xr), GFP_KERNEL);
> +	if (!xr)
> +		return -ENOMEM;
> +
> +	xr->pdev = pdev;
> +	xr->pf_cb = *cb;
> +	xroot_groups_init(xr);
> +	xroot_event_init(xr);
> +
> +	*root = xr;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xroot_probe);
> +
> +void xroot_remove(void *root)
> +{
> +	struct xroot *xr = (struct xroot *)root;
> +	struct platform_device *grp = NULL;
> +
> +	xroot_info(xr, "leaving...");
> +
> +	if (xroot_get_group(xr, XROOT_GROUP_FIRST, &grp) == 0) {
> +		int instance = grp->id;
> +
> +		xroot_put_group(xr, grp);
> +		xroot_destroy_group(xr, instance);
> +	}
> +
> +	xroot_event_fini(xr);
> +	xroot_groups_fini(xr);
> +}
> +EXPORT_SYMBOL_GPL(xroot_remove);
> +
> +void xroot_broadcast(void *root, enum xrt_events evt)
> +{
> +	struct xroot *xr = (struct xroot *)root;
> +	struct xrt_event e = { 0 };
> +
> +	/* Root pf driver only broadcasts below two events. */
> +	if (evt != XRT_EVENT_POST_CREATION && evt != XRT_EVENT_PRE_REMOVAL) {
> +		xroot_info(xr, "invalid event %d", evt);
> +		return;
> +	}
> +
> +	e.xe_evt = evt;
> +	e.xe_subdev.xevt_subdev_id = XRT_ROOT;
> +	e.xe_subdev.xevt_subdev_instance = 0;
> +	xroot_trigger_event(xr, &e, false);
> +}
> +EXPORT_SYMBOL_GPL(xroot_broadcast);

