Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B15C354BC2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 06:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbhDFEgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:36:50 -0400
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:11712
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242441AbhDFEgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:36:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDVl50pnO655YOWv+Wrw+vv/xOuT2TOsrhGRpPyCvw7sOpEHw6NoyuN6bB+wzZHqFQy1Y3fZQWND7go3Y2y1XistX8OJHRAf70xlN21/hOBOfbKzpB8t7KuPArSdhEvkoTtMGk5h5mcUUTzMtI/t0SHJ94GVWZWNZkmHIK3hcXszcQTM+dC9h0h3x+W6hgcblZUczI+w5O0v+moXybajul4xSTa5Jz9rtVZ6phaE9Gx4vkcWfwFEJA0GBVP5mkdrvz44gzHVLNmARndH028MsFxavmXGG/r0yhPsa0VthMQRQFa1Ej3zUpUXaaGTQpG7rZ8T0jH1uCGE6oURnfcnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLb+gKycGjT8sMpPR4YkAnyBH73y7vgZ3avdcXadm9I=;
 b=hDvtzUPbIPRLF7VZ0rkjcsThnRlnX16gHIEdbfgZh+bPYN6rrvWS7r+BkQcet4RJ+X8m6d4sC54GdM1IxcMhMATW2YAPNg5XB6yM5UIdutz7Wy2mB2tzjJJU6MJ/YhnBvfR76uq5sV2CF5MmGdX11RjH+Za8r4ScJpBbC2ffdnjrAmMCM6xwXIBXlYcMWmh+nk6/7ZmfEtEy8yWisOfJ758RMimSkJh7SjD8ztGqOJ9UNwuKOjI90WZtqmsiQw6na/1R/tlk29MVjkkYcnkZB69FuXyGuiz3IHtRmKA5ewRi/k4FT5A3DF6j4rM5odAzMiHZBIsgj8lQnIUU2ou6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLb+gKycGjT8sMpPR4YkAnyBH73y7vgZ3avdcXadm9I=;
 b=SxbFfF5MRzEOAvNLDZ0yhw2VR9pL+C9isMlFj4CbkKm6/D0VNNjVP89oSKomz3QbTsQcKv5O1G5tDfFK0lWAF3XVJIpsOL0uAh07rMa9KUytZHAi8MuoLmQEVTWmYmheqfHlP/OK0NDdS2A/PMDJLcM8pdfIwC9f3Nr9MPKe+Gk=
Received: from DM6PR02CA0147.namprd02.prod.outlook.com (2603:10b6:5:332::14)
 by DM5PR02MB2682.namprd02.prod.outlook.com (2603:10b6:3:108::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 04:36:38 +0000
Received: from DM3NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::f4) by DM6PR02CA0147.outlook.office365.com
 (2603:10b6:5:332::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Tue, 6 Apr 2021 04:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT046.mail.protection.outlook.com (10.13.4.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 04:36:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Apr 2021 21:36:37 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 5 Apr 2021 21:36:37 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=39316)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lTdS9-0005O0-Fg; Mon, 05 Apr 2021 21:36:37 -0700
Subject: Re: [PATCH V4 XRT Alveo 02/20] fpga: xrt: driver metadata helper
 functions
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <mdf@kernel.org>, <robh@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-3-lizhi.hou@xilinx.com>
 <d6fc7dbc-8a57-1e29-46bd-5129a39358b8@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <affbbbcf-7674-06ee-ab2d-e11357b59531@xilinx.com>
Date:   Mon, 5 Apr 2021 21:36:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <d6fc7dbc-8a57-1e29-46bd-5129a39358b8@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73ea17d3-7038-489b-cf31-08d8f8b59121
X-MS-TrafficTypeDiagnostic: DM5PR02MB2682:
X-Microsoft-Antispam-PRVS: <DM5PR02MB268259DDE6D2D1AA8B677DB5A1769@DM5PR02MB2682.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rb53zGX0BULxi45C6G7czZK86tMV8FoQXnV6YKbvV/7V7dZ1Wg2V5couWM3dE48s2X/WPxYlx0fvu7YWS2+R+WUXxlUbzmV693fpTKiGqu/pEbR3NWmO/W4PpS+QCMWNt7qayB6Zzeiejb47V0AhDi+yEiknjQjoyKSKpuTUOTRSH4nyW13xFlyHQzT4CkyV4JrVA6G885Jox78ikatkf5ZoRJRaxShjowqLlQm9eES5W6NpbDaE9it/XHfWZAwdYsaOF+JyXnnnoj4SEVcMvRigdhdWmJwd5B89RcWmY1P5GCTSZynL1UqIx7zHEiIAkGT4lONcsnnINP5xJgvjFqltn4/Wh8XdckHa4G3u7bslry2A8Mbn/hXaouo26OvMDDtc6r+u3efAg7pQYEIHrz34l7zZfDQjUAkohOiJb6c6kHDrwCNkk7gPreTS056qn4cniz57fariM0iSCqwcNpDfJHokhO1kg1BdfHtalv76Rpp5lyXcLNQARCWR7cZvBOXES1cwFHqJwQ4KR3OE94+2wYQZUSDAglvHDPWEWFI/8Vz6MOOzKictkaErFptTwjAN/a06e4AEjyfIDW1JdjbXuWLqgTotGiCnT7p+YoSppHVMLbcpzQTCtSNI73ZN/dgZhyJLvMdLqeasvtijvInm6tpftUCS3HwxC+fjp7SfP5WPQzZFubEk81tGjG9OsXQDgbabukFxFDuiuc0DSO4s5FgUzOw/6Jtw197mDJY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(5660300002)(31696002)(44832011)(30864003)(53546011)(82740400003)(186003)(36860700001)(316002)(2906002)(54906003)(478600001)(36756003)(110136005)(83380400001)(36906005)(9786002)(7636003)(82310400003)(26005)(8936002)(356005)(47076005)(4326008)(426003)(2616005)(70586007)(70206006)(336012)(31686004)(8676002)(107886003)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 04:36:37.9716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ea17d3-7038-489b-cf31-08d8f8b59121
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2682
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,


On 03/28/2021 08:30 AM, Tom Rix wrote:
> Do not reorder function definitions, this makes comparing changes from the previous patchset difficult.
>
> A general issue with returning consistent error codes.  There are several cases where fdt_* code are not translated.
Sure. Will fix.
>
> On 3/23/21 10:29 PM, Lizhi Hou wrote:
>> XRT drivers use device tree as metadata format to discover HW subsystems
>> behind PCIe BAR. Thus libfdt functions are called for the driver to parse
>> device tree blob.
> to parse the device
Will fix
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/metadata.h  | 233 ++++++++++++
>>   drivers/fpga/xrt/metadata/metadata.c | 545 +++++++++++++++++++++++++++
>>   2 files changed, 778 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/metadata.h
>>   create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>>
>> diff --git a/drivers/fpga/xrt/include/metadata.h b/drivers/fpga/xrt/include/metadata.h
>> new file mode 100644
>> index 000000000000..479e47960c61
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/metadata.h
>> @@ -0,0 +1,233 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
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
>> +/* metadata properties */
>> +#define XRT_MD_PROP_BAR_IDX "pcie_bar_mapping"
>> +#define XRT_MD_PROP_COMPATIBLE "compatible"
>> +#define XRT_MD_PROP_HWICAP "axi_hwicap"
>> +#define XRT_MD_PROP_INTERFACE_UUID "interface_uuid"
>> +#define XRT_MD_PROP_INTERRUPTS "interrupts"
>> +#define XRT_MD_PROP_IO_OFFSET "reg"
>> +#define XRT_MD_PROP_LOGIC_UUID "logic_uuid"
>> +#define XRT_MD_PROP_PDI_CONFIG "pdi_config_mem"
>> +#define XRT_MD_PROP_PF_NUM "pcie_physical_function"
>> +#define XRT_MD_PROP_VERSION_MAJOR "firmware_version_major"
>> +
>> +/* non IP nodes */
>> +#define XRT_MD_NODE_ENDPOINTS "addressable_endpoints"
>> +#define XRT_MD_NODE_FIRMWARE "firmware"
>> +#define XRT_MD_NODE_INTERFACES "interfaces"
>> +#define XRT_MD_NODE_PARTITION_INFO "partition_info"
>> +
>> +/*
>> + * IP nodes
>> + * AF:  AXI Firewall
>> + * CMC: Card Management Controller
>> + * ERT: Embedded Runtime
> * EP: End Point
Will add
>> + * PLP: Provider Reconfigurable Partition
>> + * ULP: User Reconfigurable Partition
>> + */
>> +#define XRT_MD_NODE_ADDR_TRANSLATOR "ep_remap_data_c2h_00"
>> +#define XRT_MD_NODE_AF_BLP_CTRL_MGMT "ep_firewall_blp_ctrl_mgmt_00"
>> +#define XRT_MD_NODE_AF_BLP_CTRL_USER "ep_firewall_blp_ctrl_user_00"
>> +#define XRT_MD_NODE_AF_CTRL_DEBUG "ep_firewall_ctrl_debug_00"
>> +#define XRT_MD_NODE_AF_CTRL_MGMT "ep_firewall_ctrl_mgmt_00"
>> +#define XRT_MD_NODE_AF_CTRL_USER "ep_firewall_ctrl_user_00"
>> +#define XRT_MD_NODE_AF_DATA_C2H "ep_firewall_data_c2h_00"
> c2h ?
Card to host. I will add a comment.
>> +#define XRT_MD_NODE_AF_DATA_H2C "ep_firewall_data_h2c_00"
>> +#define XRT_MD_NODE_AF_DATA_M2M "ep_firewall_data_m2m_00"
>> +#define XRT_MD_NODE_AF_DATA_P2P "ep_firewall_data_p2p_00"
>> +#define XRT_MD_NODE_CLKFREQ_HBM "ep_freq_cnt_aclk_hbm_00"
>> +#define XRT_MD_NODE_CLKFREQ_K1 "ep_freq_cnt_aclk_kernel_00"
>> +#define XRT_MD_NODE_CLKFREQ_K2 "ep_freq_cnt_aclk_kernel_01"
>> +#define XRT_MD_NODE_CLK_KERNEL1 "ep_aclk_kernel_00"
>> +#define XRT_MD_NODE_CLK_KERNEL2 "ep_aclk_kernel_01"
>> +#define XRT_MD_NODE_CLK_KERNEL3 "ep_aclk_hbm_00"
> hbm ?
>
> unusual acronyms should be documented.
High bandwidth memory. I will add a comment.
>
>> +#define XRT_MD_NODE_CLK_SHUTDOWN "ep_aclk_shutdown_00"
>> +#define XRT_MD_NODE_CMC_FW_MEM "ep_cmc_firmware_mem_00"
>> +#define XRT_MD_NODE_CMC_MUTEX "ep_cmc_mutex_00"
>> +#define XRT_MD_NODE_CMC_REG "ep_cmc_regmap_00"
>> +#define XRT_MD_NODE_CMC_RESET "ep_cmc_reset_00"
>> +#define XRT_MD_NODE_DDR_CALIB "ep_ddr_mem_calib_00"
>> +#define XRT_MD_NODE_DDR4_RESET_GATE "ep_ddr_mem_srsr_gate_00"
>> +#define XRT_MD_NODE_ERT_BASE "ep_ert_base_address_00"
>> +#define XRT_MD_NODE_ERT_CQ_MGMT "ep_ert_command_queue_mgmt_00"
>> +#define XRT_MD_NODE_ERT_CQ_USER "ep_ert_command_queue_user_00"
>> +#define XRT_MD_NODE_ERT_FW_MEM "ep_ert_firmware_mem_00"
>> +#define XRT_MD_NODE_ERT_RESET "ep_ert_reset_00"
>> +#define XRT_MD_NODE_ERT_SCHED "ep_ert_sched_00"
>> +#define XRT_MD_NODE_FLASH "ep_card_flash_program_00"
>> +#define XRT_MD_NODE_FPGA_CONFIG "ep_fpga_configuration_00"
>> +#define XRT_MD_NODE_GAPPING "ep_gapping_demand_00"
>> +#define XRT_MD_NODE_GATE_PLP "ep_pr_isolate_plp_00"
>> +#define XRT_MD_NODE_GATE_ULP "ep_pr_isolate_ulp_00"
>> +#define XRT_MD_NODE_KDMA_CTRL "ep_kdma_ctrl_00"
>> +#define XRT_MD_NODE_MAILBOX_MGMT "ep_mailbox_mgmt_00"
>> +#define XRT_MD_NODE_MAILBOX_USER "ep_mailbox_user_00"
>> +#define XRT_MD_NODE_MAILBOX_XRT "ep_mailbox_user_to_ert_00"
>> +#define XRT_MD_NODE_MSIX "ep_msix_00"
>> +#define XRT_MD_NODE_P2P "ep_p2p_00"
>> +#define XRT_MD_NODE_PCIE_MON "ep_pcie_link_mon_00"
>> +#define XRT_MD_NODE_PMC_INTR   "ep_pmc_intr_00"
>> +#define XRT_MD_NODE_PMC_MUX    "ep_pmc_mux_00"
>> +#define XRT_MD_NODE_QDMA "ep_qdma_00"
>> +#define XRT_MD_NODE_QDMA4 "ep_qdma4_00"
>> +#define XRT_MD_NODE_REMAP_P2P "ep_remap_p2p_00"
>> +#define XRT_MD_NODE_STM "ep_stream_traffic_manager_00"
>> +#define XRT_MD_NODE_STM4 "ep_stream_traffic_manager4_00"
>> +#define XRT_MD_NODE_SYSMON "ep_cmp_sysmon_00"
>> +#define XRT_MD_NODE_XDMA "ep_xdma_00"
>> +#define XRT_MD_NODE_XVC_PUB "ep_debug_bscan_user_00"
>> +#define XRT_MD_NODE_XVC_PRI "ep_debug_bscan_mgmt_00"
>> +#define XRT_MD_NODE_UCS_CONTROL_STATUS "ep_ucs_control_status_00"
>> +
>> +/* endpoint regmaps */
>> +#define XRT_MD_REGMAP_DDR_SRSR "drv_ddr_srsr"
>> +#define XRT_MD_REGMAP_CLKFREQ "freq_cnt"
> clock frequency vs frequency count ?
>
> is this ok?
Yes. "freq_cnt" has been used by hardware tools which generates the 
metadata. It is clock frequency count.
>
>> +
>> +/* driver defined endpoints */
>> +#define XRT_MD_NODE_BLP_ROM "drv_ep_blp_rom_00"
>> +#define XRT_MD_NODE_DDR_SRSR "drv_ep_ddr_srsr"
>> +#define XRT_MD_NODE_FLASH_VSEC "drv_ep_card_flash_program_00"
>> +#define XRT_MD_NODE_GOLDEN_VER "drv_ep_golden_ver_00"
>> +#define XRT_MD_NODE_MAILBOX_VSEC "drv_ep_mailbox_vsec_00"
>> +#define XRT_MD_NODE_MGMT_MAIN "drv_ep_mgmt_main_00"
>> +#define XRT_MD_NODE_PLAT_INFO "drv_ep_platform_info_mgmt_00"
>> +#define XRT_MD_NODE_PARTITION_INFO_BLP "partition_info_0"
>> +#define XRT_MD_NODE_PARTITION_INFO_PLP "partition_info_1"
>> +#define XRT_MD_NODE_TEST "drv_ep_test_00"
>> +#define XRT_MD_NODE_VSEC "drv_ep_vsec_00"
>> +#define XRT_MD_NODE_VSEC_GOLDEN "drv_ep_vsec_golden_00"
>> +
>> +/* driver defined properties */
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
>> +     u64             bar_off;
>> +     ulong           size;
> bar_off changed from long to u64.
>
> should bar and size both be changed to u64 ?
bar is bar index and u32 should be good enough for it.  I will change 
size to u64 and rename 'bar' to 'bar_index'.
>
>> +     char            *regmap;
> It seems like this is really a compatibility string and not a regmap.
Yes. I will rename 'regmap' to 'compat' and 'regmap_ver' to 'compat_ver'
>
>> +     char            *regmap_ver;
>> +};
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
>> +             if (!strncmp(res_name, res_map->res_name, strlen(res_map->res_name) + 1))
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
>> +char *xrt_md_dup(struct device *dev, const char *blob);
>> +int xrt_md_add_endpoint(struct device *dev, char *blob,
>> +                     struct xrt_md_endpoint *ep);
>> +int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
>> +                     const char *regmap_name);
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
>> +int xrt_md_pack(struct device *dev, char *blob);
>> +int xrt_md_get_interface_uuids(struct device *dev, const char *blob,
>> +                            u32 num_uuids, uuid_t *intf_uuids);
>> +
>> +/*
>> + * The firmware provides a 128 bit hash string as a unique id to the
>> + * partition/interface.
>> + * Existing hw does not yet use the cononical form, so it is necessary to
>> + * use a translation function.
>> + */
>> +static inline void xrt_md_trans_uuid2str(const uuid_t *uuid, char *uuidstr)
>> +{
>> +     int i, p;
>> +     u8 tmp[UUID_SIZE];
>> +
>> +     BUILD_BUG_ON(UUID_SIZE != 16);
>> +     export_uuid(tmp, uuid);
> ok
>> +     for (p = 0, i = UUID_SIZE - 1; i >= 0; p++, i--)
>> +             snprintf(&uuidstr[p * 2], 3, "%02x", tmp[i]);
> XMGMT_UUID_STR_LEN is 80.
>
> This logic say it could be reduced to 33.
Sure. I will define it as (UUID_SIZE * 2 + 1).
>
>> +}
>> +
>> +static inline int xrt_md_trans_str2uuid(struct device *dev, const char *uuidstr, uuid_t *p_uuid)
>> +{
>> +     u8 p[UUID_SIZE];
>> +     const char *str;
>> +     char tmp[3] = { 0 };
>> +     int i, ret;
>> +
>> +     BUILD_BUG_ON(UUID_SIZE != 16);
> Also defined above, do not need to repeat.
Will remove.
>> +     str = uuidstr + strlen(uuidstr) - 2;
> needs an underflow check
Will add check

        if (strlen(uuidstr) != UUID_SIZE * 2)
                 return -EINVAL;

>> +
>> +     for (i = 0; i < sizeof(*p_uuid) && str >= uuidstr; i++) {
>> +             tmp[0] = *str;
>> +             tmp[1] = *(str + 1);
>> +             ret = kstrtou8(tmp, 16, &p[i]);
>> +             if (ret)
>> +                     return -EINVAL;
>> +             str -= 2;
>> +     }
>> +     import_uuid(p_uuid, p);
>> +
>> +     return 0;
>> +}
>> +
>> +#endif
>> diff --git a/drivers/fpga/xrt/metadata/metadata.c b/drivers/fpga/xrt/metadata/metadata.c
>> new file mode 100644
>> index 000000000000..3b2be50fcb02
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/metadata/metadata.c
>> @@ -0,0 +1,545 @@
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
>> +#define MAX_DEPTH 5
> MAX_BLOB_SIZE is defined in keys/trusted-type.h
>
> General, add a prefix to help avoid conflicts.
>
> Like
>
> XRT_MAX_BLOB_SIZE
>
> etc.
Sure. Will add XRT_
>
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
>> +static int xrt_md_get_endpoint(struct device *dev, const char *blob,
>> +                            const char *ep_name, const char *regmap_name,
>> +                            int *ep_offset)
>> +{
>> +     const char *name;
>> +     int offset;
>> +
>> +     for (offset = fdt_next_node(blob, -1, NULL);
>> +         offset >= 0;
>> +         offset = fdt_next_node(blob, offset, NULL)) {
>> +             name = fdt_get_name(blob, offset, NULL);
>> +             if (!name || strncmp(name, ep_name, strlen(ep_name) + 1))
>> +                     continue;
>> +             if (!regmap_name ||
> regmap_name is known at the start but checked here in the loop.
>
> this check should be made outside of the loop.
Will change.
>
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
>> +static inline int xrt_md_get_node(struct device *dev, const char *blob,
>> +                               const char *name, const char *regmap_name,
>> +                               int *offset)
>> +{
>> +     int ret = 0;
>> +
>> +     if (name) {
>> +             ret = xrt_md_get_endpoint(dev, blob, name, regmap_name,
>> +                                       offset);
>> +             if (ret) {
>> +                     dev_err(dev, "cannot get node %s, regmap %s, ret = %d",
>> +                             name, regmap_name, ret);
> from above regmap_name is sometimes NULL.
Will add a check.
>> +                     return -EINVAL;
>> +             }
>> +     } else {
>> +             ret = fdt_next_node(blob, -1, NULL);
>> +             if (ret < 0) {
>> +                     dev_err(dev, "internal error, ret = %d", ret);
>> +                     return -EINVAL;
>> +             }
>> +             *offset = ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_md_overlay(struct device *dev, char *blob, int target,
>> +                       const char *overlay_blob, int overlay_offset,
>> +                       int depth)
>> +{
>> +     int     property, subnode;
>> +     int     ret;
> whitespace, looks like tab's after 'int'
>
> should be consistent with space used elsewhere
Will fix.
>
>> +
>> +     if (!blob || !overlay_blob) {
>> +             dev_err(dev, "blob is NULL");
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (depth > MAX_DEPTH) {
> ok
>> +             dev_err(dev, "meta data depth beyond %d", MAX_DEPTH);
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
>> +             if (!prop || prop_len >= MAX_BLOB_SIZE || prop_len < 0) {
>> +                     dev_err(dev, "internal error");
>> +                     return -EINVAL;
>> +             }
>> +
>> +             ret = xrt_md_setprop(dev, blob, target, name, prop,
>> +                                  prop_len);
>> +             if (ret) {
>> +                     dev_err(dev, "setprop failed, ret = %d", ret);
>> +                     return ret;
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
> This is an offset, not an error code
>
> return -EINVAL or similar
Will fix.
>
>> +             }
>> +
>> +             ret = xrt_md_overlay(dev, blob, nnode, overlay_blob, subnode, depth + 1);
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +unsigned long xrt_md_size(struct device *dev, const char *blob)
>> +{
> review fdt_ro_probe.
>
> fdt_totalsize is signed 32 bit, this conversion to sometimes 64 bit is not necessary.
>
> at most it should be uint32_t
Will use u32.
>
>> +     unsigned long len = (long)fdt_totalsize(blob);
>> +
>> +     if (len > MAX_BLOB_SIZE)
>> +             return XRT_MD_INVALID_LENGTH;
>> +
>> +     return len;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_size);
>> +
>> +int xrt_md_create(struct device *dev, char **blob)
>> +{
>> +     int ret = 0;
>> +
>> +     if (!blob) {
>> +             dev_err(dev, "blob is NULL");
>> +             return -EINVAL;
>> +     }
>> +
>> +     *blob = vzalloc(MAX_BLOB_SIZE);
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
>> +     if (ret < 0) {
>> +             dev_err(dev, "No Node, ret = %d", ret);
>> +             goto failed;
>> +     }
>> +
>> +     ret = fdt_add_subnode(*blob, 0, XRT_MD_NODE_ENDPOINTS);
>> +     if (ret < 0) {
> fdt error code
will return -EINVAL.
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
>> +char *xrt_md_dup(struct device *dev, const char *blob)
>> +{
>> +     char *dup_blob;
>> +     int ret;
>> +
>> +     ret = xrt_md_create(dev, &dup_blob);
>> +     if (ret)
>> +             return NULL;
>> +     ret = xrt_md_overlay(dev, dup_blob, -1, blob, -1, 0);
>> +     if (ret) {
>> +             vfree(dup_blob);
>> +             return NULL;
>> +     }
>> +
>> +     return dup_blob;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_dup);
> Wasn't xrt_md_dup going to be replaced by memcpy ?
Looked into this more and found it is not able to replaced by memcpy.  
The blob read from firmware could be marked as 'read only'. And we need 
'read-write' for driver metadata.
>> +
>> +int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
>> +                     const char *regmap_name)
>> +{
>> +     int ep_offset;
>> +     int ret;
>> +
>> +     ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name, &ep_offset);
>> +     if (ret) {
>> +             dev_err(dev, "can not find ep %s", ep_name);
>> +             return -EINVAL;
>> +     }
>> +
>> +     ret = fdt_del_node(blob, ep_offset);
> fdt return code
>
> Fix these generally.
sure.
>
>> +     if (ret)
>> +             dev_err(dev, "delete node %s failed, ret %d", ep_name, ret);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_del_endpoint);
>> +
>> +static int __xrt_md_add_endpoint(struct device *dev, char *blob,
>> +                              struct xrt_md_endpoint *ep, int *offset,
>> +                              const char *parent)
>> +{
>> +     int parent_offset = 0;
>> +     u32 val, count = 0;
>> +     int ep_offset = 0;
>> +     u64 io_range[2];
>> +     char comp[128];
>> +     int ret = 0;
>> +
>> +     if (!ep->ep_name) {
>> +             dev_err(dev, "empty name");
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (parent) {
>> +             ret = xrt_md_get_endpoint(dev, blob, parent, NULL, &parent_offset);
>> +             if (ret) {
>> +                     dev_err(dev, "invalid blob, ret = %d", ret);
>> +                     return -EINVAL;
>> +             }
>> +     }
>> +
>> +     ep_offset = xrt_md_add_node(dev, blob, parent_offset, ep->ep_name);
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
> if ep->bar is an index, then rename the element to 'bar_index'
sure.
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
>> +                     count = snprintf(comp, sizeof(comp) - 1,
> The -1 should be good enough that the if-check below is not needed
We do not expect compat string is beyond 127 bytes. I will change to
       if (count >= sizeof(comp))
So if the converted compat string is beyond 127 bytest, returns error.
>> +                                      "%s-%s", ep->regmap, ep->regmap_ver);
>> +                     count++;
>> +             }
>> +             if (count > sizeof(comp)) {
>> +                     ret = -EINVAL;
>> +                     goto failed;
>> +             }
>> +
>> +             count += snprintf(comp + count, sizeof(comp) - count - 1,
>> +                               "%s", ep->regmap);
> what happens when only part of regmap is added to comp ?
It should never happen and will return error if it is.
>> +             count++;
>> +             if (count > sizeof(comp)) {
>> +                     ret = -EINVAL;
>> +                     goto failed;
>> +             }
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
>> +     return __xrt_md_add_endpoint(dev, blob, ep, NULL, XRT_MD_NODE_ENDPOINTS);
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_add_endpoint);
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
>> +     if (!ret && epname)
> split this condition, if the call failed, check and return early.
sure.
>> +             *epname = fdt_get_name(blob, offset, NULL);
> what happens if fdt_get_name fails ?
will add check.
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
>> +     if (!val) {
>> +             dev_err(dev, "val is null");
>> +             return -EINVAL;
> ok
>> +     }
>> +
>> +     *val = NULL;
>> +     ret = xrt_md_get_node(dev, blob, ep_name, regmap_name, &offset);
>> +     if (ret)
>> +             return ret;
>> +
>> +     *val = fdt_getprop(blob, offset, prop, size);
>> +     if (!*val) {
>> +             dev_dbg(dev, "get ep %s, prop %s failed", ep_name, prop);
>> +             return -EINVAL;
>> +     }
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_get_prop);
>> +
>> +int xrt_md_set_prop(struct device *dev, char *blob,
>> +                 const char *ep_name, const char *regmap_name,
>> +                 const char *prop, const void *val, int size)
>> +{
>> +     int offset;
>> +     int ret;
>> +
>> +     ret = xrt_md_get_node(dev, blob, ep_name, regmap_name, &offset);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = xrt_md_setprop(dev, blob, offset, prop, val, size);
> ok
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
>> +     const char *newepnm = new_ep_name ? new_ep_name : ep_name;
>> +     struct xrt_md_endpoint ep = {0};
>> +     int offset, target;
>> +     const char *parent;
>> +     int ret;
>> +
>> +     ret = xrt_md_get_endpoint(dev, src_blob, ep_name, regmap_name,
>> +                               &offset);
>> +     if (ret)
>> +             return -EINVAL;
>> +
>> +     ret = xrt_md_get_endpoint(dev, blob, newepnm, regmap_name, &target);
>> +     if (ret) {
>> +             ep.ep_name = newepnm;
>> +             parent = fdt_parent_offset(src_blob, offset) == 0 ? NULL : XRT_MD_NODE_ENDPOINTS;
>> +             ret = __xrt_md_add_endpoint(dev, blob, &ep, &target, parent);
>> +             if (ret)
>> +                     return -EINVAL;
>> +     }
>> +
>> +     ret = xrt_md_overlay(dev, blob, target, src_blob, offset, 0);
>> +     if (ret)
>> +             dev_err(dev, "overlay failed, ret = %d", ret);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_copy_endpoint);
>> +
>> +int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
>> +                          const char *ep_name, const char *regmap_name,
>> +                          char **next_ep, char **next_regmap)
>> +{
>> +     int offset, ret;
>> +
>> +     *next_ep = NULL;
>> +     *next_regmap = NULL;
>> +     if (!ep_name) {
>> +             ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_ENDPOINTS, NULL,
>> +                                       &offset);
>> +     } else {
>> +             ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
>> +                                       &offset);
>> +     }
>> +
>> +     if (ret)
>> +             return -EINVAL;
>> +
>> +     offset = ep_name ? fdt_next_subnode(blob, offset) :
>> +             fdt_first_subnode(blob, offset);
> tristate with function calls is harder to follow, convert this to if-else logic
Will change.

Thanks,
Lizhi
>> +     if (offset < 0)
>> +             return -EINVAL;
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
>> +     *ep_name = fdt_get_name(blob, ep_offset, NULL);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_get_compatible_endpoint);
>> +
>> +int xrt_md_pack(struct device *dev, char *blob)
>> +{
>> +     int ret;
>> +
>> +     ret = fdt_pack(blob);
>> +     if (ret)
>> +             dev_err(dev, "pack failed %d", ret);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_pack);
>> +
>> +int xrt_md_get_interface_uuids(struct device *dev, const char *blob,
> ok
>> +                            u32 num_uuids, uuid_t *interface_uuids)
>> +{
>> +     int offset, count = 0;
>> +     const char *uuid_str;
>> +     int ret;
>> +
>> +     ret = xrt_md_get_endpoint(dev, blob, XRT_MD_NODE_INTERFACES, NULL, &offset);
>> +     if (ret)
>> +             return -ENOENT;
>> +
>> +     for (offset = fdt_first_subnode(blob, offset);
>> +         offset >= 0;
>> +         offset = fdt_next_subnode(blob, offset), count++) {
>> +             uuid_str = fdt_getprop(blob, offset, XRT_MD_PROP_INTERFACE_UUID,
>> +                                    NULL);
>> +             if (!uuid_str) {
>> +                     dev_err(dev, "empty interface uuid node");
>> +                     return -EINVAL;
>> +             }
>> +
>> +             if (!num_uuids)
>> +                     continue;
>> +
>> +             if (count == num_uuids) {
> ok
>
>> +                     dev_err(dev, "too many interface uuid in blob");
>> +                     return -EINVAL;
>> +             }
>> +
>> +             if (interface_uuids && count < num_uuids) {
>> +                     ret = xrt_md_trans_str2uuid(dev, uuid_str,
>> +                                                 &interface_uuids[count]);
>> +                     if (ret)
>> +                             return -EINVAL;
>> +             }
>> +     }
>> +     if (!count)
>> +             count = -ENOENT;
>> +
>> +     return count;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_md_get_interface_uuids);
> Thanks for the changes,
>
> Tom
>

