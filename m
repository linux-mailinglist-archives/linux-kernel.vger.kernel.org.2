Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65754393397
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbhE0QXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:23:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229596AbhE0QXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:23:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RG4MX6167881;
        Thu, 27 May 2021 12:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ORzFNe0G+WYzU2+JA9c9h8YyxTQJ1yH3Q1Z/MeSInEQ=;
 b=JafX2+5D+7BakRDR+/+2QK+aj2fxfzqPIfVGwq//+YXg7k87jj+35Ay8QNbF3uMzv50o
 Fis/9jbBeu6CNQjCoBTibn1RcShloPKjPr0z4z5trl5SakcMuSBCIetXppgwSTZrENKB
 +e+HAWIgUwjM1/sLqNTnIx+sVwO4M8DspgC8GTZGy3qYPL2OyDX+P4wB+qv+z83IyPl0
 2IojJZN+bGDdtMN9HBSLmIOsYwr9Qqd0yZo6ZFQelTKo4UQfQMjbefXduJ1yQgsqHRDo
 MZsEQlefS0GuXuYHj0KB2O+f/T3vrz6ngfKq5MYWoPtmFV/b0dnBIDhDtPAYgDcTHb15 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38td0wd256-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 12:22:08 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14RG4ngV170032;
        Thu, 27 May 2021 12:22:07 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38td0wd249-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 12:22:07 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14RGIBoZ017591;
        Thu, 27 May 2021 16:22:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 38swpa08bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 16:22:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14RGM3xK31981876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 16:22:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E76FA4051;
        Thu, 27 May 2021 16:22:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C65FA4057;
        Thu, 27 May 2021 16:22:02 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.39.77])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 27 May 2021 16:22:02 +0000 (GMT)
Date:   Thu, 27 May 2021 19:22:00 +0300
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
Message-ID: <YK/HKMgajBCwpLt8@linux.ibm.com>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
 <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
 <YK6EXNZHY1xt7Kjs@linux.ibm.com>
 <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
 <YK9e0LgDOfCFo6TM@linux.ibm.com>
 <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qMqVU8FV7I7pQ1xz4BBZteNHh9eULiaL
X-Proofpoint-ORIG-GUID: 3YnKkD0oZZyebVhkuWkrs9KO5l6fd8oM
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_07:2021-05-27,2021-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=762 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 10:33:13AM -0400, Qian Cai wrote:
> 
> 
> On 5/27/2021 4:56 AM, Mike Rapoport wrote:
> > Let's drop memblock=debug for now and add this instead:
> 
> [    0.000000][    T0] Booting Linux on physical CPU 0x0000000000 [0x503f0002]
> [    0.000000][    T0] Linux version 5.13.0-rc3-next-20210526+ (root@admin5) (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #31 SMP Thu May 27 12:32:40 UTC 2021
> [    0.000000][    T0] Inode-cache hash table entries: 4194304 (order: 9, 33554432 bytes, linear)
> [    0.000000][    T0] mem auto-init: stack:off, heap alloc:on, heap free:off
> [    0.000000][    T0] MEMBLOCK configuration:
> [    0.000000][    T0]  memory size = 0x0000001ff0000000 reserved size = 0x0000000421e33ae8
> [    0.000000][    T0]  memory.cnt  = 0xc
> [    0.000000][    T0] Memory: 777216K/133955584K available (17984K kernel code, 118722K rwdata, 4416K rodata, 6080K init, 67276K bss, 17379072K reserved, 0K cma-reserved)

I still cannot understand where most of the memory disappeared, but it
seems entirely different issue.
 
> > Sorry, I've missed that the BUG is apparently triggered for pfn + i. Can
> > you please try this instead:
> 
> [  259.216661][ T1417] test_pages_in_a_zone: pfn 8000 is not valid
> [  259.226547][ T1417] page:00000000f4aa8c5c is uninitialized and poisoned
> [  259.226560][ T1417] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))

Can you please try Anshuman's patch "arm64/mm: Drop HAVE_ARCH_PFN_VALID":

https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com

It seems to me that the check for memblock_is_memory() in
arm64::pfn_valid() is what makes init_unavailable_range() to bail out for
section parts that are not actually populated and then we have
VM_BUG_ON_PAGE(PagePoisoned(p)) for these pages.

-- 
Sincerely yours,
Mike.
