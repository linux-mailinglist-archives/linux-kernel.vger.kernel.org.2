Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA53641BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbhDSMdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 08:33:49 -0400
Received: from mail-eopbgr690052.outbound.protection.outlook.com ([40.107.69.52]:8676
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233780AbhDSMdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:33:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONPtryD2aUKkkEi0vetLOMa+GjtfvDMCH480YnybyliVRR1FPKiuU/Qw1Y7A2GlNfB2vIPco6qQ+l/Eln6RkjgtpyrKJg7hu/CJ92m7rZXjZBB1Z5xctkIsGPQTlJKmhEgn93Qi08TZcrffk+UFR81QOf8Kk4s3R1PR0y73L90p4lLDusHzIHxx6D8czKLK0dW7K1sOdABzucUX4C8duBpAbmco1EsdihMj6rCz+EuF89wqNhO7VTRp/jhvtehkiNASW31mYPep7BmxpSylly35YXqb0tly/gFv952s7SLu2AZrAoNiK3Xw8AERCWtQZh45IuRnMVbbasepl0lPSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rcyOg3WQ4GN2NAg1cK9xx8q5yLdk9vW5yhrvpU7IYw=;
 b=Jn/hjBp3WqOJhAk+gDZPgW7i3gaEq+8PhtKP7WpJl0sqr0yQ7g9LUZm3S4orUx1u+uNgxZhmdYTTAiZvabS8CGUpINas/WmVZc2xLqTyA5G4myzE/UC+uduaIj2b3FIIpPtZF++4gcNCeCqs1AQYC1Qu+Xmy/mWOqEHXAhbmxZMnY0m2cds037895or0H1ABTqLJga1h3IOOw9YSyjSzdqDwDBbU8HlLLGVMlKGeyMCOUFpdRzL/7gHEud5/obTe9s+gNs0BlcrdHGsCKD1zEjUpfr0oWcbh1jjM4pVcf5hXzteE2oeObJiPWRmNY71M4Fp9+sSb+nSkWn3uQedeyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rcyOg3WQ4GN2NAg1cK9xx8q5yLdk9vW5yhrvpU7IYw=;
 b=kzZejY7edc82V6J5252Fez5uFa9+qNDOZ6ZLewF9Sa0WDeYLjEYet0s5lqHOeUILju56mNU8ByhbXcqTLmYsyKvzq3sJPA12EScMhsGIBcFMtdjeYy/qUOU91QjXloloAg8UCfGfpIQmdq4O7zM7ro2VfL22v80JqnJEL3HdyRMWBpAslb81vQObR4l+oy33m9cQlDFq6ZEOAXqvaCzFGsn+YRRoRaJdoGcyKq86L+kErEXgA2iRr2P9NtVrZV3yen+N/i9nkRXzhjhsciaSnhewd14qNBdJJ9hybdaWWfjk5itQE44Fr9SJNvRPH1YYTVYFaC7+lSGP/OGPbouf/Q==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 12:33:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 12:33:16 +0000
Date:   Mon, 19 Apr 2021 09:33:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Message-ID: <20210419123314.GT1370958@nvidia.com>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
 <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
 <20210415220137.GA1672608@nvidia.com>
 <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Mon, 19 Apr 2021 12:33:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYT5W-008OOJ-QB; Mon, 19 Apr 2021 09:33:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67f90101-0f28-4688-cef5-08d9032f4e37
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40423087081D35492E9AAB8BC2499@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjgBC4o/K7FLzheIkC0uAZovfsCHP5+UBr/d2yXtUnVO0SiQwCbS9Qt7dEYqV55oCrm6dlPw6r/6brtFJLvsaGIc0YGcTU8qXViyngyPV0MMXm/neK6u6yjZbNvYNf9HfoG+KtOcGvQja3r8As8lD15moHjDIIhMzncYyBf+JdU7RoETiYchxs/8X1SGWkpzr3MKZ6ekCkQGD3RPY23nUAmnFIpxO4UxwQ34t6+/k5xGv6o88phPnMbx2zeuRTJ0JKDPtrOHWmiabVhIENfY54xPAOX/qB13A12VtTisjUUkaaIQHV5TIjCQOuqW/UPwZv+5USsZed7zTRQQIvn9pnu3YyFBch5awbWcLV6OnmSmdOgFQ90/YSMhwi8LQKQn5pJMYienwDlzRqzl9sUJXem9P/HLijpeoeDutvcJ7WMjh9h9j9/xZjhWiC5XIPk8GX97w7gdn/fKlKSTYxe7Th2oBkAy49Wj1xZFu6/qtFWDy5pTFwidCrrnNkSVLxf20mGDNABZLvjviwtY+dS3osy8MRj/QujA2XQUcPCbSUzioZ3Px3eprpYlDVTsqkX8e6ZHNGNcGpw+abnwt7R0kLm8ifAZsSuYQ93xV+gGr3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(186003)(6916009)(66476007)(478600001)(66556008)(83380400001)(36756003)(316002)(86362001)(26005)(426003)(2616005)(8936002)(4326008)(5660300002)(33656002)(8676002)(66946007)(1076003)(2906002)(9746002)(38100700002)(4744005)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SHpU7aYBFYoRuJs6vpf2wGt4YAgbsCMxQ/k8jHOFcQKzThYl1RRDHw6vsP5I?=
 =?us-ascii?Q?c5C21aeOhhJtxbfMmwilVdiSeWKbVaKPA1XT2wRYngrI61XnRa1Ivt1M8aL2?=
 =?us-ascii?Q?HC27AJcTq7cxYpbefAJPZRwD3TPiRjAJ6h8kuwncrmqIFeg8SzWW61MIO53W?=
 =?us-ascii?Q?eHnRGM/I47DOJfL5YddHHYAos/+6QEtaiKGmm9GP5S0ckwK70xmtN5iI5TET?=
 =?us-ascii?Q?qG5aU3MKTGyq0cmkBW/jMLeNYCnCLC9zOgZkYUx6nHE4dKZTcQywLm9D0IZD?=
 =?us-ascii?Q?8EHbkDaierk+Qj2lXyCE5mu5Zf8VIqmaQMCPf2K77f1JKn/jEnTAOE4pIero?=
 =?us-ascii?Q?vK3aHV8wyVzTFFTEg4O2gyE4MDWB13k/rNZyFgux7jDSZzLs3YMyJdd70i8T?=
 =?us-ascii?Q?l4IdIcJkKLrUpA8hyapHS2vqZ1UTH67twDOwVlADc9pi6d9Bb6i4AWK2ZQJx?=
 =?us-ascii?Q?9MEdmSfJnYbQ/w9AVKjcMrHy6Xp9fhczl7gTGKnN7wpSrfUOTw/50hlhEkOw?=
 =?us-ascii?Q?oUYVTabq8dOCr0lH81WsTipQE56MWTtDM4FulYBhLd8tKru+bk1dNdVvAXtS?=
 =?us-ascii?Q?KOlRpUTJG8O44qmCMovMWCyXRe+LJWc6yVVV4X5rx+iIm1jZcNqPeZAISvNo?=
 =?us-ascii?Q?g/3APygPCYhXwnnBFqHLENY3Ta4YPWdfWD26xdcP+EWtRvj7x1jpZf1aEBOE?=
 =?us-ascii?Q?8r8Liic4PVJrmYdf41PlJDXX3WXm5In6NWd6/X1bpyW9Ib7kg360QiwaUhUW?=
 =?us-ascii?Q?n2Rgkdas7pz9KgrE/phyPikCWmbL+4IkateKxe9BGAOMBZJMqyS0S+MPOFbX?=
 =?us-ascii?Q?tjylWOuNECfDs88z6ArYLbYp1i+wWjwF3vtFiQUI9pTLVyFEeo1tBzlR6oWu?=
 =?us-ascii?Q?Xmneqd4m+1CC39B8e1pdylrYVYcEGDrBowwaRZe/cXzGbYyPRca5+HH+eUT5?=
 =?us-ascii?Q?qyYtLwifTS/9rhT5v7zv2e7WpHslLcFD1msfcoYyk0aG5XPod8NIdWEcua5v?=
 =?us-ascii?Q?G0xmzSfJz7QAZ2a/tsGiZaqPQASzWTKQtWrW1a5wKlGG4g4noiZPDn6h8Utj?=
 =?us-ascii?Q?b3YQbCoIPqwaqvHcO3WtKx2+2nOiuR2gL2Kr3kR2M5vtQ7Tnat1fSYSmJHPl?=
 =?us-ascii?Q?lxWrm+C5mEHmgLwHa6GQK2fv0AvecFvNvGdZBwwvAATlwXnKmw+n3sSbx4Ae?=
 =?us-ascii?Q?JBlnR3nJDjDOTh2k2BNPDepf3KPhQprFIV6w+AkeL9oXOQE3tIkxGUtttZKP?=
 =?us-ascii?Q?10c5tfDqF7ZSUjx2L64jiafXsoWOXobjKbGlpEVjr0V4ONGM0S1TTy/Y5M3Q?=
 =?us-ascii?Q?fVuIIK+B2wwbWpKTvez2fW7U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f90101-0f28-4688-cef5-08d9032f4e37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 12:33:16.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfDIwEfi2YKr+flSifwC4QTiv8hGcYg4QsPKb+iEf8VhNBMmGDao7JWD1q/4H+nM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 08:24:40PM +0800, liulongfang wrote:

> > I'm also confused how this works securely at all, as a general rule a
> > VFIO PCI driver cannot access the MMIO memory of the function it is
> > planning to assign to the guest. There is a lot of danger that the
> > guest could access that MMIO space one way or another.
> 
> VF's MMIO memory is divided into two parts, one is the guest part,
> and the other is the live migration part. They do not affect each other,
> so there is no security problem.

AFAIK there are several scenarios where a guest can access this MMIO
memory using DMA even if it is not mapped into the guest for CPU
access.

> If pci_release_mem_regions() is not added here,
> The guests using pci_request_mem_regions() will return an error.
> Then, the guest will not be able to obtain the MMIO address of the VF.

Which is why VFIO has this protection to prevent sharing MMIO regions
on the VF assigned to the guest

Jason
