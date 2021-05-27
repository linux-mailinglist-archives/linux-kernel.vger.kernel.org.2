Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96082392BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhE0Kc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:32:26 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:23138
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236129AbhE0KcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:32:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ynth6EgSd5yHhOdTGDDqbrV2WnioR2vqocX9NSHgzt99KPngZ8nnSHtoiwLIf/tdtg5Aktf3hFeR2FV9lYWmuq1UYeFS3nuHRgjwKE+3Kqq8NB081WsthKmeYUJvBsaYikDZ9rTxY1LbCRPAphx7Fqq9mjDOxHTKuaAGdHwXJVMLfW4FMJLl0mGV+EcZs7uVLD78KEGURdJ/CGXNb6ditW46TIHJzYWXfqeya5gSnkW11vNabDok0B20bsLTtpkzNT6oCLnWxbFfRk/23qa7xSjRZe+xir5RYfRlZlXQ8sP1rKEOJLGKaUjdljbqpewyKgV9j4F0IyVgwCXa3Yv12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZh6FYjfIzxwXv/spYeekCKMRJs72vFRUKIpIpN5jr8=;
 b=IcN6pEIrh1wqs70VZK0kD89vYpqqynycKiWyAyPqb3FAAGlcizVZMIAMi8Ak0+HyF8EimRtya6bJjRzO5tVdNKpvWtATOvL8TL6hMBmKGDavMCiKqRZT09pIGX0JSXFLrKgMDlVxc9o8667ayZpFmBAcnZyW4O4pjKAvdI3p6/pB+uR5VvtWnu6DVuyRMB3ZFJK3ZbJ90Ciyslyf3nbls/1KiwOO/Gd7zxrODXO+IUyMZ7zopJf1G+UwdKPCv86msztiPSYx+ORnWgkOB1rHHNXhlKOt5eqTYE2TGquHi1FBdTuXPvsmQSSSWG1nR+fOUOXl11redGcrK2aNCAlmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZh6FYjfIzxwXv/spYeekCKMRJs72vFRUKIpIpN5jr8=;
 b=I2uzaEltyfLiWwt7CuVgzvjq9BOfcQcotFWv0tcUv/3uni+TSpCwxmKA9fmRsmu8QwHwsBa5l0/RmctE1OwQFiK2NTvyZVOIC+GknEVmgJWVH5QEjwf+iHvUg5Bk1K+5eakp2bxiLmbu+WALrgoLw9yJXs63QAuYHQBNz13wyHWzi1PBbhTjnGxMYo8t/TTBrHPQqAeLyfENpROBJ7E6pHRlfriQOz64vg3Qq5a8/LKMWxbm6uMG4qhuR0xpYM6YLbs+YbrNvA5qe4/8EWRv0cmTGqYokKfl2q7YbCw/LkRdzfZqQb/x6OfLhdDpPh+Iec7ugWjol8Mzc7LfCi4ylA==
Received: from DS7PR03CA0192.namprd03.prod.outlook.com (2603:10b6:5:3b6::17)
 by BN8PR12MB3105.namprd12.prod.outlook.com (2603:10b6:408:67::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Thu, 27 May
 2021 10:30:47 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::80) by DS7PR03CA0192.outlook.office365.com
 (2603:10b6:5:3b6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 10:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 10:30:46 +0000
Received: from [172.27.15.200] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 10:30:43 +0000
Subject: Re: [Linuxarm] Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     liulongfang <liulongfang@huawei.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Oren Duer <oren@nvidia.com>
References: <20210420160457.6b91850a@x1.home.shazbot.org>
 <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
 <20210421121224.62382e5d@redhat.com>
 <6ea89655-31c5-233b-ca2a-fcc166b5597c@huawei.com>
 <20210512121053.GT1002214@nvidia.com>
 <3eaa3114-81b6-1bd9-c7e6-cb1541389b58@huawei.com>
 <20210513134422.GD1002214@nvidia.com>
 <e3db0c328da6411ea2ae07595ed5f6c3@huawei.com>
 <20210513110349.68e3d59d@redhat.com>
 <1035a9a9b03b43dd9f859136ed84a7f8@huawei.com>
 <20210513182413.GO1002214@nvidia.com>
 <0301a502747748968393aa3e3b0a849d@huawei.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <0ed0263f-6aa7-0bfd-dc49-90308bcb512f@nvidia.com>
Date:   Thu, 27 May 2021 13:30:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0301a502747748968393aa3e3b0a849d@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7019c823-479b-4118-bafa-08d920fa7d18
X-MS-TrafficTypeDiagnostic: BN8PR12MB3105:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3105CC00307205846FC304E6DE239@BN8PR12MB3105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lxR3Jn07zl9d3d2aY/wazidDH/yR+2F6CF3wuyT7/PyPrXV6sbIRTpzN3Sc+yCg8BneWvJVxwZtrPM4K4/OEG0JNW5KPiCV8Iu8F7e7j4w+3fcJ3lyp73ESZpXkHsaAL+FkADjZqIAB1qwMnYGvaV8CJoBLdlgVESL+WrJ0wQmCwv3Oanea2Ha1EzEBnMnQiP2wwtED3ZN/Au6W4NFrdPLSZ9ecXGaEu2Chhz9dEF+TkViX0eGt4IpsF7vLWH7+1ipAN/mwveKVc+wsCOwMpWYDGUIISxx6uOfzbrG2M3q7cBx8fitO8Husi+Rz/8HCEBi2XDu+xkAqPL6FJ75jPsOE//rT55Xnp6QDjY5CRN2e2RHVqqLAZ4P5D9btuUxFpZTRQyzfb7qoekhZd0MAe2Ukww9kel6kyMmG33ZagfwOMi9wBooxLnDuhuvbVxzXnzhn5CsViIFhXKt9mo976BsGQ+gf33jmABcEIKpzpVkul1/qXN5qU0PoKaf9wI244lIagIubOx515yzbWlfYi+Y6nZZuYRdwtl3xUYC757TLSacyKr2qq13NW5aPbf/xdoAOrAwjnC3wQ1bjX8tcEObWFOHR1gM8ZHnB37L5MfMxI8uHoEKhdGR+aLCD8MJ7l5N2+ly9oNfy+/G3+BIMiHx5eAbBkz2+7QlgkOEXRvg0WkvV1LKcRUFHsR7a2pwObX2rpg9vxUtjaMd5GG/+JlqN0Dkj5YNcT2Wke2FxGOVGqZE9yGYodZgoHiaOl/Q88oPxrU7TyWwot26h2+XuD89/Fn/t3Fso74VrPSxhlPOiB50TtYuVg7HtiPqCMwxr
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(2616005)(70206006)(107886003)(426003)(70586007)(82310400003)(186003)(83380400001)(36906005)(8676002)(47076005)(86362001)(36756003)(16526019)(36860700001)(4326008)(82740400003)(316002)(53546011)(336012)(478600001)(7636003)(31686004)(8936002)(54906003)(16576012)(5660300002)(26005)(2906002)(356005)(31696002)(966005)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 10:30:46.1162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7019c823-479b-4118-bafa-08d920fa7d18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/27/2021 1:11 PM, Shameerali Kolothum Thodi wrote:
> [+]
>
> Hi,
>
>> -----Original Message-----
>> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
>> Sent: 13 May 2021 19:24
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>; liulongfang
>> <liulongfang@huawei.com>; cohuck@redhat.com;
>> linux-kernel@vger.kernel.org; linuxarm@openeuler.org
>> Subject: Re: [Linuxarm] Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to
>> vfio
>>
>> On Thu, May 13, 2021 at 05:52:56PM +0000, Shameerali Kolothum Thodi
>> wrote:
>>
>>> Since the devices we are concerned here are all integrated endpoints and if
>> the
>>> above quirk is an acceptable one, then we can use the uAPI as done in this
>>> series without overly complicating things here.
>> IMHO such a quirk in the core code should not be done. You need to
>> override this in your own driver like Max was showing.
>>
>> I think we are very close to having worked out a great solution to the
>> lingering questions on Max's last RFC, hopefully we can post an
>> updated version soon
> We have now integrated this HiSilicon ACC live migration driver into the
> proposed[0] vfio-pci-core subsystem framework. Basically now have
> a new vendor extension driver based on this framework. It indeed makes it
> easy to do the registration to vfio core and overriding of functions if required.
> Performed some basic sanity tests with the prototype and it seems to be
> working.

Great news.


>
> Also, we now managed to get rid of any access to Guest VF dev MMIO space
> during the (VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RUNNING)
> state. However we still need to access the Guest VF MMIO space during
> few other device states eg; VFIO_DEVICE_STATE_SAVING, VFIO_DEVICE_STATE_STOP
> etc. These accesses are to save and restore device register states. As per our
> analysis the Guest vCPUs are in stopped state at these device states. So I
> hope we don't have any security related holes with these accesses.

We can start talking about more API's that are missing.

>
> Please let us know if we miss something or anything else to be taken care of with
> this approach.
>
> We are planning to send out a revised RFC soon, and if there is a plan to
> post an updated one to Max's series as mentioned above, will base
> it on that one. Please let us know.

I'll send a new version of the series soon with many improvements that 
we'll taken from previous discussion.

I'll add you as CC.


>
> Thanks,
> Shameer
> [0] https://lore.kernel.org/lkml/20210310123127.GT2356281@nvidia.com/T/
>
>
