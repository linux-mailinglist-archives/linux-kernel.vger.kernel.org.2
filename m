Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FAA3273BF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 19:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhB1SJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 13:09:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231295AbhB1SJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 13:09:49 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11SI4TRM141005;
        Sun, 28 Feb 2021 13:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=4bb935c/UZyEQhCai159ASVF1c2deNbr/2p5TWhmbJc=;
 b=YE21XdX46aBFkYH+sul7Ck3aEc2l0vgnZmGUCKfZQ2CaRwZPVfLVpv+vwEFSVj1Ek63z
 p+y7Y8aCs0OIbCj/QQekJTEBPA15o9aCKHcGOsYDk4N045E/wAuxVQlwzOpS5nFWdVbi
 CKgWrKtRfQ/aVZgoXfZSdCbWjlyT2BEpSgFe0UMVIvX2soiyB5K6hOjEsZGMAozTn0fl
 BaXW5MdQaKY60GGZBPit4bv5p23ZiCc8qgCHswTqKg1/pfZjFEZ02/WJkLVvjkDj1LDi
 1UxXog3LZMHNPzICgDfUacOFhNPsnJ0jlJLVUFb4Xim3uFTliNYOVn3cTaNVdMWWGqNY IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 370410w9v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Feb 2021 13:08:41 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11SI4iI1141354;
        Sun, 28 Feb 2021 13:08:40 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 370410w9u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Feb 2021 13:08:40 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11SI2b3G020519;
        Sun, 28 Feb 2021 18:08:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 36ydq893ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Feb 2021 18:08:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11SI8Zsh31588766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Feb 2021 18:08:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C302BAE045;
        Sun, 28 Feb 2021 18:08:35 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A0D7AE051;
        Sun, 28 Feb 2021 18:08:33 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.18.192])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 28 Feb 2021 18:08:33 +0000 (GMT)
Date:   Sun, 28 Feb 2021 20:08:31 +0200
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
Message-ID: <YDvcH7IY8hV4u2Zh@linux.ibm.com>
References: <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
 <20210225145700.GC1854360@linux.ibm.com>
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
 <20210225160706.GD1854360@linux.ibm.com>
 <6000e7fd-bf8b-b9b0-066d-23661da8a51d@oracle.com>
 <dc5e007c-9223-b03b-1c58-28d2712ec352@oracle.com>
 <20210226111730.GL1854360@linux.ibm.com>
 <e9e2f1a3-80f2-1b3e-6ffd-8004fe41c485@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9e2f1a3-80f2-1b3e-6ffd-8004fe41c485@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-28_07:2021-02-26,2021-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102280156
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:16:06AM -0500, George Kennedy wrote:
> On 2/26/2021 6:17 AM, Mike Rapoport wrote:
> > Hi George,
> > 
> > On Thu, Feb 25, 2021 at 08:19:18PM -0500, George Kennedy wrote:
> > > 
> > > Not sure if it's the right thing to do, but added
> > > "acpi_tb_find_table_address()" to return the physical address of a table to
> > > use with memblock_reserve().
> > > 
> > > virt_to_phys(table) does not seem to return the physical address for the
> > > iBFT table (it would be nice if struct acpi_table_header also had a
> > > "address" element for the physical address of the table).
> >
> > virt_to_phys() does not work that early because then it is mapped with
> > early_memremap()  which uses different virtual to physical scheme.
> > 
> > I'd say that acpi_tb_find_table_address() makes sense if we'd like to
> > reserve ACPI tables outside of drivers/acpi.
> > 
> > But probably we should simply reserve all the tables during
> > acpi_table_init() so that any table that firmware put in the normal memory
> > will be surely reserved.
> > > Ran 10 successful boots with the above without failure.
> > That's good news indeed :)
> 
> Wondering if we could do something like this instead (trying to keep changes
> minimal). Just do the memblock_reserve() for all the standard tables.

I think something like this should work, but I'm not an ACPI expert to say
if this the best way to reserve the tables.
 
> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
> index 0bb15ad..830f82c 100644
> --- a/drivers/acpi/acpica/tbinstal.c
> +++ b/drivers/acpi/acpica/tbinstal.c
> @@ -7,6 +7,7 @@
>   *
> *****************************************************************************/
> 
> +#include <linux/memblock.h>
>  #include <acpi/acpi.h>
>  #include "accommon.h"
>  #include "actables.h"
> @@ -14,6 +15,23 @@
>  #define _COMPONENT          ACPI_TABLES
>  ACPI_MODULE_NAME("tbinstal")
> 
> +void
> +acpi_tb_reserve_standard_table(acpi_physical_address address,
> +               struct acpi_table_header *header)
> +{
> +    struct acpi_table_header local_header;
> +
> +    if ((ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) ||
> +        (ACPI_VALIDATE_RSDP_SIG(header->signature))) {
> +        return;
> +    }
> +    /* Standard ACPI table with full common header */
> +
> +    memcpy(&local_header, header, sizeof(struct acpi_table_header));
> +
> +    memblock_reserve(address, PAGE_ALIGN(local_header.length));
> +}
> +
>  /*******************************************************************************
>   *
>   * FUNCTION:    acpi_tb_install_table_with_override
> @@ -58,6 +76,9 @@
>                        new_table_desc->flags,
>                        new_table_desc->pointer);
> 
> +    acpi_tb_reserve_standard_table(new_table_desc->address,
> +                   new_table_desc->pointer);
> +
>      acpi_tb_print_table_header(new_table_desc->address,
>                     new_table_desc->pointer);
> 
> There should be no harm in doing the memblock_reserve() for all the standard
> tables, right?

It should be ok to memblock_reserve() all the tables very early as long as
we don't run out of static entries in memblock.reserved.

We just need to make sure the tables are reserved before memblock
allocations are possible, so we'd still need to move acpi_table_init() in
x86::setup_arch() before e820__memblock_setup().
Not sure how early ACPI is initialized on arm64.
 
> Ran 10 boots with the above without failure.
> 
> George

-- 
Sincerely yours,
Mike.
