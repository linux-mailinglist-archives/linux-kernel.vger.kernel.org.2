Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C646136D7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbhD1NBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:01:38 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:62240
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239572AbhD1NBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:01:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs6NxHjMDddcSlMCCfO+nnkmnDfUshfsO3nxOVjHZCsl1H+fD9zmeYwume8S98syVPZ9XzyQumFFLBSh14ZjH1nztfX7lGL9STQr491UBfUPkSyMSszoq55Nl0vHaqE9dBnkheZopgFnqW59nopwHmo5bZJq/wWL23utmR1nTFAYoovr7GIf+xyv9SChG9oBgwhG/MbEy154pPln4K3eesIn7sQsbjtwPFE6MnqtJyNVa1CG5bPooZwD9EAYPOKXaLixUTH7rAAME4nFwN+Ty5FvKgtjdVSLEUtqkAlwi8ioAvURl9qZIOqJbIizvbPRUPDtnCc61hA1651M9FzHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDIXDNP9GvP9Ci5qM4V9mbqfYiigkDyqgWRgZkQTwrs=;
 b=DekJqWYmabqLC1866bjyGQrxsj1ZppeCDf/tzig9p+heEMFhNZ7hA9pRYP7NZLidUjaH9+rTJmAnIZ0yoc1OIdFa5WqDmtsReoX4xeiDV7+ZfNTq0K7tw17qOYGh3c/9dVPcw2HgDiEyqVr8O/IQL0QahYDIEpynGdDPnpjPishfPq8/akH5A45cKCWWSsF0t77ynywCEMEAoyZQMYCM5RlCIO7MEUiMjDi0fb+wpMwYRJ5/cF60UgWxpzyX1Y27c/jdutA6reu/hbSKnld9za6j8/2SrVm144j7ahVL297FwVp5HDr1nors6NQTsRxIzfW7/QcEOgTKxPlAtcHX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDIXDNP9GvP9Ci5qM4V9mbqfYiigkDyqgWRgZkQTwrs=;
 b=pggWItSQyH87J4QSIg8kn5lnZ+u0bSVqygaeP5+VQmtHe6b5VNiXlI+B3F0pUYqJkw1q5j2ZWngvmQCY02BSlt7rCoH/2UmQe2nLgxzX0ODG9amMkt73Ea6oATU26VRwW31NCPS9kt8TVOQTUG1Z171umWzEaIU+xfqMFwazeuTAIyg7Vrojx4kiLJ+FRHkCGALunGl9n1BHUOp/EhBuqX6sxzMLqb8qkRkWnJ0Hxu83/zOkrgvLKd2Sy1OhaTLxG7bbAXrFdN1cWO/7yd9ZXsmSuvg/pr4xI17JlUsRmpc3PNd2uViTyLAGrUsLNU137r7nyvjEh0HRRReh3PgLUA==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 13:00:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 13:00:47 +0000
Date:   Wed, 28 Apr 2021 10:00:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 037/190] Revert "RDMA/core: Fix several reference count
 leaks."
Message-ID: <20210428130044.GQ1370958@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-38-gregkh@linuxfoundation.org>
 <20210421141444.GL1370958@nvidia.com>
 <YIgfbZDo9eQ2tKvc@kroah.com>
 <20210427161235.GB1370958@nvidia.com>
 <YIlTzGLpbRj3rh/R@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIlTzGLpbRj3rh/R@kroah.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR03CA0241.namprd03.prod.outlook.com (2603:10b6:a03:3a0::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Wed, 28 Apr 2021 13:00:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lbjo4-00E0cr-Kt; Wed, 28 Apr 2021 10:00:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25b84763-bd1f-4169-c5f8-08d90a45a422
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3402175CB7E1556C988C20D8C2409@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5YFG0vUIv+ubFsXoU5IMrrUmrodqvsigZKrv+TXSnp/cLqvw7kKa54MsjNrUXiX9xYkUxdYZJWwKcnbMhmcWeCgLGf6VM07Yu0aoTMb4FLFutQf+WiWg0hWbaJpW99WYOOQUyx+hUE4kY8VNS5KiS76gl9YtwDq1WLiOD6HAb1dOIbiASG3GOebCNtN7KgJoUjF/qodw8+Q7VFkxE1/i7zarl/Dq6p/BSGPMdPrfN3uNJewxxQ2P0mp00AOzWSHN2urxSOgWeR1EcKDGlbQXysmdfTuNHdqfpUjH/2W6zXc94ALnkwyjwEUX64bWCMMJppxMuuotxyuOWICwvRIYkBT1Tdg0SDO2W6Aw8NFWnY7czN31+FGazS9Oyi68FIW3XK+2Ylnjcs9Pe8kvow471Nel6atWACbmh1fo9ikKH3e6ju1NdBY7IFNRRirw2DXhFlkpARd+8gcYC2csiSDnBsFZDTRLoNvQ8WOlgQ9kCPvjgENLp6YPGPy4zUwRt/ld+gWiHKpTyCBmtMNEBu03Fe7SLubBYHgiBYqkNpqmoJw4hI6Fny/w36Emui1xdRTWMGFA+00P/SGamxTSdfxjGfEy98pEtMeuEaPMLxJO//AJWXvT2TETjhKtAJ8zEIT/G88HYmN6AqIyjTonSXfVlORgOhUjSugu9mEp2ulRM67sYFzXlE/y5N+6gnRIDRJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(38100700002)(26005)(478600001)(5660300002)(9786002)(9746002)(36756003)(316002)(4744005)(33656002)(8676002)(6916009)(426003)(1076003)(966005)(86362001)(83380400001)(4326008)(66946007)(66556008)(66476007)(8936002)(2616005)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zkRmamCn8eA5g1ItzDoJAXlyho4GadODcGdDvvxJykHK/8IJB4OPIOWJIj1T?=
 =?us-ascii?Q?6Mcd2iSMdkwgzmrujWv+qRnDe0B9RoQYNHmPusZ9SNDoboGJfffIGuu3b1KY?=
 =?us-ascii?Q?Ep1LNPaH5W0eP0Cs4zXXvT/mjbU1f7oWbeDEKeXCdr/VlldTcU3ElVL9NZ80?=
 =?us-ascii?Q?9/cKGH6OIjf5AjJ7J8X5q1+6RLEE1tx3DxVhB/YmfAJe4wUbCg/HZpuI3Hzq?=
 =?us-ascii?Q?wR/Bx5u1kIlgkI+wHlrcYPzyhTymqtlSaOFTwV2tmoAiWeeKQbMIzv3sMawq?=
 =?us-ascii?Q?e5pk8uwYR+zEzFeqaJLnK3sVfnmJzp871LJXxy5u5sHO9IMh52k/0+JWPJox?=
 =?us-ascii?Q?gMUGECTqS/Swie5ma/CfLExaAdfBURayLLwXdB0dHviMyzWxu4oMzczikuRa?=
 =?us-ascii?Q?7buhp1e/wIps/m91BMSMgXEHigx2jex+i/PgljCUhRv771IalnqeI9riQ7ix?=
 =?us-ascii?Q?qwj9Zr8NcHm0JaL4tep7eJcZwTewyv7JVFhsGea+VRUJ1i/qPvjBqraLcWTE?=
 =?us-ascii?Q?mJ2f8E1uAHBN+/xd5ECqh14YcB2VbZkgYylTeNsNeoZ5t0Sa5Gqz+hxeB2ae?=
 =?us-ascii?Q?T0BQVHWTFqL9EhsNmO1d7HxsE5oqQLDAaPsajCKyMzDdlZhtx1asjXoqCCka?=
 =?us-ascii?Q?yOOlO3yBlmZjYcCXqQOP7/b86uPAbDayJ2E+ZErxQbz908c0AjDA0uHtG0Gm?=
 =?us-ascii?Q?aGeSAFj9CnuHFxjyrLEsfePEuzSDMwyN/OYNXNXFDi100fqSDW3h17r9yJO5?=
 =?us-ascii?Q?8ZXPCeoD7HEDVHUoW9RyzBPVu8T5WPSE6P0/dP/xcMGhZo5GT4AGrdDGEVmH?=
 =?us-ascii?Q?95xtL9zDukTFghPrzmf5D1m0C7yXVjP7gXVVFiY6XGXt7mKD6PyuyJxjTdUR?=
 =?us-ascii?Q?MZywZwmjwbbFR2QuBNpk9a3qpghd0JCjPLsryXvKtA/MeBvLTlP8YzMyYmGx?=
 =?us-ascii?Q?oV5FeC12eLpalpTlZqh6cfO3ClqTrHVqLO1IZtuYXP4V8QCjkZYBeURqsNxv?=
 =?us-ascii?Q?PV8wuPdtNv1IKNxIULxUmI6HdPvKhz783h9qrWCPLfeWf+jUHNQt/S7H5qwP?=
 =?us-ascii?Q?rnhtqaZY/sVfAhGj0+tnMUmWGvDx7UKDbsqDXrlnpSjAugTInv3nK0ITuesj?=
 =?us-ascii?Q?gyZPwhczLSYPIQhzRAl/zrrB6N4tmE04am1tKn1JW8BLQQOmHLFCincG0As6?=
 =?us-ascii?Q?e6Un7QCKIGAZLbKylsoqo5EmgXnRQdGxtNBr2oj2FjwYKU+rN9nzdv2INIS3?=
 =?us-ascii?Q?OFPsN1voXW3FH9b31F9tbfi+K/3Wq2v8woRfy/F8s4UWugX5nacf0GAdtkwA?=
 =?us-ascii?Q?zXSyAi1ZXfglf6cSHEIKrjaN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b84763-bd1f-4169-c5f8-08d90a45a422
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 13:00:47.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlDw8YHVuPp5/xX+YMyMIzt4ziiGs8R9PacGbr6bWEn3QmVqcZbeTJsXWWWMvEMA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 02:23:40PM +0200, Greg Kroah-Hartman wrote:

> > We've talked about this specifically before:
> > 
> > http://lore.kernel.org/r/20210331170720.GY2710221@ziepe.ca
> > 
> > I still don't understand what you mean by "udev sees it properly", as
> > above, all the tests I thought of look OK.
> 
> Can you query the udev database to see the attribute values?

It appears so unless I misunderstand your ask:

$ udevadm info -a /sys/class/infiniband/ibp0s9
    ATTR{ports/1/cm_rx_duplicates/dreq}=="0"

> As you say, it's uABI for now, so odds are nothing can be changed.  It's
> just no fun for when other subsystems want to do this same thing, they
> point at this code and say "see, they did it!" :)

Are you sure we shouldn't just formally support this? 

What is the exact technical blocker?

Jason
