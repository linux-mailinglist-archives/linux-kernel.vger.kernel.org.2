Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1829E37F8F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhEMNpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:45:36 -0400
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:41953
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230508AbhEMNpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:45:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2czHYV5exaoPdvshCCwZx4Z8aFglGQrKXkYtgecmqeFM4aJTmJUC8ASCVoDM1ws5xQGn1m1M/r3aBNjBdxablpy2sUDZoSim3JBbYlWqJPD0D5X2I35f+RivcbLHtrqQFePWc+M91CBqPEBMNMZAwY352G6CNFYHUXVu4VEXQ0+WZVQDU/Wnvd2em8HfXPlhMLAQ3WYlh4ESnY7YwYcHN3VY6QLfccbVdY1ZZyDxTi1+cKbH5PMlQZ4hrMh5CN9XHsUMlbJ6a+fZNS0L6fb8l9RZFLpMUMfZexrAKhHFIXifJTOt0NxE5dQdF7Ov/wcZHNa/pCqRL5v4cT2uLHzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3HzM1xb9nt1YXdUSHW8fzl3Ci2OpD7Gg1IwK7Er/DI=;
 b=KcUOLiQct9J6Z0fyoobc2IX3ICvnU0E7tVqGj6Gn3zha2FguDR6/5FDh8LC6PKdor7ODh5iL9MGELMEyY1UztT+sT4HPf1Q0hbFC9ofOukEUDvROufPhOR4oQebmA2XUo5ymaRVvhZUfH5GvOHcYuakaPbyNWkHsrmENM4+s9rsh8s7YOwBCmkm0/khLbSLRQfAuEuLO5iOUE/yjGmO5+GIBiBe3wI9Zn8cbVV8KRV6Oc1iOGKLXDEeHPXi95z0RDYOlT6zHLMd2o7bp1I/iJnfXyE3Wl0YxBrqoqv1FmySH9QjFn4I8rn4GoAvW3qoflY9tWofpTq7o8HjTb/79Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3HzM1xb9nt1YXdUSHW8fzl3Ci2OpD7Gg1IwK7Er/DI=;
 b=fY3R4Lt4nCa1zaQBHQjz+MKZOIKeJLwB2COqx5Ay/dE8VVl+SL53N/KybMdYvhRCFxRt613CPNqyEnQY8zGJhjWB6LtLZjMTYaWqG2IE6LgtLQwO58oLfMnYDnbtKkF1Te8G9d14zHPHZoubyR9xBg7kqi1KU9O7mj4kkvND/gUpM7DqEZ+gdo4mvFBQcrYBnDT+A0oIbKSXoqqBnxZtGTheRsDu4EmnB6cpQAfcnCRYZx7Jvp3K8g/rGoYQRGYcN8PbgmJDXiMa2PG0OydOe08eE/JKUwikmT7/f1RC0Zjrs9jkdpnDZroSbA3vhcqdJS3enikfz1qHZQ/J2RNi7g==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2489.namprd12.prod.outlook.com (2603:10b6:3:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 13:44:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 13:44:24 +0000
Date:   Thu, 13 May 2021 10:44:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Message-ID: <20210513134422.GD1002214@nvidia.com>
References: <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
 <20210419123314.GT1370958@nvidia.com>
 <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
 <20210420125957.GA1370958@nvidia.com>
 <20210420160457.6b91850a@x1.home.shazbot.org>
 <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
 <20210421121224.62382e5d@redhat.com>
 <6ea89655-31c5-233b-ca2a-fcc166b5597c@huawei.com>
 <20210512121053.GT1002214@nvidia.com>
 <3eaa3114-81b6-1bd9-c7e6-cb1541389b58@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eaa3114-81b6-1bd9-c7e6-cb1541389b58@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:208:234::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:208:234::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 13:44:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lhBdW-006pLh-Sg; Thu, 13 May 2021 10:44:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 242fa621-1b7e-470f-e506-08d91615380a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2489:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24892EE6AAE3366C9379841CC2519@DM5PR1201MB2489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3EiZxfkjhC6pUvjGiMdtMdNQYL6ayCevfoDOW2c3BXmTVuk9O3M0oY0b0FUqo3WfAAQFWBjwigg0Vrz0Ychp0SvvlOnUayWj6RyRcfOJzQIBagWyNNARfIynUwyk8KFiMU+2WwJ0pX/wByk7LcsEDWLmqHoPT+wMKJgCx3prTaQ+TciDj2pUYc094kBWA5N3H0HoAyJFyUgAX8Fxc9yl4DGs3PuxxA++2a+yK+91jelCMoXYkv/h1qgNwsJAjmNzofGwmYGTRRQ9s9DvTokdDEhxueRcuweTZg9wCiifAfNe2yA3lkr9hKBlFy0+OxL1QDyyxm++mNawRF/kQpXT6R9efKn7zBoXq2cdFx9XC0IeQiXJsBL56m55LW3obARqbV8dPSgXm65B73F5S2hbsFIXhqN4Fh0A5OUb2LVI3wcdJALLFmye8xSjxZWMNffSMLvHPYdTWn94MqsAC8NQaKHDvmaAvbCdCsx4jYM+2uNABsgOEnRZuNrPICetk41l9drRcdHnsaq7jpKOmAZnAF6hvEGMg8uh+GbdYJlB1D8EMbxs17tXB4EXjXcp3vSC52OFGpEZKT87Tm0wPaOx4O30lv0P2IVpNGfroT9Kmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(8676002)(4744005)(86362001)(66556008)(9786002)(6916009)(426003)(66476007)(33656002)(38100700002)(9746002)(478600001)(8936002)(316002)(36756003)(83380400001)(26005)(2906002)(53546011)(66946007)(1076003)(4326008)(5660300002)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Oxh4AdOQFY/VV46cJbYREtjqSBGefaZGHtjLxTr6TJWZ0TDMxmsgpmuYUhSv?=
 =?us-ascii?Q?VssJcgH6ScnN5eKdxLaiu7rQlH0N85RNhG2OzexHzjCOBZ2VcQ+X/H4kiF0u?=
 =?us-ascii?Q?QUNZBW7Y3XfsiJ5kPp0OmyOV6Mpz5fF5L4dgcFIAs6B4VNOrLUQqYtpre17e?=
 =?us-ascii?Q?6ZSz8KdiOM8DmM/0h9PPPTzPDG46oeNaq99fu98rygoeWPZactvxlBaA2WSJ?=
 =?us-ascii?Q?7+GRu7BfG4W+T5ue5tOjfa+Phqe+dJtf9q3e4AMnPmnMTqc0iqvdyM5imh/2?=
 =?us-ascii?Q?tpJQYfja4ekSQNvDDiGDc1ZjJ5lGb8PdXaOODqSmSWmT1KRV7Fo2MCCj7ZNJ?=
 =?us-ascii?Q?6DHpIigBqrAnDEY9TXLPIqYsNBOaIElCV5oAX1SXNqdqmoP6bHdzLsWA0G1A?=
 =?us-ascii?Q?cuY5nl4yr5EvOR+qGdhSV8FkgnN89LiWfjhoUgrU8Fijq1wyhyUegx3qrIpI?=
 =?us-ascii?Q?FwJAxvxvrdSyBSqBfWD+oAsQlLPe0g1kW7sjHYEqoS1g68bolfHPoOrORqEX?=
 =?us-ascii?Q?nqq3R2kSQ0e30bzkdvljFd4JhViLUQOTsD1fV6EfnapRvUTDPuUKMZZwBR5Z?=
 =?us-ascii?Q?7YxsD2TknGV5aY7r79Z70Y1vGlIyRP4003Y0PDR9Z1CoIhIFlMcOvf7u+OWZ?=
 =?us-ascii?Q?2O3Oxx3hRbcXPxGAE7MwhhDWavkJ6NzivU/Iu2c35UCEve8xgsyerQuPM52q?=
 =?us-ascii?Q?psdttrmRnEyAY1tkRMRY3KUy/Ex9qnHNcd8nbmw5/dLyQMeRiS3wYC/21d9N?=
 =?us-ascii?Q?yQ0H/hhRnZIB67VLEleSTkmit8x2kK+7veQZPjZwjFBZDgFqhwtJXNWY0ZIJ?=
 =?us-ascii?Q?D+XAj9jS4TNpXC6hBgo/o3KkY9MjhAxrrd7ROEl1sPciAAXFnOJPBCq+tWCi?=
 =?us-ascii?Q?wMzFHAbxNyus+KeOf8lGpPJwQsyVNAEH5V3f3n/J/nnKcQ1PVLmw062G15UX?=
 =?us-ascii?Q?b1bmv+pqvY0vxQkxhPxd+1j7Akb64Yv8M8OOQSHZDmDktCdQfHZGX+8NzjBu?=
 =?us-ascii?Q?mfDgX0gwOrkKvmCBK5uNqc0pA7HLR/MC5RyOP0TjS07Tcs1Su5pXPys0wMyW?=
 =?us-ascii?Q?v5FnKrOoq5ssb7Sg5hO2nSmqieiBR/+dBL/Kb0YWDXoOR1kq8lFP1quEQhp+?=
 =?us-ascii?Q?hH1iso0C952yhHvwLMRPZ9+N+MkeLOqECg7NhxFYtmaxtWLVrakt4CxKnhcc?=
 =?us-ascii?Q?eHu/CLC4RT0w6+OKNwWk8/8wkCJATzOtZZW/EyTyEskSpWPKMdV7+7g+DM2s?=
 =?us-ascii?Q?TH+jywEhhggk3EIm53Z+PNp5Dy5PwnTw9w/Se+9DtqJLx+gyypfKxzx1sqsv?=
 =?us-ascii?Q?e/MNAg6F5PhaEsM7CKAi9n4Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242fa621-1b7e-470f-e506-08d91615380a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 13:44:24.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VW/HR2XVi3LPd1tKsmqGPBOrLmIeGgkA60xSXhaQr0zPmX6XLPYwO6iWC0p5n7m8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2489
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 10:08:28AM +0800, liulongfang wrote:
> On 2021/5/12 20:10, Jason Gunthorpe wrote:
> > On Wed, May 12, 2021 at 04:39:43PM +0800, liulongfang wrote:
> > 
> >> Therefore, this method of limiting the length of the BAR
> >> configuration space can prevent unsafe operations of the memory.
> > 
> > The issue is DMA controlled by the guest accessing the secure BAR
> > area, not the guest CPU.
> > 
> > Jason
> > .
> > 
> This secure BAR area is not presented to the Guest,
> which makes it impossible for the Guest to obtain the secure BAR area
> when establishing the DMA mapping of the configuration space.
> If the DMA controller accesses the secure BAR area, the access will
> be blocked by the SMMU.

There are scenarios where this is not true.

At a minimum the mdev driver should refuse to work in those cases.

Jason
