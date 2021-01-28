Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7AC307305
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhA1Jl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:41:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231918AbhA1Jgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:36:50 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10S9WjND124156;
        Thu, 28 Jan 2021 04:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Jrm7CzbhX8B0u6nYL4E4YOlQ19kWW0AhTX3VOVt+gvk=;
 b=RGqGzHV/F1BtDeVdiQAuyDfSwhj3D5AaPV8+Df6zVjt5nHE2jClKOuslWPNwratCP/wy
 ZPKrng1XPMOiTQzK7ikb9mq7WMlGx92M+sht4SRkhx1sDqlT9QEMyt2IvADKLjNdHN0N
 tx2MIFgtUZn9j6Y9zlS2E3jpaGX1SK9wjnWlglllyxpe3dFOZs1wKC046ZX2t/9qnyV9
 si0U8GfoAI6tQZY+3EgnkokOwHXrM0lRB7V5EbRcfCFwnbU8Ux4ngeVVUmder0KypyZH
 SB5v2z7ylwBVnIcvpDE07IpM7sX2/S2e7aFPteFOfpSDlsk3sXZ+cIb//rSrmtfKBMcD Zg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36brh842ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 04:35:49 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10S9JL9R011199;
        Thu, 28 Jan 2021 09:35:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 368b2hadx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 09:35:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10S9ZaDR30671106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 09:35:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 702294C058;
        Thu, 28 Jan 2021 09:35:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AF584C04A;
        Thu, 28 Jan 2021 09:35:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.187.107])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 28 Jan 2021 09:35:43 +0000 (GMT)
Date:   Thu, 28 Jan 2021 11:35:41 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andreas Larsson <andreas@gaisler.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: sparc32: boot fails with > 256 MB memory after switch to
 NO_BOOTMEM
Message-ID: <20210128093541.GC299309@linux.ibm.com>
References: <5adb7c41-ad71-b904-6b73-35aef4dfcafe@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5adb7c41-ad71-b904-6b73-35aef4dfcafe@gaisler.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_05:2021-01-27,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 04:03:00PM +0100, Andreas Larsson wrote:
> 
> 
> Commit cca079ef8ac29a7c02192d2bad2ffe4c0c5ffdd0 makes sparc32 use
> memblocks instead of the previous bootmem solution. Unfortunately, due
> to this:
> 
> #define PAGE_OFFSET  0xf0000000
> #define __va(x)	     ((void *)((unsigned long) (x) - phys_base +
> PAGE_OFFSET))
> #define phys_to_virt __va
> 
> it makes physical addresses >= 0x10000000 past phys_base wrap around the
> 32-bit memory space when converted to virtual addresses, e.g. in
> memblock_alloc_try_nid. Physical memory exactly 0x10000000 past
> phys_base is returned as an unintended NULL pointer, leading to a panic
> in my boot when percpu memory allocation fails due to it.
> 
> Unfortunately I have had 256 MB memory or less in a lot of my testing,
> so this old one has slipped by me.
> 
> Does anyone has any ideas or pointers on how to resolve this?

I think the simplest way to work around this is to limit early allocations
to 256M with addition of

	memblock_set_current_limit(SZ_256M);
 
somewhere at setup_arch().

The page allocator will anyway see the entire memory, so I cannot think of
any downside here.

> Example follows where I have 512 MB memory at 0x40000000:
> 
> ----->%>%>%>%-----
> memblock_add: [0x40000000-0x5fffafff] bootmem_init+0x1f8/0x210
> 319MB HIGHMEM available.
> memblock_reserve: [0x40000000-0x40e71fff] bootmem_init+0x178/0x210
> memblock_add: [0x40000000-0x40e71fff] bootmem_init+0x188/0x210
> memblock_alloc_try_nid: 5242880 bytes align=0x40000 nid=-1 from=0x00000000
> max_addr=0x00000000 srmmu_nocache_init+0x20/0x25c
> memblock_reserve: [0x40e80000-0x4137ffff]
> memblock_alloc_range_nid+0xcc/0x178
> memblock_alloc_try_nid: 2560 bytes align=0x20 nid=-1 from=0x00000000
> max_addr=0x00000000 srmmu_nocache_init+0x94/0x25c
> memblock_reserve: [0x40e72000-0x40e729ff]
> memblock_alloc_range_nid+0xcc/0x178
> memblock_alloc_try_nid: 4096 bytes align=0x20 nid=-1 from=0x00000000
> max_addr=0x00000000 sparc_context_init+0x1c/0xe4
> memblock_reserve: [0x40e72a00-0x40e739ff]
> memblock_alloc_range_nid+0xcc/0x178
> Zone ranges:
>   DMA      [mem 0x0000000040000000-0x000000004bffffff]
>   Normal   empty
>   HighMem  [mem 0x000000004c000000-0x000000005fffafff]
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000040000000-0x000000005fffafff]
> Initmem setup node 0 [mem 0x0000000040000000-0x000000005fffafff]
> ----->%>%>%>%-----
> 
> then much much later memblock_alloc_internal gets 0x50000000 from
> memblock_alloc_range_nid and returns a NULL pointer as result of
> phys_to_virt.
> 
> ----->%>%>%>%-----
> memblock_alloc_try_nid: 40960 bytes align=0x1000 nid=-1 from=0x4fffffff
> max_addr=0x00000000 pcpu_dfl_fc_alloc+0x28/0x40
> memblock_reserve: [0x50000000-0x50009fff]
> memblock_alloc_range_nid+0xcc/0x178
> memblock_free: [0x40e7e000-0x40e7efff] pcpu_free_alloc_info+0x1c/0x30
> memblock_free: [0x40e7f000-0x40e7ffff] pcpu_embed_first_chunk+0x194/0x3b8
> Kernel panic - not syncing: Failed to initialize percpu areas.
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.11.0-rc3-00040-gbc4547251e1-dirty
> #28
> ----->%>%>%>%-----
> 
> Adding mem=256M to the command line solves the panic problem but makes
> the extra memory not be available for normal allocation later on either.
> 
> The two first memblock_add calls (seen in the first first set of
> outputs) with overlapping address ranges that is done in bootmem_init
> also looks a bit worrying, but removing the second one does not affect
> this problem.
> 
> -- 
> Best regards,
> 
> Andreas Larsson
> Cobham Gaisler

-- 
Sincerely yours,
Mike.
