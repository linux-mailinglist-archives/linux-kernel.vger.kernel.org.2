Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E20325B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 01:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBZAye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 19:54:34 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60204 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhBZAya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:54:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11Q0nhr0127523;
        Fri, 26 Feb 2021 00:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=Kb9EKv1+vjophlabu4h6cyfCw2t49KeLn7BKmTqfXXo=;
 b=pOLC2MLT7MONJHPeq1IIeON1juc/b3lQYhlttqEQN/+upFIpiE/Q2M77QCrg7gQuxDa6
 uY3fasKn/S0YSSOG4tGxcPADRDzPugz8NGptt/DYiDOc4nCGJ5ZSqCPhQ6vMOs3q90R8
 v87AiBnX1Gr2sdOO0o5GZT2SK6+friJDbDLHj+Vv4dDdlFsPakHgrpDixtM4M4ExVneg
 XC2SHJJjmPWQL7PHTXcUGlevHKZgEctL8+BQ9smc1Caxv/Cm8mEBZ16b/XC3zrnlmOB3
 yM+yk4ch2XxfcdRLD2wv2Y55Csu7rsdIJib+hKtEpIbxx4EljvdKJfFiZ8fRktiYbfZl uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36vr62as07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 00:53:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11Q0oi1f111196;
        Fri, 26 Feb 2021 00:53:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 36ucb2ryyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 00:53:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie41xqrWWCDzaPaNdJ1n51NAUUX0uS0MEi+h4yXGu20es7rqfdDV3RuEKPt3Yykpc2GtbFbie2w6ZaKj5/E9ECf1osh7qzSJ0dq/+jEzhwO7w9JgwRXIGnpZ1VX512FG5ySoSse54ShQwrKX+g+lM7UkStJN3vMLjJ4YE/pSwQX/O9z5uDHCrMPByGJKVX7FcM2iSPabkU84Ce4I8kBo3Qlkx8sIr6oOba254dnfqYYalXh7TFXrDhH92HgXJ2zD6LNuB1EAK91XrBc7acPto+QiPgXx9L1utWZuo81xEoK/0TVYvsK4gER6HjneR4Ks3tlgS5C5pAmtCDvE7CG6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb9EKv1+vjophlabu4h6cyfCw2t49KeLn7BKmTqfXXo=;
 b=I7nyCB18D0fYkCDyJoKaLEFDccT831PWCfUsaMm8X6L8tSpzrf9+OF8ZgcBHyZYps67Aa/O29SQtQ+NRMpnsOqXW8f/bsyEqRKtnViUqddD5PG5XUupN9aDQMSrO6BShUGdd+zB4rmi+45hvb8TTuizqFBjG+EQWsHtVwQ6keX7bF8LED2ZxmXZofjO+4SREZP9udwNoMT8/UVUfNfkRxajiaS9+LXkaXn7Uc/dgFJ/XMB7dp2bUHvJNdrj25Qg+qvstqWt9BAa9yh5exqL/hlF8saWCfqzPGY6vv2tDGVrNHRagMWx8qlePPmH1IQc4OVpu3agmkwg7rBVB6IRhiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb9EKv1+vjophlabu4h6cyfCw2t49KeLn7BKmTqfXXo=;
 b=ncauRgF770jk38qjIiSMfLBvzNlH4rwJLaejJYzdW2PHHAt4Kwy6RG2m4UK43VamzNNuyNI9jvRnXoD5WX7jKOHbSdMvLxBxTPX8GcFJ7D+0I7Zx+swZRy8/PKZ9scNEJpF75oHjB+VQsGoZFxkXsSyY+2Te2094TA6SRo+zS4I=
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24)
 by BY5PR10MB3955.namprd10.prod.outlook.com (2603:10b6:a03:1f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Fri, 26 Feb
 2021 00:53:41 +0000
Received: from SJ0PR10MB4605.namprd10.prod.outlook.com
 ([fe80::a021:790:7ce6:6f16]) by SJ0PR10MB4605.namprd10.prod.outlook.com
 ([fe80::a021:790:7ce6:6f16%6]) with mapi id 15.20.3868.034; Fri, 26 Feb 2021
 00:53:41 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     bbhushan2@marvell.com
Cc:     alex.williamson@redhat.com, ankur.a.arora@oracle.com,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        terminus@gmail.com
Subject: Re: vfio-pci: protect remap_pfn_range() from simultaneous calls
Date:   Thu, 25 Feb 2021 16:53:33 -0800
Message-Id: <20210226005333.1576246-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121043907.76037-1-ankur.a.arora@oracle.com>
References: <20210121043907.76037-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [148.87.23.5]
X-ClientProxiedBy: MWHPR14CA0047.namprd14.prod.outlook.com
 (2603:10b6:300:12b::33) To SJ0PR10MB4605.namprd10.prod.outlook.com
 (2603:10b6:a03:2d9::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prion.us.oracle.com (148.87.23.5) by MWHPR14CA0047.namprd14.prod.outlook.com (2603:10b6:300:12b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Fri, 26 Feb 2021 00:53:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1aa36ad-7317-47a4-e752-08d8d9f0f598
X-MS-TrafficTypeDiagnostic: BY5PR10MB3955:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3955E50AADF29A86D3496EE8CE9D9@BY5PR10MB3955.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41M9eKLgQbtAr0WYPkAqWdWum/uYRaLOuHYHrzJTsQ2n0M7MSa3rWmTydOYsNQWvVfMvPnDXmrDOYa1SvLgX/gVVW3bvKxLon1mkusRTbavouiq4W1Q3hHRiPcT+zq3aBYeg8DAUzbblE7lpyT2yqcTsoPt8Rrp3yU/pgqXmkJYLVeq2yS30djRiw0N4Njxt4Lu5L03lzJ4zKwpzw3zrB8XHQruXbJXJXqA9J/wlAFFm+CRg7O3Q6tlTBRBDfZ19NjI2xHex7mEpCuCYPAzNdeNIUhVX0YCgSb204r5SspBbrsGlMFAkBacuUS9EWBumWE9lQG1g8fUSUPXObQfQVpgKYrZ5+wT2BE8TnUp7iVLUbrAyb71B5t0cFfRQnnVl/t7QhG5nPZ0sWUZBFO7fnMNrmAfFJ7BF3qFO/6zplV+uR/PMMaegA3AogBybz/8sm0rk1e3n9ZmZHKw5jlv84vRau8105DEcb0+UYnY+sKIjOqw0iUvve3UdDjnVZnMTuyzfbkpFFhabKDrHN+HgGZBIXhedF9UwP/Ku7oW3mzmuH9sJn8BgPWCCjXbTY3mKcDKadecnzZ9yDrgYCeShgahHOsp/w/qpKQvfES2VGNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4605.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(39860400002)(396003)(346002)(8676002)(956004)(66556008)(6916009)(8936002)(86362001)(966005)(7696005)(52116002)(103116003)(16526019)(5660300002)(478600001)(2616005)(6666004)(186003)(66476007)(6486002)(36756003)(1076003)(26005)(2906002)(66946007)(4326008)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K92+TIygpi3vgqSeoRbl+M7ywj+Gb++TaWGpc0UdKFSobBleVns7IJGoaCfl?=
 =?us-ascii?Q?6Xuf4eOckd4vqchZ/7wxCi5izPfs14vHLy283pM5qSl8g5b7C+Kuai8SwJsD?=
 =?us-ascii?Q?eiQ3Wf8c/9ZunUm4CDx91WSAMaObjDDESiAHJrnG7gk0NZeeTsm9EwVrjNe4?=
 =?us-ascii?Q?gUrLsvsviJVuNipIEecs21nPXxwb3/oxS3djuDABY//TUhTl+cFwI/1GbpdV?=
 =?us-ascii?Q?ZPrqV+1gJ0AMao42EcxZN8z0JX8jckMcSj/F/d0MiI3bLJ73O/xpTXeXE51d?=
 =?us-ascii?Q?/WspeRTAcIWWo5t3GzSXgJNvtFtPmc5usnCs86gmB4Xe6j0tEB0MquM2Clro?=
 =?us-ascii?Q?jiMFKoCbhHzhN0Oz6UpXrn3r9spmlEvOVGmMWh6G6RuVqGEcTYor1rsaZTbN?=
 =?us-ascii?Q?d/31snDj3WGaHY60jgo0aFsqfSYZdghesQFPsUeXsypk6gQtatFE5Y8jwIjj?=
 =?us-ascii?Q?OmWQ5UF70IIQzRgpMIc7U0lQPJi4E2sq+hN7KfsA1yY/Me0vMNsUfo5k9ZSH?=
 =?us-ascii?Q?xYlEOq8kzcCxT0nmmiA9qITj3hrZSOZJ+PjCbmnbO7SNJQCSobMWZsqQkHfa?=
 =?us-ascii?Q?F8YbOCB4VWyJ0aGA36YHHhgUDlWCJ+y5eRRfbhuEwUmay+39mMcJ8aqlSn86?=
 =?us-ascii?Q?OcptsSTkQ8vwoHxjJeEJ0BNmPQigYIiGsGtP4Dv86MHBPurr0Cb/BZkB0zje?=
 =?us-ascii?Q?tO5yYe4R4k3WROdwp4EQJmgNwCYKqvgv7/FwmB2J5d6p1iu8hlo2fdQvj5Jn?=
 =?us-ascii?Q?LXO97q9ZFHXcyvn6FxKNIoELJAy8bUR8nz/imuWooY3Ex/nQv+ReBtfeSC9r?=
 =?us-ascii?Q?Ncu8MTLdNL+qp5KEjMbgSR7UUAz1/FLOfgTNIwJCbhr6Za991W38j/9D7aDE?=
 =?us-ascii?Q?UB56Fnkr7RglKm1C/hi0Pl288jdVpo8yrPhBqNGczYSMdzImPnbxxohLbphh?=
 =?us-ascii?Q?B8sr8LYUuwfKQtfxHhIuMFC1wZbt8KHOF0neWkGn6yx6m3kAvaFd1IKab2Mj?=
 =?us-ascii?Q?SJKsfPJ4tomqJevML5DI/UkHMKmd4nxnwyFaPrVKP86241YCWKae64mC29rq?=
 =?us-ascii?Q?n+LNnykaabAArwkH/DGlmnZgLL83JSbbv0ck//gwiq0M6TOZ3XEPW74Q+XDm?=
 =?us-ascii?Q?Q70zVEUuPc1QCOjCjVLc+6WTma9lmDEtfSqm0KYZUaNy5A/zOWuPMqzLCbrx?=
 =?us-ascii?Q?BXpjo+cI3lstgKT8Y9XphnhveV6Cb8ypozJelsoBnhRWOoDOPBw3h12Q46B5?=
 =?us-ascii?Q?9prfgw/qyBp4hAqJ7W5Vz8HPqKSBRNievfJ8sT4rb5IysnhyiCWba2bn+9QO?=
 =?us-ascii?Q?tm46+HBRoGx3O9kX1DfWLN7E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1aa36ad-7317-47a4-e752-08d8d9f0f598
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4605.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 00:53:41.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FH0XR2oWRWfHmZLbIZehKwlhVg2KSRXzXLrW4hHZ5xdFd/T2h5/Y8dsWtfFWdMNaH0nxSwO5JRpcEoKf9BRWjDkoAPjUejzeu/nzW1cboDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3955
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260002
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharat,

Can you test the patch below to see if it works for you?

Also could you add some more detail to your earlier description of
the bug?
In particular, AFAICS you are using ODP (-DPDK?) with multiple
threads touching this region. From your stack, it looks like the
fault was user-space generated, and I'm guessing you were not
using the VFIO_IOMMU_MAP_DMA.

Ankur

-- >8 --

Subject: [PATCH] vfio-pci: protect io_remap_pfn_range() from simultaneous calls

vfio_pci_mmap_fault() maps the complete VMA on fault. With concurrent
faults, this would result in multiple calls to io_remap_pfn_range(),
where it would hit a BUG_ON(!pte_none(*pte)) in remap_pte_range().
(It would also link the same VMA multiple times in vdev->vma_list
but given the BUG_ON that is less serious.)

Normally, however, this won't happen -- at least with vfio_iommu_type1 --
the VFIO_IOMMU_MAP_DMA path is protected by iommu->lock.

If, however, we are using some kind of parallelization mechanism like
this one with ktask under discussion [1], we would hit this.
Even if we were doing this serially, given that vfio-pci remaps a larger
extent than strictly necessary it should internally enforce coherence of
its data structures.

Handle this by using the VMA's presence in the vdev->vma_list as
indicative of a fully mapped VMA and returning success early to
all but the first VMA fault. Note that this is clearly optimstic given
that the mapping is ongoing, and might mean that the caller sees
more faults until the remap is done.

[1] https://lore.kernel.org/linux-mm/20181105145141.6f9937f6@w520.home/

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/vfio/pci/vfio_pci.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 65e7e6b44578..b9f509863db1 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1573,6 +1573,11 @@ static int __vfio_pci_add_vma(struct vfio_pci_device *vdev,
 {
 	struct vfio_pci_mmap_vma *mmap_vma;
 
+	list_for_each_entry(mmap_vma, &vdev->vma_list, vma_next) {
+		if (mmap_vma->vma == vma)
+			return 1;
+	}
+
 	mmap_vma = kmalloc(sizeof(*mmap_vma), GFP_KERNEL);
 	if (!mmap_vma)
 		return -ENOMEM;
@@ -1613,6 +1618,7 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct vfio_pci_device *vdev = vma->vm_private_data;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
+	int vma_present;
 
 	mutex_lock(&vdev->vma_lock);
 	down_read(&vdev->memory_lock);
@@ -1623,7 +1629,21 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 		goto up_out;
 	}
 
-	if (__vfio_pci_add_vma(vdev, vma)) {
+	/*
+	 * __vfio_pci_add_vma() either adds the vma to the vdev->vma_list
+	 * (vma_present == 0), or indicates that the vma is already present
+	 * on the list (vma_present == 1).
+	 *
+	 * Overload the meaning of this flag to also imply that the vma is
+	 * fully mapped. This allows us to serialize the mapping -- ensuring
+	 * that simultaneous faults will not both try to call
+	 * io_remap_pfn_range().
+	 *
+	 * However, this might mean that callers to which we returned success
+	 * optimistically will see more faults until the remap is complete.
+	 */
+	vma_present = __vfio_pci_add_vma(vdev, vma);
+	if (vma_present < 0) {
 		ret = VM_FAULT_OOM;
 		mutex_unlock(&vdev->vma_lock);
 		goto up_out;
@@ -1631,6 +1651,9 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 
 	mutex_unlock(&vdev->vma_lock);
 
+	if (vma_present)
+		goto up_out;
+
 	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		ret = VM_FAULT_SIGBUS;
-- 
2.29.2

