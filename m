Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01BF44989B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbhKHPnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:43:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42612 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236257AbhKHPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:43:40 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8FZFcb021336;
        Mon, 8 Nov 2021 15:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1excU8RYIgpNJR9wqzlfDTEKd0IXhTNXdDYBtxpz+uk=;
 b=HQlDojOgYf2s4ax7GStfPxeLf5gALKqwlD/oazAxKqeRuRxdxrlN6egZwDFQHwLScgma
 938ZByedNUlaFelrtDkZ3gBtPkUtqgPak2wLiUs7Q8EWopzLw2GsbKMmDGYsMFZG4iSO
 DVDv3XYT9QcYm53B0gj7Vqer4ec0dh72KlBz1/4aCYktb68Asf+RH7RmI85IYZIHrpqy
 HdJpFr0qT9LZp61L7cgmexqiNCT3WaxZMu6a+cY1x6uk7+U+0CpvbRcWXo3A5vn4Izzs
 FTK0NmjMIWdFnJBavA0D+a8oSZN5WyUZtYNQ4y3njPY3bvmE8aiSz2rqFLQkkXquQ9qt Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c69dn1abt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 15:40:45 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A8E0Tkt024661;
        Mon, 8 Nov 2021 15:40:44 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c69dn1aat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 15:40:44 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A8FbkxC014177;
        Mon, 8 Nov 2021 15:40:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3c5gyj7t67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 15:40:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A8Feeuh62062914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Nov 2021 15:40:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F8174C046;
        Mon,  8 Nov 2021 15:40:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0803B4C052;
        Mon,  8 Nov 2021 15:40:40 +0000 (GMT)
Received: from localhost (unknown [9.171.0.165])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  8 Nov 2021 15:40:39 +0000 (GMT)
Date:   Mon, 8 Nov 2021 16:40:38 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] compiler.h: Avoid using inline asm operand modifiers
Message-ID: <your-ad-here.call-01636386038-ext-6578@work.hours>
References: <cover.thread-1a26be.your-ad-here.call-01621428935-ext-2104@work.hours>
 <patch-1.thread-1a26be.git-930d1b44844a.your-ad-here.call-01621428935-ext-2104@work.hours>
 <20211105165418.ucsrpk53dv5kgu6k@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211105165418.ucsrpk53dv5kgu6k@treble>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2tMQAjdIfhs9CpExj_eLxDMyhyMWqdfw
X-Proofpoint-ORIG-GUID: wrHOXx2ufE8MBy-NiQGXOu9yHYo7gS5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_05,2021-11-08_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 09:54:18AM -0700, Josh Poimboeuf wrote:
> On Wed, May 19, 2021 at 03:03:08PM +0200, Vasily Gorbik wrote:
> > The expansion of annotate_reachable/annotate_unreachable on s390 will
> > result in a compiler error if the __COUNTER__ value is high enough.
> > For example with "i" (154) the "%c0" operand of annotate_reachable
> > will be expanded to -102:
> > 
> >         -102:
> >         .pushsection .discard.reachable
> >         .long -102b - .
> >         .popsection
> > 
> > This is a quirk of the gcc backend for s390, it interprets the %c0
> > as a signed byte value. Avoid using operand modifiers in this case
> > by simply converting __COUNTER__ to string, with the same result,
> > but in an arch assembler independent way.
> > 
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> 
> This patch causes these macros to break with Clang and
> CONFIG_TRACE_BRANCH_PROFILING.
> 
> I get a lot of warnings like
> 
>   arch/x86/kernel/traps.o: warning: objtool: handle_xfd_event()+0x134: unreachable instruction
> 
> Without an asm input, 'volatile' is ignored for some reason and Clang
> feels free to move the reachable() annotation away from its intended
> location.
> 
> I wonder if we could go back to the original approach of providing
> __COUNTER__ as an input to the asm, but then mask it to < 128.
> 
> Does this work on s390?
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 3d5af56337bd..42935500a712 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -115,24 +115,18 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>   * The __COUNTER__ based labels are a hack to make each instance of the macros
>   * unique, to convince GCC not to merge duplicate inline asm statements.
>   */
> -#define __stringify_label(n) #n
> -
> -#define __annotate_reachable(c) ({					\
> -	asm volatile(__stringify_label(c) ":\n\t"			\
> +#define annotate_reachable() ({						\
> +	asm volatile("%c0:\n\t"						\
>  		     ".pushsection .discard.reachable\n\t"		\
> -		     ".long " __stringify_label(c) "b - .\n\t"		\
> -		     ".popsection\n\t");				\
> +		     ".long %c0b - .\n\t"				\
> +		     ".popsection\n\t" : : "i" (__COUNTER__ & 0x7f));	\
>  })

hm, could we just add asm input back and not use it? and keep
__stringify_label(c) as is? would that work as well?
