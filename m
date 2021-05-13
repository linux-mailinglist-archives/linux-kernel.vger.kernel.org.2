Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAA837FD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhEMSgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:36:06 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:64225
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230125AbhEMSgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:36:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFfvrqAnrFtoiVCrzMvJBVUS6QxjMut158VHTb+X8TfWxYx+Ods9deicL3bxsJjXtZ09r/5KhB1ycpX1TscTE/Q4Sdl0fhAieNW260akBn6e82h5eooVfH9Sm54inN5Pki8f3BRZLMMc9119jOD4IuexHoUG9kSDHrPY/HdBvlqNXeKcDNEc9xaZMPrTj6WDO13PClvg9/gVjAdAQlDyfjtG2TmtMk9dBu04CeA4LIDuI4UWSFtZDtsN6lVhdM+yvRWrTdnBzI0Cq50V6n5UNpRgHsol01n7B7sBSBds4l72o+xfkiVBzV+Hm0RxjWKVqOf/n/AkhulMnLfcqiGNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOeoDp5dCxZHSmX3YZM2oxWqIfMqFm54v+iigBTR0Do=;
 b=QcNgYKb+imLl/FYLvQGUotZikvH6AtQaSHmCCKpoDQb3YzqhnanfvtLz8a5Aag/6L0Wvpj7OuZb1AGRFCY1LfBTGHQ6riPcVmKh40XCdAQ2imANGjsdmKi/FdPSo4nK82XvcndANifUVXW/W0r+FvCwSSgotBneu5zFt+nNQ9Bune1xxcM+Ucy6C0ONIWgDWPA9E1orC0p9MWh7S2jra9FJXm6sXDx0wOPg8ZSpDO5o2Uq649TCjWXmtsMbDkNGdlYVWxLY7ZcPa29IXi55845E9Byg6wdHGS3AP+pwWLWhubAN0YK+vekhkto+bxip4wKDjPSCgnuFlFk/lhs2UAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOeoDp5dCxZHSmX3YZM2oxWqIfMqFm54v+iigBTR0Do=;
 b=RePcHtp+HkyNpoQBXRhXggFNGb/fCYdag1qjNLAFqyBsSOzk+JhXgAS7YGmII1ZBc1888Yw4rTyumdHrJ5RxcBfxNoolpjwblXMRDD/xfmS5HyH9opPUVA5S75PMGATesZzKcB9pYTNQQM3XueVcnCh3TfpZZ+NnosQLE9j3LcnnL+BOVEPk1DL/GD8rFtwpb/H10R5yi6xD3p2c4daoo9jr4J1ZJLl/krfWX+DPmgExaPPwrDuf5FIvppCa3jggSn3xpyvL5YTrBVAeA0vFSFol7WGOx8aC1ugJDgnfNve9KHIpOH/HNLRJal82nRzd6sawBXc/xReRgLnuEvYPMg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 18:34:54 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 18:34:54 +0000
Date:   Thu, 13 May 2021 15:34:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        liulongfang <liulongfang@huawei.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Message-ID: <20210513183452.GP1002214@nvidia.com>
References: <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
 <20210421121224.62382e5d@redhat.com>
 <6ea89655-31c5-233b-ca2a-fcc166b5597c@huawei.com>
 <20210512121053.GT1002214@nvidia.com>
 <3eaa3114-81b6-1bd9-c7e6-cb1541389b58@huawei.com>
 <20210513134422.GD1002214@nvidia.com>
 <e3db0c328da6411ea2ae07595ed5f6c3@huawei.com>
 <20210513110349.68e3d59d@redhat.com>
 <1035a9a9b03b43dd9f859136ed84a7f8@huawei.com>
 <20210513122232.589d24d8@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513122232.589d24d8@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:207:17::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR1501CA0017.namprd15.prod.outlook.com (2603:10b6:207:17::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 18:34:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lhGAe-0079Jw-O4; Thu, 13 May 2021 15:34:52 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b0c1e23-dac1-41e4-e43f-08d9163dcd11
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1754E287700C6B057A4FAFBCC2519@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYCwwnywBeSSMXxkwD4PgbYKDfavS5bv/bY2vmyVnoYIi3XjXU+Nd3PkPFh/wiO4nQARiOwzZS8E832z9RpIppqTneR4vjAzoUeFbUUh2S4NgRuJACRdE6eyVrC11rs0E00yy6vmcuv3EtYwVzlt6shhPBLeapCOlSqMIcwjJFZuuWxZVWUSJckDZsDWrY8mHenC686aXH4N/WvN5xS6bLonUhDraD/V+P9LA/9ecl0xmOUFByoIfp79zTmbZ5vY4YPzbLiBygJ+Vf3hd7MwFe5IFlVFo6YvT2iFRNgEGWBKc+7ml3O/CGXnZh6jSqp8dHlSXPm6l7pT2HldsFxix+uSIC/DikHNiaj1Haa70Dambr6CTcArgWBecjSoOm1aOWU2qZ67ueYoz8FH6wfFj+slHFIwL/M3mfqi4P2cQ+iANPkVlJiU/6McEMLcqMz3KNdLgqQ7F5YrYtvS0y1ssI7YSqksvf18UrsMzFbglr0lxEfnVz9Q0QC4TDzN+4CpqOZ4R6gHXpSyPZq3obxEvgPge8ATRmTGNZKp4lc19x2BQW8YOS3MROCmcb+RFad8F+qWQUTOVg+KJEdy71kBqXMF10vLyFDIhbkA3NowMw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(2616005)(86362001)(4326008)(26005)(1076003)(66476007)(9746002)(9786002)(426003)(66946007)(5660300002)(2906002)(33656002)(36756003)(186003)(8936002)(8676002)(54906003)(478600001)(38100700002)(4744005)(316002)(66556008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eqcSAQuECtEbaLSAGL2YPHB1sS7ZBHvIokfNZEbOVVxJfH+06nztxYdLZIMJ?=
 =?us-ascii?Q?T0+muI5m81MzCGNQ5xanpIUOWtUOyFeuuH+wXCADGcqAG8g6eDCEhlZbSyY1?=
 =?us-ascii?Q?7qdGKYtKeXI9XoN3KcmlxvWvsJg28F1/5G0TE+M9zuxJgh6lWJuBojLfiua6?=
 =?us-ascii?Q?QfbgX/3VKr4jWspzydjq7YBq4rn1f7U/Vhx8WVTId2bhIEIkZf05c/SNBm6D?=
 =?us-ascii?Q?QrqO+i3b0FihlAp4gCrbAOWlfBLgWRAXG+UbwO/AfktwSGg7jTmJumxkIPFT?=
 =?us-ascii?Q?+RZ5wyH5njmzOKYG+5MSMXoVP+swxSg7YUDJPFK/WQJKNvx5oZhgoUDmip3c?=
 =?us-ascii?Q?MT9OUr6oEiXVmvRJkpAM+g9NeLPU/O23/tjrH8LSWGj3ZAUQxjsOwEWnYUqW?=
 =?us-ascii?Q?J94oZLMiQ2R5xTM+fUpich04afta3Ni0Va/wRDN1wZmnYqYT/D1ToSxQoaoP?=
 =?us-ascii?Q?U/eBvvd4fkkja2fHQO1xxYWeXsheguaDr+7Wo8RINHPh9e040MItwxwoqwIP?=
 =?us-ascii?Q?N60A8wWghsFgzKcU8Xdy7huXM8NF/APyOyEOfFWJhdlWC5cnBMNyxmVlTQ1c?=
 =?us-ascii?Q?yGQywVa03Q9D4Nxp7Px8FEgxDwW1cuF5xc7xaMYx0+HKUN+MJfj4lWr9uj/2?=
 =?us-ascii?Q?4DXCtA/jl70QnRFJRaO0dCuyRhoHgkMcWwdQLjhmwqjWGZqRAJAinspPC87H?=
 =?us-ascii?Q?KNXAndhR2Jskz18nlQ6YbMDCCkDU9UivOjXa3wXMc20ICWGYi7mjuJO8abGu?=
 =?us-ascii?Q?qgGjp9E/H1zqVJoCzjKGHQEV3cqcL3qaMcIFz7LgppJ5xwFZXM2USOJXFCAf?=
 =?us-ascii?Q?qM2rjVgvJX1q5hFlC/S9FeXEzfCSHWv398liODHqH8Grx9WmaVIKVtHF5j5/?=
 =?us-ascii?Q?FzkVMxq6Oe+1WD6C3eKCcduHtRAEgMcJHn0RIb48NcHHsE/TQ6qBq2KxI7wm?=
 =?us-ascii?Q?Baw0c6/vbQ+n6UBW268xmNGFvUsAP6pad2M3LYYuTnAZv27Gg8Kx5K7kCNk5?=
 =?us-ascii?Q?Kd4bGhDTMWV/N7DkmzT0ozG3Zo0V+dl3j9d7bKCBV2lUn6Wj2cj5A44egQvD?=
 =?us-ascii?Q?ZXNwzdamtyJyeJaRw5r5yD3ift6B5DyN8lk5hNk+Pf1BXc8vZnggnaOCN6fN?=
 =?us-ascii?Q?QnCcoAvTngf1YtIOD/scrXhFVkxljXSVWuxIut38RiYs4oyKGThe7CO1CT2k?=
 =?us-ascii?Q?EjU1jcZkLNW/X5Jfg2gxpyCA/cZUCp3Fl0srDXJ68Gfw+9PRkeXoAtBNNWUW?=
 =?us-ascii?Q?fo2cwaag3fQpHd3pjXVaGkYOgAULBvBX+DgRRLiq4hEscEUsYRBwq5CfmQ7C?=
 =?us-ascii?Q?uR4CkvkRmvUGfHJHASuvppfX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0c1e23-dac1-41e4-e43f-08d9163dcd11
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 18:34:54.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nxihz2Xta9aIFciBR4hzrjHJTlv7e5pXSo1CxSbXNtLRJNzqLYlaTIwP2/s1Pakw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:22:32PM -0600, Alex Williamson wrote:

> If you expect this device to appear only as an integrated endpoint, then
> I think Jason's suggestion above is correct.  Your driver that supports
> migration can refuse to load for devices there the topology is other
> than expected and you're effectively guaranteeing DMA isolation of the
> user and in-kernel drivers by hardware DMA semantics and topology.

Some kind of VFIO api 'vfio_is_this_pci_dev_is_safe_to_share()'
seems appropriate here.

I saw Intel doing the same thing in one of their VDPA driver proposals.

Jason
