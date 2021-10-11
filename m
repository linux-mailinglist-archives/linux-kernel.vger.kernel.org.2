Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D642926B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbhJKOpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:45:41 -0400
Received: from pv50p00im-zteg10011401.me.com ([17.58.6.41]:59633 "EHLO
        pv50p00im-zteg10011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244058AbhJKOpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1633963411; bh=Ffmgc+eOs3zeWuYxNFkiIe3ut9JNJ7qAah2dXr12VAo=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=gnbIrso9Cl5Vgx2dO3qzq9do26CMp2D6CoFEew9w9XfIwAeqFze4/WwX8bj3SPj1p
         uELSAL8XiGYUt2StXsYd2XdlaZ5qo/b/z+8EcbiawP04pnTc1Wngtd96MmxRVpcy1I
         an4TmeTq3Y2EoyGO3RrUgellfhWnQ98OlCF5/6qhJD936vTWGGDTu4s/MERoMBr6lb
         75lIxPhWDdG6cBXTDTyUrB06z96h7Q3VwGa2sShytF6oD4wRqJN7mSq8B8Vc7VCipD
         seccnOL9LRE4fHD/pxRudikLoqikN4oEbLKmDpqiWMJDIsoTsG28rkqQqo/7YyfJlA
         8pfjfnAHTUVdA==
Received: from 192.168.1.6 (unknown [120.245.2.114])
        by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id AD7D49002D2;
        Mon, 11 Oct 2021 14:43:21 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 0/6] Use generic code for randomization of virtual
 address of x86
From:   Xiongwei Song <sxwjean@me.com>
In-Reply-To: <20211011143150.318239-1-sxwjean@me.com>
Date:   Mon, 11 Oct 2021 22:43:17 +0800
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <23A70A75-8016-4A80-9AEC-89B41F155104@me.com>
References: <20211011143150.318239-1-sxwjean@me.com>
To:     linux-mm@kvack.org, x86@kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-11_05:2021-10-07,2021-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=892 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110110086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 11, 2021, at 10:31 PM, sxwjean@me.com wrote:
>=20
> From: Xiongwei Song <sxwjean@gmail.com>
>=20
> Hello,
>=20
> This patchset are to use generic code for randomization of virtual =
address
> of x86. Since the basic code logic of x86 is same as generic code, so =
no
> need to implement these functions on x86.
>=20
> Patch 1~3 are prepared to change the generic code to apply to x86.
>=20
> Patch 4 is to switch to generic arch_pick_mmap_layout() with=20
> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT enabled. Also provided basically
> test and the result was put in commit message too.
>=20
> Patch 5~6 are used to handle the legacy things.
>=20
> Test programs(to verify if the entropy of return value of mmap is kept
> after applying the patchset):
> - C code for mmap test:
> 	#include <stdio.h>
> 	#include <stdlib.h>
> 	#include <sys/mman.h>
>=20
> 	int main(int argc, char *argv[])
> 	{
> 		unsigned long *addr;
>=20
> 		addr =3D mmap(NULL, 4096, PROT_READ, =
MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> 		if (addr =3D=3D MAP_FAILED) {
> 			printf("NULL\n");
> 		} else {
> 			printf("%lx\n", (unsigned long)addr);
> 			munmap(addr, 4096);
> 		}
>=20
> 		return 0;
> 	}
>=20
> - Shell script for collecting output of C progarm above and give a
>  statistics:
> 	#!/bin/bash
> 	declare -a COUNT
>=20
> 	if [ "$1" =3D=3D "" ]; then
> 	    echo "Please give a test number!"
> 	    exit 1
> 	fi
> 	number=3D$1
>=20
> 	for ((i=3D0; i<$number; i++))
> 	do
> 	    addr=3D$(mmaptest)
> 	    addr=3D$(((16#$addr&0xf000000000)>>36))
> 	    COUNT[$addr]=3D$((COUNT[$addr]+1))
> 	done
>=20
> 	echo "    Virtual Address Range     |   hit times   "
> 	echo "----------------------------------------"
> 	for ((i=3D0; i<16; i++))
> 	do
> 	    j=3D`echo "obase=3D16; $i" | bc`
> 	    echo "0x7f${j,,}000000000 - 0x7f${j,,}ffffff000 |   =
${COUNT[i]}"
> 	done
>=20
> Run 10 thousands times C progam, collect the output with shell script, =
get
> the test results below:
> 	Before the patchset:
>            Virtual Address Range       | hit times
>        ----------------------------------------
>        0x7f0000000000 - 0x7f0ffffff000 |   655=20
>        0x7f1000000000 - 0x7f1ffffff000 |   617=20
>        0x7f2000000000 - 0x7f2ffffff000 |   636=20
>        0x7f3000000000 - 0x7f3ffffff000 |   625=20
>        0x7f4000000000 - 0x7f4ffffff000 |   651=20
>        0x7f5000000000 - 0x7f5ffffff000 |   591=20
>        0x7f6000000000 - 0x7f6ffffff000 |   623=20
>        0x7f7000000000 - 0x7f7ffffff000 |   627=20
>        0x7f8000000000 - 0x7f8ffffff000 |   638=20
>        0x7f9000000000 - 0x7f9ffffff000 |   586=20
>        0x7fa000000000 - 0x7faffffff000 |   637=20
>        0x7fb000000000 - 0x7fbffffff000 |   607=20
>        0x7fc000000000 - 0x7fcffffff000 |   618=20
>        0x7fd000000000 - 0x7fdffffff000 |   656=20
>        0x7fe000000000 - 0x7feffffff000 |   614=20
>        0x7ff000000000 - 0x7ffffffff000 |   619=20
>=20
> 	After the patchset:
>            Virtual Address Range       | hit times
>        ----------------------------------------
>        0x7f0000000000 - 0x7f0ffffff000 |   661=20
>        0x7f1000000000 - 0x7f1ffffff000 |   645=20
>        0x7f2000000000 - 0x7f2ffffff000 |   609=20
>        0x7f3000000000 - 0x7f3ffffff000 |   594=20
>        0x7f4000000000 - 0x7f4ffffff000 |   616=20
>        0x7f5000000000 - 0x7f5ffffff000 |   622=20
>        0x7f6000000000 - 0x7f6ffffff000 |   617=20
>        0x7f7000000000 - 0x7f7ffffff000 |   582=20
>        0x7f8000000000 - 0x7f8ffffff000 |   618=20
>        0x7f9000000000 - 0x7f9ffffff000 |   629=20
>        0x7fa000000000 - 0x7faffffff000 |   635=20
>        0x7fb000000000 - 0x7fbffffff000 |   625=20
>        0x7fc000000000 - 0x7fcffffff000 |   614=20
>        0x7fd000000000 - 0x7fdffffff000 |   610=20
>        0x7fe000000000 - 0x7feffffff000 |   648
>        0x7ff000000000 - 0x7ffffffff000 |   675

Hi Kees,

Sorry, I have no idea about the entropy measure tools, so I designed a =
test program
myself. I=E2=80=99m not sure if my test is enough. Or could you please =
share a better method to
measure entropy?

Regards,
Xiongwei


