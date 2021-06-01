Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B23D39749E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhFANx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:53:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233584AbhFANxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:53:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151DX2xm090255;
        Tue, 1 Jun 2021 09:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=mDnV0LUjr/nkxsZMowZ68RPaqejWJLV3R5OTVuMBWNI=;
 b=BaMnAF6sQzBcj+g7At8P2++bnm48aNRufByTQtZpFZG+1GGHHLizMiNSoZVfT0zxpH8Z
 mzycO6ktXnqLyA+yLqtKExRlXZkiERVMG/bD5AFgQpz1fIViCx2wgFMUKIwZzQ2zI4fX
 kAHTc72fvqhIKm65NjPgJD/0cRiVKjrJ8lLCcjZ8f9U0WayAzILcoqeRaTy+N1+a9oG/
 y0AEPYx8mUUZiYi5RvMY/BOUb2A5+gXTo8RIcOpHA98i/IO//1zuv5K0B00bK6g0Bm5j
 eisRC3lRNef/wfH8FsNhM6RrxRb7FJM25VCumGaq9GBT4BNCHOzDdPMzK9oniCaESUeM sw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38wntd8qty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 09:51:33 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 151DmZ5N020259;
        Tue, 1 Jun 2021 13:51:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 38ucvh9rm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 13:51:31 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 151DpTDD14352894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 13:51:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 839B6A4051;
        Tue,  1 Jun 2021 13:51:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B093AA4053;
        Tue,  1 Jun 2021 13:51:28 +0000 (GMT)
Received: from localhost (unknown [9.85.73.71])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jun 2021 13:51:28 +0000 (GMT)
Date:   Tue, 01 Jun 2021 19:21:27 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/6] powerpc/trace: Add support for stack tracer
To:     Torsten Duwe <duwe@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1621577151.git.naveen.n.rao@linux.vnet.ibm.com>
        <6ed4941e8ff48729a14b24c8e0d0f876fe8f22e0.1621577151.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <6ed4941e8ff48729a14b24c8e0d0f876fe8f22e0.1621577151.git.naveen.n.rao@linux.vnet.ibm.com>
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1622555131.dct16s656o.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mvcbIP1VvixYC1v_n35mv_aOznNrkNu6
X-Proofpoint-GUID: mvcbIP1VvixYC1v_n35mv_aOznNrkNu6
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_06:2021-06-01,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen N. Rao wrote:
> +
> +unsigned long ftrace_get_traced_func_if_no_stackframe(unsigned long ip, =
unsigned long *stack)
> +{
> +	if (!is_ftrace_entry(ip))
> +		return 0;
> +
> +	if (IS_ENABLED(CONFIG_PPC32))
> +		return stack[11]; /* see MCOUNT_SAVE_FRAME */
> +
> +	if (!IS_ENABLED(CONFIG_MPROFILE_KERNEL))
> +		return 0;
> +
> +	return stack[(STACK_FRAME_OVERHEAD + offsetof(struct pt_regs, nip)) / s=
izeof(unsigned long)];

Looking at Daniel's patch to address KASAN errors with our stack walk=20
code in show_stack() [*], I realized that I am not validating the stack=20
pointer here for the above accesses...

[*] http://lkml.kernel.org/r/20210528074806.1311297-1-dja@axtens.net

> +}
> +
> +#ifdef CONFIG_STACK_TRACER
> +void stack_get_trace(unsigned long traced_ip,
> +		     unsigned long *stack_ref __maybe_unused,
> +		     unsigned long stack_size __maybe_unused,
> +		     int *tracer_frame)
> +{
> +	unsigned long sp, newsp, top, ip;
> +	int ftrace_call_found =3D 0;
> +	unsigned long *stack;
> +	int i =3D 0;
> +
> +	sp =3D current_stack_frame();
> +	top =3D (unsigned long)task_stack_page(current) + THREAD_SIZE;
> +
> +	while (validate_sp(sp, current, STACK_FRAME_OVERHEAD) && i < STACK_TRAC=
E_ENTRIES) {
> +		stack =3D (unsigned long *) sp;
> +		newsp =3D stack[0];
> +		ip =3D stack[STACK_FRAME_LR_SAVE];
> +
> +		if (ftrace_call_found) {
> +			stack_dump_trace[i] =3D ip;
> +			stack_trace_index[i++] =3D top - sp;
> +		}

And I need to make the above accesses bypass KASAN as well.


- Naveen

