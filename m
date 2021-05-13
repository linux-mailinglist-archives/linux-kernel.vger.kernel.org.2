Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AEF37FD32
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhEMSZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:25:28 -0400
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:23008
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229819AbhEMSZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:25:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROLL0Am2tGUUtXRR/4IyPcdLuWRGRR8dI7gglbVCrkmnLxF0jCewwnXVO/9XOOqpwQLkq4mvcB3atmg/mvkgJl0OeVosQ1ctOEQXHSD5+fAgApNFmXQfBrO+8pCUovEXXKZb2YRkWfxztXD3ApJ95+TAY2C/zP3j7vCdTjDgtXa2FUarXjsT2D9FvqaLYcPZjhiMZ/LrZO3nFreDzxtRWFzhc+XriCa4yUgmg0vwSzoyYdP23NqgR/uh1PiM6KpRf4wKH2zrrlQL0LjBfs/nnRzdUNz6hLzW4Mg3P6TI2JFTdgsW34IlTPKF3Nst2uJs8v99ftrPFJxmysOf2Fi8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fJywzG7Rlv4CsT0zTIg3py/4TmlKRFObk18WfIZzlY=;
 b=XaT+UhNhXIMLZNCgteNcsivr016ug9cnW4NS4kcyTe0WwCFrV+kHyu5aQqvuBBlFnOu74hrp1Pp64SW05zCx/I/+M9mwMY+FQcws4V6T/P+h8sY5jCSvJamWnSUftmxnGh2/y4ugciUD9M19nqCJ5UUVkwikZqt9OsYbGpSKORlntL/Ne4A7DVxjIpo4ar+KF4jT+sXYTAQzQB4iZ8MXNbSlhqcYfKO+veN78addev8LSUp/ba9NuZUsekHb0QtvK2letmKwC5xSL7PT25O9VM4bLOPj1bQ49djNgiNk3/tDRGJYaqpM6gQjD1X3tx7SkFFxXnnbOaH0W6xGC4ZO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fJywzG7Rlv4CsT0zTIg3py/4TmlKRFObk18WfIZzlY=;
 b=ji94/QxS1TlDXzzyEYL2gm1qGBFk4i+gWh7PFWiWZo8nzHP+dLlnSm4+QkiCDXrnGPhRdpYfXxkV/gLi9HSylM/uq2khBtG/jNJeays3hGrB02vqgr92YThe+HFsniZOkj6gLBbtemeIdQ6yfp1sFYVv80wQx+UO41EtQcfn9zUkP/VPK3REF49QRcaEdNTF14lDaiQCvWMp5iK59Nel+jg3AoOedGsWUii6d/g1xCFRoAR8xXoL/5gbTD/UcSczoeJO/IHe53aLCu3T8pxQPNZcaN95u3Ze/LPfkcyyPxIv3w3amky7LPFf0nwGyuHPq83XxcAaApb6CI76ILukig==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.27; Thu, 13 May
 2021 18:24:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 18:24:14 +0000
Date:   Thu, 13 May 2021 15:24:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        liulongfang <liulongfang@huawei.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [Linuxarm]  Re: [RFC PATCH 2/3] vfio/hisilicon: register the
 driver to vfio
Message-ID: <20210513182413.GO1002214@nvidia.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035a9a9b03b43dd9f859136ed84a7f8@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 18:24:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lhG0L-0079AI-1l; Thu, 13 May 2021 15:24:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 776dfadc-47ce-4d5c-3be7-08d9163c4fca
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3833C05E4496EF26EF4D0715C2519@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BG6QRXQghzihcRcP+ukCiwdfkOHlbrntotagfW7oYzLN+4ftPkddGTdY8J74LozGdKEjsUQSuO/QsPnQx8VH7w7z3hMWu56PLV9OmUn95lyBQnsNPLZmfEMrN/XFFluynnerQAM3uNceaJZELcjdiVVkOPffEdA7HIVB4ikfg/a/GADiJnK93FU2B2j38sXq+Wap1qqC/KkcxUNMQVK3rdsVDVK8ZhFuMG4tgmbF55HU0Pc1iClBJFbCIxCzh/C1muCUo6o6NcjXi+satkMMs7F2awJD1DR9Oj/8j2kVxj82SxjFFpnDCVuTVbgFVzh09YoloKkAsQvd6wRbtmx3J5qGGFUbdH+D25bVdF3AiqxC9jk+v9p4COObI8oWWsEvuV30yNIQZ6nVP+Rxm52M9n8zxNtqjufKFluo6+Z5lNmUP8L4U1Eh3aLMpYbgBX5CeQWDRAQ1evk6Oi3QnSiqRNRtkGmnzRIiYlGt5HBrrhCWGgsb9rLXkH1h5w5mgfFSb8FVecib8UR0MkUVUjmb1XHi4KKcV1vhpmfgDk3rJsduWvF2u5C/qgVZ6j8tVUo3fvkUlpws4xr0LvGbGR4Sl9KH4aLOSlZhflULVaPFX3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(8676002)(66476007)(186003)(66556008)(2906002)(478600001)(38100700002)(426003)(4744005)(86362001)(26005)(36756003)(66946007)(33656002)(2616005)(9746002)(9786002)(4326008)(5660300002)(1076003)(54906003)(83380400001)(316002)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5FltTzoygm/im2R3O+6Fh5vJKLJHk5Ly9vrkD2YGUdwfCprqr19y8Q24/nQJ?=
 =?us-ascii?Q?S6TWpaxInHRS2QAPI9r2FIT7D/3mqhZMPM2zWUSmfmAqTKU/x43IRpYSsYlR?=
 =?us-ascii?Q?6WzE5UKTk+BVjG0jB91OZbp0/VJlwdrEs9B9l3WtnGltxil/bZKQY3ahB978?=
 =?us-ascii?Q?NxvWGPT/0vn+zrh3W3veWkNu3QY8hsJgDnX0KNvmE/mzimrY8l/9jsLVLJoD?=
 =?us-ascii?Q?BjRAAOfJKMk8PCk7LOCQ0WbZgJi9dUUupgjptND0H7AT9UjfntfsqzOeUS4U?=
 =?us-ascii?Q?tt85pAWYiL50Ml22Py1oUKNQhYyjZs8wt+VlenJk3k9kILgacLSoA/CiZgBC?=
 =?us-ascii?Q?VzZYT4QHHrWYbfmoiclCXDu+Qheri8B0XRD/HsTNDvjfhblnZDJ/Le0/h1FU?=
 =?us-ascii?Q?ht2mx2m8mPeFHYaACG266gpQECXdvdbjjO1jIouhYOHqceU1XVcdESmmhTII?=
 =?us-ascii?Q?bwJ+diZpj3xD+2+iRtNLNMRDdCpNqWBgkskfKWRlaQ4kZDZCQvJokKLCMU6s?=
 =?us-ascii?Q?4z9cNg9HTIDl4gcO4hFd2uvZz6WjN5q3f1gAcctf4Ze1tiNpg+GH1SExYkuo?=
 =?us-ascii?Q?lKGnu4f7D8mMHzLDf7ATt+08yjWPPYt+HSj6sm7fcq2SnRt0bgdEjo0QiEZc?=
 =?us-ascii?Q?NBQ/Y4TFNjzVhVWRp9Gw4Bz6Fl5/9nB8NiwTUVBwvjYsrnelgiPyR0/0W8aO?=
 =?us-ascii?Q?Q/xjo+UdnvBPItWlk6EREj+YXu8xV4XQOeK4OS274GIq32BT7+6WhrHDSECo?=
 =?us-ascii?Q?U8rljjbh4XU15v1BsvMuU5f2R86fokMWTuvvoN2mXNbvMtjuUUISZZPgXd8W?=
 =?us-ascii?Q?GKvJ30/sMgVDg/YLAMxWC3visFNHAQ1TLwhVZLtAv6M83dBmEq0pEe9ckS9z?=
 =?us-ascii?Q?bj83o3kEzmkQ7/dQdNRCcBoJQgBPVirR5LVC10sn1EwPath1eRZa/HCIOdtr?=
 =?us-ascii?Q?SBRd2WvURuwBZ8BXaZLrNO9uReh1LsS9GBYGcJFS4sw5mz2yRbYiSCuFpmBQ?=
 =?us-ascii?Q?AdNSIp1mWsxQbRFdKMEjhuE66SGgBSEyy5c9e5oz/llwGHFtt6af3DlOgwmD?=
 =?us-ascii?Q?PBjXNRL5sq6ffNWRWB66Iw6k/HrX6SP71g+/1FSXghVZ7xb0Zp5DbJy9JcJH?=
 =?us-ascii?Q?NfoeZXd6G3lpNTOEgs6xSCQneH1FWlKxvuIAs3/TQpg8zfBEKhACffhcNzr/?=
 =?us-ascii?Q?Tq5FnVFJtpvRl6EaPTh3C3WZcjOxfnfLOgTVDHd9DXc34OIWCjVl5wzWAP/S?=
 =?us-ascii?Q?e196SSUgHkMoOE+NQgeIVZc/rm1UKCcLksH4BxYp51fX081HRambQQh2l1D8?=
 =?us-ascii?Q?ABOKihwv1tkwSbV7rNxWOThu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776dfadc-47ce-4d5c-3be7-08d9163c4fca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 18:24:14.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAKR0Ah0qsjrgwcvAf+YRFsylDWEmkqxQA2uN4WuDGtDgmyZtu+rOLJh6fT6o+yI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 05:52:56PM +0000, Shameerali Kolothum Thodi wrote:

> Since the devices we are concerned here are all integrated endpoints and if the 
> above quirk is an acceptable one, then we can use the uAPI as done in this
> series without overly complicating things here.

IMHO such a quirk in the core code should not be done. You need to
override this in your own driver like Max was showing.

I think we are very close to having worked out a great solution to the
lingering questions on Max's last RFC, hopefully we can post an
updated version soon

Jason
