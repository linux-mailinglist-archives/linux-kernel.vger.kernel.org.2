Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BAF371FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhECSbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:31:50 -0400
Received: from mail-bn8nam08on2048.outbound.protection.outlook.com ([40.107.100.48]:38618
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229604AbhECSbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:31:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa6OD+0flDH7OGkBV7gMQMmUYuTYN7PH69Y/QJGZVEfIHYukIUQG9t6c9YJbBdS+maSJb7oi7qd/zlNCbgu26mrLwxV18kwlkKdqd1cZVoh6RMHgHJg715XQ/UMydFEuSfuBjJCodzLMjj2ERohhj3aUOoqImidwLVTs91rJuf9os9ZyXlpU6vh0SBpPP3kvKf8X1rsgxHRwKLQV5OA+ce2oawqa28yJrV+Za0YXwn/lTwTSyKwPu6d0FogSUILkx67DrBwkVcbagUZgBukl5nwajwCeWDCQXAJsX9OsdmGJ7PIrkkC/I77Y1XSKr4xZrq7//VUSZPkOhecW2vGAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm2laiPXs4Rv1Jq2I7Q5+n5gqIBHQJoZAlDbV6a4ZVU=;
 b=RwmY4c0hY4bdkbET+3W+mMpITGCeuEW/D6EHHKidFFmt9X8RUfixsNqBPxcBImv3urshgJ+WGcfzCGKGhzve98TAV/OmFbkqA64NJA3hGBTPDnKFEk8gilLrU9QeVj60rS9Y/JVP4xIbhm97dgu9TdY5oGMcUSSiCBq1h/214xm/VbjfKDdQeEZuW1IhQMENEdls7Y4o4v2b5PhHD9Zi6Vygcwq1Pbu+cqZBRdjYbUYiPMm1HiNZFvvqq8wHffttO+qDeE1TWeP0Rwl6Ss2M4IhAQS/R/wB89n6BXQw05VrA3lgIUW234QtAld92yVUYqTovMyg6VKtA9OHBuoNo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm2laiPXs4Rv1Jq2I7Q5+n5gqIBHQJoZAlDbV6a4ZVU=;
 b=oMJFgyP1BL4m+Y+6y8APVib0WPu7ZC0UCJls518kz8V/CO5y6cYVzj3+4THMGxIAmgoHkArZbdzOEHu+PMrstYTrPAfzMQgRa6jgHJdryQwCQDntvhk1x8TZi+gRjVjP+n59FjOEVD7jhJE6hQ44/a4OeXTZ5AVV+jzPB14qQA39q+dXv4tjg3HPtwaREAyplH3zikRezMe67/QhAV/RK6HIEC4DRHbb8GtSJ6Yr9y1elDxXw/E1oGahJ7TNcqPulnWjx/eLvkCcCXQNmWy1qrvpaXtxACSSIlx/GkkBnZZ5QWN3Pq92DxhTbYHWp110mgjgCGOkgUxmPTOhWnhhpw==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.26; Mon, 3 May 2021 18:30:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 18:30:53 +0000
Date:   Mon, 3 May 2021 15:30:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 037/190] Revert "RDMA/core: Fix several reference count
 leaks."
Message-ID: <20210503183051.GO1370958@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-38-gregkh@linuxfoundation.org>
 <20210421141444.GL1370958@nvidia.com>
 <YIgfbZDo9eQ2tKvc@kroah.com>
 <20210427161235.GB1370958@nvidia.com>
 <YIlTzGLpbRj3rh/R@kroah.com>
 <20210428130044.GQ1370958@nvidia.com>
 <YIq24bDyB49QJm0S@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIq24bDyB49QJm0S@kroah.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.37 via Frontend Transport; Mon, 3 May 2021 18:30:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lddLH-00Gj9a-BE; Mon, 03 May 2021 15:30:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc2716a1-0f9a-46fa-9565-08d90e619541
X-MS-TrafficTypeDiagnostic: DM5PR12MB1516:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1516131C0881C47FA4CB0059C25B9@DM5PR12MB1516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbKN4HvoFWIVRSK8Z9GDLq/aAYVYEoORJCyQb3xds/3I5qLKpuunHvYMGM7EDod84ulpo4EpoT2kwM0CBVEXLAZmgxk3bximRxycMuoIZsEFpp3yZkCZrMXvuHZ2FR40KUqYnArVakDOG/7sDzKClTQrsbXZPzFb9aLqzvAJWTqWrstgYtwDJ1GexdDyldeFem0hPeWk3kpoN52Mt3ruKepxwJK7Ngn36BxCz0AfN2y0LieciOmE2L7Tf217bPSi+jMDTYdUoKCnFRFUwfkMDtj5Il92nyF/Pe0vbz5Onpdk+/ag7iZWNm/kDnI4y4Cp8uWfxDIlC9bYRKv2+qyrpwohNzs3XukkKA0vb5q9iTJee1ss/TeT8IvMSel/hpSXiLrVhL56W4Egnw9xFagQpKmqlV+aqXb7BG/aEdZC43BWEZYQouq+FrX6QLF+su+8hi3k4k6bCbwVMJOXCq0OxZ0oUReZslvCevojtd+t7AuP7uEUp9fnQcUvd0Hn2HefKQC8UC0GmJpSW0QbePcKxxIOdQLTiXlWbtpxR5+U9e43At03NMOsThvPg7vwpEOqdh5BgS+cGxHP6uHAOy1Mp2WvRzAJWo4BzlL9UHysf/PTs3ks+u9RO8gUXDtIw2buh2Zy+P2b8UJjKzoC543MvbtQNdspQJzvEe7FL9xqIyBUondUwSmpwIywx16KWhOb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(33656002)(186003)(966005)(426003)(316002)(26005)(8936002)(8676002)(5660300002)(2616005)(86362001)(1076003)(38100700002)(4326008)(2906002)(66946007)(478600001)(66556008)(66476007)(36756003)(9746002)(9786002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?p0gzdG6I0+gLaxeVCJtMUwX6SbXJUrrkWHWUlxNbt8+6TXP6UJ33Sj8/59Fe?=
 =?us-ascii?Q?D57SiMh/dySKaqAtI02NAVBcirog39rOvezmnfJtqDSxbjVqCPqVYMLbN1Y0?=
 =?us-ascii?Q?Ivu1fHEu0A7oy/hlrg63nqWqVwGGPl/6Chczer4M5AwjDThpxfXrC55YYMHy?=
 =?us-ascii?Q?5CySpfIjBltEeFW0a8BYcL+1217Fy977Zf7YpLYxrHqlYeriAkCz9HG/gijz?=
 =?us-ascii?Q?ZmnHi9/hN5K04eeMVwCCQmJuzHSlOJL0pxfZiQhO2wFAH2MV6HyC1L1N4wxi?=
 =?us-ascii?Q?gYnbIZ0HoIfuixhlzHpojggearB3yK4RWIONooIG1u/x9j0BdAy3cmrCq/fW?=
 =?us-ascii?Q?cb7YZwGCxynvh7Zpj3BxnNxqBJfb5wLM9vjotjRDiR3kGciqscpafm+cu185?=
 =?us-ascii?Q?OhJRbQQdcaVkmoK00WUq9P5JLz+mN0etH9y5qwjRdSG4tYY+rpBVeKURzeqC?=
 =?us-ascii?Q?N+4xuTWojMTYrZZp9+uuycK5wSFt6IKjHWddC7EVFgFGPYfS+poNXYod6rIn?=
 =?us-ascii?Q?ZQqsLzGqJDytGI7O9QDr2XYv+Z0muDMDufhUp9X9pWoIRehwS6imrzJ1bkvt?=
 =?us-ascii?Q?uNgqoye43xNMgPX2+k/kk2ub+N4s2/yfAQw9idlBHO76lZxKsY1mfU+lRvPY?=
 =?us-ascii?Q?gO3i0uEBUXoXkVB3IGoy4UNhfNHW30Sy2nrSxlQuyH2R094iiuQjG6wqFLkB?=
 =?us-ascii?Q?KGknIzO8zHaLH+NFwu93SUWr6g5xvOspho8ckeTc+wedha0qeXqKOOQ24EZi?=
 =?us-ascii?Q?Z2SaEPds7Q+fYsSx1FmNgnf9j8I1JGeylptTOQlZ9eyGAyZKTTGYkyVqmoLz?=
 =?us-ascii?Q?PA21U/YblNhg3qE3ETvH01uBIdSoDroCrKHwWJItQRT470gRmFlsCvFdqu4e?=
 =?us-ascii?Q?qhJKqz5ppbv0rM1HhRwZC6bYiQNEXjvedCVyLkKXQk/7vwzB2b/1E6HV+Yr3?=
 =?us-ascii?Q?/vx1N0iFWeq+Iq3jub5r/qoss819PFWIa6cIwn3Jp8bJiTyayUt4BGnfuEgM?=
 =?us-ascii?Q?r/mQSpIocsfLY7qbWY3TU/BeyUBXPcXOoMe16mzYy+qdv0XolnzF8HqkTc+y?=
 =?us-ascii?Q?9TsSQOX6NYZ3nIv1DxP5c17cE5RXnGTOs0aGPX8jBZi/mmCAql1S1s8vps+E?=
 =?us-ascii?Q?nyvJi3pGRP7DI7MiXO6sG1iREylspSvSgDFWvVk1rkAxgxluKOjWyzWFvP1v?=
 =?us-ascii?Q?E5ORcqahxQR+o9iFrKHiSbB7dr5x3MEQFIXEc/eKdr8w+iMy4u4kABh2/B0/?=
 =?us-ascii?Q?ixZs4Bn418lU96gkfItqAHXcMT2+uQUq3WjIMzawpIsQOFJC/7UgiUeXINGk?=
 =?us-ascii?Q?Dgry975DA9aCBzqkn1zcuFEr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2716a1-0f9a-46fa-9565-08d90e619541
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 18:30:53.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ga/iVGvsnDYoj4Wm9JGmcYdcgRf91ZpwrhD+/T/HGlbl6N1XILv6nWnUlB/DNfFf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:38:41PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 28, 2021 at 10:00:44AM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 28, 2021 at 02:23:40PM +0200, Greg Kroah-Hartman wrote:
> > 
> > > > We've talked about this specifically before:
> > > > 
> > > > http://lore.kernel.org/r/20210331170720.GY2710221@ziepe.ca
> > > > 
> > > > I still don't understand what you mean by "udev sees it properly", as
> > > > above, all the tests I thought of look OK.
> > > 
> > > Can you query the udev database to see the attribute values?
> > 
> > It appears so unless I misunderstand your ask:
> > 
> > $ udevadm info -a /sys/class/infiniband/ibp0s9
> >     ATTR{ports/1/cm_rx_duplicates/dreq}=="0"
> 
> That works?  Nice, I didn't think it did.
> 
> But what about the uevent that fired for "1", isn't there attibutes
> assigned to it that udev ignores?

I'm not completely familiar with uevents, but:

$ find /sys/class/infiniband/ibp0s9/ -name "uevent"
/sys/class/infiniband/ibp0s9/uevent

$ udevadm monitor & modprobe mlx5_ib
KERNEL[169.337295] add      /bus/auxiliary/drivers/mlx5_ib.multiport (drivers)
UDEV  [169.354621] add      /bus/auxiliary/drivers/mlx5_ib.multiport (drivers)
KERNEL[169.393088] add      /devices/pci0000:00/0000:00:09.0/infiniband_verbs/uverbs0 (infiniband_verbs)
KERNEL[169.393516] add      /devices/pci0000:00/0000:00:09.0/infiniband_mad/umad0 (infiniband_mad)
KERNEL[169.394040] add      /devices/pci0000:00/0000:00:09.0/infiniband_mad/issm0 (infiniband_mad)
UDEV  [169.395189] add      /devices/pci0000:00/0000:00:09.0/infiniband_verbs/uverbs0 (infiniband_verbs)
UDEV  [169.397812] add      /devices/pci0000:00/0000:00:09.0/infiniband_mad/issm0 (infiniband_mad)
KERNEL[169.407727] add      /devices/pci0000:00/0000:00:09.0/net/ib0 (net)
KERNEL[169.407851] add      /devices/pci0000:00/0000:00:09.0/net/ib0/queues/rx-0 (queues)
KERNEL[169.408113] add      /devices/pci0000:00/0000:00:09.0/net/ib0/queues/tx-0 (queues)
KERNEL[169.409059] add      /devices/pci0000:00/0000:00:09.0/infiniband/mlx5_0 (infiniband)
KERNEL[169.411483] bind     /devices/pci0000:00/0000:00:09.0/mlx5_core.rdma.0 (auxiliary)
KERNEL[169.411836] add      /bus/auxiliary/drivers/mlx5_ib.rdma (drivers)
KERNEL[169.411973] add      /module/mlx5_ib (module)
UDEV  [169.420570] bind     /devices/pci0000:00/0000:00:09.0/mlx5_core.rdma.0 (auxiliary)
UDEV  [169.421365] add      /bus/auxiliary/drivers/mlx5_ib.rdma (drivers)
UDEV  [169.447853] add      /module/mlx5_ib (module)
KERNEL[169.482293] move     /devices/pci0000:00/0000:00:09.0/infiniband/ibp0s9 (infiniband)
UDEV  [169.486395] add      /devices/pci0000:00/0000:00:09.0/infiniband/mlx5_0 (infiniband)
UDEV  [169.495193] move     /devices/pci0000:00/0000:00:09.0/infiniband/ibp0s9 (infiniband)
UDEV  [169.698592] add      /devices/pci0000:00/0000:00:09.0/net/ib0 (net)
UDEV  [169.700436] add      /devices/pci0000:00/0000:00:09.0/net/ib0/queues/rx-0 (queues)
UDEV  [169.700712] add      /devices/pci0000:00/0000:00:09.0/net/ib0/queues/tx-0 (queues)
UDEV  [170.042132] add      /devices/pci0000:00/0000:00:09.0/infiniband_mad/umad0 (infiniband_mad)

I don't see any uevents related to the nested attributes. Same on
removal.

As far I can tell udev is working perfectly fine with 4 levels of
attributes..

> Placing a raw kobject below a struct device breaks the "device tree"
> model.  You now have devices with an arbritrary number of levels deep
> set of attributes, making it impossible to determine all attributes for
> a device in a simple way.

Since udev is able to determine the attributes, does this mean at some
point it abandoned the simple way and is now doing something complex?

Jason
