Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5547F3D3122
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 03:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhGWAcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:32:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4112 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232917AbhGWAcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:32:47 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16N14DRN130535;
        Thu, 22 Jul 2021 21:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0UDzfZxoUw+wVSJ5ie/85dFi0GdTXZ9QQbsSHQJNrSY=;
 b=gljmLXFpmqerbaBRcEqHgUqVFxtxombBxdPFtkhgg61Osmx8yelGw5vwDaMAOf2FyQxi
 SaJZvEWqW5aOb/gfMbU4bglFhCerBJidWPfswDtQYtGe8lnu6kJBnJP36jqu/1D0o79k
 MOpFY9ioXmwSm7HML3BwK8ipa/QXX9jA7iNSeantHl3esrFQiw0JW9yvlZnFGXGku84M
 1SJfUk3xsCreXDJJAhMWEvd2RYelB+DLxAnDaxoQxJ2qLmIz3mMQ64NyPo87M2LSh8pY
 ZoIhMG5FGuVGVPeWFZkpT+NcGNlpl+KWy6jF9ftjS+KRdBnWGUyjvK2anQUbqxgP1ewK qw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39yjfk1xcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 21:13:00 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16N1CxZm003767;
        Fri, 23 Jul 2021 01:12:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 39vng72ccp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 01:12:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16N1CtsQ29229418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 01:12:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FC365204E;
        Fri, 23 Jul 2021 01:12:55 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.93.118])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 89CCD5204F;
        Fri, 23 Jul 2021 01:12:54 +0000 (GMT)
Date:   Fri, 23 Jul 2021 03:12:52 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
Message-ID: <20210723031252.655d6a83.pasic@linux.ibm.com>
In-Reply-To: <57e37ef9-c055-d6a6-2244-2c7dd243b5c1@de.ibm.com>
References: <20210720133826.9075-1-will@kernel.org>
        <57e37ef9-c055-d6a6-2244-2c7dd243b5c1@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ae3eLa12W-x0ipkL-mPwp06xYhUcnGIf
X-Proofpoint-GUID: Ae3eLa12W-x0ipkL-mPwp06xYhUcnGIf
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-22_16:2021-07-22,2021-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 21:22:58 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 20.07.21 15:38, Will Deacon wrote:
> > Hi again, folks,
> > 
> > This is version two of the patch series I posted yesterday:
> > 
> >    https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org
> > 
> > The only changes since v1 are:
> > 
> >    * Squash patches 2 and 3, amending the commit message accordingly
> >    * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)
> > 
> > I'd usually leave it a bit longer between postings, but since this fixes
> > issues with patches in -next I thought I'd spin a new version immediately.
> > 
> > Cheers,  
> 
> FWIW, I just bisected virtio-errors with secure execution mode
> qemu-system-s390x: virtio-serial-bus: Unexpected port id 4205794771 for device virtio-serial0.0
> 
> to
> commit 903cd0f315fe426c6a64c54ed389de0becb663dc
> Author: Claire Chang <tientzu@chromium.org>
> Date:   Thu Jun 24 23:55:20 2021 +0800
> 
>       swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing
> 
> Unfortunately this patch series does NOT fix this issue, so it seems that even more
> things are broken.
> 
> Any idea what else might be broken?

I've done some debugging, and I think I know what is going on. Since
that commit we need to set force_swiotlb before the swiotlb itself is
initialized. So the patch below should fix the problem.

--------------------8<-------------------------------------

From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 23 Jul 2021 02:57:06 +0200
Subject: [PATCH 1/1] s390/pv: fix the forcing of the swiotlb

Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
swiotlb data bouncing") if code sets swiotlb_force it needs to do so
before the swiotlb is initialised. Otherwise
io_tlb_default_mem->force_bounce will not get set to true, and devices
that use (the default) swiotlb will not bounce  despite switolb_force
having the value of SWIOTLB_FORCE.

Let us restore swiotlb functionality for PV by fulfilling this new
requirement.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 8ac710de1ab1..07bbee9b7320 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -186,9 +186,9 @@ static void pv_init(void)
 		return;
 
 	/* make sure bounce buffers are shared */
+	swiotlb_force = SWIOTLB_FORCE;
 	swiotlb_init(1);
 	swiotlb_update_mem_attributes();
-	swiotlb_force = SWIOTLB_FORCE;
 }
 
 void __init mem_init(void)
-- 
2.29.2
