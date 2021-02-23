Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05B63225AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBWGGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:06:36 -0500
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:44326
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229949AbhBWGG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:06:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzt9Oca6niumPLNRYX7tazNfPVqNwNmy0O2c5G6fiwQfSyS3AuJHL1MGe+SBzcIM+WhrfWlEqO66FTeSJJXfWLB1Z97Cq1N9yHs95uDpi0Dq/OY0IR125B+PFgw10JBLmaX7KzxAa0VDelArED+PtfPXSvsQtglLv+rSSISNw6LOIMb1d+eOl/xmKRHf7nqVN/e9dS6hfuus2CHNxde0smrh5MgC9vWbhfCQ64g3jd/U/cWzJi8nbOHpxJn0KfxNUPmLvW7AXslFCD3iCDm4cB/pi2cUnUa7RHEZRxU+II2ERkQVum8JTHUtF/NYZxtUX45NtYtIZ7djjByz68ytCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV5wwCGTZ/x1noqRYONa5Lk1QSeU4wPp9RTY2U8SIG8=;
 b=TDscXiZ0ssa2qzrPcNhD4I6TT8A04LkROUFwFUn/ps37U+JEjhZaxlbNDCyVVGI0hfQQi5wA6HqpAoIFno++fB4COQdicPEe49qWA8SPf5h/FWevmdCINlJs++SJScmdiLITd0tWjoiSU2LS0znGDI1Q9PfutuQafQb7RhcLoALxR8+ilgBWRAJ1pqzTQUT70YuAMxEUtD8y6CWgrd04y+R32vWQDjnpgY9SNZyiow1IL6/ZhaHd84/pa5XZbVe1+MFEhEYZY7OhBl6ewB3u3c5pd7EOHLR+K0eMzJJDh/xYuW6Rwq483voIA2FtfHjbZObKL8u6iWeOLO6f/obJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV5wwCGTZ/x1noqRYONa5Lk1QSeU4wPp9RTY2U8SIG8=;
 b=o4fLNzFxtFbbTfDjo/x7RyfNLxJD2XiEQ6BShlATFnYQlLgOd0XvEAsuDvzmnvMcTnFdPn+nIMMhdJzYhSVlpJFcKPSxq8Cg19Fti4iYvTFw71E32hHF664CYONHjGIcwFkfoyCivqkPkV34aBhW3KBIo3O81LzMHIo6QBeR/54=
Received: from MN2PR10CA0004.namprd10.prod.outlook.com (2603:10b6:208:120::17)
 by DM6PR02MB5002.namprd02.prod.outlook.com (2603:10b6:5:4f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 06:05:31 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:120:cafe::9a) by MN2PR10CA0004.outlook.office365.com
 (2603:10b6:208:120::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Tue, 23 Feb 2021 06:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 06:05:30 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 22 Feb 2021 22:05:30 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 22 Feb 2021 22:05:30 -0800
Envelope-to: maxz@xilinx.com,
 max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhi.hou@xilinx.com,
 stefanos@xilinx.com,
 robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=59364)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lEQp8-0004iF-5U; Mon, 22 Feb 2021 22:05:30 -0800
Subject: Re: [PATCH V3 XRT Alveo 02/18] fpga: xrt: driver metadata helper
 functions
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-3-lizhih@xilinx.com>
 <472b183b-e601-2022-2bed-59a3ff9a2920@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <fad75c44-9259-a1da-bdc4-518b93111a65@xilinx.com>
Date:   Mon, 22 Feb 2021 22:05:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <472b183b-e601-2022-2bed-59a3ff9a2920@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c23ea6a3-d784-4c96-c1ba-08d8d7c10669
X-MS-TrafficTypeDiagnostic: DM6PR02MB5002:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5002D3304737044E5851F33EA1809@DM6PR02MB5002.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oEyYgdXAhJSqgb4FZpfHjfTHC10exfIxNtU5KqKqeUYwGLgPkF6GG8EVukclzz34JswIzHmIDheZLTrfAZ70hOY6k5hOM4vqQLs6T5i38mX5W3SU2nIs5PzPorSWm7Qyo8lLFMVloMBiTJzPtlX3P0YxHJp1bBbfEFP4h5R2c0W5B1joRUsIZuEdpI4TiEtPu0IgQe9L2Go3ozOa2/99KVU/II6JjYdDiwTr6MEz0Ibk5ELWw7xKZ+6h+tyuuHem13smZf3wczL1RV5IodaUlPwjl6CI9jQ7+F8i+JEm8/Gl6Atle2FTvomezTR4Qnhek9wRGRWSAg4NVCMXSSjrNDgIu7qe3GqK0mXx3WZuFIl9EXIGW7SlGO9/EyE2ift4Hr0ksLVPyvIl3ddHZUb+GmaWTh876eqeT1Ow8JaSMqqNM2byEZA/MfEqCBR8mbfSO1gJNoGmVNaJOXhG1qV0iixRbFODlkc8aonHe8ABkEj6nkqC3jifOWgDXGzvICM5UsNNs8PbqiyH9xg064BORId6VdxIzt2KDJk7Zlh9tzrozlJKBmqwNwqpjJKxF2MeZQfWAYZhVpiydQdDuOOFVXjqKoSWsshFqWmRGXmyZOGtWDa+i4defxRuVuD2VykjB91ufeYjrg03rHAj8fXTB5ImhgUQfxqY2XB02rpHFr+401Ry0MVSH9HeG5Q325s6g/6ZNq1pSxrJwY57gyV8+qqGRGpeixtamG6npdDR8Ks=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(36840700001)(36860700001)(26005)(186003)(53546011)(30864003)(31686004)(2906002)(36906005)(54906003)(316002)(36756003)(110136005)(4326008)(107886003)(9786002)(8676002)(478600001)(8936002)(83380400001)(44832011)(336012)(82310400003)(82740400003)(7636003)(426003)(2616005)(356005)(70206006)(70586007)(5660300002)(47076005)(31696002)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 06:05:30.7750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c23ea6a3-d784-4c96-c1ba-08d8d7c10669
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,


On 02/20/2021 09:07 AM, Tom Rix wrote:
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> XRT drivers use device tree as metadata format to discover HW subsystems
>> behind PCIe BAR. Thus libfdt functions are called for driver to parse
> for the driver to parse the
will fix.
>> device tree blob.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/metadata.h  | 229 ++++++++++++
>>   drivers/fpga/xrt/metadata/metadata.c | 524 +++++++++++++++++++++++++++
>>   2 files changed, 753 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/metadata.h
>>   create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>>
>> diff --git a/drivers/fpga/xrt/include/metadata.h b/drivers/fpga/xrt/include/metadata.h
>> new file mode 100644
>> index 000000000000..b929bc469b73
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/metadata.h
>> @@ -0,0 +1,229 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for Xilinx Runtime (XRT) driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *      Lizhi Hou <Lizhi.Hou@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_METADATA_H
>> +#define _XRT_METADATA_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/uuid.h>
>> +
>> +#define XRT_MD_INVALID_LENGTH (~0UL)
>> +
> These #defines could be in alphabetical order
>
> Some #define with embedded acronyms could be expanded
>
> ex/ XRT_MD_NODE_CMC_REG , what is CMC ?
Will reorder. Expanding might make macro name too long. I will add 
comment as below:
/*
* IP nodes
* AF: AXI Firewall
* CMC: Card Management Controller
* ERT: Embedded Runtime
* PLP: Provider Reconfigurable Partition
* ULP: User Reconfigurable Partition
*/
>
>> +#define XRT_MD_PROP_COMPATIBLE "compatible"
>> +#define XRT_MD_PROP_PF_NUM "pcie_physical_function"
>> +#define XRT_MD_PROP_BAR_IDX "pcie_bar_mapping"
>> +#define XRT_MD_PROP_IO_OFFSET "reg"
>> +#define XRT_MD_PROP_INTERRUPTS "interrupts"
>> +#define XRT_MD_PROP_INTERFACE_UUID "interface_uuid"
>> +#define XRT_MD_PROP_LOGIC_UUID "logic_uuid"
>> +#define XRT_MD_PROP_VERSION_MAJOR "firmware_version_major"
>> +
>> +#define XRT_MD_PROP_HWICAP "axi_hwicap"
>> +#define XRT_MD_PROP_PDI_CONFIG "pdi_config_mem"
>> +
>> +#define XRT_MD_NODE_ENDPOINTS "addressable_endpoints"
>> +#define XRT_MD_INTERFACES_PATH "/interfaces"
>> +
>> +#define XRT_MD_NODE_FIRMWARE "firmware"
>> +#define XRT_MD_NODE_INTERFACES "interfaces"
>> +#define XRT_MD_NODE_PARTITION_INFO "partition_info"
>> +
>> +#define XRT_MD_NODE_FLASH "ep_card_flash_program_00"
>> +#define XRT_MD_NODE_XVC_PUB "ep_debug_bscan_user_00"
>> +#define XRT_MD_NODE_XVC_PRI "ep_debug_bscan_mgmt_00"
>> +#define XRT_MD_NODE_SYSMON "ep_cmp_sysmon_00"
>> +#define XRT_MD_NODE_AF_BLP_CTRL_MGMT "ep_firewall_blp_ctrl_mgmt_00"
>> +#define XRT_MD_NODE_AF_BLP_CTRL_USER "ep_firewall_blp_ctrl_user_00"
>> +#define XRT_MD_NODE_AF_CTRL_MGMT "ep_firewall_ctrl_mgmt_00"
>> +#define XRT_MD_NODE_AF_CTRL_USER "ep_firewall_ctrl_user_00"
>> +#define XRT_MD_NODE_AF_CTRL_DEBUG "ep_firewall_ctrl_debug_00"
>> +#define XRT_MD_NODE_AF_DATA_H2C "ep_firewall_data_h2c_00"
>> +#define XRT_MD_NODE_AF_DATA_C2H "ep_firewall_data_c2h_00"
>> +#define XRT_MD_NODE_AF_DATA_P2P "ep_firewall_data_p2p_00"
>> +#define XRT_MD_NODE_AF_DATA_M2M "ep_firewall_data_m2m_00"
>> +#define XRT_MD_NODE_CMC_REG "ep_cmc_regmap_00"
>> +#define XRT_MD_NODE_CMC_RESET "ep_cmc_reset_00"
>> +#define XRT_MD_NODE_CMC_MUTEX "ep_cmc_mutex_00"
>> +#define XRT_MD_NODE_CMC_FW_MEM "ep_cmc_firmware_mem_00"
>> +#define XRT_MD_NODE_ERT_FW_MEM "ep_ert_firmware_mem_00"
>> +#define XRT_MD_NODE_ERT_CQ_MGMT "ep_ert_command_queue_mgmt_00"
>> +#define XRT_MD_NODE_ERT_CQ_USER "ep_ert_command_queue_user_00"
>> +#define XRT_MD_NODE_MAILBOX_MGMT "ep_mailbox_mgmt_00"
>> +#define XRT_MD_NODE_MAILBOX_USER "ep_mailbox_user_00"
>> +#define XRT_MD_NODE_GATE_PLP "ep_pr_isolate_plp_00"
>> +#define XRT_MD_NODE_GATE_ULP "ep_pr_isolate_ulp_00"
>> +#define XRT_MD_NODE_PCIE_MON "ep_pcie_link_mon_00"
>> +#define XRT_MD_NODE_DDR_CALIB "ep_ddr_mem_calib_00"
>> +#define XRT_MD_NODE_CLK_KERNEL1 "ep_aclk_kernel_00"
>> +#define XRT_MD_NODE_CLK_KERNEL2 "ep_aclk_kernel_01"
>> +#define XRT_MD_NODE_CLK_KERNEL3 "ep_aclk_hbm_00"
>> +#define XRT_MD_NODE_KDMA_CTRL "ep_kdma_ctrl_00"
>> +#define XRT_MD_NODE_FPGA_CONFIG "ep_fpga_configuration_00"
>> +#define XRT_MD_NODE_ERT_SCHED "ep_ert_sched_00"
>> +#define XRT_MD_NODE_XDMA "ep_xdma_00"
>> +#define XRT_MD_NODE_MSIX "ep_msix_00"
>> +#define XRT_MD_NODE_QDMA "ep_qdma_00"
>> +#define XRT_MD_XRT_MD_NODE_QDMA4 "ep_qdma4_00"
>> +#define XRT_MD_NODE_STM "ep_stream_traffic_manager_00"
>> +#define XRT_MD_NODE_STM4 "ep_stream_traffic_manager4_00"
>> +#define XRT_MD_NODE_CLK_SHUTDOWN "ep_aclk_shutdown_00"
>> +#define XRT_MD_NODE_ERT_BASE "ep_ert_base_address_00"
>> +#define XRT_MD_NODE_ERT_RESET "ep_ert_reset_00"
>> +#define XRT_MD_NODE_CLKFREQ_K1 "ep_freq_cnt_aclk_kernel_00"
>> +#define XRT_MD_NODE_CLKFREQ_K2 "ep_freq_cnt_aclk_kernel_01"
>> +#define XRT_MD_NODE_CLKFREQ_HBM "ep_freq_cnt_aclk_hbm_00"
>> +#define XRT_MD_NODE_GAPPING "ep_gapping_demand_00"
>> +#define XRT_MD_NODE_UCS_CONTROL_STATUS "ep_ucs_control_status_00"
>> +#define XRT_MD_NODE_P2P "ep_p2p_00"
>> +#define XRT_MD_NODE_REMAP_P2P "ep_remap_p2p_00"
>> +#define XRT_MD_NODE_DDR4_RESET_GATE "ep_ddr_mem_srsr_gate_00"
>> +#define XRT_MD_NODE_ADDR_TRANSLATOR "ep_remap_data_c2h_00"
>> +#define XRT_MD_NODE_MAILBOX_XRT "ep_mailbox_user_to_ert_00"
>> +#define XRT_MD_NODE_PMC_INTR   "ep_pmc_intr_00"
>> +#define XRT_MD_NODE_PMC_MUX    "ep_pmc_mux_00"
>> +
>> +/* driver defined endpoints */
>> +#define XRT_MD_NODE_VSEC "drv_ep_vsec_00"
>> +#define XRT_MD_NODE_VSEC_GOLDEN "drv_ep_vsec_golden_00"
>> +#define XRT_MD_NODE_BLP_ROM "drv_ep_blp_rom_00"
>> +#define XRT_MD_NODE_MAILBOX_VSEC "ep_mailbox_vsec_00"
>> +#define XRT_MD_NODE_PLAT_INFO "drv_ep_platform_info_mgmt_00"
>> +#define XRT_MD_NODE_TEST "drv_ep_test_00"
>> +#define XRT_MD_NODE_MGMT_MAIN "drv_ep_mgmt_main_00"
>> +#define XRT_MD_NODE_FLASH_VSEC "drv_ep_card_flash_program_00"
>> +#define XRT_MD_NODE_GOLDEN_VER "drv_ep_golden_ver_00"
>> +#define XRT_MD_XRT_MD_NODE_PARTITION_INFO_BLP "partition_info_0"
>> +#define XRT_MD_XRT_MD_NODE_PARTITION_INFO_PLP "partition_info_1"
>> +
>> +#define XRT_MD_NODE_DDR_SRSR "drv_ep_ddr_srsr"
>> +#define XRT_MD_REGMAP_DDR_SRSR "drv_ddr_srsr"
>> +
>> +#define XRT_MD_PROP_OFFSET "drv_offset"
>> +#define XRT_MD_PROP_CLK_FREQ "drv_clock_frequency"
>> +#define XRT_MD_PROP_CLK_CNT "drv_clock_frequency_counter"
>> +#define XRT_MD_PROP_VBNV "vbnv"
>> +#define XRT_MD_PROP_VROM "vrom"
>> +#define XRT_MD_PROP_PARTITION_LEVEL "partition_level"
>> +
>> +struct xrt_md_endpoint {
>> +     const char      *ep_name;
>> +     u32             bar;
>> +     long            bar_off;
>> +     ulong           size;
>> +     char            *regmap;
>> +     char            *regmap_ver;
>> +};
> could the existing 'struct regmap' be used here ?
This structure is just a direct translation of firmware node. It is 
simple description of hardware endpoint.
>> +
>> +/* Note: res_id is defined by leaf driver and must start with 0. */
>> +struct xrt_iores_map {
>> +     char            *res_name;
>> +     int             res_id;
>> +};
>> +
>> +static inline int xrt_md_res_name2id(const struct xrt_iores_map *res_map,
>> +                                  int entry_num, const char *res_name)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < entry_num; i++) {
>> +             if (!strcmp(res_name, res_map->res_name))
> Use the 'n' variant strncmp for better safety.
>
> Fix generally.
Will replace all strcmp()
>
>> +                     return res_map->res_id;
>> +             res_map++;
>> +     }
>> +     return -1;
>> +}
>> +
>> +static inline const char *
>> +xrt_md_res_id2name(const struct xrt_iores_map *res_map, int entry_num, int id)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < entry_num; i++) {
>> +             if (res_map->res_id == id)
>> +                     return res_map->res_name;
>> +             res_map++;
>> +     }
>> +     return NULL;
>> +}
>> +
>> +unsigned long xrt_md_size(struct device *dev, const char *blob);
>> +int xrt_md_create(struct device *dev, char **blob);
>> +int xrt_md_add_endpoint(struct device *dev, char *blob,
>> +                     struct xrt_md_endpoint *ep);
>> +int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
>> +                     char *regmap_name);
>> +int xrt_md_get_prop(struct device *dev, const char *blob, const char *ep_name,
>> +                 const char *regmap_name, const char *prop,
>> +                 const void **val, int *size);
>> +int xrt_md_set_prop(struct device *dev, char *blob, const char *ep_name,
>> +                 const char *regmap_name, const char *prop,
>> +                 const void *val, int size);
>> +int xrt_md_copy_endpoint(struct device *dev, char *blob, const char *src_blob,
>> +                      const char *ep_name, const char *regmap_name,
>> +                      const char *new_ep_name);
>> +int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
>> +                          const char *ep_name,  const char *regmap_name,
>> +                          char **next_ep, char **next_regmap);
>> +int xrt_md_get_compatible_endpoint(struct device *dev, const char *blob,
>> +                                const char *regmap_name, const char **ep_name);
>> +int xrt_md_find_endpoint(struct device *dev, const char *blob,
>> +                      const char *ep_name, const char *regmap_name,
>> +                      const char **epname);
>> +void xrt_md_pack(struct device *dev, char *blob);
>> +char *xrt_md_dup(struct device *dev, const char *blob);
>> +int xrt_md_get_intf_uuids(struct device *dev, const char *blob,
>> +                       u32 *num_uuids, uuid_t *intf_uuids);
>> +static inline int xrt_md_copy_all_endpoints(struct device *dev, char *blob, const char *src_blob)
>> +{
>> +     return xrt_md_copy_endpoint(dev, blob, src_blob, XRT_MD_NODE_ENDPOINTS,
>> +                                 NULL, NULL);
> A wrapping a single call seems like an unnecessary abstraction layer.
>
> can this be reduced/removed ?
Will remove.
>
>> +}
>> +
>> +/*
>> + * Firmware provides 128 bit hash string as unque id of partition/interface.
> The firmware provides a 128 bit hash string as a unique id to the partition/interface.
>
> Existing hw does not yet use the cononical form, so it is necessary to use a translation function.
Will fix
>
>> + * This string will be canonical textual representation in the future.
>> + * Before that, introducing these two functions below to translate
>> + * hash string to uuid_t for released hardware.
> Is there an existing version string the new hw will use to check which way to go ?
We do not have the new hw yet.
>> + */
>> +static inline void xrt_md_trans_uuid2str(const uuid_t *uuid, char *uuidstr)
>> +{
>> +     int i, p;
>> +     u8 *u = (u8 *)uuid;
>> +
>> +     for (p = 0, i = sizeof(uuid_t) - 1; i >= 0; p++, i--)
> This loop needs to be improved.
>
> Consider if sizeof(uuid_t) changed, accessing u[] would overflow.
Will fix all the issues of uuid2str()/str2uuid() you pointed out. The 
rough idea is to use export_uuid() and import_uuid().
>
>> +             (void)snprintf(&uuidstr[p * 2], 3, "%02x", u[i]);
> (void) cast isn't needed.
>> +}
>> +
>> +static inline int xrt_md_trans_str2uuid(struct device *dev, const char *uuidstr, uuid_t *p_uuid)
>> +{
>> +     char *p;
>> +     const char *str;
>> +     char tmp[3] = { 0 };
>> +     int i, ret;
>> +
>> +     memset(p_uuid, 0, sizeof(*p_uuid));
>> +     p = (char *)p_uuid;
> access with p_uuid->b[] would remove use of 'p'
>> +     str = uuidstr + strlen(uuidstr) - 2;
>> +
>> +     for (i = 0; i < sizeof(*p_uuid) && str >= uuidstr; i++) {
> is not filling p_uuid completely really ok ?
>> +             tmp[0] = *str;
>> +             tmp[1] = *(str + 1);
>> +             ret = kstrtou8(tmp, 16, p);
>> +             if (ret)
>> +                     return -EINVAL;
>> +             p++;
>> +             str -= 2;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +#endif
>> diff --git a/drivers/fpga/xrt/metadata/metadata.c b/drivers/fpga/xrt/metadata/metadata.c
>> new file mode 100644
>> index 000000000000..5d106396f438
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/metadata/metadata.c
>> @@ -0,0 +1,524 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo FPGA Metadata parse APIs
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *      Lizhi Hou <Lizhi.Hou@xilinx.com>
>> + */
>> +
>> +#include <linux/libfdt_env.h>
>> +#include "libfdt.h"
>> +#include "metadata.h"
>> +
>> +#define MAX_BLOB_SIZE        (4096 * 25)
>> +
>> +static int xrt_md_setprop(struct device *dev, char *blob, int offset,
>> +                       const char *prop, const void *val, int size);
>> +static int xrt_md_overlay(struct device *dev, char *blob, int target,
>> +                       const char *overlay_blob, int overlay_offset);
>> +static int xrt_md_get_endpoint(struct device *dev, const char *blob,
>> +                            const char *ep_name, const char *regmap_name,
>> +                            int *ep_offset);
> consider reordering functions so these fwd decl's are not needed
Will remove decl's.
>> +
>> +unsigned long xrt_md_size(struct device *dev, const char *blob)
>> +{
>> +     unsigned long len = (long)fdt_totalsize(blob);
>> +
>> +     len = (len > MAX_BLOB_SIZE) ? XRT_MD_INVALID_LENGTH : len;
>> +     return len;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_size);
>> +
>> +int xrt_md_create(struct device *dev, char **blob)
>> +{
>> +     int ret = 0;
>> +
>> +     WARN_ON(!blob);
>> +
>> +     *blob = vmalloc(MAX_BLOB_SIZE);
> why vmalloc instead of vzalloc ?
Will use vzalloc.
>> +     if (!*blob)
>> +             return -ENOMEM;
>> +
>> +     ret = fdt_create_empty_tree(*blob, MAX_BLOB_SIZE);
>> +     if (ret) {
>> +             dev_err(dev, "format blob failed, ret = %d", ret);
>> +             goto failed;
>> +     }
>> +
>> +     ret = fdt_next_node(*blob, -1, NULL);
> A variable called 'offset' would make more sense here because it is used later in fdt_add_subnode as the parentoffset parameter.
the following fdt_add_subnode should use 0 as the parentoffset 
parameter. So I will keep 'ret' here.
>
>> +     if (ret < 0) {
>> +             dev_err(dev, "No Node, ret = %d", ret);
>> +             goto failed;
>> +     }
>> +
>> +     ret = fdt_add_subnode(*blob, ret, XRT_MD_NODE_ENDPOINTS);
> why isn't the parentoffset '0' ?
Yes, 0 should be used as parentoffset.
>
>
>> +     if (ret < 0) {
>> +             dev_err(dev, "add node failed, ret = %d", ret);
>> +             goto failed;
>> +     }
>> +
>> +     return 0;
>> +
>> +failed:
>> +     vfree(*blob);
>> +     *blob = NULL;
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_create);
>> +
>> +static int xrt_md_add_node(struct device *dev, char *blob, int parent_offset,
>> +                        const char *ep_name)
>> +{
>> +     int ret;
>> +
>> +     ret = fdt_add_subnode(blob, parent_offset, ep_name);
>> +     if (ret < 0 && ret != -FDT_ERR_EXISTS)
>> +             dev_err(dev, "failed to add node %s. %d", ep_name, ret);
>> +
>> +     return ret;
>> +}
>> +
>> +int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
>> +                     char *regmap_name)
>> +{
>> +     int ret;
>> +     int ep_offset;
>> +
>> +     ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name, &ep_offset);
>> +     if (ret) {
>> +             dev_err(dev, "can not find ep %s", ep_name);
>> +             return -EINVAL;
>> +     }
>> +
>> +     ret = fdt_del_node(blob, ep_offset);
>> +     if (ret)
>> +             dev_err(dev, "delete node %s failed, ret %d", ep_name, ret);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_del_endpoint);
>> +
>> +static int __xrt_md_add_endpoint(struct device *dev, char *blob,
>> +                              struct xrt_md_endpoint *ep, int *offset, bool root)
>> +{
>> +     int ret = 0;
>> +     int ep_offset = 0;
>> +     u32 val, count = 0;
>> +     u64 io_range[2];
>> +     char comp[128];
>> +
>> +     if (!ep->ep_name) {
>> +             dev_err(dev, "empty name");
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (!root) {
>> +             ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_ENDPOINTS, NULL,
>> +                                       &ep_offset);
>> +             if (ret) {
>> +                     dev_err(dev, "invalid blob, ret = %d", ret);
>> +                     return -EINVAL;
>> +             }
>> +     }
>> +
>> +     ep_offset = xrt_md_add_node(dev, blob, ep_offset, ep->ep_name);
>> +     if (ep_offset < 0) {
>> +             dev_err(dev, "add endpoint failed, ret = %d", ret);
>> +             return -EINVAL;
>> +     }
>> +     if (offset)
>> +             *offset = ep_offset;
>> +
>> +     if (ep->size != 0) {
>> +             val = cpu_to_be32(ep->bar);
>> +             ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_BAR_IDX,
>> +                                  &val, sizeof(u32));
>> +             if (ret) {
>> +                     dev_err(dev, "set %s failed, ret %d",
>> +                             XRT_MD_PROP_BAR_IDX, ret);
>> +                     goto failed;
>> +             }
>> +             io_range[0] = cpu_to_be64((u64)ep->bar_off);
>> +             io_range[1] = cpu_to_be64((u64)ep->size);
> is there a type mismatch between bar (u32) and size (u64) ?
Do you mean ep->bar? 'ep->bar' is bar index. So it does not have type 
mismatch issue.
>> +             ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_IO_OFFSET,
>> +                                  io_range, sizeof(io_range));
>> +             if (ret) {
>> +                     dev_err(dev, "set %s failed, ret %d",
>> +                             XRT_MD_PROP_IO_OFFSET, ret);
>> +                     goto failed;
>> +             }
>> +     }
>> +
>> +     if (ep->regmap) {
>> +             if (ep->regmap_ver) {
>> +                     count = snprintf(comp, sizeof(comp),
>> +                                      "%s-%s", ep->regmap, ep->regmap_ver);
>> +                     count++;
>> +             }
>> +
>> +             count += snprintf(comp + count, sizeof(comp) - count,
>> +                               "%s", ep->regmap);
>> +             count++;
> unlikely, but overflow is not checked.
Will add overflow check.
>
> are multiple null's in this string ok ?
yes.
>
>> +
>> +             ret = xrt_md_setprop(dev, blob, ep_offset, XRT_MD_PROP_COMPATIBLE,
>> +                                  comp, count);
>> +             if (ret) {
>> +                     dev_err(dev, "set %s failed, ret %d",
>> +                             XRT_MD_PROP_COMPATIBLE, ret);
>> +                     goto failed;
>> +             }
>> +     }
>> +
>> +failed:
>> +     if (ret)
>> +             xrt_md_del_endpoint(dev, blob, ep->ep_name, NULL);
>> +
>> +     return ret;
>> +}
>> +
>> +int xrt_md_add_endpoint(struct device *dev, char *blob,
>> +                     struct xrt_md_endpoint *ep)
>> +{
>> +     return __xrt_md_add_endpoint(dev, blob, ep, NULL, false);
> ok, user doesn't add root's endpoint.
>
> could an assert be added ?
The word 'root' is misleading here. Will change this argument to 'char 
*parent'
>
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_add_endpoint);
>> +
>> +static int xrt_md_get_endpoint(struct device *dev, const char *blob,
>> +                            const char *ep_name, const char *regmap_name,
>> +                            int *ep_offset)
>> +{
>> +     int offset;
>> +     const char *name;
>> +
>> +     for (offset = fdt_next_node(blob, -1, NULL);
>> +         offset >= 0;
>> +         offset = fdt_next_node(blob, offset, NULL)) {
>> +             name = fdt_get_name(blob, offset, NULL);
>> +             if (!name || strncmp(name, ep_name, strlen(ep_name) + 1))
> strlen() + 1 ?
This is to make sure "12345" and "123" are different.
>> +                     continue;
>> +             if (!regmap_name ||
>> +                 !fdt_node_check_compatible(blob, offset, regmap_name))
>> +                     break;
>> +     }
>> +     if (offset < 0)
>> +             return -ENODEV;
>> +
>> +     *ep_offset = offset;
>> +
>> +     return 0;
>> +}
>> +
>> +int xrt_md_find_endpoint(struct device *dev, const char *blob,
>> +                      const char *ep_name, const char *regmap_name,
>> +                      const char **epname)
>> +{
>> +     int offset;
>> +     int ret;
>> +
>> +     ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
>> +                               &offset);
>> +     if (!ret && epname && offset >= 0)
> The offset >= 0 check isn't needed, !ret is enough
Will fix.
>> +             *epname = fdt_get_name(blob, offset, NULL);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_find_endpoint);
>> +
>> +int xrt_md_get_prop(struct device *dev, const char *blob, const char *ep_name,
>> +                 const char *regmap_name, const char *prop,
>> +                 const void **val, int *size)
>> +{
>> +     int offset;
>> +     int ret;
>> +
>> +     if (val)
>> +             *val = NULL;
> Seems like no point in making this call if !val
>
> Return -EINVAL if !val and remove the if (val) check below.
Will fix
>
>> +     if (ep_name) {
>> +             ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
>> +                                       &offset);
>> +             if (ret) {
>> +                     dev_err(dev, "cannot get ep %s, regmap %s, ret = %d",
>> +                             ep_name, regmap_name, ret);
>> +                     return -EINVAL;
>> +             }
>> +     } else {
>> +             offset = fdt_next_node(blob, -1, NULL);
>> +             if (offset < 0) {
>> +                     dev_err(dev, "internal error, ret = %d", offset);
>> +                     return -EINVAL;
>> +             }
>> +     }
>> +
>> +     if (val) {
>> +             *val = fdt_getprop(blob, offset, prop, size);
>> +             if (!*val) {
>> +                     dev_dbg(dev, "get ep %s, prop %s failed", ep_name, prop);
>> +                     return -EINVAL;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_get_prop);
>> +
>> +static int xrt_md_setprop(struct device *dev, char *blob, int offset,
>> +                       const char *prop, const void *val, int size)
>> +{
>> +     int ret;
>> +
>> +     ret = fdt_setprop(blob, offset, prop, val, size);
>> +     if (ret)
>> +             dev_err(dev, "failed to set prop %d", ret);
>> +
>> +     return ret;
>> +}
>> +
>> +int xrt_md_set_prop(struct device *dev, char *blob,
>> +                 const char *ep_name, const char *regmap_name,
>> +                 const char *prop, const void *val, int size)
>> +{
>> +     int offset;
>> +     int ret;
>> +
>> +     if (ep_name) {
>> +             ret = xrt_md_get_endpoint(dev, blob, ep_name,
>> +                                       regmap_name, &offset);
>> +             if (ret) {
>> +                     dev_err(dev, "cannot get node %s, ret = %d",
>> +                             ep_name, ret);
>> +                     return -EINVAL;
>> +             }
>> +     } else {
>> +             offset = fdt_next_node(blob, -1, NULL);
>> +             if (offset < 0) {
>> +                     dev_err(dev, "internal error, ret = %d", offset);
>> +                     return -EINVAL;
>> +             }
>> +     }
> This if-else block is a cut-n-paste from above.
>
> It is good to convert common logic blocks to macros or inline functions.
Will define a in-line function.
>
>> +
>> +     ret = xrt_md_setprop(dev, blob, offset, prop, val, size);
>> +     if (ret)
>> +             dev_err(dev, "set prop %s failed, ret = %d", prop, ret);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_set_prop);
>> +
>> +int xrt_md_copy_endpoint(struct device *dev, char *blob, const char *src_blob,
>> +                      const char *ep_name, const char *regmap_name,
>> +                      const char *new_ep_name)
>> +{
>> +     int offset, target;
>> +     int ret;
>> +     struct xrt_md_endpoint ep = {0};
>> +     const char *newepnm = new_ep_name ? new_ep_name : ep_name;
> How is this valid ?
>
> The xrt_md_get_endpoint searches by ep_name and if there names are not unique the second one will never be found.
ep_name in the firmware will always be unique. It is documented in xrt.rst
>
>> +
>> +     ret = xrt_md_get_endpoint(dev, src_blob, ep_name, regmap_name,
>> +                               &offset);
>> +     if (ret)
>> +             return -EINVAL;
>> +
>> +     ret = xrt_md_get_endpoint(dev, blob, newepnm, regmap_name, &target);
>> +     if (ret) {
>> +             ep.ep_name = newepnm;
>> +             ret = __xrt_md_add_endpoint(dev, blob, &ep, &target,
>> +                                         fdt_parent_offset(src_blob, offset) == 0);
>> +             if (ret)
>> +                     return -EINVAL;
>> +     }
>> +
>> +     ret = xrt_md_overlay(dev, blob, target, src_blob, offset);
>> +     if (ret)
>> +             dev_err(dev, "overlay failed, ret = %d", ret);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_copy_endpoint);
>> +
>> +char *xrt_md_dup(struct device *dev, const char *blob)
>> +{
>> +     int ret;
>> +     char *dup_blob;
>> +
>> +     ret = xrt_md_create(dev, &dup_blob);
>> +     if (ret)
>> +             return NULL;
>> +     ret = xrt_md_overlay(dev, dup_blob, -1, blob, -1);
> would memcpy-ing the blob work ?
Sure. Memcpy works. I will remove xrt_md_dup() and use memcpy.
>> +     if (ret) {
>> +             vfree(dup_blob);
>> +             return NULL;
>> +     }
>> +
>> +     return dup_blob;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_dup);
>> +
>> +static int xrt_md_overlay(struct device *dev, char *blob, int target,
>> +                       const char *overlay_blob, int overlay_offset)
>> +{
>> +     int     property, subnode;
>> +     int     ret;
>> +
>> +     WARN_ON(!blob || !overlay_blob);
>> +
>> +     if (!blob) {
>> +             dev_err(dev, "blob is NULL");
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (target < 0) {
>> +             target = fdt_next_node(blob, -1, NULL);
>> +             if (target < 0) {
>> +                     dev_err(dev, "invalid target");
>> +                     return -EINVAL;
>> +             }
>> +     }
>> +     if (overlay_offset < 0) {
>> +             overlay_offset = fdt_next_node(overlay_blob, -1, NULL);
>> +             if (overlay_offset < 0) {
>> +                     dev_err(dev, "invalid overlay");
>> +                     return -EINVAL;
>> +             }
>> +     }
>> +
>> +     fdt_for_each_property_offset(property, overlay_blob, overlay_offset) {
>> +             const char *name;
>> +             const void *prop;
>> +             int prop_len;
>> +
>> +             prop = fdt_getprop_by_offset(overlay_blob, property, &name,
>> +                                          &prop_len);
>> +             if (!prop || prop_len >= MAX_BLOB_SIZE) {
> could add prop_len < 0 as another sanity check
Will add.
>> +                     dev_err(dev, "internal error");
>> +                     return -EINVAL;
>> +             }
>> +
>> +             ret = xrt_md_setprop(dev, blob, target, name, prop,
>> +                                  prop_len);
>> +             if (ret) {
>> +                     dev_err(dev, "setprop failed, ret = %d", ret);
>> +                     return ret;
> overlay_blob is half done, as an error handling shouldn't it be undone ?
The error will only cause a half done blob. Nothing need to be undone.
>> +             }
>> +     }
>> +
>> +     fdt_for_each_subnode(subnode, overlay_blob, overlay_offset) {
>> +             const char *name = fdt_get_name(overlay_blob, subnode, NULL);
>> +             int nnode;
>> +
>> +             nnode = xrt_md_add_node(dev, blob, target, name);
>> +             if (nnode == -FDT_ERR_EXISTS)
>> +                     nnode = fdt_subnode_offset(blob, target, name);
>> +             if (nnode < 0) {
>> +                     dev_err(dev, "add node failed, ret = %d", nnode);
>> +                     return nnode;
>> +             }
>> +
>> +             ret = xrt_md_overlay(dev, blob, nnode, overlay_blob, subnode);
> eek, recursion.
>
> Any chance this will blow the stack ?
Will add max recursive depth (5).
>
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
>> +                          const char *ep_name, const char *regmap_name,
>> +                          char **next_ep, char **next_regmap)
>> +{
>> +     int offset, ret;
>> +
>> +     if (!ep_name) {
>> +             ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_ENDPOINTS, NULL,
>> +                                       &offset);
>> +     } else {
>> +             ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
>> +                                       &offset);
>> +     }
>> +
>> +     if (ret) {
>> +             *next_ep = NULL;
>> +             *next_regmap = NULL;
> could initialize next_ep and next_regmap to NULL outside the check.
Will move outside.
>> +             return -EINVAL;
>> +     }
>> +
>> +     offset = ep_name ? fdt_next_subnode(blob, offset) :
>> +             fdt_first_subnode(blob, offset);
>> +     if (offset < 0) {
>> +             *next_ep = NULL;
>> +             *next_regmap = NULL;
>> +             return -EINVAL;
>> +     }
>> +
>> +     *next_ep = (char *)fdt_get_name(blob, offset, NULL);
>> +     *next_regmap = (char *)fdt_stringlist_get(blob, offset, XRT_MD_PROP_COMPATIBLE,
>> +                                               0, NULL);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_get_next_endpoint);
>> +
>> +int xrt_md_get_compatible_endpoint(struct device *dev, const char *blob,
>> +                                const char *regmap_name, const char **ep_name)
>> +{
>> +     int ep_offset;
>> +
>> +     ep_offset = fdt_node_offset_by_compatible(blob, -1, regmap_name);
>> +     if (ep_offset < 0) {
>> +             *ep_name = NULL;
>> +             return -ENOENT;
>> +     }
>> +
>> +     *ep_name = (char *)fdt_get_name(blob, ep_offset, NULL);
> why the cast ?
Will remove.
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_get_compatible_endpoint);
>> +
>> +void xrt_md_pack(struct device *dev, char *blob)
>> +{
>> +     int ret;
>> +
>> +     ret = fdt_pack(blob);
>> +     if (ret)
>> +             dev_err(dev, "pack failed %d", ret);
> maybe return int
Will return int.
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_pack);
>> +
> The input/output of num_uuids parameter is tricky add a comment
Will modify to 'u32 num_uuids'  and return the actual number
>> +int xrt_md_get_intf_uuids(struct device *dev, const char *blob,
>> +                       u32 *num_uuids, uuid_t *intf_uuids)
> what is intf ? change to 'interface' ?
yes. And will change to 'interface'.
>> +{
>> +     int offset, count = 0;
>> +     int ret;
>> +     const char *uuid_str;
>> +
>> +     ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_INTERFACES, NULL, &offset);
>> +     if (ret)
>> +             return -ENOENT;
>> +
>> +     for (offset = fdt_first_subnode(blob, offset);
>> +         offset >= 0;
>> +         offset = fdt_next_subnode(blob, offset)) {
>> +             uuid_str = fdt_getprop(blob, offset, XRT_MD_PROP_INTERFACE_UUID,
>> +                                    NULL);
>> +             if (!uuid_str) {
>> +                     dev_err(dev, "empty intf uuid node");
>> +                     return -EINVAL;
>> +             }
>> +
>> +             if (intf_uuids && count < *num_uuids) {
>> +                     ret = xrt_md_trans_str2uuid(dev, uuid_str,
>> +                                                 &intf_uuids[count]);
>> +                     if (ret)
>> +                             return -EINVAL;
>> +             }
>> +             count++;
> keep going even when count > num_uuids ?
>
> that seems like an error.
Will add check.

Thanks,
Lizhi
>
> Tom
>
>> +     }
>> +
>> +     *num_uuids = count;
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_get_intf_uuids);

