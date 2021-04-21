Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D3366DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhDUOLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:11:19 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:48033
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236011AbhDUOLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:11:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8IPHy+2p/3Y0n/acLeZctkViu20TCMRTrcniY6v4/hUkbhL+2Jki004Vjeq+aL0onaSR+hUSBaLXTNrwmeLvdQdQPcvUyu+1ATbPFq5WJW6ODnzCjy42K9TQzp5tpjEHCbzKUqJEf3UEA1YXW3K0SHuN7wZGWof4Di4q4gsT1Bpo+QbzAipEhvOjAOBcELF3i9rYoua12SWhls7C402RCAEUUqYS9TzI1ASV2S8mIbNO71uwWHaSKghCOzkVVUctf/1fX/ftWV/jtSneCyc69Rv9GrUDJDOZm9KC7r/tA/TBjgo3Kc+gPpfhsdz95kPEpN7BexJb6EPTidIbydoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRJydwv2gu2Ki8BWpRFOvDmzOYBN8fqq/5qIh68R/kE=;
 b=FDB48jYcx1fikL4tgFLD4pr0gTalp1MgzpcKsTHTUu9lD5m2W3P7deWJUbRDgkgOq4JGkf8O+xYX906PrKjZ+wlxwUQDCcxoSRoPy39d1duuTu2+ogw7PAiCnj/b2vsZCe8uPijLfAINbXhiYIEf8NN2z2r0TTECeIbgZeSR0BY0jGLtNIaAstPNRcP2es2mEHr/5T8xEqhlV17PmP2eP1nxwjCVXGJ8jia59suwy9L8l7fOvxFQLuy0FAGH73+DfYArrzThPSwEkiNJ8wAeMVRYi0KCI7oJ9FZYbEOwnPgtWE6YSMK9raJg/ZXiit5MavI/VaJVl33hVC7cEZ9fFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRJydwv2gu2Ki8BWpRFOvDmzOYBN8fqq/5qIh68R/kE=;
 b=dAUEPOwxBw1Hs6Eoxer5aIkZ5L84pvB6pYX1rDOCDL3uzYPMgzl0FMIHnvp3yn2rWxZb1Bpw7UvF2NEX9jTo8a9dWbLlbsI2xGelTXf1kIfXeuY+YYZc5gG3cZKlfiB/RkizZwRcHL59skvevXlF7X5nneW+mnS5cJEiRxaW2THEqmGc80xQoJvprJfzfYsVDuM80b3MSEZs2FqPkm5/aWRQbBldvvvyhRUigiMnPM+9YOrpd8E9DzpK+4IDEqyzLdtTHIeoOAOQQXGCZGvH4PlcmkIMm0k4sq9PwIWqE5IIMWgr3dXQm7dhqRzzBkCwy4WoGTJEhFc5Ftrot1mV6w==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 14:10:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 14:10:33 +0000
Date:   Wed, 21 Apr 2021 11:10:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 044/190] Revert "RDMA/pvrdma: Fix missing pci disable in
 pvrdma_pci_probe()"
Message-ID: <20210421141031.GJ1370958@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-45-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-45-gregkh@linuxfoundation.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: YTXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by YTXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend Transport; Wed, 21 Apr 2021 14:10:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZDYl-009WOt-Ar; Wed, 21 Apr 2021 11:10:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d91ad266-2699-4a7f-4104-08d904cf3a03
X-MS-TrafficTypeDiagnostic: DM6PR12MB4973:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4973CF75AA3B5D9A27424F03C2479@DM6PR12MB4973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h5hsMP9p/+OKw3YW+p5fkZbcGS6H4vPoWsKD8r/wKNhKB/HNbalnqVtguqF3NMtPMVKv5RSNPIvAQyaAhov14odeWhjhUS7J81WJPQ75wcTNr0fbE1a0B6UY6Iht9Cj+j7J19XTMNJTv+OKTSpyP95kWuiOU15TXfSQJvWOEEaVnhu1sif6Kr0OLtJdA6j+FP9KAlEKG9pCHBDvA+gTT+M2pQ8oH/77GArZ234XbFTFJX7ZxpxCCh9h65Bij2i/Rs3Yz008k4L2xT9mmD+XreGm2zULmeHVKz2/g+3A/UvntO+tEzl4uuRQPa2aL3yUqAyRirclatkQ5i+eiyEnLPUwUvbqe/C0Qj1G0f92iuWR5Ma+XgpkrBOsasxivpR0waO5lic7xd2cogz8D5n8wCcEOE35NvaXixeRNAPWsQyxOs74Lp6SGUOPQf2Pv05Kv0Ty5uZFOZjzqa36aCu0G7itbVX5Bc1qwnWSdpVOcotS1H1yiBZjIO7/VsnmakhgWxGfEE/DTgkGzk4dWR3Y2oUCXkjySiiE9AHyDhlQJphTwGADhX8OcMgK+0O7Tb3c5r7zinWyOyVmEn4YSJq1APXdVVb2hAWCHH0BehBpeu1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(9786002)(426003)(2616005)(478600001)(8936002)(66946007)(6916009)(33656002)(5660300002)(316002)(9746002)(26005)(38100700002)(8676002)(2906002)(66476007)(186003)(4326008)(1076003)(66556008)(86362001)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5QLJMYV0f6XYyPGm6pBuPvDgDooPV793lZWagajuQBI0E8+rMclnP3kDQvui?=
 =?us-ascii?Q?m8K/Vsjiq51qZ1I+7qb2j7m5EMNJNkdogdrCbn0t3A3m2Zqy1Na+GAGEgP47?=
 =?us-ascii?Q?KPXYuHcHVg7zm9joX/yGztYoJUGuLP7xPXxRZZMI1UwhgbEZq4fteLroRn4L?=
 =?us-ascii?Q?9hYFd2oqS+p+JFmtTcSUwn9fJbMmUro2kVbLXD/9J2Y3d/1oHb0hQcCzmq0p?=
 =?us-ascii?Q?hPTAwAJTrzFC6i0VTeMcVvwnBSJpM7H+UlIkp6zlDRr/X0OwxmFB8XpGjc88?=
 =?us-ascii?Q?EwJ6jBHcZ74wirmCKDgPvQEx4ksjiafl5x8cAP9c7muQ9dME62cKt9vWkLAD?=
 =?us-ascii?Q?ZS4/1VTjQ9rXTPGVeSoIPy1SwEJ1ZJAO5bvC4UgzvI1fvuzS7Xe1vENpGq3M?=
 =?us-ascii?Q?X1aNBp4UGPtD0K8njlBw++HyGQwDnrlMcEc/wzDWtCbLWsG5lx7xxBdL/K3O?=
 =?us-ascii?Q?rP3BEFGSqW01Qh8CaC8u5pHW5u5Bn5guVpQP/QGijmlq8+IZvOt3ZqSDLen8?=
 =?us-ascii?Q?+UI4GjPxZvmXVKiX+/1Y3t3hssCeUpaqGAKwRrTwR9Td/C5Et/jx0qcd+c5j?=
 =?us-ascii?Q?P3E1TLTi4Xhhq12cnXsrr94ZFxwFVACzDdto1CDT7JDDcSyYxT79XghAqUjo?=
 =?us-ascii?Q?4COjb+Uzo69fUGQTJNftCIf5T4eSvq+w9Q81EYoOoSjc4NZZPRs6nLWDZ13l?=
 =?us-ascii?Q?uS1cJ0XGqEtMIO9nu7rlXXckpl2+8Rx3mbHYGCa0wZzw6pthTx5o+7uMVVxG?=
 =?us-ascii?Q?F+rlHoOt33NFl34vLAYEG+Vm6dVUmJMuXQCUVhmYCAKTY1Ke0jwBbzfhNn/q?=
 =?us-ascii?Q?NMR6T+gFyMmB1tP+gQMHumlLDg8jC2glKpWHTQef8L7wfl4fxXKI0vQnk/Fu?=
 =?us-ascii?Q?nL8cZzF6jAmfN6lGzCInx4snnDqNVpV/BXV9ZaYAFPRI3ql9Xp2HCwXBGpmX?=
 =?us-ascii?Q?sGWQFDKlkPylHToBtVT55QqpDeZuiG3Ea3OLAqyWLprq1OIQY0jqLmH2V011?=
 =?us-ascii?Q?KVrWupamlRHwir1CBVw30UJJM4xPjeVhPqSGw1H49Lq7APoTE6otOjPdkCw7?=
 =?us-ascii?Q?jTHeg3axQk6jMNA7eFpAnanAGB7zPRBK3TTfAe4Q0x1mNHP0Bzp/VRenVifi?=
 =?us-ascii?Q?W9s8eNEV/Nt7YmqYDygsSLGTXdp6Lsg6kpYaz8xCLy/550eT4FvlWAOT8PwP?=
 =?us-ascii?Q?GEMNT3Ue9qQxpbFM6w4/EGk0bUlws8vhDjPM6tYyraz4ug5f5g8FI4pDovyi?=
 =?us-ascii?Q?502l3cVIxTxxGIXrcVX4VFA/ItlKnkHK3L08YqMfKb2CqL/vOQ85c+hoklLc?=
 =?us-ascii?Q?8mZCAzp8YDoo8T3YKxQ9VtW65ucXl/jNJ3sK5twqsgYgEg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91ad266-2699-4a7f-4104-08d904cf3a03
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 14:10:33.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SEVTDGx/but83Cr2romBgA8IpMiHIXumnwpjb528pNpv9IDSS+ghUduRh/4bltu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4973
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:39PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit db857e6ae548f0f4f4a0f63fffeeedf3cca21f9d.
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
> Cc: https
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Can't see a reason to revert this one

Jason
