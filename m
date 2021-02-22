Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AF3221DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBVV4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:56:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229959AbhBVV4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:56:20 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MLXqIa132709;
        Mon, 22 Feb 2021 16:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=R4rIU2G5kKIHfDd+43BWvqmZDKp/IJsUHSHYByhbHpg=;
 b=TTGdvXlpHCGDKkgldOJcsUcTvidVzHHRAMtgYg21fTjap6ig4ANu+wQwmVO83s+fppVj
 UDoLNuXhl/0SVLkzBaWTb/v0TwOmISPbB166mZ3iaXEaA3K1OqAN9q5kIFF0uknsLv4F
 ySaGIBdCMQhavgJzmpMpRVvDIBckHZibEVHJ0p3RPmfyTPI2DviqgFchhPueUeftxvm9
 AV4aqhHa2wS87GlYk2mMfKqy+ZZCOwRQJa6NdfiuW2Z0AckIVqo3hLDRhboMLIrmYmq1
 OVlXy6SnJRs75f7xyN6kM4QG0kndtBiUEc2laZm7qYmCiBYez2OOYfe32zLwWutfTB9e fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkfs31pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:55:13 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11MLYruF142830;
        Mon, 22 Feb 2021 16:55:12 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkfs31n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:55:11 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MLt9Mk031004;
        Mon, 22 Feb 2021 21:55:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 36tt28s27c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 21:55:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MLt7tQ45941092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 21:55:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29A824C04E;
        Mon, 22 Feb 2021 21:55:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4A5A4C044;
        Mon, 22 Feb 2021 21:55:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.51.238])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 22 Feb 2021 21:55:04 +0000 (GMT)
Date:   Mon, 22 Feb 2021 23:55:02 +0200
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
Message-ID: <20210222215502.GB1741768@linux.ibm.com>
References: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
 <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com>
 <d11bf144-669b-0fe1-4fa4-001a014db32a@oracle.com>
 <CAAeHK+y_SmP5yAeSM3Cp6V3WH9uj4737hDuVGA7U=xA42ek3Lw@mail.gmail.com>
 <c7166cae-bf89-8bdd-5849-72b5949fc6cc@oracle.com>
 <797fae72-e3ea-c0b0-036a-9283fa7f2317@oracle.com>
 <1ac78f02-d0af-c3ff-cc5e-72d6b074fc43@redhat.com>
 <bd7510b5-d325-b516-81a8-fbdc81a27138@oracle.com>
 <56c97056-6d8b-db0e-e303-421ee625abe3@redhat.com>
 <cb8564e8-3535-826b-2d42-b273a0d793fb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb8564e8-3535-826b-2d42-b273a0d793fb@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_07:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220187
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 01:42:56PM -0500, George Kennedy wrote:
> 
> On 2/22/2021 11:13 AM, David Hildenbrand wrote:
> > On 22.02.21 16:13, George Kennedy wrote:
> > > 
> > > On 2/22/2021 4:52 AM, David Hildenbrand wrote:
> > > > 
> > > > Let me look into the code ... I have little experience with ACPI
> > > > details, so bear with me.
> > > > 
> > > > I assume that acpi_map()/acpi_unmap() map some firmware blob that is
> > > > provided via firmware/bios/... to us.
> > > > 
> > > > should_use_kmap() tells us whether
> > > > a) we have a "struct page" and should kmap() that one
> > > > b) we don't have a "struct page" and should ioremap.
> > > > 
> > > > As it is a blob, the firmware should always reserve that memory region
> > > > via memblock (e.g., memblock_reserve()), such that we either
> > > > 1) don't create a memmap ("struct page") at all (-> case b) )
> > > > 2) if we have to create e memmap, we mark the page PG_reserved and
> > > >     *never* expose it to the buddy (-> case a) )
> > > > 
> > > > 
> > > > Are you telling me that in this case we might have a memmap for the HW
> > > > blob that is *not* PG_reserved? In that case it most probably got
> > > > exposed to the buddy where it can happily get allocated/freed.
> > > > 
> > > > The latent BUG would be that that blob gets exposed to the system like
> > > > ordinary RAM, and not reserved via memblock early during boot.
> > > > Assuming that blob has a low physical address, with my patch it will
> > > > get allocated/used a lot earlier - which would mean we trigger this
> > > > latent BUG now more easily.
> > > > 
> > > > There have been similar latent BUGs on ARM boards that my patch
> > > > discovered where special RAM regions did not get marked as reserved
> > > > via the device tree properly.
> > > > 
> > > > Now, this is just a wild guess :) Can you dump the page when mapping
> > > > (before PageReserved()) and when unmapping, to see what the state of
> > > > that memmap is?
> > > 
> > > Thank you David for the explanation and your help on this,
> > > 
> > > dump_page() before PageReserved and before kmap() in the above patch:
> > > 
> > > [    1.116480] ACPI: Core revision 20201113
> > > [    1.117628] XXX acpi_map: about to call kmap()...
> > > [    1.118561] page:ffffea0002f914c0 refcount:0 mapcount:0
> > > mapping:0000000000000000 index:0x0 pfn:0xbe453
> > > [    1.120381] flags: 0xfffffc0000000()
> > > [    1.121116] raw: 000fffffc0000000 ffffea0002f914c8 ffffea0002f914c8
> > > 0000000000000000
> > > [    1.122638] raw: 0000000000000000 0000000000000000 00000000ffffffff
> > > 0000000000000000
> > > [    1.124146] page dumped because: acpi_map pre SetPageReserved
> > > 
> > > I also added dump_page() before unmapping, but it is not hit. The
> > > following for the same pfn now shows up I believe as a result of setting
> > > PageReserved:
> > > 
> > > [   28.098208] BUG:Bad page state in process mo dprobe pfn:be453
> > > [   28.098394] page:ffffea0002f914c0 refcount:0 mapcount:0
> > > mapping:0000000000000000 index:0x1 pfn:0xbe453
> > > [   28.098394] flags: 0xfffffc0001000(reserved)
> > > [   28.098394] raw: 000fffffc0001000 dead000000000100 dead000000000122
> > > 0000000000000000
> > > [   28.098394] raw: 0000000000000001 0000000000000000 00000000ffffffff
> > > 0000000000000000
> > > [   28.098394] page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
> > > [   28.098394] page_owner info is not present (never set?)
> > > [   28.098394] Modules linked in:
> > > [   28.098394] CPU: 2 PID: 204 Comm: modprobe Not tainted
> > > 5.11.0-3dbd5e3 #66
> > > [   28.098394] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS 0.0.0 02/06/2015
> > > [   28.098394] Call Trace:
> > > [   28.098394]  dump_stack+0xdb/0x120
> > > [   28.098394]  bad_page.cold.108+0xc6/0xcb
> > > [   28.098394]  check_new_page_bad+0x47/0xa0
> > > [   28.098394]  get_page_from_freelist+0x30cd/0x5730
> > > [   28.098394]  ? __isolate_free_page+0x4f0/0x4f0
> > > [   28.098394]  ? init_object+0x7e/0x90
> > > [   28.098394]  __alloc_pages_nodemask+0x2d8/0x650
> > > [   28.098394]  ? write_comp_data+0x2f/0x90
> > > [   28.098394]  ? __alloc_pages_slowpath.constprop.103+0x2110/0x2110
> > > [   28.098394]  ? __sanitizer_cov_trace_pc+0x21/0x50
> > > [   28.098394]  alloc_pages_vma+0xe2/0x560
> > > [   28.098394]  do_fault+0x194/0x12c0
> > > [   28.098394]  ? write_comp_data+0x2f/0x90
> > > [   28.098394]  __handle_mm_fault+0x1650/0x26c0
> > > [   28.098394]  ? copy_page_range+0x1350/0x1350
> > > [   28.098394]  ? write_comp_data+0x2f/0x90
> > > [   28.098394]  ? write_comp_data+0x2f/0x90
> > > [   28.098394]  handle_mm_fault+0x1f9/0x810
> > > [   28.098394]  ? write_comp_data+0x2f/0x90
> > > [   28.098394]  do_user_addr_fault+0x6f7/0xca0
> > > [   28.098394]  exc_page_fault+0xaf/0x1a0
> > > [   28.098394]  asm_exc_page_fault+0x1e/0x30
> > > [   28.098394] RIP: 0010:__clear_user+0x30/0x60
> > 
> > I think the PAGE_FLAGS_CHECK_AT_PREP check in this instance means that
> > someone is trying to allocate that page with the PG_reserved bit set.
> > This means that the page actually was exposed to the buddy.
> > 
> > However, when you SetPageReserved(), I don't think that PG_buddy is set
> > and the refcount is 0. That could indicate that the page is on the buddy
> > PCP list. Could be that it is getting reused a couple of times.
> > 
> > The PFN 0xbe453 looks a little strange, though. Do we expect ACPI tables
> > close to 3 GiB ? No idea. Could it be that you are trying to map a wrong
> > table? Just a guess.
> > 
> > > 
> > > What would be  the correct way to reserve the page so that the above
> > > would not be hit?
> > 
> > I would have assumed that if this is a binary blob, that someone (which
> > I think would be acpi code) reserved via memblock_reserve() early during
> > boot.
> > 
> > E.g., see drivers/acpi/tables.c:acpi_table_upgrade()->memblock_reserve().
> 
> acpi_table_upgrade() gets called, but bails out before memblock_reserve() is
> called. Thus, it appears no pages are getting reserved.

acpi_table_upgrade() does not actually reserve memory but rather open
codes memblock allocation with memblock_find_in_range() +
memblock_reserve(), so it does not seem related anyway.

Do you have by chance a full boot log handy? 
 
>     503 void __init acpi_table_upgrade(void)
>     504 {

...

>     568         if (table_nr == 0)
>     569                 return;                                 <-- bails
> out here
> "drivers/acpi/tables.c"
> 
> George
> 

-- 
Sincerely yours,
Mike.
