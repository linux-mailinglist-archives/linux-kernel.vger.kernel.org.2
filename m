Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B173223B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhBWB03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 20:26:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231262AbhBWBZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614043429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sMttDdT9KnlpbQXFcJ+I+niuvN1pFmeqGXjoCpLCyco=;
        b=W0H8QbFQIMtBn8pI/4hrJC9UJ7/aGp+i49sXJ5Ml+8qJvcE0qYCu0kABZK+L22m52n4bCm
        ZnxCX/VikNx3v43X0bsTn/gBLjcGLzryHyybVv2QzbYP41PK0cSp+vFRzK9TtZKGmCJvqf
        F2X80H9Tjgy9aXG3SmOZg3jytNqPCb4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-PyhSbnXjMn-VvpKcSx8eEg-1; Mon, 22 Feb 2021 20:23:47 -0500
X-MC-Unique: PyhSbnXjMn-VvpKcSx8eEg-1
Received: by mail-qk1-f200.google.com with SMTP id k2so6145464qkh.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sMttDdT9KnlpbQXFcJ+I+niuvN1pFmeqGXjoCpLCyco=;
        b=N0gGb570/zviCsm+0N+DGhsodhppBCOkiqwtmxQQgOXXaEtKcC3vI28k0bludlkOFB
         ft30KPmhOVeW5LXDoQjvYHEtaRvzud6e8CyZyRp0ZAuSMuD8JOsR9ZwkDNsw2zySQ5n1
         ETjG0WItsw9520fB8HqaybZL80Q+mq2qmiua9R7KEzPjqMV9XV0a9uvzXAC+G5iaFoEN
         GLaEg2jRhEzIM9HY51uraMB4BsxbgewlP+G3H9Wxkkwg0Vp7w1Dp/yXAAuXJeecrJHn+
         4C91LWAByA3RjzMzf7vX+2oL8Eo9uWjzkRnT9vNNtZ5c+fkfFPsNmpD7DT4tESCIlPng
         xd1Q==
X-Gm-Message-State: AOAM530JDuvsGXu+w4zs2Dae9tugGnlSYU3jipi0n7WsYBF+Y1K3pp8C
        J5TaXYBfF/r/QP/yjyZDL/lWzsklQDIyF+uKhhwn+fJYAGiY4Bi1TcEdxEvRzdWk5Zp0XNpJhhM
        NZdyxkFsiUkyqWIneNlu5CsXn
X-Received: by 2002:a05:6214:262a:: with SMTP id gv10mr23628195qvb.50.1614043426556;
        Mon, 22 Feb 2021 17:23:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5j78aZxF6lbQF8anjrFOpfHjjs0Niq/ZkXdgg1/HIWh4C6uBIRW0v6G80PRLKec+asRtbhw==
X-Received: by 2002:a05:6214:262a:: with SMTP id gv10mr23628168qvb.50.1614043426210;
        Mon, 22 Feb 2021 17:23:46 -0800 (PST)
Received: from localhost (cpe-70-95-20-182.san.res.rr.com. [70.95.20.182])
        by smtp.gmail.com with ESMTPSA id f21sm13172473qka.11.2021.02.22.17.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 17:23:45 -0800 (PST)
Date:   Mon, 22 Feb 2021 17:23:44 -0800
From:   Fernando Pacheco <fpacheco@redhat.com>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, Lizhi Hou <lizhih@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com,
        mdf@kernel.org, robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V3 XRT Alveo 02/18] fpga: xrt: driver metadata helper
 functions
Message-ID: <20210223012344.GB746169@mail.gmail.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-3-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218064019.29189-3-lizhih@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 10:40:03PM -0800, Lizhi Hou wrote:
> XRT drivers use device tree as metadata format to discover HW subsystems
> behind PCIe BAR. Thus libfdt functions are called for driver to parse
> device tree blob.
> 
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/include/metadata.h  | 229 ++++++++++++
>  drivers/fpga/xrt/metadata/metadata.c | 524 +++++++++++++++++++++++++++
>  2 files changed, 753 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/metadata.h
>  create mode 100644 drivers/fpga/xrt/metadata/metadata.c
> 
> diff --git a/drivers/fpga/xrt/include/metadata.h b/drivers/fpga/xrt/include/metadata.h
> new file mode 100644
> index 000000000000..b929bc469b73
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/metadata.h
> @@ -0,0 +1,229 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Xilinx Runtime (XRT) driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *      Lizhi Hou <Lizhi.Hou@xilinx.com>
> + */
> +
> +#ifndef _XRT_METADATA_H
> +#define _XRT_METADATA_H
> +
> +#include <linux/device.h>
> +#include <linux/vmalloc.h>
> +#include <linux/uuid.h>
> +
> +#define XRT_MD_INVALID_LENGTH (~0UL)
> +
> +#define XRT_MD_PROP_COMPATIBLE "compatible"
> +#define XRT_MD_PROP_PF_NUM "pcie_physical_function"
> +#define XRT_MD_PROP_BAR_IDX "pcie_bar_mapping"
> +#define XRT_MD_PROP_IO_OFFSET "reg"
> +#define XRT_MD_PROP_INTERRUPTS "interrupts"
> +#define XRT_MD_PROP_INTERFACE_UUID "interface_uuid"
> +#define XRT_MD_PROP_LOGIC_UUID "logic_uuid"
> +#define XRT_MD_PROP_VERSION_MAJOR "firmware_version_major"
> +
> +#define XRT_MD_PROP_HWICAP "axi_hwicap"
> +#define XRT_MD_PROP_PDI_CONFIG "pdi_config_mem"
> +
> +#define XRT_MD_NODE_ENDPOINTS "addressable_endpoints"
> +#define XRT_MD_INTERFACES_PATH "/interfaces"
> +
> +#define XRT_MD_NODE_FIRMWARE "firmware"
> +#define XRT_MD_NODE_INTERFACES "interfaces"
> +#define XRT_MD_NODE_PARTITION_INFO "partition_info"
> +
> +#define XRT_MD_NODE_FLASH "ep_card_flash_program_00"
> +#define XRT_MD_NODE_XVC_PUB "ep_debug_bscan_user_00"
> +#define XRT_MD_NODE_XVC_PRI "ep_debug_bscan_mgmt_00"
> +#define XRT_MD_NODE_SYSMON "ep_cmp_sysmon_00"
> +#define XRT_MD_NODE_AF_BLP_CTRL_MGMT "ep_firewall_blp_ctrl_mgmt_00"
> +#define XRT_MD_NODE_AF_BLP_CTRL_USER "ep_firewall_blp_ctrl_user_00"
> +#define XRT_MD_NODE_AF_CTRL_MGMT "ep_firewall_ctrl_mgmt_00"
> +#define XRT_MD_NODE_AF_CTRL_USER "ep_firewall_ctrl_user_00"
> +#define XRT_MD_NODE_AF_CTRL_DEBUG "ep_firewall_ctrl_debug_00"
> +#define XRT_MD_NODE_AF_DATA_H2C "ep_firewall_data_h2c_00"
> +#define XRT_MD_NODE_AF_DATA_C2H "ep_firewall_data_c2h_00"
> +#define XRT_MD_NODE_AF_DATA_P2P "ep_firewall_data_p2p_00"
> +#define XRT_MD_NODE_AF_DATA_M2M "ep_firewall_data_m2m_00"
> +#define XRT_MD_NODE_CMC_REG "ep_cmc_regmap_00"
> +#define XRT_MD_NODE_CMC_RESET "ep_cmc_reset_00"
> +#define XRT_MD_NODE_CMC_MUTEX "ep_cmc_mutex_00"
> +#define XRT_MD_NODE_CMC_FW_MEM "ep_cmc_firmware_mem_00"
> +#define XRT_MD_NODE_ERT_FW_MEM "ep_ert_firmware_mem_00"
> +#define XRT_MD_NODE_ERT_CQ_MGMT "ep_ert_command_queue_mgmt_00"
> +#define XRT_MD_NODE_ERT_CQ_USER "ep_ert_command_queue_user_00"
> +#define XRT_MD_NODE_MAILBOX_MGMT "ep_mailbox_mgmt_00"
> +#define XRT_MD_NODE_MAILBOX_USER "ep_mailbox_user_00"
> +#define XRT_MD_NODE_GATE_PLP "ep_pr_isolate_plp_00"
> +#define XRT_MD_NODE_GATE_ULP "ep_pr_isolate_ulp_00"
> +#define XRT_MD_NODE_PCIE_MON "ep_pcie_link_mon_00"
> +#define XRT_MD_NODE_DDR_CALIB "ep_ddr_mem_calib_00"
> +#define XRT_MD_NODE_CLK_KERNEL1 "ep_aclk_kernel_00"
> +#define XRT_MD_NODE_CLK_KERNEL2 "ep_aclk_kernel_01"
> +#define XRT_MD_NODE_CLK_KERNEL3 "ep_aclk_hbm_00"
> +#define XRT_MD_NODE_KDMA_CTRL "ep_kdma_ctrl_00"
> +#define XRT_MD_NODE_FPGA_CONFIG "ep_fpga_configuration_00"
> +#define XRT_MD_NODE_ERT_SCHED "ep_ert_sched_00"
> +#define XRT_MD_NODE_XDMA "ep_xdma_00"
> +#define XRT_MD_NODE_MSIX "ep_msix_00"
> +#define XRT_MD_NODE_QDMA "ep_qdma_00"
> +#define XRT_MD_XRT_MD_NODE_QDMA4 "ep_qdma4_00"
> +#define XRT_MD_NODE_STM "ep_stream_traffic_manager_00"
> +#define XRT_MD_NODE_STM4 "ep_stream_traffic_manager4_00"
> +#define XRT_MD_NODE_CLK_SHUTDOWN "ep_aclk_shutdown_00"
> +#define XRT_MD_NODE_ERT_BASE "ep_ert_base_address_00"
> +#define XRT_MD_NODE_ERT_RESET "ep_ert_reset_00"
> +#define XRT_MD_NODE_CLKFREQ_K1 "ep_freq_cnt_aclk_kernel_00"
> +#define XRT_MD_NODE_CLKFREQ_K2 "ep_freq_cnt_aclk_kernel_01"
> +#define XRT_MD_NODE_CLKFREQ_HBM "ep_freq_cnt_aclk_hbm_00"
> +#define XRT_MD_NODE_GAPPING "ep_gapping_demand_00"
> +#define XRT_MD_NODE_UCS_CONTROL_STATUS "ep_ucs_control_status_00"
> +#define XRT_MD_NODE_P2P "ep_p2p_00"
> +#define XRT_MD_NODE_REMAP_P2P "ep_remap_p2p_00"
> +#define XRT_MD_NODE_DDR4_RESET_GATE "ep_ddr_mem_srsr_gate_00"
> +#define XRT_MD_NODE_ADDR_TRANSLATOR "ep_remap_data_c2h_00"
> +#define XRT_MD_NODE_MAILBOX_XRT "ep_mailbox_user_to_ert_00"
> +#define XRT_MD_NODE_PMC_INTR   "ep_pmc_intr_00"
> +#define XRT_MD_NODE_PMC_MUX    "ep_pmc_mux_00"
> +
> +/* driver defined endpoints */
> +#define XRT_MD_NODE_VSEC "drv_ep_vsec_00"
> +#define XRT_MD_NODE_VSEC_GOLDEN "drv_ep_vsec_golden_00"
> +#define XRT_MD_NODE_BLP_ROM "drv_ep_blp_rom_00"
> +#define XRT_MD_NODE_MAILBOX_VSEC "ep_mailbox_vsec_00"

Should this be "drv_ep_mailbox_vsec_00"?

> +#define XRT_MD_NODE_PLAT_INFO "drv_ep_platform_info_mgmt_00"
> +#define XRT_MD_NODE_TEST "drv_ep_test_00"
> +#define XRT_MD_NODE_MGMT_MAIN "drv_ep_mgmt_main_00"
> +#define XRT_MD_NODE_FLASH_VSEC "drv_ep_card_flash_program_00"
> +#define XRT_MD_NODE_GOLDEN_VER "drv_ep_golden_ver_00"
> +#define XRT_MD_XRT_MD_NODE_PARTITION_INFO_BLP "partition_info_0"
> +#define XRT_MD_XRT_MD_NODE_PARTITION_INFO_PLP "partition_info_1"
> +
> +#define XRT_MD_NODE_DDR_SRSR "drv_ep_ddr_srsr"
> +#define XRT_MD_REGMAP_DDR_SRSR "drv_ddr_srsr"
> +
> +#define XRT_MD_PROP_OFFSET "drv_offset"
> +#define XRT_MD_PROP_CLK_FREQ "drv_clock_frequency"
> +#define XRT_MD_PROP_CLK_CNT "drv_clock_frequency_counter"
> +#define XRT_MD_PROP_VBNV "vbnv"
> +#define XRT_MD_PROP_VROM "vrom"
> +#define XRT_MD_PROP_PARTITION_LEVEL "partition_level"
> +
> +struct xrt_md_endpoint {
> +	const char	*ep_name;
> +	u32		bar;
> +	long		bar_off;
> +	ulong		size;
> +	char		*regmap;
> +	char		*regmap_ver;
> +};
> +
> +/* Note: res_id is defined by leaf driver and must start with 0. */
> +struct xrt_iores_map {
> +	char		*res_name;
> +	int		res_id;
> +};
> +
> +static inline int xrt_md_res_name2id(const struct xrt_iores_map *res_map,
> +				     int entry_num, const char *res_name)
> +{
> +	int i;
> +
> +	for (i = 0; i < entry_num; i++) {
> +		if (!strcmp(res_name, res_map->res_name))
> +			return res_map->res_id;
> +		res_map++;
> +	}
> +	return -1;
> +}
> +
> +static inline const char *
> +xrt_md_res_id2name(const struct xrt_iores_map *res_map, int entry_num, int id)
> +{
> +	int i;
> +
> +	for (i = 0; i < entry_num; i++) {
> +		if (res_map->res_id == id)
> +			return res_map->res_name;
> +		res_map++;
> +	}
> +	return NULL;
> +}
> +
> +unsigned long xrt_md_size(struct device *dev, const char *blob);
> +int xrt_md_create(struct device *dev, char **blob);
> +int xrt_md_add_endpoint(struct device *dev, char *blob,
> +			struct xrt_md_endpoint *ep);
> +int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
> +			char *regmap_name);
> +int xrt_md_get_prop(struct device *dev, const char *blob, const char *ep_name,
> +		    const char *regmap_name, const char *prop,
> +		    const void **val, int *size);
> +int xrt_md_set_prop(struct device *dev, char *blob, const char *ep_name,
> +		    const char *regmap_name, const char *prop,
> +		    const void *val, int size);
> +int xrt_md_copy_endpoint(struct device *dev, char *blob, const char *src_blob,
> +			 const char *ep_name, const char *regmap_name,
> +			 const char *new_ep_name);
> +int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
> +			     const char *ep_name,  const char *regmap_name,
> +			     char **next_ep, char **next_regmap);
> +int xrt_md_get_compatible_endpoint(struct device *dev, const char *blob,
> +				   const char *regmap_name, const char **ep_name);
> +int xrt_md_find_endpoint(struct device *dev, const char *blob,
> +			 const char *ep_name, const char *regmap_name,
> +			 const char **epname);
> +void xrt_md_pack(struct device *dev, char *blob);
> +char *xrt_md_dup(struct device *dev, const char *blob);
> +int xrt_md_get_intf_uuids(struct device *dev, const char *blob,
> +			  u32 *num_uuids, uuid_t *intf_uuids);
> +static inline int xrt_md_copy_all_endpoints(struct device *dev, char *blob, const char *src_blob)
> +{
> +	return xrt_md_copy_endpoint(dev, blob, src_blob, XRT_MD_NODE_ENDPOINTS,
> +				    NULL, NULL);
> +}
> +
> +/*
> + * Firmware provides 128 bit hash string as unque id of partition/interface.
> + * This string will be canonical textual representation in the future.
> + * Before that, introducing these two functions below to translate
> + * hash string to uuid_t for released hardware.
> + */
> +static inline void xrt_md_trans_uuid2str(const uuid_t *uuid, char *uuidstr)
> +{
> +	int i, p;
> +	u8 *u = (u8 *)uuid;
> +
> +	for (p = 0, i = sizeof(uuid_t) - 1; i >= 0; p++, i--)
> +		(void)snprintf(&uuidstr[p * 2], 3, "%02x", u[i]);
> +}
> +
> +static inline int xrt_md_trans_str2uuid(struct device *dev, const char *uuidstr, uuid_t *p_uuid)
> +{
> +	char *p;
> +	const char *str;
> +	char tmp[3] = { 0 };
> +	int i, ret;
> +
> +	memset(p_uuid, 0, sizeof(*p_uuid));
> +	p = (char *)p_uuid;
> +	str = uuidstr + strlen(uuidstr) - 2;
> +
> +	for (i = 0; i < sizeof(*p_uuid) && str >= uuidstr; i++) {
> +		tmp[0] = *str;
> +		tmp[1] = *(str + 1);
> +		ret = kstrtou8(tmp, 16, p);
> +		if (ret)
> +			return -EINVAL;
> +		p++;
> +		str -= 2;
> +	}
> +
> +	return 0;
> +}
> +
> +#endif
> diff --git a/drivers/fpga/xrt/metadata/metadata.c b/drivers/fpga/xrt/metadata/metadata.c
> new file mode 100644
> index 000000000000..5d106396f438
> --- /dev/null
> +++ b/drivers/fpga/xrt/metadata/metadata.c
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA Metadata parse APIs
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *      Lizhi Hou <Lizhi.Hou@xilinx.com>
> + */
> +
> +#include <linux/libfdt_env.h>
> +#include "libfdt.h"
> +#include "metadata.h"
> +
> +#define MAX_BLOB_SIZE	(4096 * 25)
> +
> +static int xrt_md_setprop(struct device *dev, char *blob, int offset,
> +			  const char *prop, const void *val, int size);
> +static int xrt_md_overlay(struct device *dev, char *blob, int target,
> +			  const char *overlay_blob, int overlay_offset);
> +static int xrt_md_get_endpoint(struct device *dev, const char *blob,
> +			       const char *ep_name, const char *regmap_name,
> +			       int *ep_offset);
> +
> +unsigned long xrt_md_size(struct device *dev, const char *blob)
> +{
> +	unsigned long len = (long)fdt_totalsize(blob);
> +
> +	len = (len > MAX_BLOB_SIZE) ? XRT_MD_INVALID_LENGTH : len;

how about (avoiding len = len):

	if (len > MAX_BLOB_SIZE)
		return XRT_MD_INVALID_LENGTH;

	return len;

> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_size);
> +
> +int xrt_md_create(struct device *dev, char **blob)
> +{
> +	int ret = 0;
> +
> +	WARN_ON(!blob);

Shouldn't this be signaled to caller as a -EINVAL?

> +
> +	*blob = vmalloc(MAX_BLOB_SIZE);
> +	if (!*blob)
> +		return -ENOMEM;
> +
> +	ret = fdt_create_empty_tree(*blob, MAX_BLOB_SIZE);
> +	if (ret) {
> +		dev_err(dev, "format blob failed, ret = %d", ret);
> +		goto failed;
> +	}
> +
> +	ret = fdt_next_node(*blob, -1, NULL);
> +	if (ret < 0) {
> +		dev_err(dev, "No Node, ret = %d", ret);
> +		goto failed;
> +	}
> +
> +	ret = fdt_add_subnode(*blob, ret, XRT_MD_NODE_ENDPOINTS);
> +	if (ret < 0) {
> +		dev_err(dev, "add node failed, ret = %d", ret);
> +		goto failed;
> +	}
> +
> +	return 0;
> +
> +failed:
> +	vfree(*blob);
> +	*blob = NULL;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_create);
> +
> +static int xrt_md_add_node(struct device *dev, char *blob, int parent_offset,
> +			   const char *ep_name)
> +{
> +	int ret;
> +
> +	ret = fdt_add_subnode(blob, parent_offset, ep_name);
> +	if (ret < 0 && ret != -FDT_ERR_EXISTS)
> +		dev_err(dev, "failed to add node %s. %d", ep_name, ret);
> +
> +	return ret;
> +}
> +
> +int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
> +			char *regmap_name)
> +{
> +	int ret;
> +	int ep_offset;
> +
> +	ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name, &ep_offset);
> +	if (ret) {
> +		dev_err(dev, "can not find ep %s", ep_name);
> +		return -EINVAL;
> +	}
> +
> +	ret = fdt_del_node(blob, ep_offset);
> +	if (ret)
> +		dev_err(dev, "delete node %s failed, ret %d", ep_name, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_del_endpoint);
> +
> +static int __xrt_md_add_endpoint(struct device *dev, char *blob,
> +				 struct xrt_md_endpoint *ep, int *offset, bool root)
> +{
> +	int ret = 0;
> +	int ep_offset = 0;
> +	u32 val, count = 0;
> +	u64 io_range[2];
> +	char comp[128];
> +
> +	if (!ep->ep_name) {
> +		dev_err(dev, "empty name");
> +		return -EINVAL;
> +	}
> +
> +	if (!root) {
> +		ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_ENDPOINTS, NULL,
> +					  &ep_offset);
> +		if (ret) {
> +			dev_err(dev, "invalid blob, ret = %d", ret);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ep_offset = xrt_md_add_node(dev, blob, ep_offset, ep->ep_name);

A little hard to follow when you re-use ep_offset like this. Maybe
parent_offset to match xrt_md_add_node parameter?

> +	if (ep_offset < 0) {
> +		dev_err(dev, "add endpoint failed, ret = %d", ret);
> +		return -EINVAL;
> +	}
> +	if (offset)
> +		*offset = ep_offset;
> +
> +	if (ep->size != 0) {
> +		val = cpu_to_be32(ep->bar);
> +		ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_BAR_IDX,
> +				     &val, sizeof(u32));
> +		if (ret) {
> +			dev_err(dev, "set %s failed, ret %d",
> +				XRT_MD_PROP_BAR_IDX, ret);
> +			goto failed;
> +		}
> +		io_range[0] = cpu_to_be64((u64)ep->bar_off);
> +		io_range[1] = cpu_to_be64((u64)ep->size);
> +		ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_IO_OFFSET,
> +				     io_range, sizeof(io_range));
> +		if (ret) {
> +			dev_err(dev, "set %s failed, ret %d",
> +				XRT_MD_PROP_IO_OFFSET, ret);
> +			goto failed;
> +		}
> +	}
> +
> +	if (ep->regmap) {
> +		if (ep->regmap_ver) {
> +			count = snprintf(comp, sizeof(comp),
> +					 "%s-%s", ep->regmap, ep->regmap_ver);
> +			count++;
> +		}
> +
> +		count += snprintf(comp + count, sizeof(comp) - count,
> +				  "%s", ep->regmap);
> +		count++;
> +
> +		ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_COMPATIBLE,
> +				     comp, count);
> +		if (ret) {
> +			dev_err(dev, "set %s failed, ret %d",
> +				XRT_MD_PROP_COMPATIBLE, ret);
> +			goto failed;
> +		}
> +	}
> +
> +failed:
> +	if (ret)
> +		xrt_md_del_endpoint(dev, blob, ep->ep_name, NULL);
> +
> +	return ret;
> +}
> +
> +int xrt_md_add_endpoint(struct device *dev, char *blob,
> +			struct xrt_md_endpoint *ep)
> +{
> +	return __xrt_md_add_endpoint(dev, blob, ep, NULL, false);
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_add_endpoint);
> +
> +static int xrt_md_get_endpoint(struct device *dev, const char *blob,
> +			       const char *ep_name, const char *regmap_name,
> +			       int *ep_offset)
> +{
> +	int offset;
> +	const char *name;
> +
> +	for (offset = fdt_next_node(blob, -1, NULL);
> +	    offset >= 0;
> +	    offset = fdt_next_node(blob, offset, NULL)) {
> +		name = fdt_get_name(blob, offset, NULL);
> +		if (!name || strncmp(name, ep_name, strlen(ep_name) + 1))
> +			continue;
> +		if (!regmap_name ||
> +		    !fdt_node_check_compatible(blob, offset, regmap_name))
> +			break;
> +	}
> +	if (offset < 0)
> +		return -ENODEV;
> +
> +	*ep_offset = offset;
> +
> +	return 0;
> +}
> +
> +int xrt_md_find_endpoint(struct device *dev, const char *blob,
> +			 const char *ep_name, const char *regmap_name,
> +			 const char **epname)
> +{
> +	int offset;
> +	int ret;
> +
> +	ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
> +				  &offset);
> +	if (!ret && epname && offset >= 0)
> +		*epname = fdt_get_name(blob, offset, NULL);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_find_endpoint);
> +
> +int xrt_md_get_prop(struct device *dev, const char *blob, const char *ep_name,
> +		    const char *regmap_name, const char *prop,
> +		    const void **val, int *size)
> +{
> +	int offset;
> +	int ret;
> +
> +	if (val)
> +		*val = NULL;
> +	if (ep_name) {
> +		ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
> +					  &offset);
> +		if (ret) {
> +			dev_err(dev, "cannot get ep %s, regmap %s, ret = %d",
> +				ep_name, regmap_name, ret);
> +			return -EINVAL;
> +		}
> +	} else {
> +		offset = fdt_next_node(blob, -1, NULL);
> +		if (offset < 0) {
> +			dev_err(dev, "internal error, ret = %d", offset);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (val) {
> +		*val = fdt_getprop(blob, offset, prop, size);
> +		if (!*val) {
> +			dev_dbg(dev, "get ep %s, prop %s failed", ep_name, prop);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_get_prop);
> +
> +static int xrt_md_setprop(struct device *dev, char *blob, int offset,
> +			  const char *prop, const void *val, int size)
> +{
> +	int ret;
> +
> +	ret = fdt_setprop(blob, offset, prop, val, size);
> +	if (ret)
> +		dev_err(dev, "failed to set prop %d", ret);
> +
> +	return ret;
> +}
> +
> +int xrt_md_set_prop(struct device *dev, char *blob,
> +		    const char *ep_name, const char *regmap_name,
> +		    const char *prop, const void *val, int size)
> +{
> +	int offset;
> +	int ret;
> +
> +	if (ep_name) {
> +		ret = xrt_md_get_endpoint(dev, blob, ep_name,
> +					  regmap_name, &offset);
> +		if (ret) {
> +			dev_err(dev, "cannot get node %s, ret = %d",
> +				ep_name, ret);
> +			return -EINVAL;
> +		}
> +	} else {
> +		offset = fdt_next_node(blob, -1, NULL);
> +		if (offset < 0) {
> +			dev_err(dev, "internal error, ret = %d", offset);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ret = xrt_md_setprop(dev, blob, offset, prop, val, size);
> +	if (ret)
> +		dev_err(dev, "set prop %s failed, ret = %d", prop, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_set_prop);
> +
> +int xrt_md_copy_endpoint(struct device *dev, char *blob, const char *src_blob,
> +			 const char *ep_name, const char *regmap_name,
> +			 const char *new_ep_name)
> +{
> +	int offset, target;
> +	int ret;
> +	struct xrt_md_endpoint ep = {0};
> +	const char *newepnm = new_ep_name ? new_ep_name : ep_name;
> +
> +	ret = xrt_md_get_endpoint(dev, src_blob, ep_name, regmap_name,
> +				  &offset);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = xrt_md_get_endpoint(dev, blob, newepnm, regmap_name, &target);
> +	if (ret) {
> +		ep.ep_name = newepnm;
> +		ret = __xrt_md_add_endpoint(dev, blob, &ep, &target,
> +					    fdt_parent_offset(src_blob, offset) == 0);
> +		if (ret)
> +			return -EINVAL;
> +	}
> +
> +	ret = xrt_md_overlay(dev, blob, target, src_blob, offset);
> +	if (ret)
> +		dev_err(dev, "overlay failed, ret = %d", ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_copy_endpoint);
> +
> +char *xrt_md_dup(struct device *dev, const char *blob)
> +{
> +	int ret;
> +	char *dup_blob;
> +
> +	ret = xrt_md_create(dev, &dup_blob);
> +	if (ret)
> +		return NULL;
> +	ret = xrt_md_overlay(dev, dup_blob, -1, blob, -1);
> +	if (ret) {
> +		vfree(dup_blob);
> +		return NULL;
> +	}
> +
> +	return dup_blob;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_dup);
> +
> +static int xrt_md_overlay(struct device *dev, char *blob, int target,
> +			  const char *overlay_blob, int overlay_offset)
> +{
> +	int	property, subnode;
> +	int	ret;
> +
> +	WARN_ON(!blob || !overlay_blob);

Why check !blob twice? Also, is a WARN_ON justified here
(and in xrt_md_create)?

Fernando

> +
> +	if (!blob) {
> +		dev_err(dev, "blob is NULL");
> +		return -EINVAL;
> +	}
> +
> +	if (target < 0) {
> +		target = fdt_next_node(blob, -1, NULL);
> +		if (target < 0) {
> +			dev_err(dev, "invalid target");
> +			return -EINVAL;
> +		}
> +	}
> +	if (overlay_offset < 0) {
> +		overlay_offset = fdt_next_node(overlay_blob, -1, NULL);
> +		if (overlay_offset < 0) {
> +			dev_err(dev, "invalid overlay");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	fdt_for_each_property_offset(property, overlay_blob, overlay_offset) {
> +		const char *name;
> +		const void *prop;
> +		int prop_len;
> +
> +		prop = fdt_getprop_by_offset(overlay_blob, property, &name,
> +					     &prop_len);
> +		if (!prop || prop_len >= MAX_BLOB_SIZE) {
> +			dev_err(dev, "internal error");
> +			return -EINVAL;
> +		}
> +
> +		ret = xrt_md_setprop(dev, blob, target, name, prop,
> +				     prop_len);
> +		if (ret) {
> +			dev_err(dev, "setprop failed, ret = %d", ret);
> +			return ret;
> +		}
> +	}
> +
> +	fdt_for_each_subnode(subnode, overlay_blob, overlay_offset) {
> +		const char *name = fdt_get_name(overlay_blob, subnode, NULL);
> +		int nnode;
> +
> +		nnode = xrt_md_add_node(dev, blob, target, name);
> +		if (nnode == -FDT_ERR_EXISTS)
> +			nnode = fdt_subnode_offset(blob, target, name);
> +		if (nnode < 0) {
> +			dev_err(dev, "add node failed, ret = %d", nnode);
> +			return nnode;
> +		}
> +
> +		ret = xrt_md_overlay(dev, blob, nnode, overlay_blob, subnode);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
> +			     const char *ep_name, const char *regmap_name,
> +			     char **next_ep, char **next_regmap)
> +{
> +	int offset, ret;
> +
> +	if (!ep_name) {
> +		ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_ENDPOINTS, NULL,
> +					  &offset);
> +	} else {
> +		ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
> +					  &offset);
> +	}
> +
> +	if (ret) {
> +		*next_ep = NULL;
> +		*next_regmap = NULL;
> +		return -EINVAL;
> +	}
> +
> +	offset = ep_name ? fdt_next_subnode(blob, offset) :
> +		fdt_first_subnode(blob, offset);
> +	if (offset < 0) {
> +		*next_ep = NULL;
> +		*next_regmap = NULL;
> +		return -EINVAL;
> +	}
> +
> +	*next_ep = (char *)fdt_get_name(blob, offset, NULL);
> +	*next_regmap = (char *)fdt_stringlist_get(blob, offset, XRT_MD_PROP_COMPATIBLE,
> +						  0, NULL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_get_next_endpoint);
> +
> +int xrt_md_get_compatible_endpoint(struct device *dev, const char *blob,
> +				   const char *regmap_name, const char **ep_name)
> +{
> +	int ep_offset;
> +
> +	ep_offset = fdt_node_offset_by_compatible(blob, -1, regmap_name);
> +	if (ep_offset < 0) {
> +		*ep_name = NULL;
> +		return -ENOENT;
> +	}
> +
> +	*ep_name = (char *)fdt_get_name(blob, ep_offset, NULL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_get_compatible_endpoint);
> +
> +void xrt_md_pack(struct device *dev, char *blob)
> +{
> +	int ret;
> +
> +	ret = fdt_pack(blob);
> +	if (ret)
> +		dev_err(dev, "pack failed %d", ret);
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_pack);
> +
> +int xrt_md_get_intf_uuids(struct device *dev, const char *blob,
> +			  u32 *num_uuids, uuid_t *intf_uuids)
> +{
> +	int offset, count = 0;
> +	int ret;
> +	const char *uuid_str;
> +
> +	ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_INTERFACES, NULL, &offset);
> +	if (ret)
> +		return -ENOENT;
> +
> +	for (offset = fdt_first_subnode(blob, offset);
> +	    offset >= 0;
> +	    offset = fdt_next_subnode(blob, offset)) {
> +		uuid_str = fdt_getprop(blob, offset, XRT_MD_PROP_INTERFACE_UUID,
> +				       NULL);
> +		if (!uuid_str) {
> +			dev_err(dev, "empty intf uuid node");
> +			return -EINVAL;
> +		}
> +
> +		if (intf_uuids && count < *num_uuids) {
> +			ret = xrt_md_trans_str2uuid(dev, uuid_str,
> +						    &intf_uuids[count]);
> +			if (ret)
> +				return -EINVAL;
> +		}
> +		count++;
> +	}
> +
> +	*num_uuids = count;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xrt_md_get_intf_uuids);
> -- 
> 2.18.4
> 

