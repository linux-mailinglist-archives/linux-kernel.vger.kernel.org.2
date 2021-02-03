Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD9C30D3A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhBCHCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 02:02:10 -0500
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76]:34016
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231636AbhBCHCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 02:02:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoUD/4l8eDePt0lxreDkOo2jEpd9v9Jqa3PqzH+nOtJf+yqTNX0XFTtb+OYu9o3bG8vp5xTggZiiOyhB7UbGUpBue3OX5B1CN5E6Np4AOvz/PBc7Auyd6L5KxMlPww+NTqg9SccGwtbNn09swEyd3L8Hz61cUD8VdLGHjRMUuysm54sKtJHivs8S3UEacKypA82vh01J48a1SilrMvvlJ5TiAV7ZHJlYTnoo/M9oKwuUyFL1/EdapWZKQYOynkmi3JfSEnnteDEILTa/8WYA7Z8mIWqBaiIYFxPdF/l83fnug4XOkajm1rS+P+yxUUy90IpL8+WciQXWvnT7vydU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZnFT1GxFJRduPjf/Z+vVefHSA2/p5Bf1+WnOxhTKk4=;
 b=XyZmulEzerMRMJPu24C2LgIzgKLXbFhaV/9yUyelG8+lwUx8/bAVjJCujdRubfWzC9q0QGaMn9GzUBZPTpyvx3c3KP8UVk0wpx7lULDrupft1yhGjFmwKokCYrkrhdhT1e76li3BrOGI8RUZSSzJzvYBzx8IRZRPuJpfjNnKDSb+ZRotb8ywJqMx7TQmUCgvgfiqPh3jkWuw9SzdKE5y6HVk25Hobu1xF4QI1GsDZIDb7O+2FOOZTOKC3MML57MWsq5N/tuJKAGJm2LMz0VAZQVX6BVWJEO+oCmqfJsUqBY/YQRauXnMrNufHdUIO3cl6LBiyfTAbiVlFfs2xkyfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZnFT1GxFJRduPjf/Z+vVefHSA2/p5Bf1+WnOxhTKk4=;
 b=f+Qg40oc4ewArdSNkboimj2iqWtf+rsGiltsrK8yvTR/DUFipsPbok5XCIWA3/Y+9IEVbQ32nGW7+K/eFP0HAOfNY7MaByi3cngqSvas6imfR185W58cUwClcQMqhmqZaWDO1xw+loSraBV5/dmtWwHG2cgOFaI/wHgpCLasAMo=
Received: from CY1PR03CA0024.namprd03.prod.outlook.com (2603:10b6:600::34) by
 SN6PR02MB4224.namprd02.prod.outlook.com (2603:10b6:805:33::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19; Wed, 3 Feb 2021 07:01:16 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:600:0:cafe::38) by CY1PR03CA0024.outlook.office365.com
 (2603:10b6:600::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Wed, 3 Feb 2021 07:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 3 Feb 2021 07:01:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 2 Feb 2021 23:00:53 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 2 Feb 2021 23:00:53 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 andre.przywara@arm.com,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 robh+dt@kernel.org
Received: from [172.30.17.109] (port=49736)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l7C9k-0003fA-7s; Tue, 02 Feb 2021 23:00:52 -0800
Subject: Re: [PATCH] ARM: dts: zynq: Add address-cells property to interrupt
 controllers
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michal Simek" <monstr@monstr.eu>, git <git@xilinx.com>,
        Andre Przywara <andre.przywara@arm.com>,
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com>
 <CAL_JsqJnu1M6ut8g_36ve-OG22jFsySHbmVHOgtDRhc-s37rpQ@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <210b0e5a-767b-c285-62e2-23de19bd3cf1@xilinx.com>
Date:   Wed, 3 Feb 2021 08:00:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJnu1M6ut8g_36ve-OG22jFsySHbmVHOgtDRhc-s37rpQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5e2369e-1bcb-46f1-66ea-08d8c811806d
X-MS-TrafficTypeDiagnostic: SN6PR02MB4224:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB4224E76F1F608AC01F677F04C6B49@SN6PR02MB4224.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlO222YWIsvU/NZH9gnc/Nl05ED4yZomMvOxw4T/2UF4/0BhpQ/v8QNzoWOTKYSsQLE59gIlmW9RP29Y05Mub6u7FXqgogWtKZhGS4I0arIW+c3H5sHTj4gG85ZnxNgpSJ/4xGvgYpOOof+q9HIOk9rEoyc8Lmp8hoplqET0vV5Yaw43Onalnfk+gyjLjWRskwTWQxEIm/SIT36lKoCeng7uzA3yOWN1MS8KB7D2M9q9UqqGcZ/hk2Rg8CFolG+RWh0jZHtBjOsMQoXXU/E8cr2shDpYnQ/yQH5TPw+qFJKOl+xbDqvq4vy2Ls7vgjr5FohABuMrUxJALLu+glrrjKOm+17eRK9kbZZCBf+NPwNDmFFEkCWuYMTaPwJOXtSgmsKRVkAts+V+UVRvoa/Am95BP+0MciM3djqa7fGS59w5cZrc0GvJO3q649L2syAJGfahGPHWDLUCmMYlYtgYzHGIf3uD3HhTySH6d2w1wQBkYixYx8PKhSPJ7SYmqWUEclVr3VWkOFoR3gwNdIaDqhUly5SezZi4WDGxYiV6/YYxe0aql0f8cCsJFQyN/6gv4FmCMiAz6cSnMarHF7crRxs7Zzx1nJzlo1XICA+zptJ1dzNRurhdLxZ9XlXeWzQ7uRMKrIxQJm2vfjcc4yy+fAsSe4WW0gKzKU8UVbqJ8AjvspfpYZNW+fWdeUiONYK9iGcU/jdlSmvJ5hGQ4Hxg/A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(46966006)(83380400001)(8936002)(426003)(4744005)(336012)(8676002)(7636003)(31696002)(2616005)(5660300002)(47076005)(9786002)(44832011)(356005)(82740400003)(82310400003)(36860700001)(110136005)(53546011)(316002)(36906005)(36756003)(70586007)(70206006)(478600001)(31686004)(4326008)(186003)(2906002)(54906003)(26005)(6666004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 07:01:16.5998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e2369e-1bcb-46f1-66ea-08d8c811806d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4224
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/21 6:41 PM, Rob Herring wrote:
> On Mon, Feb 1, 2021 at 8:27 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> The commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version
>> v1.6.0-11-g9d7888cbf19c") updated dtc version which also contained DTC
>> commit
>> "81e0919a3e21 checks: Add interrupt provider test"
>> where reasons for this checking are mentioned as
>> "A missing #address-cells property is less critical, but creates
>> ambiguities when used in interrupt-map properties, so warn about this as
>> well now."
>>
>> Add address-cells property to gic and gpio nodes to get rid of this warning.
>> The similar change has been done for ZynqMP too.
> 
> FYI, we're going to make this check dependent on having an
> interrupt-map property. So adding these isn't necessary.

Good to know. Is there going to be report if interrupt-map doesn't
exist? Which can end up with reverting these changes?

Thanks,
Michal
