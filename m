Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32113986A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhFBKhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:37:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231287AbhFBKhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:37:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152AY6fp176625;
        Wed, 2 Jun 2021 06:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=QxAVbfL5BAgImK+GOlJ6xg8BGbCXi6xnMfw6KzomfrA=;
 b=hSgDRtu5xey4ZpfesftSMSTmvMndX+aBdt7on0l8/pAhOZpCV7602Jww2kX6th5uJDKB
 Kt/tLI4lZLxoTuPBBQmPrGb7j2U1ux8G7ctLOFvtnAA+L6ScEfi9nNjQckRvMWkBXlks
 k8NYm2X0GiS9ZHL18u/kA24xAU5ZERPlWp8U/gFFfDYRcUU+OJom2hDyGaAtq2NSxKvA
 dOZ7SPm3n4sKxnAAkJGM+dR4oAFEtSohCCyqXoT62EsiHAwws0aNguAp9FicnRD4xLkx
 PAHVCFpW6qG55/kPXi6dpl/tz2nT5lq7KZyvP/NJIoMQQfocvw8zuCDiWa7V0Ht1Rt44 vQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38x6bsb7g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 06:35:24 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 152AWi9F000856;
        Wed, 2 Jun 2021 10:35:22 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 38ucvha8k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 10:35:22 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 152AYmfM25166238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jun 2021 10:34:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BE6CA4054;
        Wed,  2 Jun 2021 10:35:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11D2DA405C;
        Wed,  2 Jun 2021 10:35:20 +0000 (GMT)
Received: from localhost (unknown [9.85.73.225])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jun 2021 10:35:19 +0000 (GMT)
Date:   Wed, 02 Jun 2021 16:05:18 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/6] trace/stack: Move code to save the stack trace
 into a separate function
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Torsten Duwe <duwe@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>
References: <cover.1621577151.git.naveen.n.rao@linux.vnet.ibm.com>
        <6a8b68f8bd64f8c16d97ef943534c639781e7f77.1621577151.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210601112824.29c5f168@oasis.local.home>
In-Reply-To: <20210601112824.29c5f168@oasis.local.home>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1622626530.3j8u9fhp7h.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wMaknAHvZGGcKWQbgIroU6fNZzhXIyU2
X-Proofpoint-GUID: wMaknAHvZGGcKWQbgIroU6fNZzhXIyU2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_05:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 21 May 2021 12:18:36 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> In preparation to add support for stack tracer to powerpc, move code to
>> save stack trace and to calculate the frame sizes into a separate weak
>> function. Also provide access to some of the data structures used by the
>> stack trace code so that architectures can update those.
>>=20
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  include/linux/ftrace.h     |  8 ++++
>>  kernel/trace/trace_stack.c | 98 ++++++++++++++++++++------------------
>>  2 files changed, 60 insertions(+), 46 deletions(-)
>>=20
>> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
>> index a69f363b61bf73..8263427379f05c 100644
>> --- a/include/linux/ftrace.h
>> +++ b/include/linux/ftrace.h
>> @@ -368,10 +368,18 @@ static inline void arch_ftrace_set_direct_caller(s=
truct pt_regs *regs,
>> =20
>>  #ifdef CONFIG_STACK_TRACER
>> =20
>> +#define STACK_TRACE_ENTRIES 500
>> +
>> +extern unsigned long stack_dump_trace[STACK_TRACE_ENTRIES];
>> +extern unsigned stack_trace_index[STACK_TRACE_ENTRIES];
>> +extern unsigned int stack_trace_nr_entries;
>> +extern unsigned long stack_trace_max_size;
>>  extern int stack_tracer_enabled;
>> =20
>>  int stack_trace_sysctl(struct ctl_table *table, int write, void *buffer=
,
>>  		       size_t *lenp, loff_t *ppos);
>> +void stack_get_trace(unsigned long traced_ip, unsigned long *stack_ref,
>> +					unsigned long stack_size, int *tracer_frame);
>> =20
>>  /* DO NOT MODIFY THIS VARIABLE DIRECTLY! */
>>  DECLARE_PER_CPU(int, disable_stack_tracer);
>> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
>> index 63c28504205162..5b63dbd37c8c25 100644
>> --- a/kernel/trace/trace_stack.c
>> +++ b/kernel/trace/trace_stack.c
>> @@ -19,13 +19,11 @@
>> =20
>>  #include "trace.h"
>> =20
>> -#define STACK_TRACE_ENTRIES 500
>> +unsigned long stack_dump_trace[STACK_TRACE_ENTRIES];
>> +unsigned stack_trace_index[STACK_TRACE_ENTRIES];
>> =20
>> -static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES];
>> -static unsigned stack_trace_index[STACK_TRACE_ENTRIES];
>> -
>> -static unsigned int stack_trace_nr_entries;
>> -static unsigned long stack_trace_max_size;
>> +unsigned int stack_trace_nr_entries;
>> +unsigned long stack_trace_max_size;
>>  static arch_spinlock_t stack_trace_max_lock =3D
>>  	(arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
>> =20
>> @@ -152,49 +150,19 @@ static void print_max_stack(void)
>>   * Although the entry function is not displayed, the first function (sy=
s_foo)
>>   * will still include the stack size of it.
>>   */
>> -static void check_stack(unsigned long ip, unsigned long *stack)
>=20
> I just got back from PTO and have a ton of other obligations to attend
> to before I can dig deeper into this.

Thanks for the heads up.

> I'm not opposed to this change,
> but the stack_tracer has not been getting the love that it deserves and
> I think you hit one of the issues that needs to be addressed.

Sure. I started off by just updating arch_stack_walk() to return the=20
traced function, but soon realized that the frame size determination can=20
be made more robust on powerpc due to the ABI.

> I'm not
> sure this is a PPC only issue, and would like to see if I can get more
> time (or someone else can) to reevaluate the way stack tracer works,
> and see if it can be made a bit more robust.

Sure. If you have specific issues to be looked at, please do elaborate.

It seems to be working fine otherwise. The one limitation though is down=20
to how ftrace works on powerpc -- the mcount call is before a function=20
sets up its own stackframe. Due to this, we won't ever be able to=20
account for the stackframe from a leaf function -- but, that's a fairly=20
minor limitation.


Thanks,
Naveen

