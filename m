Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24443B2D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhFXLCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:02:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7355 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232136AbhFXLCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:02:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OAXOtp028164;
        Thu, 24 Jun 2021 06:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=seR004U7BS151tIWRK/UQWFcTx1CFnM1fGVnMoFtlFY=;
 b=YphTG24n0KllvWfsANDhmaqChXPU5couFpjUU6wTnmII18l2NTQVuACP8KHnZtI5GAIU
 /wIttwzVZuqT5CwUHfEvQvgxsfj2YXzHJQBFAaZDw4P386qMG1J16Tueqtq67rxk6tRO
 oeqj4KIFYX/HH6k0kEfCWwi9N3tOgsAjlP1iof7QNnu+XCZBwHJsOASVwXtSMw6jCP9f
 GvM0WyEBIyab4tnnPwv78UWNTyU5tRiNYy/Irs/kpNOuci5mMrwR5NJ0LRVbXXOYPyGR
 Q0FgkfWsu33JpUVlm0n1hnaalcg37qQbP7LVhSAjodA1wFILb2qCClLN2DJbMvNFMELc pw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39cpu1v3ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 06:59:36 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15OAx3wb024246;
        Thu, 24 Jun 2021 10:59:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3998789cc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 10:59:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15OAw7FV33161620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 10:58:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DD574C04A;
        Thu, 24 Jun 2021 10:59:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA6B04C04E;
        Thu, 24 Jun 2021 10:59:31 +0000 (GMT)
Received: from localhost (unknown [9.85.126.249])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Jun 2021 10:59:31 +0000 (GMT)
Date:   Thu, 24 Jun 2021 16:29:30 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/kprobes: Fix Oops by passing ppc_inst as a
 pointer to emulate_step() on ppc32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <5bdc8cbc9a95d0779e27c9ddbf42b40f51f883c0.1624425798.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5bdc8cbc9a95d0779e27c9ddbf42b40f51f883c0.1624425798.git.christophe.leroy@csgroup.eu>
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1624531892.3vdz8ibfty.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7Kj5BgczmA_qe273mY4-7D7mNHcbxbmm
X-Proofpoint-ORIG-GUID: 7Kj5BgczmA_qe273mY4-7D7mNHcbxbmm
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_06:2021-06-24,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=801 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106240056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>=20
> Trying to use a kprobe on ppc32 results in the below splat:
>     BUG: Unable to handle kernel data access on read at 0x7c0802a6
>     Faulting instruction address: 0xc002e9f0
>     Oops: Kernel access of bad area, sig: 11 [#1]
>     BE PAGE_SIZE=3D4K PowerPC 44x Platform
>     Modules linked in:
>     CPU: 0 PID: 89 Comm: sh Not tainted 5.13.0-rc1-01824-g3a81c0495fdb #7
>     NIP:  c002e9f0 LR: c0011858 CTR: 00008a47
>     REGS: c292fd50 TRAP: 0300   Not tainted  (5.13.0-rc1-01824-g3a81c0495=
fdb)
>     MSR:  00009000 <EE,ME>  CR: 24002002  XER: 20000000
>     DEAR: 7c0802a6 ESR: 00000000
>     <snip>
>     NIP [c002e9f0] emulate_step+0x28/0x324
>     LR [c0011858] optinsn_slot+0x128/0x10000
>     Call Trace:
>      opt_pre_handler+0x7c/0xb4 (unreliable)
>      optinsn_slot+0x128/0x10000
>      ret_from_syscall+0x0/0x28
>=20
> The offending instruction is:
>     81 24 00 00     lwz     r9,0(r4)
>=20
> Here, we are trying to load the second argument to emulate_step():
> struct ppc_inst, which is the instruction to be emulated. On ppc64,
> structures are passed in registers when passed by value. However, per
> the ppc32 ABI, structures are always passed to functions as pointers.
> This isn't being adhered to when setting up the call to emulate_step()
> in the optprobe trampoline. Fix the same.
>=20
> Fixes: eacf4c0202654a ("powerpc: Enable OPTPROBES on PPC32")
> Cc: stable@vger.kernel.org
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> v2: Rebased on powerpc/merge 7f030e9d57b8
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks for rebasing this!

I think git am drops everything after three dashes, so applying this=20
patch will drop your SOB. The recommended style (*) for adding a=20
changelog is to include it within [] before the second SOB.


- Naveen

(*) https://www.kernel.org/doc/html/latest/maintainer/modifying-patches.html

