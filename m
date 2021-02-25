Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE42E3254EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhBYRzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:55:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232465AbhBYRvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:51:25 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PHYDt1066795;
        Thu, 25 Feb 2021 12:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Dj0Pa8aF0tC5Uv5BuKgWwY3C1VrzZLxPJIwF5G/jwvk=;
 b=jLpmAJ+HQOcNz/W7ybTjCwVvp0F0pfeN2HvTs0Qf7IWf2ppJ+/gIPlkIKOtqrD/TyAs5
 V1oeVnwBOx3p0HCx+fsBbxtz2IkY4jDKYxe+cIEU3Q1yp1P3veZO4EzwnDp/74diRO+l
 exJL27RMnxwai9DLF7FXfxibFPTvSamhDpER9SSPFALItWE9ZkrSO6FjFxZZpgZnRs/H
 /WDV7YULKL2bn4vmsF+bYGfv93lsjRttvAQyut1kl/MipuBZ+o5FEXIz3ClmK8w05Tv9
 bwvKSJWKntevdYanBdcF8SNSAno2GCJ2B9wfAJIGzer5iMRrPhYqGQMNxBwzExH2t6gN ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xe106cj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 12:50:16 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11PHa19U072619;
        Thu, 25 Feb 2021 12:50:16 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xe106ch5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 12:50:15 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11PHi6BY012014;
        Thu, 25 Feb 2021 17:50:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 36tt28aekq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 17:50:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11PHoAmD36765968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 17:50:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D28985205A;
        Thu, 25 Feb 2021 17:50:09 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.51.238])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id E438852078;
        Thu, 25 Feb 2021 17:50:06 +0000 (GMT)
Date:   Thu, 25 Feb 2021 19:50:04 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
Message-ID: <20210225175004.GG1854360@linux.ibm.com>
References: <20210223213237.GI1741768@linux.ibm.com>
 <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
 <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
 <20210225145700.GC1854360@linux.ibm.com>
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
 <20210225160706.GD1854360@linux.ibm.com>
 <dcf821e8-768f-1992-e275-2f1ade405025@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcf821e8-768f-1992-e275-2f1ade405025@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_10:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 11:31:04AM -0500, George Kennedy wrote:
> 
> 
> On 2/25/2021 11:07 AM, Mike Rapoport wrote:
> > On Thu, Feb 25, 2021 at 10:22:44AM -0500, George Kennedy wrote:
> > > > > > > On 2/24/2021 5:37 AM, Mike Rapoport wrote:
> > > Applied just your latest patch, but same failure.
> > > 
> > > I thought there was an earlier comment (which I can't find now) that stated
> > > that memblock_reserve() wouldn't reserve the page, which is what's needed
> > > here.
> > Actually, I think that memblock_reserve() should be just fine, but it seems
> > I'm missing something in address calculation each time.
> > 
> > What would happen if you stuck
> > 
> > 	memblock_reserve(0xbe453000, PAGE_SIZE);
> > 
> > say, at the beginning of find_ibft_region()?
> 
> Added debug to your patch and this is all that shows up. Looks like the
> patch is in the wrong place as acpi_tb_parse_root_table() is only called for
> the RSDP address.

Right, but I think it parses table description of the other tables and
populates local tables with them.
I think the problem is with how I compare the signatures, please see below

> [    0.064317] ACPI: Early table checksum verification disabled
> [    0.065437] XXX acpi_tb_parse_root_table: rsdp_address=bfbfa014
> [    0.066612] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
> [    0.067759] ACPI: XSDT 0x00000000BFBF90E8 00004C (v01 BOCHS BXPCFACP
> 00000001      01000013)
> [    0.069470] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS BXPCFACP
> 00000001 BXPC 00000001)
> [    0.071183] ACPI: DSDT 0x00000000BFBF6000 00238D (v01 BOCHS BXPCDSDT
> 00000001 BXPC 00000001)
> [    0.072876] ACPI: FACS 0x00000000BFBFD000 000040
> [    0.073806] ACPI: APIC 0x00000000BFBF4000 000090 (v01 BOCHS BXPCAPIC
> 00000001 BXPC 00000001)
> [    0.075501] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS BXPCHPET
> 00000001 BXPC 00000001)
> [    0.077194] ACPI: BGRT 0x00000000BE49B000 000038 (v01 INTEL EDK2    
> 00000002      01000013)
> [    0.078880] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS BXPCFACP
> 00000000      00000000)
> [    0.080588] ACPI: Local APIC address 0xfee00000
> 
> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> index dfe1ac3..603b3a8 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -7,6 +7,8 @@
>   *
> *****************************************************************************/
> 
> +#include <linux/memblock.h>
> +
>  #include <acpi/acpi.h>
>  #include "accommon.h"
>  #include "actables.h"
> @@ -232,6 +234,8 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32
> table_index)
>      acpi_status status;
>      u32 table_index;
> 
> +printk(KERN_ERR "XXX acpi_tb_parse_root_table: rsdp_address=%llx\n",
> rsdp_address);
> +
>      ACPI_FUNCTION_TRACE(tb_parse_root_table);
> 
>      /* Map the entire RSDP and extract the address of the RSDT or XSDT */
> @@ -339,6 +343,22 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32
> table_index)
>              acpi_tb_parse_fadt();
>          }
> 
> +        if (ACPI_SUCCESS(status) &&
> +            ACPI_COMPARE_NAMESEG(&acpi_gbl_root_table_list.
> +                     tables[table_index].signature,
> +                     ACPI_SIG_IBFT)) {

We have:

include/acpi/actbl1.h:#define ACPI_SIG_IBFT           "IBFT"    /* iSCSI Boot Firmware Table */

and the BIOS uses "iBFT", so we need to loop over possible signature
variants like iscsi_ibft_find does.

Do you mind replacing ACPI_SIG_IBFT with "iBFT" and try again?

> +            struct acpi_table_header *ibft;
> +            struct acpi_table_desc *desc;
> +
> +            desc = &acpi_gbl_root_table_list.tables[table_index];
> +            status = acpi_tb_get_table(desc, &ibft);
> +            if (ACPI_SUCCESS(status)) {
> +printk(KERN_ERR "XXX acpi_tb_parse_root_table(calling memblock_reserve()):
> addres=%llx, ibft->length=%x\n", address, ibft->length);
> +                memblock_reserve(address, ibft->length);
> +                acpi_tb_put_table(desc);
> +            }
> +        }
> +
>  next_table:
> 
>          table_entry += table_entry_size;
> 
> 
> > > [   30.308229] iBFT detected..
> > > [   30.308796]
> > > ==================================================================
> > > [   30.308890] BUG: KASAN: use-after-free in ibft_init+0x134/0xc33
> > > [   30.308890] Read of size 4 at addr ffff8880be453004 by task swapper/0/1
> > > [   30.308890]
> > > [   30.308890] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.11.0-f9593a0 #12
> > > [   30.308890] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > 0.0.0 02/06/2015
> > > [   30.308890] Call Trace:
> > > [   30.308890]  dump_stack+0xdb/0x120
> > > [   30.308890]  ? ibft_init+0x134/0xc33
> > > [   30.308890]  print_address_description.constprop.7+0x41/0x60
> > > [   30.308890]  ? ibft_init+0x134/0xc33
> > > [   30.308890]  ? ibft_init+0x134/0xc33
> > > [   30.308890]  kasan_report.cold.10+0x78/0xd1
> > > [   30.308890]  ? ibft_init+0x134/0xc33
> > > [   30.308890]  __asan_report_load_n_noabort+0xf/0x20
> > > [   30.308890]  ibft_init+0x134/0xc33
> > > [   30.308890]  ? write_comp_data+0x2f/0x90
> > > [   30.308890]  ? ibft_check_initiator_for+0x159/0x159
> > > [   30.308890]  ? write_comp_data+0x2f/0x90
> > > [   30.308890]  ? ibft_check_initiator_for+0x159/0x159
> > > [   30.308890]  do_one_initcall+0xc4/0x3e0
> > > [   30.308890]  ? perf_trace_initcall_level+0x3e0/0x3e0
> > > [   30.308890]  ? unpoison_range+0x14/0x40
> > > [   30.308890]  ? ____kasan_kmalloc.constprop.5+0x8f/0xc0
> > > [   30.308890]  ? kernel_init_freeable+0x420/0x652
> > > [   30.308890]  ? __kasan_kmalloc+0x9/0x10
> > > [   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
> > > [   30.308890]  kernel_init_freeable+0x596/0x652
> > > [   30.308890]  ? console_on_rootfs+0x7d/0x7d
> > > [   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
> > > [   30.308890]  ? rest_init+0xf0/0xf0
> > > [   30.308890]  kernel_init+0x16/0x1d0
> > > [   30.308890]  ? rest_init+0xf0/0xf0
> > > [   30.308890]  ret_from_fork+0x22/0x30
> > > [   30.308890]
> > > [   30.308890] The buggy address belongs to the page:
> > > [   30.308890] page:0000000001b7b17c refcount:0 mapcount:0
> > > mapping:0000000000000000 index:0x1 pfn:0xbe453
> > > [   30.308890] flags: 0xfffffc0000000()
> > > [   30.308890] raw: 000fffffc0000000 ffffea0002ef9788 ffffea0002f91488
> > > 0000000000000000
> > > [   30.308890] raw: 0000000000000001 0000000000000000 00000000ffffffff
> > > 0000000000000000
> > > [   30.308890] page dumped because: kasan: bad access detected
> > > [   30.308890] page_owner tracks the page as freed
> > > [   30.308890] page last allocated via order 0, migratetype Movable,
> > > gfp_mask 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), pid 204, ts 28121288605
> > > [   30.308890]  prep_new_page+0xfb/0x140
> > > [   30.308890]  get_page_from_freelist+0x3503/0x5730
> > > [   30.308890]  __alloc_pages_nodemask+0x2d8/0x650
> > > [   30.308890]  alloc_pages_vma+0xe2/0x560
> > > [   30.308890]  __handle_mm_fault+0x930/0x26c0
> > > [   30.308890]  handle_mm_fault+0x1f9/0x810
> > > [   30.308890]  do_user_addr_fault+0x6f7/0xca0
> > > [   30.308890]  exc_page_fault+0xaf/0x1a0
> > > [   30.308890]  asm_exc_page_fault+0x1e/0x30
> > > [   30.308890] page last free stack trace:
> > > [   30.308890]  free_pcp_prepare+0x122/0x290
> > > [   30.308890]  free_unref_page_list+0xe6/0x490
> > > [   30.308890]  release_pages+0x2ed/0x1270
> > > [   30.308890]  free_pages_and_swap_cache+0x245/0x2e0
> > > [   30.308890]  tlb_flush_mmu+0x11e/0x680
> > > [   30.308890]  tlb_finish_mmu+0xa6/0x3e0
> > > [   30.308890]  exit_mmap+0x2b3/0x540
> > > [   30.308890]  mmput+0x11d/0x450
> > > [   30.308890]  do_exit+0xaa6/0x2d40
> > > [   30.308890]  do_group_exit+0x128/0x340
> > > [   30.308890]  __x64_sys_exit_group+0x43/0x50
> > > [   30.308890]  do_syscall_64+0x37/0x50
> > > [   30.308890]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [   30.308890]
> > > [   30.308890] Memory state around the buggy address:
> > > [   30.308890]  ffff8880be452f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ff ff
> > > [   30.308890]  ffff8880be452f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ff ff
> > > [   30.308890] >ffff8880be453000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ff ff
> > > [   30.308890]                    ^
> > > [   30.308890]  ffff8880be453080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ff ff
> > > [   30.308890]  ffff8880be453100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ff ff
> > > [   30.308890]
> > > ==================================================================
> > > 
> > > George
> > > 
> 

-- 
Sincerely yours,
Mike.
