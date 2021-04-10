Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36AF35ABEB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhDJIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:34:17 -0400
Received: from pv50p00im-ztdg10012001.me.com ([17.58.6.51]:59456 "EHLO
        pv50p00im-ztdg10012001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234201AbhDJIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1618043642; bh=PN/LSxVmoMkWa5q270yo7EYDmh67DW98oE9ADNqGm8I=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=07K4dDU9FQHOR420AGczzEPG2QIIfBYio7n7zQzu6WgyerEaed7uVFCTYu5JiL/7g
         exKXrCFp4QcrI7IwFlgQUlt1Z8Pm4/hFzKP+eaNCNzcgZCPz93EDP8+YgnInOF8Jxk
         IAbtoOubOUQ6PyGOvWgN3hp1mDhPUK61giEqBdACGtbAcc8skfsZ9RVTbzJT8zwjIs
         m8wYxzA1W0JsSA8cfYfl4IVJxSkBHyet0brrqaRqF7ADhBJO24m83N4SDh51sYaYyh
         qPbIwzjNrsz64UKbBk9WLKVK5adra+jNV3BmEinbYrLkKSbCoUVJYhhIYVMtZ0gIX/
         eTtoK7bhhWXqw==
Received: from 192.168.1.3 (unknown [120.245.2.39])
        by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 2B26128034B;
        Sat, 10 Apr 2021 08:33:51 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v3] powerpc/traps: Enhance readability for trap types
From:   Xiongwei Song <sxwjean@me.com>
In-Reply-To: <874kgfdmxq.fsf@mpe.ellerman.id.au>
Date:   Sat, 10 Apr 2021 16:33:49 +0800
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        benh@kernel.crashing.org, paulus@samba.org, oleg@redhat.com,
        npiggin@gmail.com, aneesh.kumar@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, mikey@neuling.org,
        haren@linux.ibm.com, akpm@linux-foundation.org, rppt@kernel.org,
        jniethe5@gmail.com, atrajeev@linux.vnet.ibm.com,
        maddy@linux.ibm.com, peterz@infradead.org, kjain@linux.ibm.com,
        kan.liang@linux.intel.com, aik@ozlabs.ru, alistair@popple.id.au,
        pmladek@suse.com, john.ogness@linutronix.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <15CACAC1-95CE-4964-9221-A4EBF97590B4@me.com>
References: <20210408140750.26832-1-sxwjean@me.com>
 <70ece993-12bd-335c-d246-914564eb51dd@csgroup.eu>
 <874kgfdmxq.fsf@mpe.ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-10_04:2021-04-09,2021-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2104100065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 10, 2021, at 8:04 AM, Michael Ellerman <mpe@ellerman.id.au> =
wrote:
>=20
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Le 08/04/2021 =C3=A0 16:07, Xiongwei Song a =C3=A9crit :
>>> From: Xiongwei Song <sxwjean@gmail.com>
>>>=20
>>> Create a new header named traps.h, define macros to list ppc =
interrupt
>>> types in traps.h, replace the reference of the trap hex values with =
these
>>> macros.
> ...
>>> diff --git a/arch/powerpc/include/asm/interrupt.h =
b/arch/powerpc/include/asm/interrupt.h
>>> index 7c633896d758..5ce9898bc9a6 100644
>>> --- a/arch/powerpc/include/asm/interrupt.h
>>> +++ b/arch/powerpc/include/asm/interrupt.h
>>> @@ -8,6 +8,7 @@
>>>  #include <asm/ftrace.h>
>>>  #include <asm/kprobes.h>
>>>  #include <asm/runlatch.h>
>>> +#include <asm/traps.h>
>>>=20
>>>  struct interrupt_state {
>>>  #ifdef CONFIG_PPC_BOOK3E_64
>>> @@ -59,7 +60,7 @@ static inline void interrupt_enter_prepare(struct =
pt_regs *regs, struct interrup
>>>  		 * CT_WARN_ON comes here via program_check_exception,
>>>  		 * so avoid recursion.
>>>  		 */
>>> -		if (TRAP(regs) !=3D 0x700)
>>> +		if (TRAP(regs) !=3D INTERRUPT_PROGRAM)
>>>  			CT_WARN_ON(ct_state() !=3D CONTEXT_KERNEL);
>>>  	}
>>>  #endif
>>> @@ -156,7 +157,8 @@ static inline void =
interrupt_nmi_enter_prepare(struct pt_regs *regs, struct inte
>>>  	/* Don't do any per-CPU operations until interrupt state is =
fixed */
>>>  #endif
>>>  	/* Allow DEC and PMI to be traced when they are soft-NMI */
>>> -	if (TRAP(regs) !=3D 0x900 && TRAP(regs) !=3D 0xf00 && TRAP(regs) =
!=3D 0x260) {
>>> +	if (TRAP(regs) !=3D INTERRUPT_DECREMENTER &&
>>> +	    TRAP(regs) !=3D INTERRUPT_PERFMON) {
>>=20
>> I think too long names hinder readability, see later for suggestions.
>=20
> I asked for the longer names :)
>=20
> I think they make it easier for people who are less familiar with the
> architecture than us to make sense of the names.
>=20
> And there's only a couple of cases where it requires splitting a line,
> and they could be converted to use switch if we think it's a problem.
>=20
>>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>>> index 0c0b1c2cfb49..641b3feef7ee 100644
>>> --- a/arch/powerpc/mm/fault.c
>>> +++ b/arch/powerpc/mm/fault.c
>>> @@ -588,20 +589,24 @@ void __bad_page_fault(struct pt_regs *regs, =
int sig)
>>>  	/* kernel has accessed a bad area */
>>>=20
>>>  	switch (TRAP(regs)) {
>>> -	case 0x300:
>>> -	case 0x380:
>>> -	case 0xe00:
>>> +	case INTERRUPT_DATA_STORAGE:
>>> +#ifdef CONFIG_PPC_BOOK3S
>>> +	case INTERRUPT_DATA_SEGMENT:
>>> +	case INTERRUPT_H_DATA_STORAGE:
>>> +#endif
>>=20
>> It would be better to avoid #ifdefs when none where necessary before.
>=20
> Yes I agree.
>=20
> I think these can all be avoided by defining most of the values
> regardless of what platform we're building for. Only the values that
> overlap need to be kept behind an ifdef.

Ok.=20

Regards,
Xiongwei

>=20
> cheers

