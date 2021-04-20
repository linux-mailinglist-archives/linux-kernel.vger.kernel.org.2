Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9421365B87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhDTOzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:55:52 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:65505
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232504AbhDTOzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:55:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQUDZzIt/XaGXaMcHcWsmMTmS7crZ77Iwolo32N0EvTT+BNnFYMrEtlJu6XLr2kfJDv/DYIALNybnnpPETcHbj4fM/4xdVlt0TB4PSnTwY47b7at51E5TxPu0OzsxYPpZ3P0W9p5P62kKVdCLTQWbLNiwVfBDlUSyGxXx42gz5FlyQmLTyW18Vey9Am0RxcHDEeij/O/ht8NFmR8/bAsrxw/rFt/uv6omoOh/t3dOA4WloR4Qtvz3aBsl+GxB4VQH3iLblUFqWtjSHx6R9dxLc03wSBpinoc0PYnkIvkFoZiFqvgRvEE9mRXOVrJ1Yn6ds0jHkHtcFWrtz0I3paWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWRV/ZqdlHgjELHKchcpZ32YGP1h2TOEWs991yE94nk=;
 b=QUpvsOzMX1dIR76U9LreWQ8PiYpK3yLiW7VLb6JshUXBsYCxfJXGcWispYqXRH5fRm5hMhRbS53+XduAspiv8rHYWY0HOXvHOpawTBqMzxVo4e3auUcOWcY6XK2J9dqDglYF/1/I59NleoUfvajK+tyi9gm4LVwdEuuKHlwhrKII6uugalBEmcPoC4SWqJo02PppOCJognHZvKFMS4GXUa0Ao+qNymhX6RwYbTtA9FDaPhYnm+j0OVb6tsqZmnzz3ItIndMoyR6mGsNYnT0cvT1hqRCrVzgPax312C6Aak6FE3OsMRnxrUvPSH+x0+GLnO+nllX2eHFDPyRUvlcvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWRV/ZqdlHgjELHKchcpZ32YGP1h2TOEWs991yE94nk=;
 b=Ket46lPG6a8RQl/cqMCv7Wy6I1GrTjv8xjD5j3S49o8M3Ljkv0i2/59WSy+TkVHy0mXdSLJO2vdb7Qn0yZZTC0sgNJ4PP6w7qzk9Ss2UrZY/YKWezL39bQu8zPadBmsnfh9EtpBpmcmLbBRfdggU2LNDURLHLK0IunKL8/SNS+nassTUO/RIIPCaKKFru3RViDQj2tvIHxrPTo3waBVsoGEni3wJoFg98mzO+4WLFMEr6d96kpkTov6j48o9MOjeNBFgLiDTVwAflERWJmfUaS2jyQ/jrvTYeWYdhF9B++1lAI7Jb3muGv9QoYZIfC+jo62z+C9DQo4C6QkPK6PPEg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 14:55:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 14:55:15 +0000
Date:   Tue, 20 Apr 2021 11:55:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Message-ID: <20210420145514.GB1370958@nvidia.com>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
 <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
 <20210415220137.GA1672608@nvidia.com>
 <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
 <20210419123314.GT1370958@nvidia.com>
 <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
 <20210420125957.GA1370958@nvidia.com>
 <b0fadb89-e875-5a0d-016e-29e54d26726e@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0fadb89-e875-5a0d-016e-29e54d26726e@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:208:1a0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 14:55:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYrmU-0094gO-E0; Tue, 20 Apr 2021 11:55:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2095350-3caf-4214-726d-08d9040c4e96
X-MS-TrafficTypeDiagnostic: DM6PR12MB4944:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4944CBB78D9174305F29FAF2C2489@DM6PR12MB4944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hG9cq6ahwfUuYLQ4Dij16YnLPhlgoKaHapCscvYH8K93y41Pd+Fm/WlNek2ajD+pBInyYAK+WLkt7+F4c2JoHpU+J4rW0LE+als9QBk4nxvBzUazFXIU6LEgLn9PaVbsYXI1Nz+Sa+bRcAijthG9EF6vHEDMqNzXS9oIS1fETCPNbs9XCuwx3uRa6cf4MgapCsy1xxSkFPegyOUo7pmzr8Nbr/DG/KYDcSXXWl+sQFiyccuGF33Y20MMT1ID2/llXY49aHfGgMOe25EsaiCFP7zeuWCr7lXMWqWw6e7B6brA3+r6TdGztmIiB1ibNxFXLF4tSRFVRHkKe9zCgwi4DNWI5bDGMUB0bNk0FdprlFbL62fosFhSUY0H6U5Qe8IiTGPStI2GYVQ1LD4eIZLFlPEtrW9jEYxC5UW5cEmmQNEXl97j697k4xp4MZFWWw6ZisfsSAjnJbRf7x+6k6OFVpKEBjVjyGP7KXn0B0FGRWUuPij9omykjyoEvLYV7mt9Q1Q37R0PhzbnxPUd3u0/Ce/6UtwqN+I25sa8ThTmSpy3E3YgOyVkz7/ul++Kg2QkfWwXcc6KVZGzTH/fJtDrqUTJNIY0qXHrgzU0SBYUHFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(2906002)(2616005)(478600001)(9746002)(26005)(1076003)(38100700002)(426003)(9786002)(66946007)(8676002)(316002)(33656002)(6916009)(83380400001)(36756003)(4326008)(8936002)(86362001)(5660300002)(186003)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?92ds3qn65TBVFFNhMqDVTML5O/vc/+iEu02M6gMGC/SlsT+E6HNZiNiRblaz?=
 =?us-ascii?Q?eMWYHGomW+cqWuh3vz2wOp3mXsxwxnx9DDsLnzzFqo8h7aHkPLbFLeIL63cE?=
 =?us-ascii?Q?BcF3it4j0+IQ6QpJQkoYMf5lwzQgRB8arzItvrPLn9MpACy5CDkc48sQRTPl?=
 =?us-ascii?Q?XS/vIfJIB6Tcg8oxKZhUX9JD8yRtTGcZgti68qtkWjjBs6Vs/AKUfWN49GwL?=
 =?us-ascii?Q?xRIDphvUaEYOJegu2InWoHKjLfevh0UIZXASfwRteFe2B9iOoB+L0kdnJEvk?=
 =?us-ascii?Q?f7Vixdz6jMXk1D0UPxhbaDRG3unMHTnB/NLUeyMcn4sCkEypDRfZSHS9nadP?=
 =?us-ascii?Q?YomysRhqqKr0KSYx/nXJAUZ/rmdbmaU9TEVGYJQvetilDifAGdYSDWB4G6tO?=
 =?us-ascii?Q?qwXi2jFdMplDwUSVJwqqYFzhaM4QGrpvdjdt7EmmJW7rtJnTNHjZJk99CJg6?=
 =?us-ascii?Q?tdqtgp5qEDjgMsj95dAWcMWbjHHc6adTfO8WRunniO6Om68NmPIfYcFAqqM3?=
 =?us-ascii?Q?AyGC/nyJDsbJfbXnPaErfz8bkW8LtW3H+J+60lRgAEJNBT3JZO8M90T1rEhC?=
 =?us-ascii?Q?vAVFyaga1PVfIuJLEp/hOmNHWiJWvZ6fFKg+NGZacrnGEh1InslYOFdOwZAb?=
 =?us-ascii?Q?ZNoM3gp6td8Q4G65NtW0IALhfT0OS/L7X+1dZHAvkDiOJSjIJM0WuLBkdcg9?=
 =?us-ascii?Q?NLr9q9LG9xxIe9Kbrl3hnnwWqfvrsBeUUKQW2IdICQIYY22w6PSck07wrA6C?=
 =?us-ascii?Q?UD4iNssXCQYZj39YzudWDMBSkDkeNhdfteSB8PA8x5xbY/0+x4eT0jlXILQh?=
 =?us-ascii?Q?DxB6+mSkWlwl1X4beJjgwfoFf/841p09n0F6kNGsdcDZMcWrqH2rUHzE9uHF?=
 =?us-ascii?Q?bMScp+qyeTFFJo0xJkZKDUAwQWstbTwWQYhtq56lkf6B6JkZkvaw2oyr5wu8?=
 =?us-ascii?Q?V3VCITArGw4NnsOtk7gQZlP7huGdpcFA5iAkBDc2G3uLSJQDuGB7pNPiSHSJ?=
 =?us-ascii?Q?ntXMT4HoMaPVPA1NmgraRz+u7BUfRddmphTN6/BocEGpTvVmUfHEpo9QchoF?=
 =?us-ascii?Q?cEyIsP4O1qT5V/Q/kiRWyAqho5eiqva+pTx3Omvx1dgn+Ki82qnYJZF+njFl?=
 =?us-ascii?Q?ujzwwkOVzN7ur/oQW2NFLu+gcEW/u9X2RXCMtHyahY3hBOoJPXt3r2OdGdxB?=
 =?us-ascii?Q?InvV0mZ+q7teWL9BIve6ImbCtmdF6jMoFAh84PjLh0M7QHa/O4lVHbLAE1Ph?=
 =?us-ascii?Q?AMdGyAvcKK0+RPfAc7uQwHlreleRZjRkxQ1qEWAXvJU0W56uFQjDgcvN+H0t?=
 =?us-ascii?Q?dEsGwpW1lU/kBxnmd6OeCbKz60GUnUvL6/DRtLY2AAowbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2095350-3caf-4214-726d-08d9040c4e96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 14:55:15.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPqqQ/vmFupcgWPalXkVOOLbVR56WLtQvh0CHmtJ92Pc/l0LQOx8GStwB/UCzBAu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 09:28:46PM +0800, liulongfang wrote:
> >> So, I still don't understand what the security risk you are talking about is,
> >> and what do you think the security design should look like?
> >> Can you elaborate on it?
> > 
> > Each security domain must have its own PCI BDF.
> > 
> The basic unit to perform the live migration function is the VF, and the basic
> function of the VF is the business function of the device. If the live migration
> function and the business function are completely separated, and they are bound
> to their respective VFs, it will result in the ability to execute the business
> in the guest A functional VF cannot perform live migration, and a VF with a live
> migration function cannot perform business functions in the guest.
> 
> In fact, the scenario that requires live migration is to migrate its business
> functions to the VFs of other hosts when the VF's business functions are heavily
> loaded.
> This usage scenario itself requires that the VF needs to have these two functions
> at the same time.

Other vendors are managing, it is not an unsolvable problem.

I think these patches can't advance in any form without somehow
addressing the isolation issue.

Jason
