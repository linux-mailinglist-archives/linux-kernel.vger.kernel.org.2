Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69BC3254B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhBYRnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:43:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232177AbhBYRnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:43:07 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PHWmPL004083;
        Thu, 25 Feb 2021 12:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=/nWMJgwtZ7Cm8sF4GEYJiUOZKiRImRLfYOx8gpJxRys=;
 b=irXn9tef6j28pcK9CBZ+Z7HLwDqATyoG3Tco9CnCn9ODI5u7iCK6Q4zGX4AO0/Ag04ax
 ytNDyAX21s2puysbucB9F4z4+9EUK1XpbC4yR1rmMwXtAxjTrRH9ugJQfKaIYFcmlOKY
 Um5zhyqB8BhgXkf0ZzCOGk0F8je5dPxNtAdNjxNgHIgNRKERFjIeONf8EiTmvc2rZ+t3
 9b0j/w2sD9MrWLKzRE9JsfGILJyDEhCfbXpSi3iaDwIIrFjUdvDN5CK+dKtCBJHV30+q
 +dIdLrhFfXG93SkPJqRYMyqVXujcry7yWALsM9G38rB0l65FFiy0/OZIUixr3wqvXjaw yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xfcxadey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 12:42:00 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11PHfx3A039690;
        Thu, 25 Feb 2021 12:41:59 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xfcxade2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 12:41:59 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11PHbiII007103;
        Thu, 25 Feb 2021 17:41:57 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 36tt28aehq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 17:41:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11PHfsg026280326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 17:41:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAB1CA4040;
        Thu, 25 Feb 2021 17:41:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E755A4057;
        Thu, 25 Feb 2021 17:41:52 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.51.238])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Feb 2021 17:41:52 +0000 (GMT)
Date:   Thu, 25 Feb 2021 19:41:50 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     George Kennedy <george.kennedy@oracle.com>,
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
Message-ID: <20210225174150.GF1854360@linux.ibm.com>
References: <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
 <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
 <20210225145700.GC1854360@linux.ibm.com>
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
 <20210225160706.GD1854360@linux.ibm.com>
 <dcf821e8-768f-1992-e275-2f1ade405025@oracle.com>
 <24e43280-1442-3c4e-aa57-ac84b987aa58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24e43280-1442-3c4e-aa57-ac84b987aa58@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_10:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 06:23:24PM +0100, David Hildenbrand wrote:
> On 25.02.21 17:31, George Kennedy wrote:
> > : rsdp_address=bfbfa014
> > [    0.066612] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
> > [    0.067759] ACPI: XSDT 0x00000000BFBF90E8 00004C (v01 BOCHS BXPCFACP
> > 00000001      01000013)
> > [    0.069470] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS BXPCFACP
> > 00000001 BXPC 00000001)
> > [    0.071183] ACPI: DSDT 0x00000000BFBF6000 00238D (v01 BOCHS BXPCDSDT
> > 00000001 BXPC 00000001)
> > [    0.072876] ACPI: FACS 0x00000000BFBFD000 000040
> > [    0.073806] ACPI: APIC 0x00000000BFBF4000 000090 (v01 BOCHS BXPCAPIC
> > 00000001 BXPC 00000001)
> > [    0.075501] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS BXPCHPET
> > 00000001 BXPC 00000001)
> > [    0.077194] ACPI: BGRT 0x00000000BE49B000 000038 (v01 INTEL EDK2
> > 00000002      01000013)
> > [    0.078880] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS BXPCFACP
> > 00000000      00000000)
> 
> 
> Can you explore the relevant area using the page-flags tools (located in
> Linux src code located in tools/vm/page-flags.c)
> 
> 
> ./page-types -L -r -a 0xbe490,0xbe4a0

These are not iBFT and they are "ACPI data", so we should have them as
PG_Reserved set at init_unavailable_mem().


[    0.000000] BIOS-e820: [mem 0x0000000000808000-0x000000000080ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000810000-0x00000000008fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000900000-0x00000000be49afff] usable

                               ^ iBFT@0xbe453 lives here ^ 

And it should be a normal page, as it's in "usable" memory and nothing
reserves it at boot, so no reason it won't be freed to buddy.

If iBFT was in the low memory (<1M) it would have been reserved by
reserve_ibft_region(), but with ACPI any block not marked by BIOS as "ACPI
something" is treated like a normal memory and there is nothing that
reserves it.

So we do need to memblock_reserve() iBFT region, but I still couldn't find
the right place to properly get its address without duplicating ACPI tables
parsing :(

[    0.000000] BIOS-e820: [mem 0x00000000be49b000-0x00000000be49bfff] ACPI data




-- 
Sincerely yours,
Mike.
