Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D853251D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 16:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBYO6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:58:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhBYO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:58:22 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PElcBD053797;
        Thu, 25 Feb 2021 09:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=mMaj3P4SrpEf4+/aFD9uJ8yy0sa8Fh7SEIG9gR0/fc4=;
 b=kPXWWFBO5oSOPAtgrNz5L7J9rw6mP1F9ecM/GRT4n+GL8N1FYMIj03PvLb53vcHGILlE
 t+rsEVxO8ALqtxvG0ybGu7D6QU7Vda7vLNjd9ng4DTURAUQqk9lg/HAh4tZ7iFyn2Vz0
 jWkvGwXwKANvkq/YHdCMVd8F2ubczERvUPChY2ZJRtNBoo/LiKvZXvlUAhU3oGQ34JZs
 xedYVfhwGaUSg42QEsxzg8YKjxYlSAfAS4aLItrLZUr+wmQrrjgCBPPIYxoS1/CYCmkL
 OTQvhN5HTURH204HRrkHNCUV8KUm6/GKszGgDLxHPS8LmTLZ0KBs6O58TdBtg2S03GGH VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xdpws3gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 09:57:11 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11PEmLqW059649;
        Thu, 25 Feb 2021 09:57:10 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xdpws3fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 09:57:10 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11PEqPQp012125;
        Thu, 25 Feb 2021 14:57:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 36tt28actd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 14:57:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11PEv5BL43319776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 14:57:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74F36AE053;
        Thu, 25 Feb 2021 14:57:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D106AE04D;
        Thu, 25 Feb 2021 14:57:03 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.51.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Feb 2021 14:57:02 +0000 (GMT)
Date:   Thu, 25 Feb 2021 16:57:00 +0200
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
Message-ID: <20210225145700.GC1854360@linux.ibm.com>
References: <20210223154758.GF1741768@linux.ibm.com>
 <3a56ba38-ce91-63a6-b57c-f1726aa1b76e@oracle.com>
 <20210223200914.GH1741768@linux.ibm.com>
 <af06267d-00cd-d4e0-1985-b06ce7c993a3@oracle.com>
 <20210223213237.GI1741768@linux.ibm.com>
 <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
 <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_09:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:38:19AM -0500, George Kennedy wrote:
> On 2/25/2021 3:53 AM, Mike Rapoport wrote:
> > Hi George,
> > 
> > > On 2/24/2021 5:37 AM, Mike Rapoport wrote:
> > > > On Tue, Feb 23, 2021 at 04:46:28PM -0500, George Kennedy wrote:
> > > > > Mike,
> > > > > 
> > > > > Still no luck.
> > > > > 
> > > > > [   30.193723] iscsi: registered transport (iser)
> > > > > [   30.195970] iBFT detected.
> > > > > [   30.196571] BUG: unable to handle page fault for address: ffffffffff240004
> > > > Hmm, we cannot set ibft_addr to early pointer to the ACPI table.
> > > > Let's try something more disruptive and move the reservation back to
> > > > iscsi_ibft_find.c.
> > > > 
> > > > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > > > index 7bdc0239a943..c118dd54a747 100644
> > > > --- a/arch/x86/kernel/acpi/boot.c
> > > > +++ b/arch/x86/kernel/acpi/boot.c
> > > > @@ -1551,6 +1551,7 @@ void __init acpi_boot_table_init(void)
> > > >    	if (acpi_disabled)
> > > >    		return;
> > > > +#if 0
> > > >    	/*
> > > >    	 * Initialize the ACPI boot-time table parser.
> > > >    	 */
> > > > @@ -1558,6 +1559,7 @@ void __init acpi_boot_table_init(void)
> > > >    		disable_acpi();
> > > >    		return;
> > > >    	}
> > > > +#endif
> > > >    	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
> > > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > > index d883176ef2ce..c615ce96c9a2 100644
> > > > --- a/arch/x86/kernel/setup.c
> > > > +++ b/arch/x86/kernel/setup.c
> > > > @@ -570,16 +570,6 @@ void __init reserve_standard_io_resources(void)
> > > >    }
> > > > -static __init void reserve_ibft_region(void)
> > > > -{
> > > > -	unsigned long addr, size = 0;
> > > > -
> > > > -	addr = find_ibft_region(&size);
> > > > -
> > > > -	if (size)
> > > > -		memblock_reserve(addr, size);
> > > > -}
> > > > -
> > > >    static bool __init snb_gfx_workaround_needed(void)
> > > >    {
> > > >    #ifdef CONFIG_PCI
> > > > @@ -1032,6 +1022,12 @@ void __init setup_arch(char **cmdline_p)
> > > >    	 */
> > > >    	find_smp_config();
> > > > +	/*
> > > > +	 * Initialize the ACPI boot-time table parser.
> > > > +	 */
> > > > +	if (acpi_table_init())
> > > > +		disable_acpi();
> > > > +
> > > >    	reserve_ibft_region();
> > > >    	early_alloc_pgt_buf();
> > > > diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
> > > > index 64bb94523281..01be513843d6 100644
> > > > --- a/drivers/firmware/iscsi_ibft_find.c
> > > > +++ b/drivers/firmware/iscsi_ibft_find.c
> > > > @@ -47,7 +47,25 @@ static const struct {
> > > >    #define VGA_MEM 0xA0000 /* VGA buffer */
> > > >    #define VGA_SIZE 0x20000 /* 128kB */
> > > > -static int __init find_ibft_in_mem(void)
> > > > +static void __init *acpi_find_ibft_region(void)
> > > > +{
> > > > +	int i;
> > > > +	struct acpi_table_header *table = NULL;
> > > > +	acpi_status status;
> > > > +
> > > > +	if (acpi_disabled)
> > > > +		return NULL;
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
> > > > +		status = acpi_get_table(ibft_signs[i].sign, 0, &table);
> > > > +		if (ACPI_SUCCESS(status))
> > > > +			return table;
> > > > +	}
> > > > +
> > > > +	return NULL;
> > > > +}
> > > > +
> > > > +static void __init *find_ibft_in_mem(void)
> > > >    {
> > > >    	unsigned long pos;
> > > >    	unsigned int len = 0;
> > > > @@ -70,35 +88,44 @@ static int __init find_ibft_in_mem(void)
> > > >    				/* if the length of the table extends past 1M,
> > > >    				 * the table cannot be valid. */
> > > >    				if (pos + len <= (IBFT_END-1)) {
> > > > -					ibft_addr = (struct acpi_table_ibft *)virt;
> > > >    					pr_info("iBFT found at 0x%lx.\n", pos);
> > > > -					goto done;
> > > > +					return virt;
> > > >    				}
> > > >    			}
> > > >    		}
> > > >    	}
> > > > -done:
> > > > -	return len;
> > > > +
> > > > +	return NULL;
> > > >    }
> > > > +
> > > > +static void __init *find_ibft(void)
> > > > +{
> > > > +	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
> > > > +	 * only use ACPI for this */
> > > > +	if (!efi_enabled(EFI_BOOT))
> > > > +		return find_ibft_in_mem();
> > > > +	else
> > > > +		return acpi_find_ibft_region();
> > > > +}
> > > > +
> > > >    /*
> > > >     * Routine used to find the iSCSI Boot Format Table. The logical
> > > >     * kernel address is set in the ibft_addr global variable.
> > > >     */
> > > > -unsigned long __init find_ibft_region(unsigned long *sizep)
> > > > +void __init reserve_ibft_region(void)
> > > >    {
> > > > -	ibft_addr = NULL;
> > > > +	struct acpi_table_ibft *table;
> > > > +	unsigned long size;
> > > > -	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
> > > > -	 * only use ACPI for this */
> > > > +	table = find_ibft();
> > > > +	if (!table)
> > > > +		return;
> > > > -	if (!efi_enabled(EFI_BOOT))
> > > > -		find_ibft_in_mem();
> > > > -
> > > > -	if (ibft_addr) {
> > > > -		*sizep = PAGE_ALIGN(ibft_addr->header.length);
> > > > -		return (u64)virt_to_phys(ibft_addr);
> > > > -	}
> > > > +	size = PAGE_ALIGN(table->header.length);
> > > > +	memblock_reserve(virt_to_phys(table), size);
> > > > -	*sizep = 0;
> > > > -	return 0;
> > > > +	if (efi_enabled(EFI_BOOT))
> > > > +		acpi_put_table(&table->header);
> > > > +	else
> > > > +		ibft_addr = table;
> > > >    }
> > > > diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
> > > > index b7b45ca82bea..da813c891990 100644
> > > > --- a/include/linux/iscsi_ibft.h
> > > > +++ b/include/linux/iscsi_ibft.h
> > > > @@ -26,13 +26,9 @@ extern struct acpi_table_ibft *ibft_addr;
> > > >     * mapped address is set in the ibft_addr variable.
> > > >     */
> > > >    #ifdef CONFIG_ISCSI_IBFT_FIND
> > > > -unsigned long find_ibft_region(unsigned long *sizep);
> > > > +void reserve_ibft_region(void);
> > > >    #else
> > > > -static inline unsigned long find_ibft_region(unsigned long *sizep)
> > > > -{
> > > > -	*sizep = 0;
> > > > -	return 0;
> > > > -}
> > > > +static inline void reserve_ibft_region(void) {}
> > > >    #endif
> > > >    #endif /* ISCSI_IBFT_H */
> > > Still no luck Mike,
> > > 
> > > We're back to the original problem where the only thing that worked was to
> > > run "SetPageReserved(page)" before calling "kmap(page)". The page is being
> > > "freed" before ibft_init() is called as a result of the recent buddy page
> > > freeing changes.
> > I keep missing some little details each time :(
> No worries. Thanks for all your help. Does this patch go on top of your
> previous patch or is it standalone?

This is standalone.
 
> George
> > Ok, let's try from the different angle.
> > 
> > diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> > index 4b9b329a5a92..ec43e1447336 100644
> > --- a/drivers/acpi/acpica/tbutils.c
> > +++ b/drivers/acpi/acpica/tbutils.c
> > @@ -7,6 +7,8 @@
> >    *
> >    *****************************************************************************/
> > +#include <linux/memblock.h>
> > +
> >   #include <acpi/acpi.h>
> >   #include "accommon.h"
> >   #include "actables.h"
> > @@ -339,6 +341,21 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
> >   			acpi_tb_parse_fadt();
> >   		}
> > +		if (ACPI_SUCCESS(status) &&
> > +		    ACPI_COMPARE_NAMESEG(&acpi_gbl_root_table_list.
> > +					 tables[table_index].signature,
> > +					 ACPI_SIG_IBFT)) {
> > +			struct acpi_table_header *ibft;
> > +			struct acpi_table_desc *desc;
> > +
> > +			desc = &acpi_gbl_root_table_list.tables[table_index];
> > +			status = acpi_tb_get_table(desc, &ibft);
> > +			if (ACPI_SUCCESS(status)) {
> > +				memblock_reserve(address, ibft->length);
> > +				acpi_tb_put_table(desc);
> > +			}
> > +		}
> > +
> >   next_table:
> >   		table_entry += table_entry_size;
> > 
> > 
> 

-- 
Sincerely yours,
Mike.
