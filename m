Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC673323D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCILWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:22:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbhCILWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:22:12 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129B3hVr112130;
        Tue, 9 Mar 2021 06:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=33MSJeKOJi4+jaAUNsH0vSXR7A3trD0q3srKz5Tj/ok=;
 b=hEJzA/ph2QFwapCbBviSSkLZguu55d0WTFdUgAySnXKXXfFwO8NFJHwCI3ID1KQGvOIT
 jMrNPBzK0pLP6BtO2JxGvTw0kLSUsDk2NhOywymq6ed7Ny3yjgCghLSymWUfb+jygdxv
 Ncu9gQphkeaD73x2gdxvoapqAgCEOz4r8GQEFV0117LH3PkehLVpSXvuJ7STgjYve92F
 dBlSZ8+9ELQ1qf+pO9Gg77tI0NEFWWIL0z/v7/ZGI3aZAqGneZas/JCUMUQmIr3/NxzG
 zGcb8BTcoLaJQLcaXErWxBTI7s9qhDt/GvteYeOwBbcQgu42VWCRu4WT7R3WG7FXfH5M CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375wesyqhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 06:21:24 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 129B3mjq112563;
        Tue, 9 Mar 2021 06:21:24 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375wesyqgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 06:21:24 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 129AwPua010276;
        Tue, 9 Mar 2021 11:21:21 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3741c81dc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 11:21:21 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 129BLIGZ56099188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 11:21:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 815FBA4057;
        Tue,  9 Mar 2021 11:21:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BDC4A404D;
        Tue,  9 Mar 2021 11:21:18 +0000 (GMT)
Received: from localhost (unknown [9.85.103.166])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Mar 2021 11:21:17 +0000 (GMT)
Date:   Tue, 9 Mar 2021 16:51:15 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, oleg@redhat.com,
        rostedt@goodmis.org, paulus@samba.org, jniethe5@gmail.com,
        naveen.n.rao@linux.ibm.com, sandipan@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        christophe.leroy@csgroup.eu
Subject: Re: [PATCH v4] powerpc/uprobes: Validation for prefixed instruction
Message-ID: <20210309112115.GG145@DESKTOP-TDPLP67.localdomain>
References: <20210305115433.140769-1-ravi.bangoria@linux.ibm.com>
 <87ft14r6sa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft14r6sa.fsf@mpe.ellerman.id.au>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_09:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/03/09 08:54PM, Michael Ellerman wrote:
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
> > As per ISA 3.1, prefixed instruction should not cross 64-byte
> > boundary. So don't allow Uprobe on such prefixed instruction.
> >
> > There are two ways probed instruction is changed in mapped pages.
> > First, when Uprobe is activated, it searches for all the relevant
> > pages and replace instruction in them. In this case, if that probe
> > is on the 64-byte unaligned prefixed instruction, error out
> > directly. Second, when Uprobe is already active and user maps a
> > relevant page via mmap(), instruction is replaced via mmap() code
> > path. But because Uprobe is invalid, entire mmap() operation can
> > not be stopped. In this case just print an error and continue.
> >
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> Do we have a Fixes: tag for this?

Since this is an additional check we are adding, I don't think we should 
add a Fixes: tag. Nothing is broken per-se -- we're just adding more 
checks to catch simple mistakes. Also, like Oleg pointed out, there are 
still many other ways for users to shoot themselves in the foot with 
uprobes and prefixed instructions, if they so desire.

However, if you still think we should add a Fixes: tag, we can perhaps 
use the below commit since I didn't see any specific commit adding 
support for prefixed instructions for uprobes:

Fixes: 650b55b707fdfa ("powerpc: Add prefixed instructions to 
instruction data type")

> 
> > ---
> > v3: https://lore.kernel.org/r/20210304050529.59391-1-ravi.bangoria@linux.ibm.com
> > v3->v4:
> >   - CONFIG_PPC64 check was not required, remove it.
> >   - Use SZ_ macros instead of hardcoded numbers.
> >
> >  arch/powerpc/kernel/uprobes.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
> > index e8a63713e655..4cbfff6e94a3 100644
> > --- a/arch/powerpc/kernel/uprobes.c
> > +++ b/arch/powerpc/kernel/uprobes.c
> > @@ -41,6 +41,13 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
> >  	if (addr & 0x03)
> >  		return -EINVAL;
> >  
> > +	if (cpu_has_feature(CPU_FTR_ARCH_31) &&
> > +	    ppc_inst_prefixed(auprobe->insn) &&
> > +	    (addr & (SZ_64 - 4)) == SZ_64 - 4) {
> > +		pr_info_ratelimited("Cannot register a uprobe on 64 byte unaligned prefixed instruction\n");
> > +		return -EINVAL;
> 
> I realise we already did the 0x03 check above, but I still think this
> would be clearer simply as:
> 
> 	    (addr & 0x3f == 60)

Indeed, I like the use of `60' there -- hex is overrated ;)

- Naveen
