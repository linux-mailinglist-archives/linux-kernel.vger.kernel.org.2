Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5971356F87
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353225AbhDGO7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:59:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345747AbhDGO7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:59:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137EX1O8156742;
        Wed, 7 Apr 2021 10:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dd/ot2QwEl8xUK3CIVbT8kEhkYMJjKVAMBX5GWjlEZA=;
 b=n96TBR5dqU6Z5gl2yqBiqnIQsdScLhwTo+KTqz9pW6AtnEWMm1hhr9pL5jIUpQPqTHtf
 1os6w0dRvs2fG2jayzwlu9SlTswQB9FfOii0aiplpxcbnjZQ4D+50wIWfiFjAmWvUs/O
 e81MmTJu3nq/bslklwvgfpbOrLAolsEyfWKX21FtstiG+G+MoYSPSd0j2qzFkfsXwnRZ
 40WKExM7K7gFBdPBC1fahxUZTpJKcKy9eCZ/Z9luCQhQhRjSmzZD5NoXyBQ9LRRPs50l
 bMzSXdSslx6ItYCc2OAj06rNfpYNdxdDU5jA06idW30Hmc05q6NiDD3Dm0OwkivhZCh0 CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rw7jmgkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 10:59:30 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 137EXOoD161227;
        Wed, 7 Apr 2021 10:59:29 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rw7jmgk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 10:59:29 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137EvW8E017817;
        Wed, 7 Apr 2021 14:59:28 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 37rvc469wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 14:59:28 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137ExRj013238594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 14:59:27 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ED61136051;
        Wed,  7 Apr 2021 14:59:27 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4336913604F;
        Wed,  7 Apr 2021 14:59:27 +0000 (GMT)
Received: from [9.211.151.211] (unknown [9.211.151.211])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  7 Apr 2021 14:59:27 +0000 (GMT)
Subject: Re: crashkernel reservation failed - No suitable area found on a
 cortina/gemini SoC
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <YG2rfzRvHIZKXkf/@Red>
 <34ff1fcc-e9ee-02c2-b2a8-d98a24ce94c3@linux.vnet.ibm.com>
 <YG3AZ4K2auqEz9BK@Red>
 <7a75028b-4495-cd51-6a32-59fcf6e0f166@linux.vnet.ibm.com>
 <YG3GWxYU02UhOnUX@Red>
From:   Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Message-ID: <291254c6-97e3-f5ba-dcee-77f8e4d25f9b@linux.vnet.ibm.com>
Date:   Wed, 7 Apr 2021 07:59:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <YG3GWxYU02UhOnUX@Red>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D9UYz_gygOFRC6Vk--LATWjeYwRzM22j
X-Proofpoint-ORIG-GUID: OVCSXYENGxnjDHZ6CO_H7h4D2rbl8K1b
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_08:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/2021 07:48, Corentin Labbe wrote:
> Le Wed, Apr 07, 2021 at 07:28:26AM -0700, Bruce Mitchell a écrit :
>> On 4/7/2021 07:23, Corentin Labbe wrote:
>>> Le Wed, Apr 07, 2021 at 07:13:04AM -0700, Bruce Mitchell a écrit :
>>>> On 4/7/2021 05:54, Corentin Labbe wrote:
>>>>> Hello
>>>>>
>>>>> I try to do kexec on a cortina/gemini SoC.
>>>>> On a "normal" boot, kexec fail to find memory so I added crashkernel=8M to cmdline. (kernel size is ~6M).
>>>>> But now, kernel fail to reserve memory:
>>>>> Load Kern image from 0x30020000 to 0x800000 size 7340032
>>>>> Booting Linux on physical CPU 0x0
>>>>> Linux version 5.12.0-rc5-next-20210401+ (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 9.3.0-r2 p4) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.34.0) #98 PREEMPT Wed Apr 7 14:14:08 CEST 2021
>>>>> CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
>>>>> CPU: VIVT data cache, VIVT instruction cache
>>>>> OF: fdt: Machine model: Edimax NS-2502
>>>>> Memory policy: Data cache writeback
>>>>> Zone ranges:
>>>>>      Normal   [mem 0x0000000000000000-0x0000000007ffffff]
>>>>>      HighMem  empty
>>>>> Movable zone start for each node
>>>>> Early memory node ranges
>>>>>      node   0: [mem 0x0000000000000000-0x0000000007ffffff]
>>>>> Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
>>>>> crashkernel reservation failed - No suitable area found.
>>>>> Built 1 zonelists, mobility grouping on.  Total pages: 32512
>>>>> Kernel command line: console=ttyS0,19200n8 ip=dhcp crashkernel=8M
>>>>> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
>>>>> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
>>>>> mem auto-init: stack:off, heap alloc:off, heap free:off
>>>>> Memory: 119476K/131072K available (5034K kernel code, 579K rwdata, 1372K rodata, 3020K init, 210K bss, 11596K reserved, 0K cma-reserved, 0K highmem)
>>>>> SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>>>>>
>>>>> What can I do ?
>>>>>
>>>>> Thanks
>>>>> Regards
>>>>>
>>>>> _______________________________________________
>>>>> kexec mailing list
>>>>> kexec@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/kexec
>>>>>
>>>>
>>>> Hello Corentin,
>>>>
>>>> I see much larger crashkernel=xxM being shown here
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kdump/kdump.rst
>>>> and from many of my other searches.
>>>>
>>>> Here is an interesting article on kdump for ARM-32
>>>> https://kaiwantech.wordpress.com/2017/07/13/setting-up-kdump-and-crash-for-arm-32-an-ongoing-saga/
>>>>
>>>>
>>>> Here is the kernel command line reference
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt?h=v5.11#n732
>>>>
>>>> I feel your frustrations too.
>>>
>>> Hello
>>>
>>> Thanks but I have already read those documentation.
>>> I search to know why the kernel cannot find 8M of memory ouf of 128.
>>>
>>> Regards
>>>
>>
>> How much more memory does the kernel and initrd above and beyond just
>> their physical size?  (heaps, stacks, buffers, virtual filesystems)
> 
> The kernel size include a rootfs.cpio.lzma of 3MB and dtb is appended.
> The total kernel size is 7MB.
> The uncompressed size of the kernel is 13M (size of vmlinux)
> The uncompressed size of rootfs is 11M.
> 
> cat /proc/meminfo
> MemTotal:         122496 kB
> MemFree:          103700 kB
> MemAvailable:     101936 kB
> Buffers:               0 kB
> Cached:            10904 kB
> SwapCached:            0 kB
> Active:             4304 kB
> Inactive:           8012 kB
> Active(anon):       4304 kB
> Inactive(anon):     8012 kB
> Active(file):          0 kB
> Inactive(file):        0 kB
> Unevictable:           0 kB
> Mlocked:               0 kB
> HighTotal:             0 kB
> HighFree:              0 kB
> LowTotal:         122496 kB
> LowFree:          103700 kB
> SwapTotal:             0 kB
> SwapFree:              0 kB
> Dirty:                 0 kB
> Writeback:             0 kB
> AnonPages:          1428 kB
> Mapped:             3552 kB
> Shmem:             10904 kB
> KReclaimable:        608 kB
> Slab:               2960 kB
> SReclaimable:        608 kB
> SUnreclaim:         2352 kB
> KernelStack:         312 kB
> PageTables:          136 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:       61248 kB
> Committed_AS:      14336 kB
> VmallocTotal:     901120 kB
> VmallocUsed:          64 kB
> VmallocChunk:          0 kB
> Percpu:               32 kB
> CmaTotal:              0 kB
> CmaFree:               0 kB
> 

I believe you need space for all of that,
the smallest that would work for me was 20MB.


