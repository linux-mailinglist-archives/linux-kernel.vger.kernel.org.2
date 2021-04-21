Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA903672AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbhDUShO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:37:14 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:51297
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238217AbhDUShK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:37:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmaETYci09PMoz3dKfPPQGvp7oE1IuZ4DJUgqw7G1OeqOLWZPArs28KkV0rgWk8G2Rf/V8VYo6KKrFPwn3lhIONsMfEPZYbCPRUhNGzNP8EN3qc/6PDtb5S7LfRsjQEjoJZavAxO4Mz7R2G6iOX6VdhDWrLzetf8NOeLOCqyogPqVLlijKhAEkby5dsFGyZfQ12VQxmqoE5O4slOKwZNmnOKM8ZM18vFu4bXVWZdQzRcaIXIgL80WQQH83sUC8qeF3GtiKtGw4AynM0HV9w9jQalLK+BgblxL2GGt02PivaniBYWCLP3IpF7bUO2Yih2gHv6pN/H7/82jlWyTQPipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l/tdMwrsYsk/gvhZ4SPv+K2c1wVZIAwxgjJIaWyTUk=;
 b=lbioUoxOCOSyT7xgaUe4P6Cza0yIgQJu6mMV0zcX/uusNzMx17FDNbsuKoB9pMLrwpGEckS2AedM4ZLZzcYhghlPVajx4mpsxR18LS2VIlh84btwBfSJ9uZbsXXVWJJYwZIEKMtKQ/ZSARP0+sOqGpU0vewLPIvQ/RIrNHTSkjipFAxFSRnpE1Lum9x62iWjQI6WStPuv7ODfc0DTql5mlxKFGbn5ifzABL+m0Q2WtVaYgFT5nSgqHrioldLIHksmXJv1y8dIHxHSOfaVS/8h0CA/bkgwfhsnLtkjm3PpBqihzK6kJ25aYrhftZW9/LnucELzWKgR4s1b1fg/iZRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l/tdMwrsYsk/gvhZ4SPv+K2c1wVZIAwxgjJIaWyTUk=;
 b=mBpIehR9sYOsfO12AzEHEdS70mQDQi0GnnMTcnLiSg/hE97ATatxjgdMcwUvpRpVDfUVahJf1Fk+wcHccIkM/SLTJB+M88f6VSM9GD7eLP2Couym2w7gbc6047Ml2Z0iqbF5YtIJ/3wmJyF5zA/kYNTU5vKnoD3vGJ94UNsOELTrhQAQR3E//oDET7VL0juXdxo7GNYPc76JIKtKJBCagCxYOXLz6yJux40+CQaikFAXt0b6leQKbCNCTgyd2onExzVI4FnMdgP6xvlSCNtNpevRpC98Z6f4nE7RwGiYo/UrJ0GEQrIfpUvj2Uc+h2AzTumXq/gkyKBRZw9OSf1Ddg==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Wed, 21 Apr
 2021 18:36:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 18:36:36 +0000
Date:   Wed, 21 Apr 2021 15:36:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 036/190] Revert "vfio/mdev: Fix reference count leak in
 add_mdev_supported_type"
Message-ID: <20210421183634.GA2290758@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-37-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-37-gregkh@linuxfoundation.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:208:23c::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:208:23c::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 18:36:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZHiE-009c3j-Cv; Wed, 21 Apr 2021 15:36:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5cfad06-69e1-4598-2cf5-08d904f464c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45001F7074C1743DD42C0250C2479@DM6PR12MB4500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCCl5Bo3ADFmq0U1xnmAaRa5UjtOtA0WQl7aekmZEjDCIxDo+Zp25MiKtqM1Ty5PNfiROWMQfOIAki+4fxo0ouTr46tTYvIYWbGauaw4WL8GwNZv8ECvPkqzOeoj9KOUdHDR1wBK8q4dugrvJ4LuEj4zYHzbVFm1HzVexTSjaj5x+VZ36BjfQL3VCI++cnvE+VqU7dueajCneCvqRVCD0B6dllbVb7eV/nX0sNLs7emYsik0+Jn/NnsWwVtkie6GqMIxDJcEdLSoI2l/PSCiOAS50Ztdsa6k3LQlYZOKYtWQhPd4l3ZNvO2bh2BgKC0nhX5sVF4X1Lqu7eiP6jgcuAVmEwVgvKUfG8L6vIR7pvKG4fySm4yspC0T5Fsth3AWND5p797WHh+bm0wtPck2RBOv9RiT4csn9WzsvJRkTDr8vxmrkonctGG/4hoUudhTJDTo3UMjzucMiVhgWZtl/f6oMiK3BO6++jC+dYVZBk+4gsliGZLihFuspfxs5Uf6BL9zB+gvv4Dv3Pk5TFOz8t4H6fHndK8JJ0zDIU0Co5Seka4Q1PYvXMPF+AGSgCjm9yUBgm/4fQ10X6U10Tv5kUVJKmAwyMwZjzlXFqC0y10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(4326008)(9786002)(66476007)(66946007)(8936002)(33656002)(9746002)(478600001)(83380400001)(2616005)(66556008)(6916009)(2906002)(26005)(426003)(38100700002)(86362001)(316002)(1076003)(186003)(54906003)(5660300002)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HipedSezakbVQG613Xlhjo21Ffx0jw9VywH7TPh/r5Or42LUdlwIa0Fz8qjo?=
 =?us-ascii?Q?evNaz+bjtAOuR4TSOgnKh9VLUIkumHFW5oox4bIuZesb4gem+D3xpZru+ljB?=
 =?us-ascii?Q?5UOs0v+uuQ8MIe+la8DnpfqN3cZdRFARVandplHW4Hg4sOgCvJyFo7dJrOuw?=
 =?us-ascii?Q?hMdyZbePYtICJsefpOtyLcHSOFi5HXIwKnsSSigkcVuKUxEBuRlNjIv9hdjB?=
 =?us-ascii?Q?xmOTjgLUU+k24sP/N3xqyfzySTNqTzGtBhYcGQY9MJDJ/YM+UMHytXSHNvY4?=
 =?us-ascii?Q?XEJhIgxKRT52U2DDeJlF7oZXUgsqYtGllqxI19L1Gv1ErdAa+S7Kk4Q6Qdbt?=
 =?us-ascii?Q?Vo3IO1+rsOOhDAiKbwj5ty3AN5Fkdr2Vu0/sF4swTSsqpwf/oeXCKRwov1Yp?=
 =?us-ascii?Q?TornM7+2ncFDrr15cCPFE1ekgydGCIo9QBlDSmFmuxxCU6gD/aRMw5v6hVGA?=
 =?us-ascii?Q?ExCYrOdvbCIPUi3m0OtgKy+TC1eRQmzXaaeY6qVfzJV1LKbZfsdSrwE2u+O6?=
 =?us-ascii?Q?528PJ2vK1ePSdfbuigXuiZmhsyUOvlksttyXxqhnHam2yVhPg3PGcxZU1qou?=
 =?us-ascii?Q?iomggDHIjI9ubdOFezwpEes5QOFGt9g9Y21UF1vPFkgA7UqdpWDjIm7nv3TG?=
 =?us-ascii?Q?4cDWiuhwH5MXXsXJlct+XBMOR8J+RV1KotZU6w8UDGZ7KzwalsEMg4t4cg2A?=
 =?us-ascii?Q?sdJObA8JB6X9fKSLVm71t95B9vCZ6Uzk9s1OrBCd5nVOOfSd9xaJ0UyXr5MJ?=
 =?us-ascii?Q?D0lC+gUTslXhNRFU2iFZ/PIXwwf2VRk+AiEUs/DRHjvkrn3vZhPZQYnk8NrE?=
 =?us-ascii?Q?hUNDaysYkntd/F4qv5K1FITBq4SJK20PR8NswfK2TtN0qfKuFpSMCQLsOxcr?=
 =?us-ascii?Q?NXsuhY2Skso4xgYjNwBqkxFZhf5aMNDFG0lbadBOLPcDCs+gUIy5k9mxhTnq?=
 =?us-ascii?Q?YSJF+jtBCX+562Rneo4XSf5ZcxOjjvH4GpA7a3Ms2ImMLqyU8xPLiiX/wGt8?=
 =?us-ascii?Q?5oY+3i+ukxN4Vq9ju0QPtu3G/Iro43F8ZQkRc/dFo4lS2CW7kZR4aOowALPr?=
 =?us-ascii?Q?w4jdU/Kb2wkw1SawyxofIvlbELZdpmRH8oICV88SMVPK91gDXIEHzJ/vozHj?=
 =?us-ascii?Q?5Q3Kp/H1eW6Vo17i9R6AbjvJkXvrH04bokKE5aL6zs+HtW0Yuxvzg2b+6YND?=
 =?us-ascii?Q?bh0A5BwtMOiX2ksSvrWu+uVa9iHbfn1lcFI3Bz5rEPLq9LfiWORFckb/eGRR?=
 =?us-ascii?Q?sWxgWk6yEElrTj9vl/r9ijWtK7XGApIoLE2VPjkcwnI/s5wnrCps7U7fe7pp?=
 =?us-ascii?Q?FgbI5E+uBLgssGclVCR5AggP+tIfAaeCgqvPAJuLb67LYA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cfad06-69e1-4598-2cf5-08d904f464c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 18:36:36.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CiK8zcyTIicH14zKBGh0g6IYMXnJuAVdaZcTYigRsGAB0Ydm8yVWwKCVCcX/hRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:31PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit aa8ba13cae3134b8ef1c1b6879f66372531da738.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/vfio/mdev/mdev_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I recently audited all of this mdev stuff, the original patch is OK,
though I would have written it with a goto. Please don't revert it.

Jason
