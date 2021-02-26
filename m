Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B773261E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhBZLSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:18:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230164AbhBZLSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:18:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QB3jwR080096;
        Fri, 26 Feb 2021 06:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=yhvr1Xkbh7XOwtOWAyA3QzMCb183Bb/rbHDxBvE6E48=;
 b=EbjwnvBb1pWi3H4bcvxNzG/xF/xasyvZmO06exVMexdK/s5wvrKoHlSou/GlIBDVT37v
 hkeYUYUi2cN26n0ZAyy/OOAMpDnCjDdUbGYfGyBEXRm1eXDuN/69ECD0qiqzeqveIYfX
 mgjda5KWd7MDnOaCruTQ24KM9Nzz4Ar4Oedptv1EOG/bbo2aBzbr5yYOqEilJXD+nmyl
 jIM/vdEa2Ydwtz89c8NkmYH81RHNffV56XDR7OawyRpGJ7Sl7eecujQCdyyTn4mry6Vx
 KVf0fx8zaBawUggQI6o5Z6d9Em1PpLL+q9Dgsat7SaVefGYT9Ko3W3yfrvnPW4qJnuZd LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xphuq02m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 06:17:39 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11QB41fZ082178;
        Fri, 26 Feb 2021 06:17:39 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xphuq01k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 06:17:39 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QBGZHP032136;
        Fri, 26 Feb 2021 11:17:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 36tt28d7bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 11:17:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QBHYHX35913984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 11:17:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 547BFAE04D;
        Fri, 26 Feb 2021 11:17:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26B05AE056;
        Fri, 26 Feb 2021 11:17:32 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.51.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 26 Feb 2021 11:17:32 +0000 (GMT)
Date:   Fri, 26 Feb 2021 13:17:30 +0200
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
Message-ID: <20210226111730.GL1854360@linux.ibm.com>
References: <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
 <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
 <20210225145700.GC1854360@linux.ibm.com>
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
 <20210225160706.GD1854360@linux.ibm.com>
 <6000e7fd-bf8b-b9b0-066d-23661da8a51d@oracle.com>
 <dc5e007c-9223-b03b-1c58-28d2712ec352@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc5e007c-9223-b03b-1c58-28d2712ec352@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_02:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On Thu, Feb 25, 2021 at 08:19:18PM -0500, George Kennedy wrote:
> 
> Mike,
> 
> To get rid of the 0x00000000BE453000 hardcoding, I added the following patch
> to your above patch to get the iBFT table "address" to use with
> memblock_reserve():
> 
> diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
> index 56d81e4..4bc7bf3 100644
> --- a/drivers/acpi/acpica/tbfind.c
> +++ b/drivers/acpi/acpica/tbfind.c
> @@ -120,3 +120,34 @@
>      (void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
>      return_ACPI_STATUS(status);
>  }
> +
> +acpi_physical_address
> +acpi_tb_find_table_address(char *signature)
> +{
> +    acpi_physical_address address = 0;
> +    struct acpi_table_desc *table_desc;
> +    int i;
> +
> +    ACPI_FUNCTION_TRACE(tb_find_table_address);
> +
> +printk(KERN_ERR "XXX acpi_tb_find_table_address: signature=%s\n",
> signature);
> +
> +    (void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
> +    for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
> +        if (memcmp(&(acpi_gbl_root_table_list.tables[i].signature),
> +               signature, ACPI_NAMESEG_SIZE)) {
> +
> +            /* Not the requested table */
> +
> +            continue;
> +        }
> +
> +        /* Table with matching signature has been found */
> +        table_desc = &acpi_gbl_root_table_list.tables[i];
> +        address = table_desc->address;
> +    }
> +
> +    (void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
> +printk(KERN_ERR "XXX acpi_tb_find_table_address(EXIT): address=%llx\n",
> address);
> +    return address;
> +}
> diff --git a/drivers/firmware/iscsi_ibft_find.c
> b/drivers/firmware/iscsi_ibft_find.c
> index 95fc1a6..0de70b4 100644
> --- a/drivers/firmware/iscsi_ibft_find.c
> +++ b/drivers/firmware/iscsi_ibft_find.c
> @@ -28,6 +28,8 @@
> 
>  #include <asm/mmzone.h>
> 
> +extern acpi_physical_address acpi_tb_find_table_address(char *signature);
> +
>  /*
>   * Physical location of iSCSI Boot Format Table.
>   */
> @@ -116,24 +118,32 @@ void __init reserve_ibft_region(void)
>  {
>      struct acpi_table_ibft *table;
>      unsigned long size;
> +    acpi_physical_address address;
> 
>      table = find_ibft();
>      if (!table)
>          return;
> 
>      size = PAGE_ALIGN(table->header.length);
> +    address = acpi_tb_find_table_address(table->header.signature);
>  #if 0
>  printk(KERN_ERR "XXX reserve_ibft_region: table=%llx,
> virt_to_phys(table)=%llx, size=%lx\n",
>      (u64)table, virt_to_phys(table), size);
>      memblock_reserve(virt_to_phys(table), size);
>  #else
> -printk(KERN_ERR "XXX reserve_ibft_region: table=%llx, 0x00000000BE453000,
> size=%lx\n",
> -    (u64)table, size);
> -    memblock_reserve(0x00000000BE453000, size);
> +printk(KERN_ERR "XXX reserve_ibft_region: table=%llx, address=%llx,
> size=%lx\n",
> +    (u64)table, address, size);
> +    if (address)
> +        memblock_reserve(address, size);
> +    else
> +        printk(KERN_ERR "%s: Can't find table address\n", __func__);
>  #endif
> 
> -    if (efi_enabled(EFI_BOOT))
> +    if (efi_enabled(EFI_BOOT)) {
> +printk(KERN_ERR "XXX reserve_ibft_region: calling acpi_put_table(%llx)\n",
> (u64)&table->header);
>          acpi_put_table(&table->header);
> -    else
> +    } else {
>          ibft_addr = table;
> +printk(KERN_ERR "XXX reserve_ibft_region: ibft_addr=%llx\n",
> (u64)ibft_addr);
> +    }
>  }
> 
> Debug from the above:
> [    0.050646] ACPI: Early table checksum verification disabled
> [    0.051778] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
> [    0.052922] ACPI: XSDT 0x00000000BFBF90E8 00004C (v01 BOCHS BXPCFACP
> 00000001      01000013)
> [    0.054623] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS BXPCFACP
> 00000001 BXPC 00000001)
> [    0.056326] ACPI: DSDT 0x00000000BFBF6000 00238D (v01 BOCHS BXPCDSDT
> 00000001 BXPC 00000001)
> [    0.058016] ACPI: FACS 0x00000000BFBFD000 000040
> [    0.058940] ACPI: APIC 0x00000000BFBF4000 000090 (v01 BOCHS BXPCAPIC
> 00000001 BXPC 00000001)
> [    0.060627] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS BXPCHPET
> 00000001 BXPC 00000001)
> [    0.062304] ACPI: BGRT 0x00000000BE49B000 000038 (v01 INTEL EDK2    
> 00000002      01000013)
> [    0.063987] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS BXPCFACP
> 00000000      00000000)
> [    0.065683] XXX acpi_tb_find_table_address: signature=iBFT
> [    0.066754] XXX acpi_tb_find_table_address(EXIT): address=be453000
> [    0.067959] XXX reserve_ibft_region: table=ffffffffff240000,
> address=be453000, size=1000
> [    0.069534] XXX reserve_ibft_region: calling
> acpi_put_table(ffffffffff240000)
> 
> Not sure if it's the right thing to do, but added
> "acpi_tb_find_table_address()" to return the physical address of a table to
> use with memblock_reserve().
> 
> virt_to_phys(table) does not seem to return the physical address for the
> iBFT table (it would be nice if struct acpi_table_header also had a
> "address" element for the physical address of the table).

virt_to_phys() does not work that early because then it is mapped with
early_memremap()  which uses different virtual to physical scheme.

I'd say that acpi_tb_find_table_address() makes sense if we'd like to
reserve ACPI tables outside of drivers/acpi. 

But probably we should simply reserve all the tables during
acpi_table_init() so that any table that firmware put in the normal memory
will be surely reserved.
 
> Ran 10 successful boots with the above without failure.

That's good news indeed :)

> George
> > 
> > 

-- 
Sincerely yours,
Mike.
