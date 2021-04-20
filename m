Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D15365968
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhDTNAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:00:32 -0400
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:48030
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232019AbhDTNAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:00:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajeFv8p6kor7T+pUcmU9xX56+Ne5XpNMNt7LArAq7HOH5KhdlKAtjkFJB8knRZ4QY2mTtcUJjVK5C8VLHQ9WV1QTh4ImQ2VFjZJ1BpolbQhDvLxROGGjghQQtIWoWju3aj1vGMJ1u65uoR9T8G6gHZisxaCZXXtE7JGACh/6wAd2dQd8yq5SBkIcZCG3EXcBDoTwRRRgHgB74AaGIzbE8f4X38NAOiiK35lqbMfglsaUfBNCouSaw/5BIAGyOfV1BfVOjFsmU7Vauqm37PqZw7stO47ySaD8iCoPTl/pO6GHfVPQpBsxVY902XOMv3W/C2T9suUVXm/RCoh4TqXcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylwy7O6HmrqllIm7tMNpY3v3m/zfkNL6GBiPElgTjx8=;
 b=kjho9qeMSOTJz8JuzilXAmKBxCitwKtC7m1PC1D98PPQGxmP69olhyjy4CGio94Gh6g7dESU7RTweuG0EWso2hiJI4RoqdVUiVM5BMQB+MMmpTLMJEyf1Wsmu9XDDSwJl0aR+GBkEmU/kZ7S/QIHzsLL7NDK+Qnn/xyBoyuJkEUjALs83plkk93JuOF10a8m+Q8kRPtWziI2hoTvaOuYbhBxlgac91b6ktSp7WHvH32iUfHXviaWoS4gC9QFhbhxFN6awoAiPnmnLTyKJKFB7bJht8f/uuEfSLqRUBuCb2753qRr5EfpRhw0J9oyYorv0zsV303BLq+yC3jPTaKPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylwy7O6HmrqllIm7tMNpY3v3m/zfkNL6GBiPElgTjx8=;
 b=K2m37zVKrcoIOQX1tNH1e2xUwwevqPzcEU8aL1+RYKhklYF79fr9qycC9EhM7f2b4hT/2F3vqdXOBQwK5jB8IJUVUGz2/YWyjMCcZ8UTh5s0S//uO0fvKEWglpyBi3GZJNDK8yrDVHu2OqN29lwth4xeh/RyYp/oeW8bszv0tq7beIDaMX4GLWedij367MrY+iYtKmFa6k3Pp+EDfuYaTfIf0KXp6dw5FHmYphFkcz6rg18KSaRYpwFrrsYHoe/tysXr/FO5BwbeNQQ5o37v6yv69OT3ZQwi21YgUgne2X+AUAXTVXM9hQFg9mA9v4xzEtqCXbKLoVUm+3YgIxm7vw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Tue, 20 Apr 2021 12:59:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 12:59:58 +0000
Date:   Tue, 20 Apr 2021 09:59:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Message-ID: <20210420125957.GA1370958@nvidia.com>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
 <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
 <20210415220137.GA1672608@nvidia.com>
 <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
 <20210419123314.GT1370958@nvidia.com>
 <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 12:59:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYpyv-0090P0-4t; Tue, 20 Apr 2021 09:59:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fee89a4-984c-4712-f6a1-08d903fc338e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1657B4BBDA81A6C06567ABF4C2489@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1g85yPqj3TZJAs0E4LttqXRkP6zh6upXhzCYStgO5yGY9HCHi9z/mxzosWhC7pKxuJNe5LOYSfJKka/COMYaTj5zZyegDj1VAFAPdz/XfAZYS57NhWB8Y6ShwySWOTkMn0E/9tzPerAvHszPwNdaLX1otkAkriczKqaNfoQc4p28hgGU0QHAP7JXa3a5JMi/veUa2RxdVFf2lWBZTPAEWDSImr4IMlo+GhOhRLy3ssh3nc85llePvRx9IatN/K9DsN7VhGl7GuzzEWg/FsXJ2AC9OPymB9hRUFLZJN04HTaV0pkPiIqTjMV/kQsq/TcwZEbVoJIxRnUY2UP3xRV+HCW0UrmGm1AW53iKFKz0UectVS4fpe9p9mBm5FvjiOsScgzBdbd1QxjRumM6yoawVjO3RwDwG8C6qEQzyGbM+/XGwaD7sOeXSJKfPjIZFqVABay3nCcqrMRHs9WBILiMaMSGS9TWbZBPIETW3tbo+RN63aHX2Cp55aJkDX/DC1ZX1ews/dMKfQAdvlWQ9u/Ay4ew0HYkVEQe6RIXn2kMGDFM7aFBudmrjXlhQUUvIQQaWLxmkPHZGnmDwMPHF3hRlab0C96Ua/+1ZYK52/f5Hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(66476007)(426003)(186003)(4326008)(9746002)(83380400001)(66946007)(316002)(53546011)(26005)(38100700002)(66556008)(5660300002)(9786002)(8936002)(86362001)(6916009)(1076003)(36756003)(8676002)(2906002)(33656002)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?65uoUKy4EtTGKK3heIKZ4kX80gCpc2lTOjr5v7Nc/U2g9wHM2O5DePeXOE94?=
 =?us-ascii?Q?VxP1S4+O2aDgUyHH3/6K1oo9cvdAeTyjNYGFZepE3fCk7JP49Q+wCLbBzB0B?=
 =?us-ascii?Q?Nb+3PQVnE4A49kAONQbUTLz50dmCZ2MJOHLr1IqZzn0pAEyQaHoOr2E3Nwvw?=
 =?us-ascii?Q?PFKWT9sZxNUkfdsg76Yr1K9WB08P85j3ygtghYpmAwd8nFhPuEcfa60AMMmn?=
 =?us-ascii?Q?xATpYzz95L8RLGXRC/pbJxUSGAq862WV4bnWThCu7NjtE6vsmNEGiS9VyVGj?=
 =?us-ascii?Q?KYLA6N24WHl8WqEuBrQaqkciBskYjvgUV+CyrUa/PgxV/l/LtdlDyfovZNGc?=
 =?us-ascii?Q?DapEbjECuz8NR+PwshiqHvbsh/OmH3N01xPAyST2dDk43d/nOLeYmhEuOQMh?=
 =?us-ascii?Q?GfM3sGSJC2AD64qlrpH3q7+s0slBwOuBwFxqbE388v/2eFYxkRpMrzBMAgTD?=
 =?us-ascii?Q?oTkw5pHVk+Kuh6qxUdKsQtKJxWN1dwrNp3rF1ZOgjSwUb4v6UBacaZqfeStd?=
 =?us-ascii?Q?O96Sv4ZooxTDW/NVR7s6gYv9FJqWpS4yp0zq7kFMpKhFxdmAxw5tNd81dLN0?=
 =?us-ascii?Q?2evB8AKjrZZcmK41jzRl7635XrPdplzynIZiakdkvsk1L2+HXjJihbyj3074?=
 =?us-ascii?Q?12+7eXSLKtuGVq4xEVUP50tFi8qrG1ub8T8bmcSQVSAgRusVnoPSAVrYPD+l?=
 =?us-ascii?Q?UldXxv7XuQWS/2RqtuGtQsE7A02JK2xAHc7OYjlyHTNYDsy1eQ9t1eeHLXfE?=
 =?us-ascii?Q?/+j9T+nvtFy7phNuXccmO/1lXcqwBfdY1BtS6QgXXBexZvTn/C9dqBTBBEmh?=
 =?us-ascii?Q?nJuIBnM0qvt+EA4TfDxIc0tB5X9ZvVUzEMquDIy5INYvA7dqu+AY8kJapRZD?=
 =?us-ascii?Q?rKfGU2/t+D063Igfd023IXawEvFCegi30fEYdZ20RMUTJ6uWHLW298HGaL5X?=
 =?us-ascii?Q?XCXGi4+U03wfDqx4WdMCMGeXM1lrr8zFju2LReZQafz5GuoFV0OwGLS5k7ki?=
 =?us-ascii?Q?AEc8vrDEpFg85Nhjq6LESFn7gSkQLMx6I1ZBOTi3RHwIWs+RZ2PbKNGBOS6b?=
 =?us-ascii?Q?lD67uOHgofEmQg+S6FLD4EwoaBVsNUuvwUsYkck+Afcf3zbI3jsOsR7FbXDH?=
 =?us-ascii?Q?vDqixVeOx6B/GRTJCwr276rZk/zMt8qIJSpSgPupT7E0hpq0rljqswAeSYDc?=
 =?us-ascii?Q?LWqbTiBg2f3rB9nmyrrHfPp34+0fhYuKYdM1qySiWqzdZIzWsTFxJNy4BNUJ?=
 =?us-ascii?Q?ZMbcfNzIxEJILCOflK/pAWDB4bXVTEgma6GI4H4/9zOHLhJNX9bDhPFkr7oT?=
 =?us-ascii?Q?Ulc0rikulksb0/IhFv9fqYUrSyAyw7vmrjc9Zh6aAavfGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fee89a4-984c-4712-f6a1-08d903fc338e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 12:59:58.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3hTwEqmlgY38wlqGHfcCvGTlC+6J+Dug3OcY4G+W7eSbqTBLNnnyGhqIC0iMW5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 08:50:12PM +0800, liulongfang wrote:
> On 2021/4/19 20:33, Jason Gunthorpe wrote:
> > On Mon, Apr 19, 2021 at 08:24:40PM +0800, liulongfang wrote:
> > 
> >>> I'm also confused how this works securely at all, as a general rule a
> >>> VFIO PCI driver cannot access the MMIO memory of the function it is
> >>> planning to assign to the guest. There is a lot of danger that the
> >>> guest could access that MMIO space one way or another.
> >>
> >> VF's MMIO memory is divided into two parts, one is the guest part,
> >> and the other is the live migration part. They do not affect each other,
> >> so there is no security problem.
> > 
> > AFAIK there are several scenarios where a guest can access this MMIO
> > memory using DMA even if it is not mapped into the guest for CPU
> > access.
> > 
> The hardware divides VF's MMIO memory into two parts. The live migration
> driver in the host uses the live migration part, and the device driver in
> the guest uses the guest part. They obtain the address of VF's MMIO memory
> in their respective drivers, although these two parts The memory is
> continuous on the hardware device, but due to the needs of the drive function,
> they will not perform operations on another part of the memory, and the
> device hardware also independently responds to the operation commands of
> the two parts.

It doesn't matter, the memory is still under the same PCI BDF and VFIO
supports scenarios where devices in the same IOMMU group are not
isolated from each other.

This is why the granual of isolation is a PCI BDF - VFIO directly
blocks kernel drivers from attaching to PCI BDFs that are not
completely isolated from VFIO BDF.

Bypassing this prevention and attaching a kernel driver directly to
the same BDF being exposed to the guest breaks that isolation model.

> So, I still don't understand what the security risk you are talking about is,
> and what do you think the security design should look like?
> Can you elaborate on it?

Each security domain must have its own PCI BDF.

The migration control registers must be on a different VF from the VF
being plugged into a guest and the two VFs have to be in different
IOMMU groups to ensure they are isolated from each other.

Jason
