Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5874D33EEC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCQKu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:50:28 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:17888
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230439AbhCQKtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:49:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjWf9lFNZ5BA07xjm5MdoDldtuH9l4W76CT8mpKxD8/GKAmuShIBQW4NTnfa23l5CQzu+AcrVkAgOS8Y7o5lHS97gSOuieetVw8wEBTkNSV5au6/9Vs+EvDIqvBwvhYXO7GyeNATu+O8ooGATCCKtAjqSq1k8lL/RG42Shl8xtF1+cMFgrsmpyMwdCqTJ5a/zTATcI+XzjgL0GwxXvQevke5AygdKkk7NHjUOTaGxrRFABNp3+I7hp9KEDYxclO1rfzgxhbFmRQrUR82xs4o4Y+7NBtvOnkoKDroQmeLvDgCPohqRiclyU2W97Na6nTAmpT1SnGiR2RVE3oMV7CYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RMxDvXMyxWjo7wwhHu7r2pfErUkt69pk8SDWlQrkkI=;
 b=ml8gTugkRQHKFVZqiYwKSNjbTn1ex02DJCtG7aP0HOVz3uWDJHqcO2VEAwkq6YzNAOL3bIDyXEj7BtDKIyGJt74sTzs5pZc4AMLwnEiEg9cjV4LJZXiNu3L+kIHtO8QMfx5DDU+na7rkqzgkeutDBwz8ItDu1bH7/H0aF5SxHOsgm4I19NFn5B6RWNV/0CYtN8MuXR1imwFHPJi1DSgEULhLVIfaj9W02e3zZFYDbtbmiz0oVAMFNCDYmoSLCthrX/Ea6Gs+MhZSXzvOiQCCTKUEM6DcB80g+IFqa97Qu5FeBp2UL08YbyytGfrSUZm/FxskgjUOYAEluBqrMHOVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RMxDvXMyxWjo7wwhHu7r2pfErUkt69pk8SDWlQrkkI=;
 b=QZnLvJJa/56XAoSH17XTa+nG2XM1QwA18hMz5/YowgznKd5Yd5iWCcDsONDDDbCuYyRjOAj7iraco9iBOrBa/zDv0zYxzIr73OpWs5nq/cvT1n6+ObWwZDhQCjNR6xcDk7G5Xm2F1fOqMd+XdUc35JC1f0ldUV5c26YsZ/b2lmg=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1790.namprd12.prod.outlook.com (2603:10b6:300:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 10:49:53 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 10:49:53 +0000
Date:   Wed, 17 Mar 2021 18:48:50 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 0/3] iommu/amd: Fix booting with amd_iommu=off
Message-ID: <20210317104850.GB2508995@hr-amd>
References: <20210317091037.31374-1-joro@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317091037.31374-1-joro@8bytes.org>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by HK2PR02CA0198.apcprd02.prod.outlook.com (2603:1096:201:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 10:49:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 043e488b-b368-4e34-4a4c-08d8e932650d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1790217EBE8FE87592EA4396EC6A9@MWHPR12MB1790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaAjG0IvDMf+pvBZMERAXB0RSEkC2n5vOXrS2hSI0FevGlXPmZosAwFZqm2CLtFMkgFydfbhhrmyWAF3vGFZGclp9LWUPsfLec9jtFXxTnahfOWjalPlZsFOEWSO7FFF2g4LF42mIDrn3AbQro5V8w78uUElu5mgBqjQmj/1X+uQF6fFQcSjIn0Pm/EmLnzOaxfmX6BVGYshZ/KjWbkMB8WhV54fOwzrBhRUppSIoB7l5q7xpnEc6pk93m0Hd2XtTFa1tAh5TU0MGk0xd4FEsF9MeunbTu/HsHWE3Ke4l4FXck9CqKCgxQbgKfHXQ9/FvBLlF+kcuHYHhc4ll+U72kFlzIoKhFhY+ZmBUq/7LgAp4mnAmTO3cby1cZFmNND/3ynFCVTQLM1VliBalNcgMTUThF9ZhewtwjJL89sBakkBJkYI4ka8Ws38BpzYQhsC3yhG6mrqOjHIMjGlu5bNvDJtv/j74tuNXzYzI3p+awN+a3DzkZkZjyau3xPdyWeGc34GtQNwdhk9Jk0z/hs+UoCsDP/lLGG9Ju/+o1WnsbwuYhSej0PvP1LDj9qDhIub
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(316002)(4744005)(66476007)(6496006)(26005)(66946007)(956004)(33716001)(55016002)(33656002)(8676002)(83380400001)(8936002)(186003)(16526019)(66556008)(52116002)(478600001)(6916009)(4326008)(1076003)(5660300002)(2906002)(86362001)(54906003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4gS9oHjQIK1zGWAdtIMvcHQtc2qcGFpAvaiFow79tccJ/gtmdlv1PjycTp8B?=
 =?us-ascii?Q?ezWY97HNIjh1JiUbj56UXNvQhIFHJVS3ktnEhMpl+JQyYXV4aRIGw3tWBR2/?=
 =?us-ascii?Q?O7b+lySTxUv+P6xJkHQSip99eQ7L7VzAHlwGcr8ZEhlHgjhIz9eyDk1o9Gic?=
 =?us-ascii?Q?9WzwAyAwIg+2pVqgeDSqr6tqfmOVMAHP8kzw7ABll41RIoAwNGeC0e8xtHSc?=
 =?us-ascii?Q?JC6u9BcvQqR/m7LYlGVEetqGqOX2VeoS5t9iyEk1nAwq84OMTrBgrRWVpmK2?=
 =?us-ascii?Q?IyCDw52b18EFZVG7lm95hkcdWnPfZwBHVWeyujbshr/VsQ1cvCUDzOIIoqfM?=
 =?us-ascii?Q?vDH4nrQlw3MNPxz8Qtqzfzi/+ADStkyLEcmdIKTGkP9wdBpp0sL3HyHG6RRO?=
 =?us-ascii?Q?53aiSgSiX4ms2M4FuSXMIW//HrRZxeLxn7h1IIHYOLU+uyUJcoA1hnSLk9Ht?=
 =?us-ascii?Q?2gEK9B/UraLsOyvQUB481I//JkaWGXWdGpOz9WyB18feeRoccuFI8cPWETIO?=
 =?us-ascii?Q?rl4G8SNCFgG3yWQeDjmNnDEV7XIll9fCxHvCYP6kTjLgjZb/2dRD6Vu4RnI9?=
 =?us-ascii?Q?06ypTSSce2T3iUZCSxEgXvQC/Mgd4XvRccop2RhJdB4KVGh4PwbGSTKLlOzY?=
 =?us-ascii?Q?SsqK+/2Wk3eF02P2AKy2ZMMtUaiGMYjvEKDvyP63gMnhiumjrCJmiAvqPdPa?=
 =?us-ascii?Q?PrDrowT1vgRQ6zvS53CmwxPK2lqzbovOz3KcTMrKd1GdxvA9hFmu6OM8aHJW?=
 =?us-ascii?Q?LcFlaQdB7vG0zlnAO1eID55xv2g37ft3oWuNiQc71D1sWI+kwl9FXxFQorV9?=
 =?us-ascii?Q?LwzBVo4vFeoVjWSwsSGxT6uPPJdtj+RtCINAWoSA/UuRiIfJnCX3IZagvnux?=
 =?us-ascii?Q?t/RPddlO9citNquIuElZh3vZIN4YFyvNr5NdkmIfgUrC3q40mSfPy5lcXaeW?=
 =?us-ascii?Q?Iec861Gm8dn1sGtvpCNPBDuxEc4bqXNI/PINQFtfreaIJ7zZprctUz551GOk?=
 =?us-ascii?Q?LuVHHz+2LcZHM7BwD56VfEp9bkh6GEoFVWIJeevAYiWev7Qzj3riRJL8WHpH?=
 =?us-ascii?Q?vJ88yrvwYNGXKBZoZ/4B4vxfoVuKOMIUntdFge4ogLmwvQ9g+c07wud9nn++?=
 =?us-ascii?Q?v9/cqRrRa9F6ByYSI3KnmYwFKOohOc/8VIJxKdxKduXFblAgh3cOgn0cNYKk?=
 =?us-ascii?Q?/Ijq2ORkNOJA47+nthPkPDOEOGsOB8S9229bCIs1sArTmf5EpBZx2c+zX/Wa?=
 =?us-ascii?Q?JSfOsmrtQW4wr1A9s2Xv/hiiGn3EIzRbYtAw9G/xSqOGfWP/9tpVvgeKA+xh?=
 =?us-ascii?Q?XDHn3HQsLvrWskGhVNFMBj5R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043e488b-b368-4e34-4a4c-08d8e932650d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 10:49:53.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEFmali1hzRCpg+4/hRDt2md09c1IW2AJk95Rf+VlBbI1wZapQg7fNwqVih49S7WpAkSR5RwcD/XXCDpJ+IL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:10:34PM +0800, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Hi,
> 
> it turned out that booting a kernel with amd_iommu=off on a machine
> that has an AMD IOMMU causes an early kernel crash. There are two
> reasons for this, and fixing one of them is already sufficient, but
> both reasons deserve fixing, which is done in this patch-set.
> 
> Regards,
> 
> 	Joerg
> 
> Joerg Roedel (3):
>   iommu/amd: Move Stoney Ridge check to detect_ivrs()
>   iommu/amd: Don't call early_amd_iommu_init() when AMD IOMMU is
>     disabled
>   iommu/amd: Keep track of amd_iommu_irq_remap state

Series are Acked-by: Huang Rui <ray.huang@amd.com>

> 
>  drivers/iommu/amd/init.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> -- 
> 2.30.2
> 
