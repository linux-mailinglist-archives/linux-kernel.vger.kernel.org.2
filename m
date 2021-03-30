Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9072934E7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhC3Mw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232082AbhC3Mwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617108765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9oSi5GGbNgg3M8lWW4k8B79yTQ6t68lBDupcdj/YAPo=;
        b=LKanRNRZLwOpk7p/Prmk+t067fpEf8xF4p7YhlYBVS6OWneHYwXMN1cIl7f4dNA+Vi/x35
        vi0qPmdlp/OH261dc/F6cGKvKw30kIBHkamfVC7vTHo+9FbibAsky9buk0j/YC6DbuF5xd
        ylI7ayZccfJGeXVIX0q3rBKIl6/MxIw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498--hYZW0jSMymSgcCTC_-oxg-1; Tue, 30 Mar 2021 08:52:43 -0400
X-MC-Unique: -hYZW0jSMymSgcCTC_-oxg-1
Received: by mail-qk1-f198.google.com with SMTP id y9so14351261qki.14
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 05:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9oSi5GGbNgg3M8lWW4k8B79yTQ6t68lBDupcdj/YAPo=;
        b=F/xTBHYlpr97v5SkfqyEWIqZHcVlNHye2SxiSbYfUea5y9Msp1AdUHxot54HjgF5e/
         Lj3b7nkK5mR+sTKJgTifDRRgf/cfkKB+6CA9GQp9eLAjkLy5vOf28qrvxwfEBBQ0JisD
         YtDGSI3sW5KYjbbfyz61P+1TjYidamHtCIkp4lN3QIDLt6YN5ieO6Tr2YG0sPi2LQ88M
         Er0D9lqPpBg1CikgYvC2AUobssWsPDxX0rfu5cgXa7PJzoocXs6W7JLTGvz7W9YBgBWG
         Cvu8hvxddoG98AaVDzdw0QkkjAVJhzO0uHVmrbCqj2OlMy7ue2LEzveIhNvzw9HW0Ewp
         z7eQ==
X-Gm-Message-State: AOAM533gKCB8c6jq9dt4rWNOX9xBvAIihkTSKgM1f8fquSG/SswNhpFy
        epE15o/CHW1hKV5j13LFC8yrrK81xHR4MtTzXZGhrAMah5h5ZJSf04+yxCBxvaZyZBwzphPfOsQ
        5ZasyZEFeefBSRKtoEjPimh+N
X-Received: by 2002:a05:622a:205:: with SMTP id b5mr27040426qtx.186.1617108762559;
        Tue, 30 Mar 2021 05:52:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynqNHTarV57tBqudl5ZzuOPufRHj6cm0jPX5JnCnQR3VGsjjwVPe7pzb5WqDow2URPRXRPww==
X-Received: by 2002:a05:622a:205:: with SMTP id b5mr27040396qtx.186.1617108762231;
        Tue, 30 Mar 2021 05:52:42 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v11sm12701178qtx.79.2021.03.30.05.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 05:52:41 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 05/20] fpga: xrt: group platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org,
        Max Zhen <max.zhen@xilinx.com>
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-6-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <692776f1-ed9f-5013-a0bf-d6c97d355369@redhat.com>
Date:   Tue, 30 Mar 2021 05:52:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-6-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/21 10:29 PM, Lizhi Hou wrote:
> group driver that manages life cycle of a bunch of leaf driver instances
> and bridges them with root.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/fpga/xrt/include/group.h |  25 +++
>  drivers/fpga/xrt/lib/group.c     | 286 +++++++++++++++++++++++++++++++
>  2 files changed, 311 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/group.h
>  create mode 100644 drivers/fpga/xrt/lib/group.c
>
> diff --git a/drivers/fpga/xrt/include/group.h b/drivers/fpga/xrt/include/group.h
> new file mode 100644
> index 000000000000..09e9d03f53fe
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/group.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
ok, removed generic boilerplate
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_GROUP_H_
> +#define _XRT_GROUP_H_
> +
> +#include "xleaf.h"
move header to another patch
> +
> +/*
> + * Group driver leaf calls.
ok
> + */
> +enum xrt_group_leaf_cmd {
> +	XRT_GROUP_GET_LEAF = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
ok
> +	XRT_GROUP_PUT_LEAF,
> +	XRT_GROUP_INIT_CHILDREN,
> +	XRT_GROUP_FINI_CHILDREN,
> +	XRT_GROUP_TRIGGER_EVENT,
> +};
> +
> +#endif	/* _XRT_GROUP_H_ */
> diff --git a/drivers/fpga/xrt/lib/group.c b/drivers/fpga/xrt/lib/group.c
> new file mode 100644
> index 000000000000..7b8716569641
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/group.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA Group Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include "xleaf.h"
> +#include "subdev_pool.h"
> +#include "group.h"
> +#include "metadata.h"
> +#include "lib-drv.h"
> +
> +#define XRT_GRP "xrt_group"
> +
> +struct xrt_group {
> +	struct platform_device *pdev;
> +	struct xrt_subdev_pool leaves;
> +	bool leaves_created;
> +	struct mutex lock; /* lock for group */
> +};
> +
> +static int xrt_grp_root_cb(struct device *dev, void *parg,
> +			   enum xrt_root_cmd cmd, void *arg)
ok
> +{
> +	int rc;
> +	struct platform_device *pdev =
> +		container_of(dev, struct platform_device, dev);
> +	struct xrt_group *xg = (struct xrt_group *)parg;
> +
> +	switch (cmd) {
> +	case XRT_ROOT_GET_LEAF_HOLDERS: {
> +		struct xrt_root_get_holders *holders =
> +			(struct xrt_root_get_holders *)arg;
> +		rc = xrt_subdev_pool_get_holders(&xg->leaves,
> +						 holders->xpigh_pdev,
> +						 holders->xpigh_holder_buf,
> +						 holders->xpigh_holder_buf_len);
> +		break;
> +	}
> +	default:
> +		/* Forward parent call to root. */
> +		rc = xrt_subdev_root_request(pdev, cmd, arg);
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +/*
> + * Cut subdev's dtb from group's dtb based on passed-in endpoint descriptor.
> + * Return the subdev's dtb through dtbp, if found.
> + */
> +static int xrt_grp_cut_subdev_dtb(struct xrt_group *xg, struct xrt_subdev_endpoints *eps,
> +				  char *grp_dtb, char **dtbp)
> +{
> +	int ret, i, ep_count = 0;
> +	char *dtb = NULL;
> +
> +	ret = xrt_md_create(DEV(xg->pdev), &dtb);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; eps->xse_names[i].ep_name || eps->xse_names[i].regmap_name; i++) {
> +		const char *ep_name = eps->xse_names[i].ep_name;
> +		const char *reg_name = eps->xse_names[i].regmap_name;
> +
> +		if (!ep_name)
> +			xrt_md_get_compatible_endpoint(DEV(xg->pdev), grp_dtb, reg_name, &ep_name);
> +		if (!ep_name)
> +			continue;
> +
> +		ret = xrt_md_copy_endpoint(DEV(xg->pdev), dtb, grp_dtb, ep_name, reg_name, NULL);
> +		if (ret)
> +			continue;
> +		xrt_md_del_endpoint(DEV(xg->pdev), grp_dtb, ep_name, reg_name);
> +		ep_count++;
> +	}
> +	/* Found enough endpoints, return the subdev's dtb. */
> +	if (ep_count >= eps->xse_min_ep) {
> +		*dtbp = dtb;
> +		return 0;
> +	}
> +
> +	/* Cleanup - Restore all endpoints that has been deleted, if any. */
> +	if (ep_count > 0) {
> +		xrt_md_copy_endpoint(DEV(xg->pdev), grp_dtb, dtb,
> +				     XRT_MD_NODE_ENDPOINTS, NULL, NULL);
> +	}
> +	vfree(dtb);
> +	*dtbp = NULL;
> +	return 0;
> +}
> +
> +static int xrt_grp_create_leaves(struct xrt_group *xg)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(xg->pdev);
> +	struct xrt_subdev_endpoints *eps = NULL;
> +	int ret = 0, failed = 0;
> +	enum xrt_subdev_id did;
> +	char *grp_dtb = NULL;
> +	unsigned long mlen;
> +
> +	if (!pdata)
> +		return -EINVAL;
ok
> +
> +	mlen = xrt_md_size(DEV(xg->pdev), pdata->xsp_dtb);
> +	if (mlen == XRT_MD_INVALID_LENGTH) {
> +		xrt_err(xg->pdev, "invalid dtb, len %ld", mlen);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&xg->lock);
> +
> +	if (xg->leaves_created) {
> +		mutex_unlock(&xg->lock);
add a comment that this is not an error and/or error is handled elsewhere
> +		return -EEXIST;
> +	}
> +
> +	grp_dtb = vmalloc(mlen);
> +	if (!grp_dtb) {
> +		mutex_unlock(&xg->lock);
> +		return -ENOMEM;
ok
> +	}
> +
> +	/* Create all leaves based on dtb. */
> +	xrt_info(xg->pdev, "bringing up leaves...");
> +	memcpy(grp_dtb, pdata->xsp_dtb, mlen);
> +	for (did = 0; did < XRT_SUBDEV_NUM; did++) {
ok
> +		eps = xrt_drv_get_endpoints(did);
> +		while (eps && eps->xse_names) {
> +			char *dtb = NULL;
> +
> +			ret = xrt_grp_cut_subdev_dtb(xg, eps, grp_dtb, &dtb);
> +			if (ret) {
> +				failed++;
> +				xrt_err(xg->pdev, "failed to cut subdev dtb for drv %s: %d",
> +					xrt_drv_name(did), ret);
> +			}
> +			if (!dtb) {
> +				/*
> +				 * No more dtb to cut or bad things happened for this instance,
> +				 * switch to the next one.
> +				 */
> +				eps++;
> +				continue;
> +			}
> +
> +			/* Found a dtb for this instance, let's add it. */
> +			ret = xrt_subdev_pool_add(&xg->leaves, did, xrt_grp_root_cb, xg, dtb);
> +			if (ret < 0) {
> +				failed++;
> +				xrt_err(xg->pdev, "failed to add %s: %d", xrt_drv_name(did), ret);

add a comment that this is not a fatal error and cleanup happens elsewhere

Tom

> +			}
> +			vfree(dtb);
> +			/* Continue searching for the same instance from grp_dtb. */
> +		}
> +	}
> +
> +	xg->leaves_created = true;
> +	vfree(grp_dtb);
> +	mutex_unlock(&xg->lock);
> +	return failed == 0 ? 0 : -ECHILD;
> +}
> +
> +static void xrt_grp_remove_leaves(struct xrt_group *xg)
> +{
> +	mutex_lock(&xg->lock);
> +
> +	if (!xg->leaves_created) {
> +		mutex_unlock(&xg->lock);
> +		return;
> +	}
> +
> +	xrt_info(xg->pdev, "tearing down leaves...");
> +	xrt_subdev_pool_fini(&xg->leaves);
> +	xg->leaves_created = false;
> +
> +	mutex_unlock(&xg->lock);
> +}
> +
> +static int xrt_grp_probe(struct platform_device *pdev)
> +{
> +	struct xrt_group *xg;
> +
> +	xrt_info(pdev, "probing...");
> +
> +	xg = devm_kzalloc(&pdev->dev, sizeof(*xg), GFP_KERNEL);
> +	if (!xg)
> +		return -ENOMEM;
> +
> +	xg->pdev = pdev;
> +	mutex_init(&xg->lock);
> +	xrt_subdev_pool_init(DEV(pdev), &xg->leaves);
> +	platform_set_drvdata(pdev, xg);
> +
> +	return 0;
> +}
> +
> +static int xrt_grp_remove(struct platform_device *pdev)
> +{
> +	struct xrt_group *xg = platform_get_drvdata(pdev);
> +
> +	xrt_info(pdev, "leaving...");
> +	xrt_grp_remove_leaves(xg);
> +	return 0;
> +}
> +
> +static int xrt_grp_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	int rc = 0;
> +	struct xrt_group *xg = platform_get_drvdata(pdev);
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		/* Simply forward to every child. */
> +		xrt_subdev_pool_handle_event(&xg->leaves,
> +					     (struct xrt_event *)arg);
> +		break;
> +	case XRT_GROUP_GET_LEAF: {
> +		struct xrt_root_get_leaf *get_leaf =
> +			(struct xrt_root_get_leaf *)arg;
> +
> +		rc = xrt_subdev_pool_get(&xg->leaves, get_leaf->xpigl_match_cb,
> +					 get_leaf->xpigl_match_arg,
> +					 DEV(get_leaf->xpigl_caller_pdev),
> +					 &get_leaf->xpigl_tgt_pdev);
> +		break;
> +	}
> +	case XRT_GROUP_PUT_LEAF: {
> +		struct xrt_root_put_leaf *put_leaf =
> +			(struct xrt_root_put_leaf *)arg;
> +
> +		rc = xrt_subdev_pool_put(&xg->leaves, put_leaf->xpipl_tgt_pdev,
> +					 DEV(put_leaf->xpipl_caller_pdev));
> +		break;
> +	}
> +	case XRT_GROUP_INIT_CHILDREN:
> +		rc = xrt_grp_create_leaves(xg);
> +		break;
> +	case XRT_GROUP_FINI_CHILDREN:
> +		xrt_grp_remove_leaves(xg);
> +		break;
> +	case XRT_GROUP_TRIGGER_EVENT:
> +		xrt_subdev_pool_trigger_event(&xg->leaves, (enum xrt_events)(uintptr_t)arg);
> +		break;
> +	default:
> +		xrt_err(pdev, "unknown IOCTL cmd %d", cmd);
> +		rc = -EINVAL;
> +		break;
> +	}
> +	return rc;
> +}
> +
> +static struct xrt_subdev_drvdata xrt_grp_data = {
> +	.xsd_dev_ops = {
> +		.xsd_leaf_call = xrt_grp_leaf_call,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_grp_id_table[] = {
> +	{ XRT_GRP, (kernel_ulong_t)&xrt_grp_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_group_driver = {
> +	.driver	= {
> +		.name    = XRT_GRP,
> +	},
> +	.probe   = xrt_grp_probe,
> +	.remove  = xrt_grp_remove,
> +	.id_table = xrt_grp_id_table,
> +};
> +
> +void group_leaf_init_fini(bool init)
> +{
> +	if (init)
> +		xleaf_register_driver(XRT_SUBDEV_GRP, &xrt_group_driver, NULL);
> +	else
> +		xleaf_unregister_driver(XRT_SUBDEV_GRP);
> +}

