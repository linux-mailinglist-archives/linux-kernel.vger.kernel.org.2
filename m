Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D0D322DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhBWPuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:50:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233464AbhBWPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:49:18 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NFYKn2068294;
        Tue, 23 Feb 2021 10:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Ak0FuL6cI8F0mJstd0CancH+iLPnxA3Bs8nwiMOi/W8=;
 b=gVd6dsjSuj2n8tH+yahyq2faST/EOQo7WdF1K8YY1QA+E1TPaETdbeK9gKHCLlgr/yE3
 qvQtGqxyi2WSNLo+9b/9ee+oLx6FM+/fg5B7abe5cLTvPk0m/v1ybbEJLFQQbLW06Cts
 AFUCHGXBU0WWGI6iTnrtiVFUgK/OErBbwLFP6K6WAogrTbYlQ08LzFn73lkJZW4v7+uv
 ojSeCH/vLXTlNF8Ln4aYhM6RnuevEvFVFqj0q4Ytn+j8VqI7CgmgLf0dPlVbTPAzAGs3
 XUvPcADl0swnm1rWtyBCZYoj9LESJJ++zYMiCHuO0dnDsRq4j357pRrRrm2DdUMnDRZH Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkfudctf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 10:48:08 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11NFbBSc085265;
        Tue, 23 Feb 2021 10:48:08 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkfudcrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 10:48:08 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11NFhUPm028665;
        Tue, 23 Feb 2021 15:48:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 36tsph9ep4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 15:48:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11NFlolU26345776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 15:47:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01B75AE059;
        Tue, 23 Feb 2021 15:48:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0698AE045;
        Tue, 23 Feb 2021 15:48:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.51.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 23 Feb 2021 15:48:00 +0000 (GMT)
Date:   Tue, 23 Feb 2021 17:47:58 +0200
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
Message-ID: <20210223154758.GF1741768@linux.ibm.com>
References: <c7166cae-bf89-8bdd-5849-72b5949fc6cc@oracle.com>
 <797fae72-e3ea-c0b0-036a-9283fa7f2317@oracle.com>
 <1ac78f02-d0af-c3ff-cc5e-72d6b074fc43@redhat.com>
 <bd7510b5-d325-b516-81a8-fbdc81a27138@oracle.com>
 <56c97056-6d8b-db0e-e303-421ee625abe3@redhat.com>
 <cb8564e8-3535-826b-2d42-b273a0d793fb@oracle.com>
 <20210222215502.GB1741768@linux.ibm.com>
 <9773282a-2854-25a4-9faa-9da5dd34e371@oracle.com>
 <20210223103321.GD1741768@linux.ibm.com>
 <3ef9892f-d657-207f-d4cf-111f98dcb55c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ef9892f-d657-207f-d4cf-111f98dcb55c@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On Tue, Feb 23, 2021 at 09:35:32AM -0500, George Kennedy wrote:
> 
> On 2/23/2021 5:33 AM, Mike Rapoport wrote:
> > (re-added CC)
> > 
> > On Mon, Feb 22, 2021 at 08:24:59PM -0500, George Kennedy wrote:
> > > On 2/22/2021 4:55 PM, Mike Rapoport wrote:
> > > > On Mon, Feb 22, 2021 at 01:42:56PM -0500, George Kennedy wrote:
> > > > > On 2/22/2021 11:13 AM, David Hildenbrand wrote:
> > > > > > On 22.02.21 16:13, George Kennedy wrote:
> > > > > > 
> > > > > > The PFN 0xbe453 looks a little strange, though. Do we expect ACPI tables
> > > > > > close to 3 GiB ? No idea. Could it be that you are trying to map a wrong
> > > > > > table? Just a guess.
> > > > > > 
> > > > > > > What would be  the correct way to reserve the page so that the above
> > > > > > > would not be hit?
> > > > > > I would have assumed that if this is a binary blob, that someone (which
> > > > > > I think would be acpi code) reserved via memblock_reserve() early during
> > > > > > boot.
> > > > > > 
> > > > > > E.g., see drivers/acpi/tables.c:acpi_table_upgrade()->memblock_reserve().
> > > > > acpi_table_upgrade() gets called, but bails out before memblock_reserve() is
> > > > > called. Thus, it appears no pages are getting reserved.
> > > > acpi_table_upgrade() does not actually reserve memory but rather open
> > > > codes memblock allocation with memblock_find_in_range() +
> > > > memblock_reserve(), so it does not seem related anyway.
> > > > 
> > > > Do you have by chance a full boot log handy?
> > > Hello Mike,
> > > 
> > > Are you after the console output? See attached.
> > > 
> > > It includes my patch to set PG_Reserved along with the dump_page() debug
> > > that David asked for - see: "page:"
> > So, iBFT is indeed at pfn 0xbe453:
> > 
> > [    0.077698] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS  BXPCFACP 00000000      00000000)
> > and it's in E820_TYPE_RAM region rather than in ACPI data:
> > 
> > [    0.000000] BIOS-e820: [mem 0x0000000000810000-0x00000000008fffff] ACPI NVS
> > [    0.000000] BIOS-e820: [mem 0x0000000000900000-0x00000000be49afff] usable
> > [    0.000000] BIOS-e820: [mem 0x00000000be49b000-0x00000000be49bfff] ACPI data
> > 
> > I could not find anywhere in x86 setup or in ACPI tables parsing the code
> > that reserves this memory or any other ACPI data for that matter. It could
> > be that I've missed some copying of the data to statically allocated
> > initial_tables, but AFAICS any ACPI data that was not marked as such in
> > e820 tables by BIOS resides in memory that is considered as free.
> > 
> 
> Close...
> 
> Applied the patch, see "[   30.136157] iBFT detected.", but now hit the
> following (missing iounmap()? see full console output attached):
> 
> diff --git a/drivers/firmware/iscsi_ibft_find.c
> b/drivers/firmware/iscsi_ibft_find.c
> index 64bb945..2e5e040 100644
> --- a/drivers/firmware/iscsi_ibft_find.c
> +++ b/drivers/firmware/iscsi_ibft_find.c
> @@ -80,6 +80,21 @@ static int __init find_ibft_in_mem(void)
>  done:
>         return len;
>  }
> +
> +static void __init acpi_find_ibft_region(void)
> +{
> +       int i;
> +       struct acpi_table_header *table = NULL;
> +
> +       if (acpi_disabled)
> +               return;
> +
> +       for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
> +               acpi_get_table(ibft_signs[i].sign, 0, &table);
> +               ibft_addr = (struct acpi_table_ibft *)table;

Can you try adding 

	acpi_put_table(table);

here?

> +       }
> +}
> +

-- 
Sincerely yours,
Mike.
