Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8222392A28
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhE0I6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:58:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235518AbhE0I6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:58:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14R8XajM045541;
        Thu, 27 May 2021 04:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=H8VcDRG4KYFKCIrx8KPWKUvYuVPna44llq/MZZuyg1I=;
 b=teifaCTi+mqYgYiixxAolCPUqsKWkJhWr4b9m/Z5+HxUESfw11JFCyu0055K+IYYzKub
 7DSe0xWdLvK1mvKiC92qN7kCftG1ON23b3O4tjXcGkWoFy6+sQ+ANRd9EVKHN6Vkeppv
 m9uPOFcmEb0CKRnFwJkw6tPUNgP8t5YMAQnA/HcSlqXaFSTAvFW2I3j1Ebm4Q3HHnBui
 stzS+VgIMO8EEzUcJ/N3cDcNg03N5Fyor+b7kjKTg3O4LUJ+iq+N3biWdVbYod7p5RlN
 8mQrAHCCAjq3bNZ9vazOcNWRUgHMO9kIrFGNH8vQckt2VmUA+SE3qJoCpp3QoCQkubAA 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38t7g41s90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 04:56:59 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14R8XjuD045994;
        Thu, 27 May 2021 04:56:59 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38t7g41s7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 04:56:58 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14R8q4Mv005066;
        Thu, 27 May 2021 08:56:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 38s1r4931f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 08:56:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14R8us3g22544752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 08:56:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F877A404D;
        Thu, 27 May 2021 08:56:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8A7AA4053;
        Thu, 27 May 2021 08:56:52 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.39.77])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 27 May 2021 08:56:52 +0000 (GMT)
Date:   Thu, 27 May 2021 11:56:48 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
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
Message-ID: <YK9e0LgDOfCFo6TM@linux.ibm.com>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
 <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
 <YK6EXNZHY1xt7Kjs@linux.ibm.com>
 <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SVEXlpzHU4SkmGSwgrFBzxBRHkDwlaCN
X-Proofpoint-ORIG-GUID: wmKVnJGQHn-e8IgVSh2PTMyurTHBkr04
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_04:2021-05-26,2021-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105270056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 08:16:14PM -0400, Qian Cai wrote:
> 
> On 5/26/2021 1:24 PM, Mike Rapoport wrote:
> > On Wed, May 26, 2021 at 12:09:14PM +0000, Qian Cai (QUIC) wrote:
> >>>
> >>> On Tue, May 25, 2021 at 03:25:59PM +0000, Qian Cai (QUIC) wrote:
> >>>> Reverting the patchset "arm64: drop pfn_valid_within() and simplify pfn_valid()" [1] from today's linux-next fixed a crash while
> >>> reading files under /sys/devices/system/memory.
> > 
> > Does the issue persist of you only revert the latest patch in the series?
> > In next-20210525 it would be commit 
> > 89fb47db72f2 ("arm64-drop-pfn_valid_within-and-simplify-pfn_valid-fix")
> > and commit
> > dfe215e9bac2 ("arm64: drop pfn_valid_within() and simplify pfn_valid()").
> 
> Reverting those two commits alone is enough to fix the issue.
> 
> > 
> >>> Can you please send the beginning of the boot log, up to the
> >>> 	 "Memory: xK/yK available ..."
> >>> line?
> >>
> >> [    0.000000] NUMA: Failed to initialise from firmware
> >> [    0.000000] NUMA: Faking a node at [mem 0x0000000090000000-0x0000009fffffffff]
> >> [    0.000000] NUMA: NODE_DATA [mem 0x9ffefbabc0-0x9ffefbffff]
> >> [    0.000000] Zone ranges:
> >> [    0.000000]   Normal   [mem 0x0000000090000000-0x0000009fffffffff]
> >> [    0.000000] Movable zone start for each node
> >> [    0.000000] Early memory node ranges
> >> [    0.000000]   node   0: [mem 0x0000000090000000-0x0000000091ffffff]
> >> [    0.000000]   node   0: [mem 0x0000000092000000-0x00000000928fffff]
> >> [    0.000000]   node   0: [mem 0x0000000092900000-0x00000000fffbffff]
> >> [    0.000000]   node   0: [mem 0x00000000fffc0000-0x00000000ffffffff]
> >> [    0.000000]   node   0: [mem 0x0000000880000000-0x0000000fffffffff]
> >> [    0.000000]   node   0: [mem 0x0000008800000000-0x0000009ff5aeffff]
> >> [    0.000000]   node   0: [mem 0x0000009ff5af0000-0x0000009ff5b2ffff]
> >> [    0.000000]   node   0: [mem 0x0000009ff5b30000-0x0000009ff5baffff]
> >> [    0.000000]   node   0: [mem 0x0000009ff5bb0000-0x0000009ff7deffff]
> >> [    0.000000]   node   0: [mem 0x0000009ff7df0000-0x0000009ff7e5ffff]
> >> [    0.000000]   node   0: [mem 0x0000009ff7e60000-0x0000009ff7ffffff]
> >> [    0.000000]   node   0: [mem 0x0000009ff8000000-0x0000009fffffffff]
> >> [    0.000000] Initmem setup node 0 [mem 0x0000000090000000-0x0000009fffffffff]
> >> [    0.000000] mem auto-init: stack:off, heap alloc:on, heap free:off
> >> [    0.000000] Memory: 777216K/133955584K available (17920K kernel code, 118786K rwdata, 4416K rodata, 6080K init, 67276K bss, 17379072K reserved, 0K cma-reserved)
> > 
> > The available and reserved sizes look weird. Can you post the log with
> > memblock=debug and mminit_loglevel=4 added to the kernel command line?
> 
> http://www.lsbug.org/tmp/dmesg.txt

It seems cut in the middle and even then it's too long to be useful.

Let's drop memblock=debug for now and add this instead:

diff --git a/mm/memblock.c b/mm/memblock.c
index afaefa8fc6ab..3f888bef1994 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2055,6 +2055,8 @@ void __init memblock_free_all(void)
 {
 	unsigned long pages;
 
+	__memblock_dump_all();
+
 	free_unused_memmap();
 	reset_all_zones_managed_pages();
 
> >>>> [1] https://lore.kernel.org/kvmarm/20210511100550.28178-1-rppt@kernel.org/
> >>>>
> >>>> [  247.669668][ T1443] kernel BUG at include/linux/mm.h:1383!
> >>>> [  247.675987][ T1443] Internal error: Oops - BUG: 0 [#1] SMP
> >>>> [  247.681472][ T1443] Modules linked in: loop processor efivarfs ip_tables x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit
> >>> nvme mlx5_core i2c_core nvme_core firmware_class
> >>>> [  247.696894][ T1443] CPU: 15 PID: 1443 Comm: ranbug Not tainted 5.13.0-rc3-next-20210524+ #11
> >>>> [  247.705326][ T1443] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
> >>>> [  247.713842][ T1443] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> >>>> [  247.720536][ T1443] pc : test_pages_in_a_zone+0x23c/0x300
> >>>> [  247.725935][ T1443] lr : test_pages_in_a_zone+0x23c/0x300
> > 
> > Do we know what PFN triggers it? Can you please run with this patch:
> 
> Nothing useful showed up with this patch. Yes, I double-checked that the patch was applied.

Sorry, I've missed that the BUG is apparently triggered for pfn + i. Can
you please try this instead:


diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 70620d0dd923..d0e42e09ad84 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1447,6 +1447,13 @@ struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 			if (zone && !zone_spans_pfn(zone, pfn + i))
 				return NULL;
 			page = pfn_to_page(pfn + i);
+
+			if (!pfn_valid(pfn + i))
+				pr_info("%s: pfn %lx is not valid\n", __func__, pfn + i);
+			else if (PagePoisoned(page))
+				dump_page(page, "");
+
+
 			if (zone && page_zone(page) != zone)
 				return NULL;
 			zone = page_zone(page);
 
-- 
Sincerely yours,
Mike.
