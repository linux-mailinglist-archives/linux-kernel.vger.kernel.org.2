Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73374391E11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 19:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhEZR0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 13:26:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229728AbhEZR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 13:26:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QH3ZDr093842;
        Wed, 26 May 2021 13:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=W9GEqnBinXruebArN1y+MT1ffCt+eSjpcahPGOjqJe4=;
 b=VVFC8B35qJ5EQEdJZYhNbOqg+7hjxNYTHbEEqvzUKHUQn8HwuNYLvLkO4RlRFrv3s5kA
 LiuRa+xtlwJQOAxo9kelYWeXc1M/AccoyaRxJ/aGakHXoaef1jWs4KrIhlfDMYrGlyyT
 cQoSW6OruJ7TscH0zijFmygb8E6+ADN6l78jdVINHRL17voN0aPIrDZYId7Vmh6as3s4
 ZgBii1uS/RSXoIB6QPVa6s++/s2UhenDaCPGwsp2mXk1WMDIddJ16VR2z4ziivS972qW
 fFcbaH3ROczXv+1AfpwXRj6wkP6rLX1LqPekfWvuv0INoi4AHcDOw9w62QXNplVAyln6 bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38st4413hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 13:24:52 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14QH4vWk101963;
        Wed, 26 May 2021 13:24:52 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38st4413hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 13:24:52 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14QH9B5O022776;
        Wed, 26 May 2021 17:24:50 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 38sba2rhgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 17:24:50 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14QHOmFu31785332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 17:24:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38DA152050;
        Wed, 26 May 2021 17:24:48 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.39.77])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id D3FB95204F;
        Wed, 26 May 2021 17:24:46 +0000 (GMT)
Date:   Wed, 26 May 2021 20:24:44 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Arm64 crash while reading memory sysfs
Message-ID: <YK6EXNZHY1xt7Kjs@linux.ibm.com>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
 <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 701emXfpoA5TE6Ksza6VEiZcWlzOAt45
X-Proofpoint-ORIG-GUID: H2vnzDMmgn_6rR_9t7vySldh9aae885d
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_10:2021-05-26,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 12:09:14PM +0000, Qian Cai (QUIC) wrote:
> > 
> > On Tue, May 25, 2021 at 03:25:59PM +0000, Qian Cai (QUIC) wrote:
> > > Reverting the patchset "arm64: drop pfn_valid_within() and simplify pfn_valid()" [1] from today's linux-next fixed a crash while
> > reading files under /sys/devices/system/memory.

Does the issue persist of you only revert the latest patch in the series?
In next-20210525 it would be commit 
89fb47db72f2 ("arm64-drop-pfn_valid_within-and-simplify-pfn_valid-fix")
and commit
dfe215e9bac2 ("arm64: drop pfn_valid_within() and simplify pfn_valid()").

> > Can you please send the beginning of the boot log, up to the
> > 	 "Memory: xK/yK available ..."
> > line?
> 
> [    0.000000] NUMA: Failed to initialise from firmware
> [    0.000000] NUMA: Faking a node at [mem 0x0000000090000000-0x0000009fffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x9ffefbabc0-0x9ffefbffff]
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000090000000-0x0000009fffffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000090000000-0x0000000091ffffff]
> [    0.000000]   node   0: [mem 0x0000000092000000-0x00000000928fffff]
> [    0.000000]   node   0: [mem 0x0000000092900000-0x00000000fffbffff]
> [    0.000000]   node   0: [mem 0x00000000fffc0000-0x00000000ffffffff]
> [    0.000000]   node   0: [mem 0x0000000880000000-0x0000000fffffffff]
> [    0.000000]   node   0: [mem 0x0000008800000000-0x0000009ff5aeffff]
> [    0.000000]   node   0: [mem 0x0000009ff5af0000-0x0000009ff5b2ffff]
> [    0.000000]   node   0: [mem 0x0000009ff5b30000-0x0000009ff5baffff]
> [    0.000000]   node   0: [mem 0x0000009ff5bb0000-0x0000009ff7deffff]
> [    0.000000]   node   0: [mem 0x0000009ff7df0000-0x0000009ff7e5ffff]
> [    0.000000]   node   0: [mem 0x0000009ff7e60000-0x0000009ff7ffffff]
> [    0.000000]   node   0: [mem 0x0000009ff8000000-0x0000009fffffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000090000000-0x0000009fffffffff]
> [    0.000000] mem auto-init: stack:off, heap alloc:on, heap free:off
> [    0.000000] Memory: 777216K/133955584K available (17920K kernel code, 118786K rwdata, 4416K rodata, 6080K init, 67276K bss, 17379072K reserved, 0K cma-reserved)

The available and reserved sizes look weird. Can you post the log with
memblock=debug and mminit_loglevel=4 added to the kernel command line?
 
> > > [1] https://lore.kernel.org/kvmarm/20210511100550.28178-1-rppt@kernel.org/
> > >
> > > [  247.669668][ T1443] kernel BUG at include/linux/mm.h:1383!
> > > [  247.675987][ T1443] Internal error: Oops - BUG: 0 [#1] SMP
> > > [  247.681472][ T1443] Modules linked in: loop processor efivarfs ip_tables x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit
> > nvme mlx5_core i2c_core nvme_core firmware_class
> > > [  247.696894][ T1443] CPU: 15 PID: 1443 Comm: ranbug Not tainted 5.13.0-rc3-next-20210524+ #11
> > > [  247.705326][ T1443] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
> > > [  247.713842][ T1443] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> > > [  247.720536][ T1443] pc : test_pages_in_a_zone+0x23c/0x300
> > > [  247.725935][ T1443] lr : test_pages_in_a_zone+0x23c/0x300

Do we know what PFN triggers it? Can you please run with this patch:

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 70620d0dd923..b9d1dd0dae5f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1443,6 +1443,12 @@ struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 				i++;
 			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
 				continue;
+
+			if (!pfn_valid(pfn))
+				pr_info("%s: pfn %lx is not valid\n", __func__, pfn);
+			else if (PagePoisoned(pfn_to_page(pfn)))
+				dump_page(pfn_to_page(pfn), "");
+
 			/* Check if we got outside of the zone */
 			if (zone && !zone_spans_pfn(zone, pfn + i))
 				return NULL;


-- 
Sincerely yours,
Mike.
