Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F229937BECB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhELNtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:49:04 -0400
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com ([40.107.93.45]:51960
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231420AbhELNsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:48:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUg9tMUlfuFOt7hhw71tRqYZCvOotXSVYS3RUymham2LPeWGOOjFQiE4ZYTjLaVg8JmF/1y7t9LmUNTRA4GK7YgonkGzDU7pT9UBJYJfA/Pv10m/w64YX8VWjw4nICZEp0gm1zFFHi2g1gGTK4GjOadoZ24omVHuz9DLdonOwbMsY3t9a9pp2vlmarVN2Q2cZVbGk0ZFPaKt4JrEJPJ7NU5tXbIFRsupAtTd7k5luST/X7WpQlrQIxDI/Q8LXBCIkC6gS7cl6xut7TjmaxckwNFrCR+z5GA/RbJD5easGZ4uJBQ5xUhnjklVaaKPA0qQH1vX6O2Ac/v1Q12Jrxx2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=892jfKukBggJsah/MD9xDYkivttX/4uuiqsGJQ5BH30=;
 b=cFZxaNfin+tFb1XoLpLBrKIDLKMqVSkdqaqkIZLVgu8apbZlIdO5Jx10FnSCwYeX5gOqT8wyU+BHDr1vK2uSJLylijaNpWD5xVqvJl/feeSpvWWrX+E5kEwOx/oGsTZv0Akuyha5wYuVU4FljLbBpCdHTfUy+4RoUwQniKNAHvhDQKIfD9DFbcsvTiE++WKceF9KurDUFsQo/WnliMmYcRCGlE5JoPPwP/IaRHbjhXk7z3d7NIfBkkRJwU8bqfsOkiChRh9qIIJ/EweBZrOCHDrccHfIdYQiRbnG8IJogMn2iECSvHAUPnqi2tacLRtDQ62skgVvKkuuSxl2Lb1zWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=892jfKukBggJsah/MD9xDYkivttX/4uuiqsGJQ5BH30=;
 b=X86gleBD5J10uR85AluIsKFz/ihFiRzb2/nBrHhtQYZ/1ESXUjpmnwEN/KUp1mx4CeIOtzkOIYJc+Zdbm+5gJB/ks1pUBe1+2rG3CHPXfAzy3aD/RaKmyIO3Iwh4JQUEWB88mPWCDtSL0YhpAV1/DCubd28PFrSLN8XHo1OGLWLnfY++Ig2JyKNM2sRYJZ0mxvmgUr5AmGHDYSEXMhgvz0wugekezLF+bri/3Xdclm2VYcyX4XH2XzVmriytAeCH+7tB+HxelKojxPYCiztTbcrds9zO5bnnc3mZswfKJ7fap9TC/ZPYUYw0C3yizvyQgU5CnQw4f7/5uEmAl2qWdA==
Received: from MW4PR04CA0253.namprd04.prod.outlook.com (2603:10b6:303:88::18)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 13:47:32 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::8e) by MW4PR04CA0253.outlook.office365.com
 (2603:10b6:303:88::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 13:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 12 May 2021 13:47:31 +0000
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May
 2021 13:47:28 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
CC:     <akpm@linux-foundation.org>, <bsingharora@gmail.com>,
        <dan.j.williams@intel.com>, <daniel.vetter@ffwll.ch>,
        <gregkh@linuxfoundation.org>, <jglisse@redhat.com>,
        <jhubbard@nvidia.com>, <linux-mm@kvack.org>, <smuchun@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] kernel/resource: Fix return code check in __request_free_mem_region
Date:   Wed, 12 May 2021 23:47:26 +1000
Message-ID: <4030894.8IlaYux4iE@nvdebian>
In-Reply-To: <7f86af3c-15ba-6ad4-8f6e-1e814a6eac1f@redhat.com>
References: <20210512073528.22334-1-apopple@nvidia.com> <7f86af3c-15ba-6ad4-8f6e-1e814a6eac1f@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7d054fd-2ef9-49c7-e512-08d9154c7d77
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-Microsoft-Antispam-PRVS: <DM6PR12MB435576801AC93B03A0A439F4DF529@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cICEC9LtBUoJSpv7FTbpOXGh4R8cff+3gkAYr9SNSKPa4gu9/PVZrTtKP7T5g4C7BRLpCcgEry6XpYv7RnK88cXG6N4TF9eAN2V6lf3m8ihySrsn2ImUEFlLr4dEDduJ1aPt4Z2n67/X7oL4EvX5SRX9GoTUQjFQPvKFcmcOGZbhyfbOkPCnDt2rIxJgW1eL1BpiMTbGvRYDaB8YyPQTRkLbcCglt7NzJ4sLmcsrkK3tEUs8QEICic26oR4UUmTBNFt8YD5O6KipNvIf0sk27nKtj1BA1IMh5lCBVNqtbhpFWyCZH12ezL2j8K5P9YEJUP37v84AGDa9k8Ag99Th01CK8zXMkoByp+90Oc9UxObK31+zWZllcfk1faN2gF0BubqJoYV/KdRI40yp1b7Rx22+xBaAj49ud86/EQjs3/i81QPsjTRztMxdrzUAsTOdxzBZ/IVFTYG3PG0AHeDxmiQZ2calLm6kl0JNNicpYSbwKp1x3hEqCD+xuA8Yi9u53SNCZbL3OstbXS6OL3v47FhvgTkkOLNIMLwROoHj7C1CK5yu8KhvnVDi6QQJYdk+87tZa/4oN3VJOWpHBPXSdmUu2C9ek69fzIB2jHoXAct2heX6++S814ReTNlvg8y1YWWvllXmq0ctQIUAY20CCbb8XkSH+6+1VOjC2Kobm5GbvuCNESLLObHt2o129YV3
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(36860700001)(5660300002)(2906002)(47076005)(33716001)(36906005)(70586007)(70206006)(7416002)(83380400001)(54906003)(186003)(316002)(16526019)(53546011)(26005)(82740400003)(336012)(7636003)(356005)(86362001)(426003)(8936002)(478600001)(8676002)(82310400003)(9686003)(9576002)(4326008)(6916009)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 13:47:31.5163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d054fd-2ef9-49c7-e512-08d9154c7d77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 12 May 2021 10:16:41 PM AEST David Hildenbrand wrote:
> On 12.05.21 09:35, Alistair Popple wrote:
> > Splitting an earlier version of a patch that allowed calling
> > __request_region() while holding the resource lock into a series of
> > patches required changing the return code for the newly introduced
> > __request_region_locked().
> >
> > Unfortunately this change was not carried through to a subsequent
> > commit 56fd94919b8b ("kernel/resource: fix locking in
> > request_free_mem_region") in the series. This resulted in a
> > use-after-free due to freeing the struct resource without properly
> > releasing it. Fix this by correcting the return code check so that the
> > struct is not freed if the request to add it was successful.
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Fixes: 56fd94919b8b ("kernel/resource: fix locking in 
request_free_mem_region")
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > ---
> >   kernel/resource.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index 028a5ab18818..ca9f5198a01f 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -1805,7 +1805,7 @@ static struct resource 
*__request_free_mem_region(struct device *dev,
> >                               REGION_DISJOINT)
> >                       continue;
> >
> > -             if (!__request_region_locked(res, &iomem_resource, addr, 
size,
> > +             if (__request_region_locked(res, &iomem_resource, addr, 
size,
> >                                               name, 0))
> >                       break;
> >
> >
> 
> Ouch, missed that, would have expected this pops up right away when testing.

Yes, ouch indeed. I am still trying to figure out why I didn't catch this 
right away as well. I retested locally and the HMM tests do complete without 
causing an oops although they don't all pass. I guess I must have been in a 
rush and didn't check the test output properly to see if they actually passed.

> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks, and sorry for the extra noise.

> --
> Thanks,
> 
> David / dhildenb
> 




