Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF185355D51
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbhDFU72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:59:28 -0400
Received: from mail-eopbgr700086.outbound.protection.outlook.com ([40.107.70.86]:42927
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241851AbhDFU7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:59:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOz7iDhhbsavlYRv635dBF/fnnvH83n7jyWJUQN83GgLmqzKW9LoJEhAnr2v/3x9ozv9vXnZ/B3bU0r7tdQrHncNtHN/jGDVeTkG7AMRdBgoNJjzgSDs0sZiRThMlE19VLu3K4bcg/Zoma7aSWpaF2t4YkSux1Nf+fGIIj0CwwqrKt8ek/N/MCYJAprj7mKoxMTK8awreuz4k8pkKHemAISswwnez4z8U/CiSOeX8icUCfC/w294lFT75bgEiWmF6J32K+8hU/UnroWYWDF7UkzRxoz0xu1dNgM5qLL6xOtxzNDtxAtWFoM8SAl7OjisiHZlkAdyRxtvx4cmkXPlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxO0yfJjP6ayIXmEVVI4/fETOl5mdMw+1O+xYwRyO+g=;
 b=GLr1obuCW7MUZ5uA5sgcIADLEdWHgpDj2ejhparQUQdM9cJYXG5yCRPxC2uUmjzqtU0YsTFiv2OnTUcO3DXcRLdgXDz/5KPDkFKeq29g3yIIMAfxl8WvyBKD/5jha1y5x5uVc8i/4U+mgftrF7dQQdXj5Yg9Ntg6QiSuykJGcStUr+rPFvDEps6+gm/QZJtuxS0B1Yj0ETPH/jmYuQ2RzGkBP5nYg6+GzKXlUoOq+cVKTrmZb0NOL+rWZCt+LdPYbgP37WhG/kbpgKCCeUOw/xxrRABcAYQFn9C8l49CsNWOUC1u7PhZe4Ju2Lxk97ZXHstJfO0fjBH9bwswgPI0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxO0yfJjP6ayIXmEVVI4/fETOl5mdMw+1O+xYwRyO+g=;
 b=YzdPaPZJOFPuwMM8W/VKgrloid5TnRP2TNPBxjgxtFyXUGKhL9ptSx+F3nBbcwjSZuQfMLI/qkB796ANraKZ0c2bd2BER+sPlanNXEZ6PyUoUvtt2v04oMuitVVUFebFmutpN3wMkUVWjnSdJrzVwj8Vu6FW0vQh4HqxNCiX7Is=
Received: from SN7PR04CA0115.namprd04.prod.outlook.com (2603:10b6:806:122::30)
 by SN6PR02MB4381.namprd02.prod.outlook.com (2603:10b6:805:b3::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 20:59:07 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:122:cafe::85) by SN7PR04CA0115.outlook.office365.com
 (2603:10b6:806:122::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Tue, 6 Apr 2021 20:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 20:59:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 13:59:06 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 6 Apr 2021 13:59:06 -0700
Envelope-to: robh@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 mdf@kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.3.3] (port=49108)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <max.zhen@xilinx.com>)
        id 1lTsmw-0001zO-4F; Tue, 06 Apr 2021 13:59:06 -0700
Subject: Re: [PATCH V4 XRT Alveo 04/20] fpga: xrt: xrt-lib platform driver
 manager
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>, Max Zhen <max.zhen@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <sonal.santan@xilinx.com>,
        <yliu@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-5-lizhi.hou@xilinx.com>
 <73acaff9-d8a7-ff26-e838-7184c08c513f@redhat.com>
From:   Max Zhen <max.zhen@xilinx.com>
Message-ID: <c3d2d449-8adb-5fbb-ab8d-7c6b07b71fed@xilinx.com>
Date:   Tue, 6 Apr 2021 13:59:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <73acaff9-d8a7-ff26-e838-7184c08c513f@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9db827bf-4162-4ecd-1490-08d8f93ed16a
X-MS-TrafficTypeDiagnostic: SN6PR02MB4381:
X-Microsoft-Antispam-PRVS: <SN6PR02MB43818C8AD237EE6F03AD4C03B9769@SN6PR02MB4381.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LtPogPWnEMOUhhEKnKYOYXnS0ePMSffle84MQcDGm++lpQ4Ows27GIYYazxHsSMKhsuMUKZoW1I7sPmJkYTIxpNriCWDUw21yktEDJ9ctIf/wF1QWPPgjf6mZlIVzbGCFW2Y959bMVUPHb0Vn7+N/ZYLP6gNoka4DsMJoa1pbYhyBj0OsBwUjPOPVAyurGeost6mO88XlCoQNZAT6Ctj0w7atbdQ/y5qYRNY5sFe1tDzx3iWasx7ePoy1vveNexTmE0TBQb7zXL8OuRH1UKiHkEj70gK9UKfGevY0STR11AQMHP52GxjWWBaO8DNh2JdJPM1A8BZROh5llSrqB4X/R0jdI868Ze5cZXA/GPdGR9VBsnSrXCKc74phAQdrHkR4P9hpTA3JJ3rthsrcaa+JHuNVdnIyy1cJfhGKas/sIR+tdjT9dY38vjk/73aH1cQ++Kj14+4+9Kovm/9qYTjqFLGo+9uql4GME8PQ0KhWaH0Ci7P5l41vzt7qT3MY3NIeuxIwcAZBsFxPM8oT+0volAmqlKXJOzyBSskWXY+ZX7ZkZv3nbieQ4wkKSof5yjGPvWv1WwK28a1NTH98KldseAzr05JirMp4tdAbCPgHOjiS2/YuGiL322zK9I6lzQamuVbkNahiOD+fsOs8Aw1i2J62QWF7rpn3+fMQy+WFvSuIU99gIgvz34Oid3UHM/1hrPmMm+W2qY7a2eCwVO/0WfKakUZfO6O7JOMgqSTvA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(136003)(376002)(46966006)(36840700001)(82310400003)(186003)(26005)(336012)(2906002)(70586007)(2616005)(426003)(5660300002)(30864003)(44832011)(70206006)(110136005)(36906005)(8936002)(4326008)(316002)(36756003)(54906003)(53546011)(82740400003)(36860700001)(8676002)(7636003)(356005)(31696002)(31686004)(478600001)(83380400001)(9786002)(47076005)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 20:59:06.8795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db827bf-4162-4ecd-1490-08d8f93ed16a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4381
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,


On 3/29/21 12:44 PM, Tom Rix wrote:
> bisectablity may be/is  an issue.
>
> Moritz,
>
> building happens on the last patch, so in theory there will never be a build break needing bisection.  Do we care about the misordering of serveral of these patches?


The general idea about ordering of patches is that global defines should 
be introduced before the user.


>
> On 3/23/21 10:29 PM, Lizhi Hou wrote:
>> xrt-lib kernel module infrastructure code to register and manage all
>> leaf driver modules.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/subdev_id.h |  38 ++++
>>   drivers/fpga/xrt/include/xleaf.h     | 264 +++++++++++++++++++++++++
>>   drivers/fpga/xrt/lib/lib-drv.c       | 277 +++++++++++++++++++++++++++
> ok
>>   drivers/fpga/xrt/lib/lib-drv.h       |  17 ++
>>   4 files changed, 596 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf.h
>>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
>>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
>>
>> diff --git a/drivers/fpga/xrt/include/subdev_id.h b/drivers/fpga/xrt/include/subdev_id.h
>> new file mode 100644
>> index 000000000000..42fbd6f5e80a
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/subdev_id.h
>> @@ -0,0 +1,38 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_SUBDEV_ID_H_
>> +#define _XRT_SUBDEV_ID_H_
>> +
>> +/*
>> + * Every subdev driver has an ID for others to refer to it. There can be multiple number of
>> + * instances of a subdev driver. A <subdev_id, subdev_instance> tuple is a unique identification
>> + * of a specific instance of a subdev driver.
>> + */
>> +enum xrt_subdev_id {
>> +     XRT_SUBDEV_GRP = 0,
> not necessary to initialize all unless there are gaps.


Yeah, just trying to avoid any issue when things are accidentally reordered.


>> +     XRT_SUBDEV_VSEC = 1,
>> +     XRT_SUBDEV_VSEC_GOLDEN = 2,
>> +     XRT_SUBDEV_DEVCTL = 3,
>> +     XRT_SUBDEV_AXIGATE = 4,
>> +     XRT_SUBDEV_ICAP = 5,
>> +     XRT_SUBDEV_TEST = 6,
>> +     XRT_SUBDEV_MGMT_MAIN = 7,
>> +     XRT_SUBDEV_QSPI = 8,
>> +     XRT_SUBDEV_MAILBOX = 9,
>> +     XRT_SUBDEV_CMC = 10,
>> +     XRT_SUBDEV_CALIB = 11,
>> +     XRT_SUBDEV_CLKFREQ = 12,
>> +     XRT_SUBDEV_CLOCK = 13,
>> +     XRT_SUBDEV_SRSR = 14,
>> +     XRT_SUBDEV_UCS = 15,
>> +     XRT_SUBDEV_NUM = 16, /* Total number of subdevs. */
>> +     XRT_ROOT = -1, /* Special ID for root driver. */
>> +};
>> +
>> +#endif       /* _XRT_SUBDEV_ID_H_ */
>> diff --git a/drivers/fpga/xrt/include/xleaf.h b/drivers/fpga/xrt/include/xleaf.h
>> new file mode 100644
>> index 000000000000..acb500df04b0
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/xleaf.h
>> @@ -0,0 +1,264 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *    Cheng Zhen <maxz@xilinx.com>
>> + *    Sonal Santan <sonal.santan@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_XLEAF_H_
>> +#define _XRT_XLEAF_H_
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/fs.h>
>> +#include <linux/cdev.h>
>> +#include "subdev_id.h"
>> +#include "xroot.h"
>> +#include "events.h"
>> +
>> +/* All subdev drivers should use below common routines to print out msg. */
>> +#define DEV(pdev)    (&(pdev)->dev)
>> +#define DEV_PDATA(pdev)                                      \
>> +     ((struct xrt_subdev_platdata *)dev_get_platdata(DEV(pdev)))
>> +#define DEV_DRVDATA(pdev)                            \
>> +     ((struct xrt_subdev_drvdata *)                  \
>> +     platform_get_device_id(pdev)->driver_data)
>> +#define FMT_PRT(prt_fn, pdev, fmt, args...)          \
>> +     ({typeof(pdev) (_pdev) = (pdev);                \
>> +     prt_fn(DEV(_pdev), "%s %s: " fmt,               \
>> +     DEV_PDATA(_pdev)->xsp_root_name, __func__, ##args); })
>> +#define xrt_err(pdev, fmt, args...) FMT_PRT(dev_err, pdev, fmt, ##args)
>> +#define xrt_warn(pdev, fmt, args...) FMT_PRT(dev_warn, pdev, fmt, ##args)
>> +#define xrt_info(pdev, fmt, args...) FMT_PRT(dev_info, pdev, fmt, ##args)
>> +#define xrt_dbg(pdev, fmt, args...) FMT_PRT(dev_dbg, pdev, fmt, ##args)
>> +
>> +enum {
>> +     /* Starting cmd for common leaf cmd implemented by all leaves. */
>> +     XRT_XLEAF_COMMON_BASE = 0,
>> +     /* Starting cmd for leaves' specific leaf cmds. */
>> +     XRT_XLEAF_CUSTOM_BASE = 64,
>> +};
>> +
>> +enum xrt_xleaf_common_leaf_cmd {
>> +     XRT_XLEAF_EVENT = XRT_XLEAF_COMMON_BASE,
>> +};
>> +
>> +/*
>> + * If populated by subdev driver, infra will handle the mechanics of
>> + * char device (un)registration.
>> + */
>> +enum xrt_subdev_file_mode {
>> +     /* Infra create cdev, default file name */
>> +     XRT_SUBDEV_FILE_DEFAULT = 0,
>> +     /* Infra create cdev, need to encode inst num in file name */
>> +     XRT_SUBDEV_FILE_MULTI_INST,
>> +     /* No auto creation of cdev by infra, leaf handles it by itself */
>> +     XRT_SUBDEV_FILE_NO_AUTO,
>> +};
>> +
>> +struct xrt_subdev_file_ops {
>> +     const struct file_operations xsf_ops;
>> +     dev_t xsf_dev_t;
>> +     const char *xsf_dev_name;
>> +     enum xrt_subdev_file_mode xsf_mode;
>> +};
>> +
>> +/*
>> + * Subdev driver callbacks populated by subdev driver.
>> + */
>> +struct xrt_subdev_drv_ops {
>> +     /*
>> +      * Per driver instance callback. The pdev points to the instance.
>> +      * If defined, these are called by other leaf drivers.
>> +      * Note that root driver may call into xsd_leaf_call of a group driver.
>> +      */
>> +     int (*xsd_leaf_call)(struct platform_device *pdev, u32 cmd, void *arg);
>> +};
>> +
>> +/*
>> + * Defined and populated by subdev driver, exported as driver_data in
>> + * struct platform_device_id.
>> + */
>> +struct xrt_subdev_drvdata {
>> +     struct xrt_subdev_file_ops xsd_file_ops;
>> +     struct xrt_subdev_drv_ops xsd_dev_ops;
>> +};
>> +
>> +/*
>> + * Partially initialized by the parent driver, then, passed in as subdev driver's
>> + * platform data when creating subdev driver instance by calling platform
>> + * device register API (platform_device_register_data() or the likes).
>> + *
>> + * Once device register API returns, platform driver framework makes a copy of
>> + * this buffer and maintains its life cycle. The content of the buffer is
>> + * completely owned by subdev driver.
>> + *
>> + * Thus, parent driver should be very careful when it touches this buffer
>> + * again once it's handed over to subdev driver. And the data structure
>> + * should not contain pointers pointing to buffers that is managed by
>> + * other or parent drivers since it could have been freed before platform
>> + * data buffer is freed by platform driver framework.
>> + */
>> +struct xrt_subdev_platdata {
>> +     /*
>> +      * Per driver instance callback. The pdev points to the instance.
>> +      * Should always be defined for subdev driver to get service from root.
>> +      */
>> +     xrt_subdev_root_cb_t xsp_root_cb;
>> +     void *xsp_root_cb_arg;
>> +
>> +     /* Something to associate w/ root for msg printing. */
>> +     const char *xsp_root_name;
>> +
>> +     /*
>> +      * Char dev support for this subdev instance.
>> +      * Initialized by subdev driver.
>> +      */
>> +     struct cdev xsp_cdev;
>> +     struct device *xsp_sysdev;
>> +     struct mutex xsp_devnode_lock; /* devnode lock */
>> +     struct completion xsp_devnode_comp;
>> +     int xsp_devnode_ref;
>> +     bool xsp_devnode_online;
>> +     bool xsp_devnode_excl;
>> +
>> +     /*
>> +      * Subdev driver specific init data. The buffer should be embedded
>> +      * in this data structure buffer after dtb, so that it can be freed
>> +      * together with platform data.
>> +      */
>> +     loff_t xsp_priv_off; /* Offset into this platform data buffer. */
>> +     size_t xsp_priv_len;
>> +
>> +     /*
>> +      * Populated by parent driver to describe the device tree for
>> +      * the subdev driver to handle. Should always be last one since it's
>> +      * of variable length.
>> +      */
>> +     bool xsp_dtb_valid;
>> +     char xsp_dtb[0];
>> +};
>> +
>> +/*
>> + * this struct define the endpoints belong to the same subdevice
>> + */
>> +struct xrt_subdev_ep_names {
>> +     const char *ep_name;
>> +     const char *regmap_name;
>> +};
>> +
>> +struct xrt_subdev_endpoints {
>> +     struct xrt_subdev_ep_names *xse_names;
>> +     /* minimum number of endpoints to support the subdevice */
>> +     u32 xse_min_ep;
>> +};
>> +
>> +struct subdev_match_arg {
>> +     enum xrt_subdev_id id;
>> +     int instance;
>> +};
>> +
>> +bool xleaf_has_endpoint(struct platform_device *pdev, const char *endpoint_name);
>> +struct platform_device *xleaf_get_leaf(struct platform_device *pdev,
>> +                                    xrt_subdev_match_t cb, void *arg);
>> +
>> +static inline bool subdev_match(enum xrt_subdev_id id, struct platform_device *pdev, void *arg)
>> +{
>> +     const struct subdev_match_arg *a = (struct subdev_match_arg *)arg;
>> +     int instance = a->instance;
>> +
>> +     if (id != a->id)
>> +             return false;
>> +     if (instance != pdev->id && instance != PLATFORM_DEVID_NONE)
>> +             return false;
>> +     return true;
>> +}
>> +
>> +static inline bool xrt_subdev_match_epname(enum xrt_subdev_id id,
>> +                                        struct platform_device *pdev, void *arg)
>> +{
>> +     return xleaf_has_endpoint(pdev, arg);
>> +}
>> +
>> +static inline struct platform_device *
>> +xleaf_get_leaf_by_id(struct platform_device *pdev,
>> +                  enum xrt_subdev_id id, int instance)
>> +{
>> +     struct subdev_match_arg arg = { id, instance };
>> +
>> +     return xleaf_get_leaf(pdev, subdev_match, &arg);
>> +}
>> +
>> +static inline struct platform_device *
>> +xleaf_get_leaf_by_epname(struct platform_device *pdev, const char *name)
>> +{
>> +     return xleaf_get_leaf(pdev, xrt_subdev_match_epname, (void *)name);
>> +}
>> +
>> +static inline int xleaf_call(struct platform_device *tgt, u32 cmd, void *arg)
>> +{
>> +     struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(tgt);
>> +
>> +     return (*drvdata->xsd_dev_ops.xsd_leaf_call)(tgt, cmd, arg);
>> +}
>> +
>> +int xleaf_broadcast_event(struct platform_device *pdev, enum xrt_events evt, bool async);
>> +int xleaf_create_group(struct platform_device *pdev, char *dtb);
>> +int xleaf_destroy_group(struct platform_device *pdev, int instance);
>> +void xleaf_get_barres(struct platform_device *pdev, struct resource **res, uint bar_idx);
>> +void xleaf_get_root_id(struct platform_device *pdev, unsigned short *vendor, unsigned short *device,
>> +                    unsigned short *subvendor, unsigned short *subdevice);
>> +void xleaf_hot_reset(struct platform_device *pdev);
>> +int xleaf_put_leaf(struct platform_device *pdev, struct platform_device *leaf);
>> +struct device *xleaf_register_hwmon(struct platform_device *pdev, const char *name, void *drvdata,
>> +                                 const struct attribute_group **grps);
>> +void xleaf_unregister_hwmon(struct platform_device *pdev, struct device *hwmon);
>> +int xleaf_wait_for_group_bringup(struct platform_device *pdev);
>> +
>> +/*
>> + * Character device helper APIs for use by leaf drivers
>> + */
>> +static inline bool xleaf_devnode_enabled(struct xrt_subdev_drvdata *drvdata)
>> +{
>> +     return drvdata && drvdata->xsd_file_ops.xsf_ops.open;
>> +}
>> +
>> +int xleaf_devnode_create(struct platform_device *pdev,
>> +                      const char *file_name, const char *inst_name);
>> +int xleaf_devnode_destroy(struct platform_device *pdev);
>> +
>> +struct platform_device *xleaf_devnode_open_excl(struct inode *inode);
>> +struct platform_device *xleaf_devnode_open(struct inode *inode);
>> +void xleaf_devnode_close(struct inode *inode);
>> +
>> +/* Helpers. */
>> +int xleaf_register_driver(enum xrt_subdev_id id, struct platform_driver *drv,
>> +                       struct xrt_subdev_endpoints *eps);
>> +void xleaf_unregister_driver(enum xrt_subdev_id id);
>> +
>> +/* Module's init/fini routines for leaf driver in xrt-lib module */
>> +#define XRT_LEAF_INIT_FINI_FUNC(_id, name)                           \
>> +void name##_leaf_init_fini(bool init)                                        \
>> +{                                                                    \
>> +     typeof(_id) id = _id;                                           \
>> +     if (init) {                                                     \
>> +             xleaf_register_driver(id,                               \
>> +                                   &xrt_##name##_driver,             \
>> +                                   xrt_##name##_endpoints);          \
>> +     } else {                                                        \
>> +             xleaf_unregister_driver(id);                            \
>> +     }                                                               \
>> +}
>> +
>> +void group_leaf_init_fini(bool init);
>> +void vsec_leaf_init_fini(bool init);
>> +void devctl_leaf_init_fini(bool init);
>> +void axigate_leaf_init_fini(bool init);
>> +void icap_leaf_init_fini(bool init);
>> +void calib_leaf_init_fini(bool init);
>> +void clkfreq_leaf_init_fini(bool init);
>> +void clock_leaf_init_fini(bool init);
>> +void ucs_leaf_init_fini(bool init);
>> +
>> +#endif       /* _XRT_LEAF_H_ */
>> diff --git a/drivers/fpga/xrt/lib/lib-drv.c b/drivers/fpga/xrt/lib/lib-drv.c
>> new file mode 100644
>> index 000000000000..64bb8710be66
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/lib-drv.c
>> @@ -0,0 +1,277 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/vmalloc.h>
>> +#include "xleaf.h"
>> +#include "xroot.h"
>> +#include "lib-drv.h"
>> +
>> +#define XRT_IPLIB_MODULE_NAME                "xrt-lib"
>> +#define XRT_IPLIB_MODULE_VERSION     "4.0.0"
>> +#define XRT_MAX_DEVICE_NODES         128
>> +#define XRT_DRVNAME(drv)             ((drv)->driver.name)
>> +
>> +/*
>> + * Subdev driver is known by it's ID to others. We map the ID to it's
> ok
>> + * struct platform_driver, which contains it's binding name and driver/file ops.
>> + * We also map it to the endpoint name in DTB as well, if it's different
>> + * than the driver's binding name.
>> + */
>> +struct xrt_drv_map {
>> +     struct list_head list;
>> +     enum xrt_subdev_id id;
>> +     struct platform_driver *drv;
>> +     struct xrt_subdev_endpoints *eps;
>> +     struct ida ida; /* manage driver instance and char dev minor */
>> +};
>> +
>> +static DEFINE_MUTEX(xrt_lib_lock); /* global lock protecting xrt_drv_maps list */
>> +static LIST_HEAD(xrt_drv_maps);
>> +struct class *xrt_class;
>> +
>> +static inline struct xrt_subdev_drvdata *
>> +xrt_drv_map2drvdata(struct xrt_drv_map *map)
>> +{
>> +     return (struct xrt_subdev_drvdata *)map->drv->id_table[0].driver_data;
>> +}
>> +
>> +static struct xrt_drv_map *
>> +__xrt_drv_find_map_by_id(enum xrt_subdev_id id)
> ok
>> +{
>> +     struct xrt_drv_map *tmap;
>> +
>> +     list_for_each_entry(tmap, &xrt_drv_maps, list) {
>> +             if (tmap->id == id)
>> +                     return tmap;
>> +     }
>> +     return NULL;
>> +}
>> +
>> +static struct xrt_drv_map *
>> +xrt_drv_find_map_by_id(enum xrt_subdev_id id)
>> +{
>> +     struct xrt_drv_map *map;
>> +
>> +     mutex_lock(&xrt_lib_lock);
>> +     map = __xrt_drv_find_map_by_id(id);
>> +     mutex_unlock(&xrt_lib_lock);
>> +     /*
>> +      * map should remain valid even after the lock is dropped since a registered
> ok
>> +      * driver should only be unregistered when driver module is being unloaded,
>> +      * which means that the driver should not be used by then.
>> +      */
>> +     return map;
>> +}
>> +
>> +static int xrt_drv_register_driver(struct xrt_drv_map *map)
>> +{
>> +     struct xrt_subdev_drvdata *drvdata;
>> +     int rc = 0;
>> +     const char *drvname = XRT_DRVNAME(map->drv);
>> +
>> +     rc = platform_driver_register(map->drv);
>> +     if (rc) {
>> +             pr_err("register %s platform driver failed\n", drvname);
>> +             return rc;
>> +     }
>> +
>> +     drvdata = xrt_drv_map2drvdata(map);
>> +     if (drvdata) {
>> +             /* Initialize dev_t for char dev node. */
>> +             if (xleaf_devnode_enabled(drvdata)) {
>> +                     rc = alloc_chrdev_region(&drvdata->xsd_file_ops.xsf_dev_t, 0,
>> +                                              XRT_MAX_DEVICE_NODES, drvname);
>> +                     if (rc) {
>> +                             platform_driver_unregister(map->drv);
>> +                             pr_err("failed to alloc dev minor for %s: %d\n", drvname, rc);
>> +                             return rc;
>> +                     }
>> +             } else {
>> +                     drvdata->xsd_file_ops.xsf_dev_t = (dev_t)-1;
>> +             }
>> +     }
>> +
>> +     ida_init(&map->ida);
>> +
>> +     pr_info("%s registered successfully\n", drvname);
>> +
>> +     return 0;
>> +}
>> +
>> +static void xrt_drv_unregister_driver(struct xrt_drv_map *map)
>> +{
>> +     const char *drvname = XRT_DRVNAME(map->drv);
>> +     struct xrt_subdev_drvdata *drvdata;
>> +
>> +     ida_destroy(&map->ida);
>> +
>> +     drvdata = xrt_drv_map2drvdata(map);
>> +     if (drvdata && drvdata->xsd_file_ops.xsf_dev_t != (dev_t)-1) {
>> +             unregister_chrdev_region(drvdata->xsd_file_ops.xsf_dev_t,
>> +                                      XRT_MAX_DEVICE_NODES);
>> +     }
>> +
>> +     platform_driver_unregister(map->drv);
>> +
>> +     pr_info("%s unregistered successfully\n", drvname);
>> +}
>> +
>> +int xleaf_register_driver(enum xrt_subdev_id id,
>> +                       struct platform_driver *drv,
>> +                       struct xrt_subdev_endpoints *eps)
>> +{
>> +     struct xrt_drv_map *map;
>> +     int rc;
>> +
>> +     mutex_lock(&xrt_lib_lock);
>> +
>> +     map = __xrt_drv_find_map_by_id(id);
>> +     if (map) {
>> +             mutex_unlock(&xrt_lib_lock);
>> +             pr_err("Id %d already has a registered driver, 0x%p\n",
>> +                    id, map->drv);
>> +             return -EEXIST;
>> +     }
>> +
>> +     map = kzalloc(sizeof(*map), GFP_KERNEL);
> ok
>> +     if (!map) {
>> +             mutex_unlock(&xrt_lib_lock);
>> +             return -ENOMEM;
>> +     }
>> +     map->id = id;
>> +     map->drv = drv;
>> +     map->eps = eps;
>> +
>> +     rc = xrt_drv_register_driver(map);
>> +     if (rc) {
> ok
>> +             kfree(map);
>> +             mutex_unlock(&xrt_lib_lock);
>> +             return rc;
>> +     }
>> +
>> +     list_add(&map->list, &xrt_drv_maps);
>> +
>> +     mutex_unlock(&xrt_lib_lock);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_register_driver);
>> +
>> +void xleaf_unregister_driver(enum xrt_subdev_id id)
>> +{
>> +     struct xrt_drv_map *map;
>> +
>> +     mutex_lock(&xrt_lib_lock);
>> +
>> +     map = __xrt_drv_find_map_by_id(id);
>> +     if (!map) {
>> +             mutex_unlock(&xrt_lib_lock);
>> +             pr_err("Id %d has no registered driver\n", id);
>> +             return;
>> +     }
>> +
>> +     list_del(&map->list);
>> +
>> +     mutex_unlock(&xrt_lib_lock);
>> +
>> +     xrt_drv_unregister_driver(map);
>> +     kfree(map);
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_unregister_driver);
>> +
>> +const char *xrt_drv_name(enum xrt_subdev_id id)
>> +{
>> +     struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
>> +
>> +     if (map)
>> +             return XRT_DRVNAME(map->drv);
>> +     return NULL;
>> +}
>> +
>> +int xrt_drv_get_instance(enum xrt_subdev_id id)
>> +{
>> +     struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
>> +
>> +     return ida_alloc_range(&map->ida, 0, XRT_MAX_DEVICE_NODES, GFP_KERNEL);
>> +}
>> +
>> +void xrt_drv_put_instance(enum xrt_subdev_id id, int instance)
>> +{
>> +     struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
>> +
>> +     ida_free(&map->ida, instance);
>> +}
>> +
>> +struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id)
>> +{
>> +     struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
>> +     struct xrt_subdev_endpoints *eps;
>> +
>> +     eps = map ? map->eps : NULL;
>> +     return eps;
>> +}
>> +
>> +/* Leaf driver's module init/fini callbacks. */
> add comment to effect that dynamically adding drivers/ID's are not supported.


Will do.


>> +static void (*leaf_init_fini_cbs[])(bool) = {
>> +     group_leaf_init_fini,
>> +     vsec_leaf_init_fini,
>> +     devctl_leaf_init_fini,
>> +     axigate_leaf_init_fini,
>> +     icap_leaf_init_fini,
>> +     calib_leaf_init_fini,
>> +     clkfreq_leaf_init_fini,
>> +     clock_leaf_init_fini,
>> +     ucs_leaf_init_fini,
>> +};
>> +
>> +static __init int xrt_lib_init(void)
>> +{
>> +     int i;
>> +
>> +     xrt_class = class_create(THIS_MODULE, XRT_IPLIB_MODULE_NAME);
>> +     if (IS_ERR(xrt_class))
>> +             return PTR_ERR(xrt_class);
>> +
>> +     for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
>> +             leaf_init_fini_cbs[i](true);
>> +     return 0;
>> +}
>> +
>> +static __exit void xrt_lib_fini(void)
>> +{
>> +     struct xrt_drv_map *map;
>> +     int i;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
>> +             leaf_init_fini_cbs[i](false);
>> +
>> +     mutex_lock(&xrt_lib_lock);
>> +
>> +     while (!list_empty(&xrt_drv_maps)) {
>> +             map = list_first_entry_or_null(&xrt_drv_maps, struct xrt_drv_map, list);
>> +             pr_err("Unloading module with %s still registered\n", XRT_DRVNAME(map->drv));
>> +             list_del(&map->list);
>> +             mutex_unlock(&xrt_lib_lock);
>> +             xrt_drv_unregister_driver(map);
>> +             kfree(map);
>> +             mutex_lock(&xrt_lib_lock);
>> +     }
>> +
>> +     mutex_unlock(&xrt_lib_lock);
>> +
>> +     class_destroy(xrt_class);
>> +}
>> +
>> +module_init(xrt_lib_init);
>> +module_exit(xrt_lib_fini);
>> +
>> +MODULE_VERSION(XRT_IPLIB_MODULE_VERSION);
>> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
>> +MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/fpga/xrt/lib/lib-drv.h b/drivers/fpga/xrt/lib/lib-drv.h
>> new file mode 100644
>> index 000000000000..a94c58149cb4
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/lib-drv.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#ifndef _LIB_DRV_H_
>> +#define _LIB_DRV_H_
>> +
>> +const char *xrt_drv_name(enum xrt_subdev_id id);
> bisectablity may be /is still an issue.


See my comments at the beginning of this reply, please. As you pointed 
out, there should be no issue since the make file is integrated as the 
very last patch.

Thanks,

Max

>
> Tom
>
>> +int xrt_drv_get_instance(enum xrt_subdev_id id);
>> +void xrt_drv_put_instance(enum xrt_subdev_id id, int instance);
>> +struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id);
>> +
>> +#endif       /* _LIB_DRV_H_ */
