Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF742F42B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbhJONtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:49:40 -0400
Received: from pv50p00im-ztdg10021201.me.com ([17.58.6.45]:57234 "EHLO
        pv50p00im-ztdg10021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240025AbhJONtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1634305647; bh=CPeJvY4pYhOkCExADo3lmJ41anrz9lUx3u3bKJGG9hY=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=YUmIudzckk61gqi2THQ0L2BDQRolmXCbNzyrjMwD+CxGHYjZK8MzZ/DEvVSSejbuC
         sxBXFWJK6ZifRaNw0zISu2ZbK+N5rQk6y5znfbF7QFKGXAJquFc+Bts5L7KUwKXDzV
         PlMZwfcunQFft7B4gBkVvZgxyF6C/o0BjH8Jb/mzO00lldQy5uQz5Gv6Vm/4jkLBJL
         IOIA8zgCzAKgaFoZE3bSSB0LvhJVVPJ4rt0ph8SnEqWW69zgneosCsxg7FtDIrfdIF
         7eDj73wIT6JQ+Qv+itlaOuIOSGJpRDgilJ4vIgM1f5p8bMx/d22s3v+VgfSNX7OQ1q
         MEi1ohAG6Pnxg==
Received: from 192.168.1.7 (unknown [120.245.2.212])
        by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id ED236A402E2;
        Fri, 15 Oct 2021 13:47:18 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 0/6] Use generic code for randomization of virtual
 address of x86
From:   Xiongwei Song <sxwjean@me.com>
In-Reply-To: <20211011143150.318239-1-sxwjean@me.com>
Date:   Fri, 15 Oct 2021 21:47:15 +0800
Cc:     Xiongwei Song <sxwjean@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Huang Rui <ray.huang@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <61781C95-6735-48B8-B32E-ECF189318953@me.com>
References: <20211011143150.318239-1-sxwjean@me.com>
To:     linux-mm@kvack.org, x86@kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-15_04:2021-10-14,2021-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110150085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Experts,

Gentle reminder.  Any comments would be appreciated.
Thank you so much.

Regards,
Xiongwei

> On Oct 11, 2021, at 10:31 PM, sxwjean@me.com wrote:
> 
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> Hello,
> 
> This patchset are to use generic code for randomization of virtual address
> of x86. Since the basic code logic of x86 is same as generic code, so no
> need to implement these functions on x86.
> 
> Patch 1~3 are prepared to change the generic code to apply to x86.
> 
> Patch 4 is to switch to generic arch_pick_mmap_layout() with 
> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT enabled. Also provided basically
> test and the result was put in commit message too.
> 
> Patch 5~6 are used to handle the legacy things.
> 
> Test programs(to verify if the entropy of return value of mmap is kept
> after applying the patchset):
> - C code for mmap test:
> 	#include <stdio.h>
> 	#include <stdlib.h>
> 	#include <sys/mman.h>
> 
> 	int main(int argc, char *argv[])
> 	{
> 		unsigned long *addr;
> 
> 		addr = mmap(NULL, 4096, PROT_READ, MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> 		if (addr == MAP_FAILED) {
> 			printf("NULL\n");
> 		} else {
> 			printf("%lx\n", (unsigned long)addr);
> 			munmap(addr, 4096);
> 		}
> 
> 		return 0;
> 	}
> 
> - Shell script for collecting output of C progarm above and give a
>  statistics:
> 	#!/bin/bash
> 	declare -a COUNT
> 
> 	if [ "$1" == "" ]; then
> 	    echo "Please give a test number!"
> 	    exit 1
> 	fi
> 	number=$1
> 
> 	for ((i=0; i<$number; i++))
> 	do
> 	    addr=$(mmaptest)
> 	    addr=$(((16#$addr&0xf000000000)>>36))
> 	    COUNT[$addr]=$((COUNT[$addr]+1))
> 	done
> 
> 	echo "    Virtual Address Range     |   hit times   "
> 	echo "----------------------------------------"
> 	for ((i=0; i<16; i++))
> 	do
> 	    j=`echo "obase=16; $i" | bc`
> 	    echo "0x7f${j,,}000000000 - 0x7f${j,,}ffffff000 |   ${COUNT[i]}"
> 	done
> 
> Run 10 thousands times C progam, collect the output with shell script, get
> the test results below:
> 	Before the patchset:
>            Virtual Address Range       | hit times
>        ----------------------------------------
>        0x7f0000000000 - 0x7f0ffffff000 |   655 
>        0x7f1000000000 - 0x7f1ffffff000 |   617 
>        0x7f2000000000 - 0x7f2ffffff000 |   636 
>        0x7f3000000000 - 0x7f3ffffff000 |   625 
>        0x7f4000000000 - 0x7f4ffffff000 |   651 
>        0x7f5000000000 - 0x7f5ffffff000 |   591 
>        0x7f6000000000 - 0x7f6ffffff000 |   623 
>        0x7f7000000000 - 0x7f7ffffff000 |   627 
>        0x7f8000000000 - 0x7f8ffffff000 |   638 
>        0x7f9000000000 - 0x7f9ffffff000 |   586 
>        0x7fa000000000 - 0x7faffffff000 |   637 
>        0x7fb000000000 - 0x7fbffffff000 |   607 
>        0x7fc000000000 - 0x7fcffffff000 |   618 
>        0x7fd000000000 - 0x7fdffffff000 |   656 
>        0x7fe000000000 - 0x7feffffff000 |   614 
>        0x7ff000000000 - 0x7ffffffff000 |   619 
> 
> 	After the patchset:
>            Virtual Address Range       | hit times
>        ----------------------------------------
>        0x7f0000000000 - 0x7f0ffffff000 |   661 
>        0x7f1000000000 - 0x7f1ffffff000 |   645 
>        0x7f2000000000 - 0x7f2ffffff000 |   609 
>        0x7f3000000000 - 0x7f3ffffff000 |   594 
>        0x7f4000000000 - 0x7f4ffffff000 |   616 
>        0x7f5000000000 - 0x7f5ffffff000 |   622 
>        0x7f6000000000 - 0x7f6ffffff000 |   617 
>        0x7f7000000000 - 0x7f7ffffff000 |   582 
>        0x7f8000000000 - 0x7f8ffffff000 |   618 
>        0x7f9000000000 - 0x7f9ffffff000 |   629 
>        0x7fa000000000 - 0x7faffffff000 |   635 
>        0x7fb000000000 - 0x7fbffffff000 |   625 
>        0x7fc000000000 - 0x7fcffffff000 |   614 
>        0x7fd000000000 - 0x7fdffffff000 |   610 
>        0x7fe000000000 - 0x7feffffff000 |   648
>        0x7ff000000000 - 0x7ffffffff000 |   675
> 
> v1 -> v2:
> - Spilt the patch 2 of v1 as Kees suggested.
> - Drop patch 1 of v1, which renamed TIF_ADDR32 to TIF_32BIT, which is
>  unreasonable for x86. Because in x86, 64bit process can call 32bit
>  syscall. Thanks Peterz for pointing this out. 
> 
> v1:
> - https://lkml.org/lkml/2021/9/21/482
> - https://lkml.org/lkml/2021/9/21/484
> - https://lkml.org/lkml/2021/9/27/688
> 
> Please review.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
> Cc: Lai Jiangshan <laijs@linux.alibaba.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Balbir Singh <sblbir@amazon.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sxwjean@me.com
> Cc: linux-kernel@vger.kernel.org
> 
> Xiongwei Song (6):
>  mm/util: Assign a meaningful value to mmap_legacy_base
>  mm/util: Allow to pass a specific task size when getting mmapping base
>  mm/util: Support CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
>  x86/mm: Randomize VA with generit arch_pick_mmap_layout()
>  x86/mm: Discard the defination of HAVE_ARCH_PICK_MMAP_LAYOUT
>  x86/elf: Discard ARCH_HAS_ELF_RANDOMIZE selection
> 
> arch/x86/Kconfig                 |   2 +-
> arch/x86/include/asm/compat.h    |   5 ++
> arch/x86/include/asm/processor.h |   5 +-
> arch/x86/mm/mmap.c               | 112 -------------------------------
> mm/util.c                        |  35 +++++++---
> 5 files changed, 37 insertions(+), 122 deletions(-)
> 
> -- 
> 2.30.2
> 

