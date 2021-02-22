Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4C4321F62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBVSuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:50:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231709AbhBVStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:49:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MIgiTv158848;
        Mon, 22 Feb 2021 13:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=7g8nMPK0BWDP02m4h8rVpPLI++nL8C+0dAkk5BW4xow=;
 b=IFr69xQANSi7a0VXN4CAuSGV0DIWl7KVH/9GpyBcx8tGQhaEhkIhP7lQMfGpYsuR9JmP
 NtnrPrOOMiOwwn+REYhlyoOy5M1aXHxCcKwLqP60oZIof5jSckoo+GBWPK7vzsE3EpNo
 4NYUJpWD6PbrTaYf/dwJsbyhl+EWNDUyFifJ/nkGgYAWmzb5YzWEXZfMPVVV6liCa8jz
 cXrMG/R03sECr410VASMeMTd+md4KuV9ZVv99fDsPtS1QqBXIM5pOEbK2rvnfYk+806t
 CQ2JJeg08eOnGSmRTrZMW2KJne+DscipysdAQ5DL2Y162jepp9/4yQwTQkt62Rxye20t tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vhy78k8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 13:47:47 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11MIgvj2159799;
        Mon, 22 Feb 2021 13:47:33 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vhy78j7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 13:47:32 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MIgCZM014626;
        Mon, 22 Feb 2021 18:45:52 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 36tt289wmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 18:45:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MIjnkg43712902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 18:45:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFA0911C05B;
        Mon, 22 Feb 2021 18:45:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCDF211C04A;
        Mon, 22 Feb 2021 18:45:45 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.51.238])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 22 Feb 2021 18:45:45 +0000 (GMT)
Date:   Mon, 22 Feb 2021 20:45:43 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     David Hildenbrand <david@redhat.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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
Message-ID: <20210222184543.GA1741768@linux.ibm.com>
References: <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com>
 <d11bf144-669b-0fe1-4fa4-001a014db32a@oracle.com>
 <CAAeHK+y_SmP5yAeSM3Cp6V3WH9uj4737hDuVGA7U=xA42ek3Lw@mail.gmail.com>
 <c7166cae-bf89-8bdd-5849-72b5949fc6cc@oracle.com>
 <797fae72-e3ea-c0b0-036a-9283fa7f2317@oracle.com>
 <1ac78f02-d0af-c3ff-cc5e-72d6b074fc43@redhat.com>
 <bd7510b5-d325-b516-81a8-fbdc81a27138@oracle.com>
 <56c97056-6d8b-db0e-e303-421ee625abe3@redhat.com>
 <4c7351e2-e97c-e740-5800-ada5504588aa@redhat.com>
 <20210222174036.GA399355@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222174036.GA399355@fedora>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_06:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220163
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 12:40:36PM -0500, Konrad Rzeszutek Wilk wrote:
> On Mon, Feb 22, 2021 at 05:39:29PM +0100, David Hildenbrand wrote:
> > On 22.02.21 17:13, David Hildenbrand wrote:
> > > On 22.02.21 16:13, George Kennedy wrote:
> > > > 
> > > > 
> > > > On 2/22/2021 4:52 AM, David Hildenbrand wrote:
> > > > > On 20.02.21 00:04, George Kennedy wrote:
> > > > > > 
> > > > > > 
> > > > > > On 2/19/2021 11:45 AM, George Kennedy wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 2/18/2021 7:09 PM, Andrey Konovalov wrote:
> > > > > > > > On Fri, Feb 19, 2021 at 1:06 AM George Kennedy
> > > > > > > > <george.kennedy@oracle.com> wrote:
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > On 2/18/2021 3:55 AM, David Hildenbrand wrote:
> > > > > > > > > > On 17.02.21 21:56, Andrey Konovalov wrote:
> > > > > > > > > > > During boot, all non-reserved memblock memory is exposed to the
> > > > > > > > > > > buddy
> > > > > > > > > > > allocator. Poisoning all that memory with KASAN lengthens boot
> > > > > > > > > > > time,
> > > > > > > > > > > especially on systems with large amount of RAM. This patch makes
> > > > > > > > > > > page_alloc to not call kasan_free_pages() on all new memory.
> > > > > > > > > > > 
> > > > > > > > > > > __free_pages_core() is used when exposing fresh memory during
> > > > > > > > > > > system
> > > > > > > > > > > boot and when onlining memory during hotplug. This patch adds a new
> > > > > > > > > > > FPI_SKIP_KASAN_POISON flag and passes it to __free_pages_ok()
> > > > > > > > > > > through
> > > > > > > > > > > free_pages_prepare() from __free_pages_core().
> > > > > > > > > > > 
> > > > > > > > > > > This has little impact on KASAN memory tracking.
> > > > > > > > > > > 
> > > > > > > > > > > Assuming that there are no references to newly exposed pages
> > > > > > > > > > > before they
> > > > > > > > > > > are ever allocated, there won't be any intended (but buggy)
> > > > > > > > > > > accesses to
> > > > > > > > > > > that memory that KASAN would normally detect.
> > > > > > > > > > > 
> > > > > > > > > > > However, with this patch, KASAN stops detecting wild and large
> > > > > > > > > > > out-of-bounds accesses that happen to land on a fresh memory page
> > > > > > > > > > > that
> > > > > > > > > > > was never allocated. This is taken as an acceptable trade-off.
> > > > > > > > > > > 
> > > > > > > > > > > All memory allocated normally when the boot is over keeps getting
> > > > > > > > > > > poisoned as usual.
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > > > > > > > Change-Id: Iae6b1e4bb8216955ffc14af255a7eaaa6f35324d
> > > > > > > > > > Not sure this is the right thing to do, see
> > > > > > > > > > 
> > > > > > > > > > https://lkml.kernel.org/r/bcf8925d-0949-3fe1-baa8-cc536c529860@oracle.com
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Reversing the order in which memory gets allocated + used during
> > > > > > > > > > boot
> > > > > > > > > > (in a patch by me) might have revealed an invalid memory access
> > > > > > > > > > during
> > > > > > > > > > boot.
> > > > > > > > > > 
> > > > > > > > > > I suspect that that issue would no longer get detected with your
> > > > > > > > > > patch, as the invalid memory access would simply not get detected.
> > > > > > > > > > Now, I cannot prove that :)
> > > > > > > > > Since David's patch we're having trouble with the iBFT ACPI table,
> > > > > > > > > which
> > > > > > > > > is mapped in via kmap() - see acpi_map() in "drivers/acpi/osl.c".
> > > > > > > > > KASAN
> > > > > > > > > detects that it is being used after free when ibft_init() accesses
> > > > > > > > > the
> > > > > > > > > iBFT table, but as of yet we can't find where it get's freed (we've
> > > > > > > > > instrumented calls to kunmap()).
> > > > > > > > Maybe it doesn't get freed, but what you see is a wild or a large
> > > > > > > > out-of-bounds access. Since KASAN marks all memory as freed during the
> > > > > > > > memblock->page_alloc transition, such bugs can manifest as
> > > > > > > > use-after-frees.
> > > > > > > 
> > > > > > > It gets freed and re-used. By the time the iBFT table is accessed by
> > > > > > > ibft_init() the page has been over-written.
> > > > > > > 
> > > > > > > Setting page flags like the following before the call to kmap()
> > > > > > > prevents the iBFT table page from being freed:
> > > > > > 
> > > > > > Cleaned up version:
> > > > > > 
> > > > > > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > > > > > index 0418feb..8f0a8e7 100644
> > > > > > --- a/drivers/acpi/osl.c
> > > > > > +++ b/drivers/acpi/osl.c
> > > > > > @@ -287,9 +287,12 @@ static void __iomem *acpi_map(acpi_physical_address
> > > > > > pg_off, unsigned long pg_sz)
> > > > > > 
> > > > > >          pfn = pg_off >> PAGE_SHIFT;
> > > > > >          if (should_use_kmap(pfn)) {
> > > > > > +        struct page *page = pfn_to_page(pfn);
> > > > > > +
> > > > > >              if (pg_sz > PAGE_SIZE)
> > > > > >                  return NULL;
> > > > > > -        return (void __iomem __force *)kmap(pfn_to_page(pfn));
> > > > > > +        SetPageReserved(page);
> > > > > > +        return (void __iomem __force *)kmap(page);
> > > > > >          } else
> > > > > >              return acpi_os_ioremap(pg_off, pg_sz);
> > > > > >      }
> > > > > > @@ -299,9 +302,12 @@ static void acpi_unmap(acpi_physical_address
> > > > > > pg_off, void __iomem *vaddr)
> > > > > >          unsigned long pfn;
> > > > > > 
> > > > > >          pfn = pg_off >> PAGE_SHIFT;
> > > > > > -    if (should_use_kmap(pfn))
> > > > > > -        kunmap(pfn_to_page(pfn));
> > > > > > -    else
> > > > > > +    if (should_use_kmap(pfn)) {
> > > > > > +        struct page *page = pfn_to_page(pfn);
> > > > > > +
> > > > > > +        ClearPageReserved(page);
> > > > > > +        kunmap(page);
> > > > > > +    } else
> > > > > >              iounmap(vaddr);
> > > > > >      }
> > > > > > 
> > > > > > David, the above works, but wondering why it is now necessary. kunmap()
> > > > > > is not hit. What other ways could a page mapped via kmap() be unmapped?
> > > > > > 
> > > > > 
> > > > > Let me look into the code ... I have little experience with ACPI
> > > > > details, so bear with me.
> > > > > 
> > > > > I assume that acpi_map()/acpi_unmap() map some firmware blob that is
> > > > > provided via firmware/bios/... to us.
> > > > > 
> > > > > should_use_kmap() tells us whether
> > > > > a) we have a "struct page" and should kmap() that one
> > > > > b) we don't have a "struct page" and should ioremap.
> > > > > 
> > > > > As it is a blob, the firmware should always reserve that memory region
> > > > > via memblock (e.g., memblock_reserve()), such that we either
> > > > > 1) don't create a memmap ("struct page") at all (-> case b) )
> > > > > 2) if we have to create e memmap, we mark the page PG_reserved and
> > > > >      *never* expose it to the buddy (-> case a) )
> > > > > 
> > > > > 
> > > > > Are you telling me that in this case we might have a memmap for the HW
> > > > > blob that is *not* PG_reserved? In that case it most probably got
> > > > > exposed to the buddy where it can happily get allocated/freed.
> > > > > 
> > > > > The latent BUG would be that that blob gets exposed to the system like
> > > > > ordinary RAM, and not reserved via memblock early during boot.
> > > > > Assuming that blob has a low physical address, with my patch it will
> > > > > get allocated/used a lot earlier - which would mean we trigger this
> > > > > latent BUG now more easily.
> > > > > 
> > > > > There have been similar latent BUGs on ARM boards that my patch
> > > > > discovered where special RAM regions did not get marked as reserved
> > > > > via the device tree properly.
> > > > > 
> > > > > Now, this is just a wild guess :) Can you dump the page when mapping
> > > > > (before PageReserved()) and when unmapping, to see what the state of
> > > > > that memmap is?
> > > > 
> > > > Thank you David for the explanation and your help on this,
> > > > 
> > > > dump_page() before PageReserved and before kmap() in the above patch:
> > > > 
> > > > [    1.116480] ACPI: Core revision 20201113
> > > > [    1.117628] XXX acpi_map: about to call kmap()...
> > > > [    1.118561] page:ffffea0002f914c0 refcount:0 mapcount:0
> > > > mapping:0000000000000000 index:0x0 pfn:0xbe453
> > > > [    1.120381] flags: 0xfffffc0000000()
> > > > [    1.121116] raw: 000fffffc0000000 ffffea0002f914c8 ffffea0002f914c8
> > > > 0000000000000000
> > > > [    1.122638] raw: 0000000000000000 0000000000000000 00000000ffffffff
> > > > 0000000000000000
> > > > [    1.124146] page dumped because: acpi_map pre SetPageReserved
> > > > 
> > > > I also added dump_page() before unmapping, but it is not hit. The
> > > > following for the same pfn now shows up I believe as a result of setting
> > > > PageReserved:
> > > > 
> > > > [   28.098208] BUG:Bad page state in process mo dprobe  pfn:be453
> > > > [   28.098394] page:ffffea0002f914c0 refcount:0 mapcount:0
> > > > mapping:0000000000000000 index:0x1 pfn:0xbe453
> > > > [   28.098394] flags: 0xfffffc0001000(reserved)
> > > > [   28.098394] raw: 000fffffc0001000 dead000000000100 dead000000000122
> > > > 0000000000000000
> > > > [   28.098394] raw: 0000000000000001 0000000000000000 00000000ffffffff
> > > > 0000000000000000
> > > > [   28.098394] page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
> > > > [   28.098394] page_owner info is not present (never set?)
> > > > [   28.098394] Modules linked in:
> > > > [   28.098394] CPU: 2 PID: 204 Comm: modprobe Not tainted 5.11.0-3dbd5e3 #66
> > > > [   28.098394] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > > BIOS 0.0.0 02/06/2015
> > > > [   28.098394] Call Trace:
> > > > [   28.098394]  dump_stack+0xdb/0x120
> > > > [   28.098394]  bad_page.cold.108+0xc6/0xcb
> > > > [   28.098394]  check_new_page_bad+0x47/0xa0
> > > > [   28.098394]  get_page_from_freelist+0x30cd/0x5730
> > > > [   28.098394]  ? __isolate_free_page+0x4f0/0x4f0
> > > > [   28.098394]  ? init_object+0x7e/0x90
> > > > [   28.098394]  __alloc_pages_nodemask+0x2d8/0x650
> > > > [   28.098394]  ? write_comp_data+0x2f/0x90
> > > > [   28.098394]  ? __alloc_pages_slowpath.constprop.103+0x2110/0x2110
> > > > [   28.098394]  ? __sanitizer_cov_trace_pc+0x21/0x50
> > > > [   28.098394]  alloc_pages_vma+0xe2/0x560
> > > > [   28.098394]  do_fault+0x194/0x12c0
> > > > [   28.098394]  ? write_comp_data+0x2f/0x90
> > > > [   28.098394]  __handle_mm_fault+0x1650/0x26c0
> > > > [   28.098394]  ? copy_page_range+0x1350/0x1350
> > > > [   28.098394]  ? write_comp_data+0x2f/0x90
> > > > [   28.098394]  ? write_comp_data+0x2f/0x90
> > > > [   28.098394]  handle_mm_fault+0x1f9/0x810
> > > > [   28.098394]  ? write_comp_data+0x2f/0x90
> > > > [   28.098394]  do_user_addr_fault+0x6f7/0xca0
> > > > [   28.098394]  exc_page_fault+0xaf/0x1a0
> > > > [   28.098394]  asm_exc_page_fault+0x1e/0x30
> > > > [   28.098394] RIP: 0010:__clear_user+0x30/0x60
> > > 
> > > I think the PAGE_FLAGS_CHECK_AT_PREP check in this instance means that
> > > someone is trying to allocate that page with the PG_reserved bit set.
> > > This means that the page actually was exposed to the buddy.
> > > 
> > > However, when you SetPageReserved(), I don't think that PG_buddy is set
> > > and the refcount is 0. That could indicate that the page is on the buddy
> > > PCP list. Could be that it is getting reused a couple of times.
> > > 
> > > The PFN 0xbe453 looks a little strange, though. Do we expect ACPI tables
> > > close to 3 GiB ? No idea. Could it be that you are trying to map a wrong
> > > table? Just a guess.
> 
> Nah, ACPI MADT enumerates the table and that is the proper location of it.
> > 
> > ... but I assume ibft_check_device() would bail out on an invalid checksum.
> > So the question is, why is this page not properly marked as reserved
> > already.
> 
> The ibft_check_device ends up being called as module way way after the
> kernel has cleaned the memory.
> 
> The funny thing about iBFT is that (it is also mentioned in the spec)
> that the table can resize in memory .. or in the ACPI regions (which

                   ^ reside I presume?

> have no E820_RAM and are considered "MMIO" regions).
> 
> Either place is fine, so it can be in either RAM or MMIO :-(

I'd say that the tables in this case are in E820_RAM, because with MMIO we
wouldn't get to kmap() at the first place.
It can be easily confirmed by comparing the problematic address with
/proc/iomem.

Can't say I have a clue about what's going on there, but the theory that
somehow iBFT table does not get PG_Reserved during boot makes sense.

Do you see "iBFT found at 0x<addr>" early in the kernel log?

I don't know if ACPI relocates the tables, but I could not find anywhere
that it reserves the original ones. The memblock_reserve() in
acpi_table_upgrade() is merely a part of open coded memblock allocation.

-- 
Sincerely yours,
Mike.
