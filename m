Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46D23577DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhDGWlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 18:41:36 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:54784
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229449AbhDGWlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:41:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUF4jHyXGbW58evTSn7UUhtKedRDZGZgmm7JY04Xd8H9Ud5pzxw5E/qjnWpzt9tW0eodw4oWS0rMSoSOnlnItKPAINi0eSXzfpPxXB22A3zTER0LGGcen+PSN1L7Omrx1Nx3mOsx/+tSYbZwSrQm/+hg3LMlMJP663Ypy+NWKdqMvj11DdealKcFG98YdU1QabtLMorkBidyyydEOgVwxlntpVlH8ImFImZ1dA2TQB/T4RKei5wJibFv6utiRRGUTmKElXrv79AvODWt5/Jd5s/mgUrnQmSYmeSYRgYxd5y4Zg/UjJ8HshJsVo/Ppukrma72nYSru4Rsbc/XURhg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kupmb62sQ8Hx8hNu7Qp0N/AIaAksXX9sJVEoISkK2+I=;
 b=LZBfKypxbrnPM8yWaFA3fApVvduCG42b3rErRcU+G/5lK7mDgcI0VsmGqZFfFXF2eHrbhn3BX8E6KNTsmgyZc5Q/0gKItMF0JmWTVVWMNnfgS0Kw/K9cJW2S+kizMZZPjuHPCvGyADz0gOqa/a2DsFnLQgEDae4aDe5ArEGg5+jGjEljMQfaAfWHCkPkhj1+hu2bBWd6LOMg2nQ2OxEd71B7uBdqlKGrnBsrShq0WsMZfVRX6CZ2/Z9SSLDF6gKgCa/nVK4CZxGKb/BJ4NNsrO9N7QVgZnE95R5Rhw2aEDUDcqOBvHk7ezvXsycBcwCHu1cIWbr8UpAZNUqkICoZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kupmb62sQ8Hx8hNu7Qp0N/AIaAksXX9sJVEoISkK2+I=;
 b=Uu4uox5ozxIkYfvJyUpd1B+QTYKbsdPFUcguqvesIkz+bBfJsNVboV/23cTmEQadqJHpezFPOiuso2kSoNP9/OWLYFdh8s0Up6SNyWnqW5cBPa0IDWF0JVbxMYyXIxW8fPl0oX9K6zPmuPlScOestSMqKItv2FPGfyCRmi0tzN4=
Received: from MN2PR11CA0012.namprd11.prod.outlook.com (2603:10b6:208:23b::17)
 by PH0PR02MB7158.namprd02.prod.outlook.com (2603:10b6:510:1b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 22:41:22 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23b:cafe::92) by MN2PR11CA0012.outlook.office365.com
 (2603:10b6:208:23b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 22:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 22:41:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 15:41:17 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Wed, 7 Apr 2021 15:41:17 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=43866)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lUGrN-0008Bz-LJ; Wed, 07 Apr 2021 15:41:17 -0700
Subject: Re: [PATCH V4 XRT Alveo 11/20] fpga: xrt: fpga-mgr and region
 implementation for xclbin download
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <mdf@kernel.org>, <robh@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-12-lizhi.hou@xilinx.com>
 <7fea5bed-c64a-528b-5e03-54f41220be8c@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <eb7c45d9-5982-e6c8-1a48-2c9ee5ef618a@xilinx.com>
Date:   Wed, 7 Apr 2021 15:41:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <7fea5bed-c64a-528b-5e03-54f41220be8c@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32bccf81-d596-4da3-b485-08d8fa164513
X-MS-TrafficTypeDiagnostic: PH0PR02MB7158:
X-Microsoft-Antispam-PRVS: <PH0PR02MB71589A45695958A04EDB8206A1759@PH0PR02MB7158.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOHjVsccV99g7mar+Zt8QE60wkNu+U6nQ4D70kOG/dQw+I9lMwFn7htKaYfsyRt4UANHFRh2o6Z02rE/HQeSyQ21YAgXhxUbYe3Et71bOfV21k+Pykz9EuFWpLG3rvr6GO+xmc0uAGBHw+CyDYV9sTNQZDN4VVVrRPIU8nx/m5PAyXIM2DKFOtWSyskh65xpNO48tts5/9zHnpb/VdR/GWJ30i1oLlx2yDyLpE5YQhVoF6q0DXSH4lc5phF4eTjWzvrJhW+yJumtcTeph/CPBSwawHJvCbsRFGhDaESH8qopykIlDzEfGkReeeD+YHv6j4zfs8uzqnlyQhL5pkOtd4GacgYuPlFr7LOYEle+N9w3oohkYb0G0CQ7ykqLabxXDPEjafHQKGSQEmslxCO1Xd/pg728OF7fvfLILmJNIzw+rHVThKQ7/YNIHfEPKyJgNNlepihWi7geEN6KiRB5Bo1auk75mpS4w/JAWeOxYwLfhp02hCfIlRUgldwr9k9J/cOEubAPs1vJV0ww3SrOZcDhsDlJZJ/1SiAztn8WYJ8w4ZP8ATrGun4xsEQyFHR9iTrmmKhIdYz9agOEvLX3zHcrJL4VJI97EpCOYzD0JE5Qr81rAeaCfHzWfMaHIEk/NPmMScMhvk+c+wODKCMYozKNy8/t8TbJI21ItmYxL4i5dysvVhc5AgRnccJZ6Iv4lXZFxwDB+PV/2JeiliXk2lelPH33O+cW65A6Q1mj0nA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(316002)(70586007)(31696002)(8936002)(8676002)(36756003)(426003)(53546011)(36906005)(31686004)(70206006)(9786002)(4326008)(356005)(26005)(107886003)(36860700001)(186003)(336012)(30864003)(44832011)(2616005)(5660300002)(82740400003)(82310400003)(83380400001)(7636003)(54906003)(2906002)(478600001)(47076005)(110136005)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 22:41:22.6666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bccf81-d596-4da3-b485-08d8fa164513
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,


On 04/01/2021 07:43 AM, Tom Rix wrote:
> small alloc's should use kzalloc.
>
> On 3/23/21 10:29 PM, Lizhi Hou wrote:
>> fpga-mgr and region implementation for xclbin download which will be
>> called from main platform driver
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/fpga/xrt/mgmt/fmgr-drv.c    | 191 +++++++++++
>>   drivers/fpga/xrt/mgmt/fmgr.h        |  19 ++
>>   drivers/fpga/xrt/mgmt/main-region.c | 483 ++++++++++++++++++++++++++++
>>   3 files changed, 693 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/mgmt/fmgr-drv.c
>>   create mode 100644 drivers/fpga/xrt/mgmt/fmgr.h
> a better file name would be xrt-mgr.*
Will change file name to xrt-mgr.*
>>   create mode 100644 drivers/fpga/xrt/mgmt/main-region.c
>>
>> diff --git a/drivers/fpga/xrt/mgmt/fmgr-drv.c b/drivers/fpga/xrt/mgmt/fmgr-drv.c
>> new file mode 100644
>> index 000000000000..12e1cc788ad9
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/fmgr-drv.c
>> @@ -0,0 +1,191 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * FPGA Manager Support for Xilinx Alveo Management Function Driver
> Since there is only one fpga mgr for xrt, this could be shortened to
>
> * FPGA Manager Support for Xilinx Alevo
Sure.
>
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors: Sonal.Santan@xilinx.com
>> + */
>> +
>> +#include <linux/cred.h>
>> +#include <linux/efi.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include "xclbin-helper.h"
>> +#include "xleaf.h"
>> +#include "fmgr.h"
>> +#include "xleaf/axigate.h"
>> +#include "xleaf/icap.h"
>> +#include "xmgnt.h"
>> +
>> +struct xfpga_class {
>> +     const struct platform_device *pdev;
>> +     char                          name[64];
>> +};
>> +
>> +/*
>> + * xclbin download plumbing -- find the download subsystem, ICAP and
>> + * pass the xclbin for heavy lifting
>> + */
>> +static int xmgmt_download_bitstream(struct platform_device *pdev,
>> +                                 const struct axlf *xclbin)
>> +
>> +{
>> +     struct xclbin_bit_head_info bit_header = { 0 };
>> +     struct platform_device *icap_leaf = NULL;
>> +     struct xrt_icap_wr arg;
>> +     char *bitstream = NULL;
>> +     u64 bit_len;
>> +     int ret;
>> +
>> +     ret = xrt_xclbin_get_section(DEV(pdev), xclbin, BITSTREAM, (void **)&bitstream, &bit_len);
>> +     if (ret) {
>> +             xrt_err(pdev, "bitstream not found");
>> +             return -ENOENT;
>> +     }
>> +     ret = xrt_xclbin_parse_bitstream_header(DEV(pdev), bitstream,
>> +                                             XCLBIN_HWICAP_BITFILE_BUF_SZ,
>> +                                             &bit_header);
>> +     if (ret) {
>> +             ret = -EINVAL;
>> +             xrt_err(pdev, "invalid bitstream header");
>> +             goto fail;
>> +     }
>> +     if (bit_header.header_length + bit_header.bitstream_length > bit_len) {
>> +             ret = -EINVAL;
>> +             xrt_err(pdev, "invalid bitstream length. header %d, bitstream %d, section len %lld",
>> +                     bit_header.header_length, bit_header.bitstream_length, bit_len);
>> +             goto fail;
>> +     }
>> +
>> +     icap_leaf = xleaf_get_leaf_by_id(pdev, XRT_SUBDEV_ICAP, PLATFORM_DEVID_NONE);
>> +     if (!icap_leaf) {
>> +             ret = -ENODEV;
>> +             xrt_err(pdev, "icap does not exist");
>> +             goto fail;
>> +     }
>> +     arg.xiiw_bit_data = bitstream + bit_header.header_length;
>> +     arg.xiiw_data_len = bit_header.bitstream_length;
>> +     ret = xleaf_call(icap_leaf, XRT_ICAP_WRITE, &arg);
>> +     if (ret) {
>> +             xrt_err(pdev, "write bitstream failed, ret = %d", ret);
>> +             xleaf_put_leaf(pdev, icap_leaf);
>> +             goto fail;
>> +     }
> ok, free_header removed
>> +
>> +     xleaf_put_leaf(pdev, icap_leaf);
>> +     vfree(bitstream);
>> +
>> +     return 0;
>> +
>> +fail:
>> +     vfree(bitstream);
>> +
>> +     return ret;
>> +}
>> +
>> +/*
>> + * There is no HW prep work we do here since we need the full
>> + * xclbin for its sanity check.
>> + */
>> +static int xmgmt_pr_write_init(struct fpga_manager *mgr,
>> +                            struct fpga_image_info *info,
>> +                            const char *buf, size_t count)
>> +{
>> +     const struct axlf *bin = (const struct axlf *)buf;
>> +     struct xfpga_class *obj = mgr->priv;
>> +
>> +     if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
>> +             xrt_info(obj->pdev, "%s only supports partial reconfiguration\n", obj->name);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (count < sizeof(struct axlf))
>> +             return -EINVAL;
>> +
>> +     if (count > bin->header.length)
>> +             return -EINVAL;
>> +
>> +     xrt_info(obj->pdev, "Prepare download of xclbin %pUb of length %lld B",
>> +              &bin->header.uuid, bin->header.length);
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * The implementation requries full xclbin image before we can start
>> + * programming the hardware via ICAP subsystem. The full image is required
> ok
>> + * for checking the validity of xclbin and walking the sections to
>> + * discover the bitstream.
>> + */
>> +static int xmgmt_pr_write(struct fpga_manager *mgr,
>> +                       const char *buf, size_t count)
>> +{
>> +     const struct axlf *bin = (const struct axlf *)buf;
>> +     struct xfpga_class *obj = mgr->priv;
>> +
>> +     if (bin->header.length != count)
>> +             return -EINVAL;
>> +
>> +     return xmgmt_download_bitstream((void *)obj->pdev, bin);
>> +}
>> +
>> +static int xmgmt_pr_write_complete(struct fpga_manager *mgr,
>> +                                struct fpga_image_info *info)
>> +{
>> +     const struct axlf *bin = (const struct axlf *)info->buf;
>> +     struct xfpga_class *obj = mgr->priv;
>> +
>> +     xrt_info(obj->pdev, "Finished download of xclbin %pUb",
>> +              &bin->header.uuid);
>> +     return 0;
>> +}
>> +
>> +static enum fpga_mgr_states xmgmt_pr_state(struct fpga_manager *mgr)
>> +{
>> +     return FPGA_MGR_STATE_UNKNOWN;
> ok as-is
>> +}
>> +
>> +static const struct fpga_manager_ops xmgmt_pr_ops = {
>> +     .initial_header_size = sizeof(struct axlf),
>> +     .write_init = xmgmt_pr_write_init,
>> +     .write = xmgmt_pr_write,
>> +     .write_complete = xmgmt_pr_write_complete,
>> +     .state = xmgmt_pr_state,
>> +};
>> +
>> +struct fpga_manager *xmgmt_fmgr_probe(struct platform_device *pdev)
>> +{
>> +     struct xfpga_class *obj = devm_kzalloc(DEV(pdev), sizeof(struct xfpga_class),
>> +                                            GFP_KERNEL);
>> +     struct fpga_manager *fmgr = NULL;
>> +     int ret = 0;
>> +
>> +     if (!obj)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     snprintf(obj->name, sizeof(obj->name), "Xilinx Alveo FPGA Manager");
>> +     obj->pdev = pdev;
>> +     fmgr = fpga_mgr_create(&pdev->dev,
>> +                            obj->name,
>> +                            &xmgmt_pr_ops,
>> +                            obj);
>> +     if (!fmgr)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     ret = fpga_mgr_register(fmgr);
>> +     if (ret) {
>> +             fpga_mgr_free(fmgr);
>> +             return ERR_PTR(ret);
>> +     }
>> +     return fmgr;
>> +}
>> +
>> +int xmgmt_fmgr_remove(struct fpga_manager *fmgr)
>> +{
>> +     fpga_mgr_unregister(fmgr);
>> +     return 0;
>> +}
>> diff --git a/drivers/fpga/xrt/mgmt/fmgr.h b/drivers/fpga/xrt/mgmt/fmgr.h
>> new file mode 100644
>> index 000000000000..ff1fc5f870f8
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/fmgr.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors: Sonal.Santan@xilinx.com
>> + */
>> +
>> +#ifndef _XMGMT_FMGR_H_
>> +#define _XMGMT_FMGR_H_
>> +
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/mutex.h>
> why do mutex.h and xclbin.h need to be included ?
>
> consider removing them.
Sure.
>
>> +
>> +#include <linux/xrt/xclbin.h>
> ok enum removed.
>> +
>> +struct fpga_manager *xmgmt_fmgr_probe(struct platform_device *pdev);
>> +int xmgmt_fmgr_remove(struct fpga_manager *fmgr);
>> +
>> +#endif
>> diff --git a/drivers/fpga/xrt/mgmt/main-region.c b/drivers/fpga/xrt/mgmt/main-region.c
>> new file mode 100644
>> index 000000000000..96a674618e86
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/main-region.c
>> @@ -0,0 +1,483 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * FPGA Region Support for Xilinx Alveo Management Function Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + * Bulk of the code borrowed from XRT mgmt driver file, fmgr.c
> review this line, there is not fmgr.c
Will remove this line.
>> + *
>> + * Authors: Lizhi.Hou@xilinx.com
>> + */
>> +
>> +#include <linux/uuid.h>
>> +#include <linux/fpga/fpga-bridge.h>
>> +#include <linux/fpga/fpga-region.h>
>> +#include "metadata.h"
>> +#include "xleaf.h"
>> +#include "xleaf/axigate.h"
>> +#include "xclbin-helper.h"
>> +#include "xmgnt.h"
>> +
>> +struct xmgmt_bridge {
>> +     struct platform_device *pdev;
>> +     const char *bridge_name;
> ok
>> +};
>> +
>> +struct xmgmt_region {
>> +     struct platform_device *pdev;
>> +     struct fpga_region *region;
>> +     struct fpga_compat_id compat_id;
>> +     uuid_t intf_uuid;
> interface_uuid
Sure.
>> +     struct fpga_bridge *bridge;
>> +     int group_instance;
>> +     uuid_t dep_uuid;
> dep ? expand.
Will use 'depend_uuid'
>> +     struct list_head list;
>> +};
>> +
>> +struct xmgmt_region_match_arg {
>> +     struct platform_device *pdev;
>> +     uuid_t *uuids;
>> +     u32 uuid_num;
>> +};
>> +
>> +static int xmgmt_br_enable_set(struct fpga_bridge *bridge, bool enable)
>> +{
>> +     struct xmgmt_bridge *br_data = (struct xmgmt_bridge *)bridge->priv;
>> +     struct platform_device *axigate_leaf;
>> +     int rc;
>> +
>> +     axigate_leaf = xleaf_get_leaf_by_epname(br_data->pdev, br_data->bridge_name);
>> +     if (!axigate_leaf) {
>> +             xrt_err(br_data->pdev, "failed to get leaf %s",
>> +                     br_data->bridge_name);
>> +             return -ENOENT;
>> +     }
>> +
>> +     if (enable)
>> +             rc = xleaf_call(axigate_leaf, XRT_AXIGATE_OPEN, NULL);
>> +     else
>> +             rc = xleaf_call(axigate_leaf, XRT_AXIGATE_CLOSE, NULL);
>> +
>> +     if (rc) {
>> +             xrt_err(br_data->pdev, "failed to %s gate %s, rc %d",
>> +                     (enable ? "free" : "freeze"), br_data->bridge_name,
>> +                     rc);
>> +     }
>> +
>> +     xleaf_put_leaf(br_data->pdev, axigate_leaf);
>> +
>> +     return rc;
>> +}
>> +
>> +const struct fpga_bridge_ops xmgmt_bridge_ops = {
>> +     .enable_set = xmgmt_br_enable_set
>> +};
>> +
>> +static void xmgmt_destroy_bridge(struct fpga_bridge *br)
>> +{
>> +     struct xmgmt_bridge *br_data = br->priv;
>> +
>> +     if (!br_data)
>> +             return;
>> +
>> +     xrt_info(br_data->pdev, "destroy fpga bridge %s", br_data->bridge_name);
>> +     fpga_bridge_unregister(br);
>> +
>> +     devm_kfree(DEV(br_data->pdev), br_data);
>> +
>> +     fpga_bridge_free(br);
>> +}
>> +
>> +static struct fpga_bridge *xmgmt_create_bridge(struct platform_device *pdev,
>> +                                            char *dtb)
>> +{
>> +     struct fpga_bridge *br = NULL;
>> +     struct xmgmt_bridge *br_data;
>> +     const char *gate;
>> +     int rc;
>> +
>> +     br_data = devm_kzalloc(DEV(pdev), sizeof(*br_data), GFP_KERNEL);
>> +     if (!br_data)
>> +             return NULL;
>> +     br_data->pdev = pdev;
>> +
>> +     br_data->bridge_name = XRT_MD_NODE_GATE_ULP;
>> +     rc = xrt_md_find_endpoint(&pdev->dev, dtb, XRT_MD_NODE_GATE_ULP,
>> +                               NULL, &gate);
>> +     if (rc) {
>> +             br_data->bridge_name = XRT_MD_NODE_GATE_PLP;
>> +             rc = xrt_md_find_endpoint(&pdev->dev, dtb, XRT_MD_NODE_GATE_PLP,
>> +                                       NULL, &gate);
>> +     }
>> +     if (rc) {
>> +             xrt_err(pdev, "failed to get axigate, rc %d", rc);
>> +             goto failed;
>> +     }
>> +
>> +     br = fpga_bridge_create(DEV(pdev), br_data->bridge_name,
>> +                             &xmgmt_bridge_ops, br_data);
>> +     if (!br) {
>> +             xrt_err(pdev, "failed to create bridge");
>> +             goto failed;
>> +     }
>> +
>> +     rc = fpga_bridge_register(br);
>> +     if (rc) {
>> +             xrt_err(pdev, "failed to register bridge, rc %d", rc);
>> +             goto failed;
>> +     }
>> +
>> +     xrt_info(pdev, "created fpga bridge %s", br_data->bridge_name);
>> +
>> +     return br;
>> +
>> +failed:
>> +     if (br)
>> +             fpga_bridge_free(br);
>> +     if (br_data)
>> +             devm_kfree(DEV(pdev), br_data);
>> +
>> +     return NULL;
>> +}
>> +
>> +static void xmgmt_destroy_region(struct fpga_region *region)
> ok
>> +{
>> +     struct xmgmt_region *r_data = region->priv;
>> +
>> +     xrt_info(r_data->pdev, "destroy fpga region %llx.%llx",
>> +              region->compat_id->id_l, region->compat_id->id_h);
> are the args ordered correctly ? I expected id_h to be first.
Will switch the order.
>> +
>> +     fpga_region_unregister(region);
>> +
>> +     if (r_data->group_instance > 0)
>> +             xleaf_destroy_group(r_data->pdev, r_data->group_instance);
>> +
>> +     if (r_data->bridge)
>> +             xmgmt_destroy_bridge(r_data->bridge);
>> +
>> +     if (r_data->region->info) {
>> +             fpga_image_info_free(r_data->region->info);
>> +             r_data->region->info = NULL;
>> +     }
>> +
>> +     fpga_region_free(region);
>> +
>> +     devm_kfree(DEV(r_data->pdev), r_data);
>> +}
>> +
>> +static int xmgmt_region_match(struct device *dev, const void *data)
>> +{
>> +     const struct xmgmt_region_match_arg *arg = data;
>> +     const struct fpga_region *match_region;
> ok
>> +     uuid_t compat_uuid;
>> +     int i;
>> +
>> +     if (dev->parent != &arg->pdev->dev)
>> +             return false;
>> +
>> +     match_region = to_fpga_region(dev);
>> +     /*
>> +      * The device tree provides both parent and child uuids for an
>> +      * xclbin in one array. Here we try both uuids to see if it matches
>> +      * with target region's compat_id. Strictly speaking we should
>> +      * only match xclbin's parent uuid with target region's compat_id
>> +      * but given the uuids by design are unique comparing with both
>> +      * does not hurt.
>> +      */
>> +     import_uuid(&compat_uuid, (const char *)match_region->compat_id);
>> +     for (i = 0; i < arg->uuid_num; i++) {
>> +             if (uuid_equal(&compat_uuid, &arg->uuids[i]))
>> +                     return true;
>> +     }
>> +
>> +     return false;
>> +}
>> +
>> +static int xmgmt_region_match_base(struct device *dev, const void *data)
>> +{
>> +     const struct xmgmt_region_match_arg *arg = data;
>> +     const struct fpga_region *match_region;
>> +     const struct xmgmt_region *r_data;
>> +
>> +     if (dev->parent != &arg->pdev->dev)
>> +             return false;
>> +
>> +     match_region = to_fpga_region(dev);
>> +     r_data = match_region->priv;
>> +     if (uuid_is_null(&r_data->dep_uuid))
>> +             return true;
>> +
>> +     return false;
>> +}
>> +
>> +static int xmgmt_region_match_by_uuid(struct device *dev, const void *data)
> ok
>> +{
>> +     const struct xmgmt_region_match_arg *arg = data;
>> +     const struct fpga_region *match_region;
>> +     const struct xmgmt_region *r_data;
>> +
>> +     if (dev->parent != &arg->pdev->dev)
>> +             return false;
>> +
>> +     if (arg->uuid_num != 1)
>> +             return false;
> ok
>> +
>> +     match_region = to_fpga_region(dev);
>> +     r_data = match_region->priv;
>> +     if (uuid_equal(&r_data->dep_uuid, arg->uuids))
>> +             return true;
>> +
>> +     return false;
>> +}
>> +
>> +static void xmgmt_region_cleanup(struct fpga_region *region)
>> +{
>> +     struct xmgmt_region *r_data = region->priv, *pdata, *temp;
>> +     struct platform_device *pdev = r_data->pdev;
>> +     struct xmgmt_region_match_arg arg = { 0 };
>> +     struct fpga_region *match_region = NULL;
>> +     struct device *start_dev = NULL;
>> +     LIST_HEAD(free_list);
>> +     uuid_t compat_uuid;
>> +
>> +     list_add_tail(&r_data->list, &free_list);
>> +     arg.pdev = pdev;
>> +     arg.uuid_num = 1;
>> +     arg.uuids = &compat_uuid;
>> +
>> +     /* find all regions depending on this region */
>> +     list_for_each_entry_safe(pdata, temp, &free_list, list) {
> ok
>> +             import_uuid(arg.uuids, (const char *)pdata->region->compat_id);
>> +             start_dev = NULL;
>> +             while ((match_region = fpga_region_class_find(start_dev, &arg,
>> +                                                           xmgmt_region_match_by_uuid))) {
>> +                     pdata = match_region->priv;
>> +                     list_add_tail(&pdata->list, &free_list);
>> +                     start_dev = &match_region->dev;
>> +                     put_device(&match_region->dev);
>> +             }
>> +     }
>> +
>> +     list_del(&r_data->list);
>> +
>> +     list_for_each_entry_safe_reverse(pdata, temp, &free_list, list)
>> +             xmgmt_destroy_region(pdata->region);
>> +
>> +     if (r_data->group_instance > 0) {
>> +             xleaf_destroy_group(pdev, r_data->group_instance);
>> +             r_data->group_instance = -1;
>> +     }
>> +     if (r_data->region->info) {
>> +             fpga_image_info_free(r_data->region->info);
>> +             r_data->region->info = NULL;
>> +     }
>> +}
>> +
>> +void xmgmt_region_cleanup_all(struct platform_device *pdev)
>> +{
>> +     struct xmgmt_region_match_arg arg = { 0 };
>> +     struct fpga_region *base_region;
>> +
>> +     arg.pdev = pdev;
>> +
>> +     while ((base_region = fpga_region_class_find(NULL, &arg, xmgmt_region_match_base))) {
> ok
>> +             put_device(&base_region->dev);
>> +
>> +             xmgmt_region_cleanup(base_region);
>> +             xmgmt_destroy_region(base_region);
>> +     }
>> +}
>> +
>> +/*
>> + * Program a region with a xclbin image. Bring up the subdevs and the
> ok
>> + * group object to contain the subdevs.
>> + */
>> +static int xmgmt_region_program(struct fpga_region *region, const void *xclbin, char *dtb)
>> +{
>> +     const struct axlf *xclbin_obj = xclbin;
>> +     struct fpga_image_info *info;
>> +     struct platform_device *pdev;
>> +     struct xmgmt_region *r_data;
>> +     int rc;
>> +
>> +     r_data = region->priv;
>> +     pdev = r_data->pdev;
>> +
>> +     info = fpga_image_info_alloc(&pdev->dev);
>> +     if (!info)
>> +             return -ENOMEM;
>> +
>> +     info->buf = xclbin;
>> +     info->count = xclbin_obj->header.length;
>> +     info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
>> +     region->info = info;
>> +     rc = fpga_region_program_fpga(region);
>> +     if (rc) {
>> +             xrt_err(pdev, "programming xclbin failed, rc %d", rc);
>> +             return rc;
>> +     }
>> +
>> +     /* free bridges to allow reprogram */
>> +     if (region->get_bridges)
>> +             fpga_bridges_put(&region->bridge_list);
>> +
>> +     /*
>> +      * Next bringup the subdevs for this region which will be managed by
>> +      * its own group object.
>> +      */
>> +     r_data->group_instance = xleaf_create_group(pdev, dtb);
>> +     if (r_data->group_instance < 0) {
>> +             xrt_err(pdev, "failed to create group, rc %d",
>> +                     r_data->group_instance);
>> +             rc = r_data->group_instance;
>> +             return rc;
>> +     }
>> +
>> +     rc = xleaf_wait_for_group_bringup(pdev);
>> +     if (rc)
>> +             xrt_err(pdev, "group bringup failed, rc %d", rc);
>> +     return rc;
>> +}
>> +
>> +static int xmgmt_get_bridges(struct fpga_region *region)
>> +{
>> +     struct xmgmt_region *r_data = region->priv;
>> +     struct device *dev = &r_data->pdev->dev;
>> +
>> +     return fpga_bridge_get_to_list(dev, region->info, &region->bridge_list);
>> +}
>> +
>> +/*
>> + * Program/create FPGA regions based on input xclbin file.
> ok, dropped sentence
>> + * 1. Identify a matching existing region for this xclbin
>> + * 2. Tear down any previous objects for the found region
>> + * 3. Program this region with input xclbin
>> + * 4. Iterate over this region's interface uuids to determine if it defines any
>> + *    child region. Create fpga_region for the child region.
>> + */
>> +int xmgmt_process_xclbin(struct platform_device *pdev,
>> +                      struct fpga_manager *fmgr,
>> +                      const struct axlf *xclbin,
>> +                      enum provider_kind kind)
>> +{
>> +     struct fpga_region *region, *compat_region = NULL;
>> +     struct xmgmt_region_match_arg arg = { 0 };
> ok
>> +     struct xmgmt_region *r_data;
>> +     uuid_t compat_uuid;
>> +     char *dtb = NULL;
>> +     int rc, i;
>> +
>> +     rc = xrt_xclbin_get_metadata(DEV(pdev), xclbin, &dtb);
>> +     if (rc) {
>> +             xrt_err(pdev, "failed to get dtb: %d", rc);
>> +             goto failed;
>> +     }
>> +
>> +     rc = xrt_md_get_interface_uuids(DEV(pdev), dtb, 0, NULL);
>> +     if (rc < 0) {
>> +             xrt_err(pdev, "failed to get intf uuid");
>> +             rc = -EINVAL;
> ok
>> +             goto failed;
>> +     }
>> +     arg.uuid_num = rc;
>> +     arg.uuids = vzalloc(sizeof(uuid_t) * arg.uuid_num);
> uuids small, convert to bzalloc
Will change to kcalloc.
>> +     if (!arg.uuids) {
>> +             rc = -ENOMEM;
>> +             goto failed;
>> +     }
>> +     arg.pdev = pdev;
>> +
>> +     rc = xrt_md_get_interface_uuids(DEV(pdev), dtb, arg.uuid_num, arg.uuids);
>> +     if (rc != arg.uuid_num) {
>> +             xrt_err(pdev, "only get %d uuids, expect %d", rc, arg.uuid_num);
>> +             rc = -EINVAL;
>> +             goto failed;
>> +     }
>> +
>> +     /* if this is not base firmware, search for a compatible region */
>> +     if (kind != XMGMT_BLP) {
>> +             compat_region = fpga_region_class_find(NULL, &arg, xmgmt_region_match);
>> +             if (!compat_region) {
>> +                     xrt_err(pdev, "failed to get compatible region");
>> +                     rc = -ENOENT;
>> +                     goto failed;
>> +             }
>> +
>> +             xmgmt_region_cleanup(compat_region);
>> +
>> +             rc = xmgmt_region_program(compat_region, xclbin, dtb);
>> +             if (rc) {
>> +                     xrt_err(pdev, "failed to program region");
>> +                     goto failed;
>> +             }
>> +     }
>> +
>> +     if (compat_region)
>> +             import_uuid(&compat_uuid, (const char *)compat_region->compat_id);
>> +
>> +     /* create all the new regions contained in this xclbin */
>> +     for (i = 0; i < arg.uuid_num; i++) {
>> +             if (compat_region && uuid_equal(&compat_uuid, &arg.uuids[i])) {
>> +                     /* region for this interface already exists */
>> +                     continue;
>> +             }
>> +
>> +             region = fpga_region_create(DEV(pdev), fmgr, xmgmt_get_bridges);
>> +             if (!region) {
>> +                     xrt_err(pdev, "failed to create fpga region");
>> +                     rc = -EFAULT;
>> +                     goto failed;
>> +             }
>> +             r_data = devm_kzalloc(DEV(pdev), sizeof(*r_data), GFP_KERNEL);
>> +             if (!r_data) {
>> +                     rc = -ENOMEM;
>> +                     fpga_region_free(region);
>> +                     goto failed;
>> +             }
>> +             r_data->pdev = pdev;
>> +             r_data->region = region;
>> +             r_data->group_instance = -1;
>> +             uuid_copy(&r_data->intf_uuid, &arg.uuids[i]);
>> +             if (compat_region)
>> +                     import_uuid(&r_data->dep_uuid, (const char *)compat_region->compat_id);
>> +             r_data->bridge = xmgmt_create_bridge(pdev, dtb);
>> +             if (!r_data->bridge) {
>> +                     xrt_err(pdev, "failed to create fpga bridge");
>> +                     rc = -EFAULT;
>> +                     devm_kfree(DEV(pdev), r_data);
>> +                     fpga_region_free(region);
>> +                     goto failed;
>> +             }
>> +
>> +             region->compat_id = &r_data->compat_id;
>> +             export_uuid((char *)region->compat_id, &r_data->intf_uuid);
>> +             region->priv = r_data;
>> +
>> +             rc = fpga_region_register(region);
>> +             if (rc) {
>> +                     xrt_err(pdev, "failed to register fpga region");
>> +                     xmgmt_destroy_bridge(r_data->bridge);
>> +                     fpga_region_free(region);
>> +                     devm_kfree(DEV(pdev), r_data);
>> +                     goto failed;
>> +             }
>> +
>> +             xrt_info(pdev, "created fpga region %llx%llx",
>> +                      region->compat_id->id_l, region->compat_id->id_h);
> see above comment on id_h
>
> destroy's info used %llx.%llx, for consistency need to add or remove a '.'
Sure.

Thanks,
Lizhi
>
> Tom
>
>> +     }
>> +
>> +     if (compat_region)
>> +             put_device(&compat_region->dev);
>> +     vfree(dtb);
>> +     return 0;
>> +
>> +failed:
>> +     if (compat_region) {
>> +             put_device(&compat_region->dev);
>> +             xmgmt_region_cleanup(compat_region);
>> +     } else {
>> +             xmgmt_region_cleanup_all(pdev);
>> +     }
>> +
>> +     vfree(dtb);
>> +     return rc;
>> +}

