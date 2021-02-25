Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151B132532A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbhBYQKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:10:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233557AbhBYQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:08:38 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PG2VXp145227;
        Thu, 25 Feb 2021 11:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Yq/02UZSE8vCULHuZGHZmGpjiIByKs4OEh4fjJendZI=;
 b=huhV46PAdYD7y8eBmxJ0jh0ueQxB2Vg/vWerlWXR1gEMC+rKm+kD3OTkzqkBldUOQHYk
 9az6/32IchIkDe59djamt+0mgV+72zg96NbaoPyfiL9pzVm72pcFGjuHk0nOYIsh46RI
 SOKT+PvVP7A+WhKLq8V4IbLYB328dln4ykwo3ejlc+p57O6Q30Ph//1pSZSAS7TqpDlH
 pHT8h8tAh3v/2zf+tORZ6V77nUzKrT3Hekl7r07Rji8zSSTLoVmzoGAfs7IJCCvSHNRO
 xtUeyPlwb6T2mFQpqdbPfAdg2Pl/tT1fK/g4T23v/lStkPnBI+Sf9+yqfxhendRUIlJJ 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36xeec1tws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 11:07:16 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11PG2fTw146394;
        Thu, 25 Feb 2021 11:07:15 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36xeec1tvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 11:07:15 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11PG2GG1008731;
        Thu, 25 Feb 2021 16:07:13 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 36tsph4khq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 16:07:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11PG7Bp949545482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 16:07:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EA77AE053;
        Thu, 25 Feb 2021 16:07:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB5C1AE057;
        Thu, 25 Feb 2021 16:07:08 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.51.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Feb 2021 16:07:08 +0000 (GMT)
Date:   Thu, 25 Feb 2021 18:07:06 +0200
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
Message-ID: <20210225160706.GD1854360@linux.ibm.com>
References: <20210223200914.GH1741768@linux.ibm.com>
 <af06267d-00cd-d4e0-1985-b06ce7c993a3@oracle.com>
 <20210223213237.GI1741768@linux.ibm.com>
 <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
 <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
 <20210225145700.GC1854360@linux.ibm.com>
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_09:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:22:44AM -0500, George Kennedy wrote:
> 
> > > > > On 2/24/2021 5:37 AM, Mike Rapoport wrote:
>
> Applied just your latest patch, but same failure.
> 
> I thought there was an earlier comment (which I can't find now) that stated
> that memblock_reserve() wouldn't reserve the page, which is what's needed
> here.

Actually, I think that memblock_reserve() should be just fine, but it seems
I'm missing something in address calculation each time.

What would happen if you stuck

	memblock_reserve(0xbe453000, PAGE_SIZE);

say, at the beginning of find_ibft_region()?
 
> [   30.308229] iBFT detected..
> [   30.308796]
> ==================================================================
> [   30.308890] BUG: KASAN: use-after-free in ibft_init+0x134/0xc33
> [   30.308890] Read of size 4 at addr ffff8880be453004 by task swapper/0/1
> [   30.308890]
> [   30.308890] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.11.0-f9593a0 #12
> [   30.308890] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 0.0.0 02/06/2015
> [   30.308890] Call Trace:
> [   30.308890]  dump_stack+0xdb/0x120
> [   30.308890]  ? ibft_init+0x134/0xc33
> [   30.308890]  print_address_description.constprop.7+0x41/0x60
> [   30.308890]  ? ibft_init+0x134/0xc33
> [   30.308890]  ? ibft_init+0x134/0xc33
> [   30.308890]  kasan_report.cold.10+0x78/0xd1
> [   30.308890]  ? ibft_init+0x134/0xc33
> [   30.308890]  __asan_report_load_n_noabort+0xf/0x20
> [   30.308890]  ibft_init+0x134/0xc33
> [   30.308890]  ? write_comp_data+0x2f/0x90
> [   30.308890]  ? ibft_check_initiator_for+0x159/0x159
> [   30.308890]  ? write_comp_data+0x2f/0x90
> [   30.308890]  ? ibft_check_initiator_for+0x159/0x159
> [   30.308890]  do_one_initcall+0xc4/0x3e0
> [   30.308890]  ? perf_trace_initcall_level+0x3e0/0x3e0
> [   30.308890]  ? unpoison_range+0x14/0x40
> [   30.308890]  ? ____kasan_kmalloc.constprop.5+0x8f/0xc0
> [   30.308890]  ? kernel_init_freeable+0x420/0x652
> [   30.308890]  ? __kasan_kmalloc+0x9/0x10
> [   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
> [   30.308890]  kernel_init_freeable+0x596/0x652
> [   30.308890]  ? console_on_rootfs+0x7d/0x7d
> [   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
> [   30.308890]  ? rest_init+0xf0/0xf0
> [   30.308890]  kernel_init+0x16/0x1d0
> [   30.308890]  ? rest_init+0xf0/0xf0
> [   30.308890]  ret_from_fork+0x22/0x30
> [   30.308890]
> [   30.308890] The buggy address belongs to the page:
> [   30.308890] page:0000000001b7b17c refcount:0 mapcount:0
> mapping:0000000000000000 index:0x1 pfn:0xbe453
> [   30.308890] flags: 0xfffffc0000000()
> [   30.308890] raw: 000fffffc0000000 ffffea0002ef9788 ffffea0002f91488
> 0000000000000000
> [   30.308890] raw: 0000000000000001 0000000000000000 00000000ffffffff
> 0000000000000000
> [   30.308890] page dumped because: kasan: bad access detected
> [   30.308890] page_owner tracks the page as freed
> [   30.308890] page last allocated via order 0, migratetype Movable,
> gfp_mask 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), pid 204, ts 28121288605
> [   30.308890]  prep_new_page+0xfb/0x140
> [   30.308890]  get_page_from_freelist+0x3503/0x5730
> [   30.308890]  __alloc_pages_nodemask+0x2d8/0x650
> [   30.308890]  alloc_pages_vma+0xe2/0x560
> [   30.308890]  __handle_mm_fault+0x930/0x26c0
> [   30.308890]  handle_mm_fault+0x1f9/0x810
> [   30.308890]  do_user_addr_fault+0x6f7/0xca0
> [   30.308890]  exc_page_fault+0xaf/0x1a0
> [   30.308890]  asm_exc_page_fault+0x1e/0x30
> [   30.308890] page last free stack trace:
> [   30.308890]  free_pcp_prepare+0x122/0x290
> [   30.308890]  free_unref_page_list+0xe6/0x490
> [   30.308890]  release_pages+0x2ed/0x1270
> [   30.308890]  free_pages_and_swap_cache+0x245/0x2e0
> [   30.308890]  tlb_flush_mmu+0x11e/0x680
> [   30.308890]  tlb_finish_mmu+0xa6/0x3e0
> [   30.308890]  exit_mmap+0x2b3/0x540
> [   30.308890]  mmput+0x11d/0x450
> [   30.308890]  do_exit+0xaa6/0x2d40
> [   30.308890]  do_group_exit+0x128/0x340
> [   30.308890]  __x64_sys_exit_group+0x43/0x50
> [   30.308890]  do_syscall_64+0x37/0x50
> [   30.308890]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   30.308890]
> [   30.308890] Memory state around the buggy address:
> [   30.308890]  ffff8880be452f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff
> [   30.308890]  ffff8880be452f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff
> [   30.308890] >ffff8880be453000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff
> [   30.308890]                    ^
> [   30.308890]  ffff8880be453080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff
> [   30.308890]  ffff8880be453100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff
> [   30.308890]
> ==================================================================
> 
> George
> 

-- 
Sincerely yours,
Mike.
