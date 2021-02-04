Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442B830F78A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbhBDQSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:18:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237833AbhBDQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:14:06 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 114GBsOo050304;
        Thu, 4 Feb 2021 11:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=kVnwx0F5jwDSpsz5yPUrCTU+5mHXUotFBG3arnVKbac=;
 b=fRM0ko5StgyMzKExDMXOMWFvGVu6am2Di+uorVXLjzCK95xMhtJX964ldcu/WzLyd/0S
 9vFTxlE36MCQH3uoxn3bDY0SZ9dWvXkeXmeL+s+LS1ZHy1peonA52s8cDxAINCocTofn
 yaLGDjcT6X8rcY1kJVf4ZH7jJ7sUF6HarWf7+RKMK+wx+D79vf9GyHP6CuXTcKxpZgdW
 zALYNvs9cuKUgkE4h4yj+SCS+hdg3xsMmR1LLjDAiBdZWvb5o4zZukpTpYhB/7+IeLdp
 gJb2w2RHXIXiylRfNQ0BEwPxCECNRkknNKL64fi3CSDqhVvnNTCi6BcIjgMVL8+YI14A +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36gm7wr0rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 11:12:19 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 114GC3NX051080;
        Thu, 4 Feb 2021 11:12:19 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36gm7wr0q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 11:12:18 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 114FXmEd020212;
        Thu, 4 Feb 2021 16:12:17 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 36g8kerb05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 16:12:17 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 114GC5TA27394498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 16:12:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C4AAA4053;
        Thu,  4 Feb 2021 16:12:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95E64A4051;
        Thu,  4 Feb 2021 16:12:13 +0000 (GMT)
Received: from localhost (unknown [9.85.87.37])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Feb 2021 16:12:13 +0000 (GMT)
Date:   Thu, 4 Feb 2021 21:42:11 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, oleg@redhat.com, rostedt@goodmis.org,
        paulus@samba.org, jniethe5@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/uprobes: Validation for prefixed instruction
Message-ID: <20210204161211.GM210@DESKTOP-TDPLP67.localdomain>
References: <20210204104703.273429-1-ravi.bangoria@linux.ibm.com>
 <20210204130821.GK210@DESKTOP-TDPLP67.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204130821.GK210@DESKTOP-TDPLP67.localdomain>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_08:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/02/04 06:38PM, Naveen N. Rao wrote:
> On 2021/02/04 04:17PM, Ravi Bangoria wrote:
> > Don't allow Uprobe on 2nd word of a prefixed instruction. As per
> > ISA 3.1, prefixed instruction should not cross 64-byte boundary.
> > So don't allow Uprobe on such prefixed instruction as well.
> > 
> > There are two ways probed instruction is changed in mapped pages.
> > First, when Uprobe is activated, it searches for all the relevant
> > pages and replace instruction in them. In this case, if we notice
> > that probe is on the 2nd word of prefixed instruction, error out
> > directly. Second, when Uprobe is already active and user maps a
> > relevant page via mmap(), instruction is replaced via mmap() code
> > path. But because Uprobe is invalid, entire mmap() operation can
> > not be stopped. In this case just print an error and continue.
> > 
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > ---
> > v1: http://lore.kernel.org/r/20210119091234.76317-1-ravi.bangoria@linux.ibm.com
> > v1->v2:
> >   - Instead of introducing new arch hook from verify_opcode(), use
> >     existing hook arch_uprobe_analyze_insn().
> >   - Add explicit check for prefixed instruction crossing 64-byte
> >     boundary. If probe is on such instruction, throw an error.
> > 
> >  arch/powerpc/kernel/uprobes.c | 66 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 65 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
> > index e8a63713e655..485d19a2a31f 100644
> > --- a/arch/powerpc/kernel/uprobes.c
> > +++ b/arch/powerpc/kernel/uprobes.c
> > @@ -7,6 +7,7 @@
> >   * Adapted from the x86 port by Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> >   */
> >  #include <linux/kernel.h>
> > +#include <linux/highmem.h>
> >  #include <linux/sched.h>
> >  #include <linux/ptrace.h>
> >  #include <linux/uprobes.h>
> > @@ -28,6 +29,69 @@ bool is_trap_insn(uprobe_opcode_t *insn)
> >  	return (is_trap(*insn));
> >  }
> >  
> > +#ifdef CONFIG_PPC64
> > +static int get_instr(struct mm_struct *mm, unsigned long addr, u32 *instr)
> > +{
> > +	struct page *page;
> > +	struct vm_area_struct *vma;
> > +	void *kaddr;
> > +	unsigned int gup_flags = FOLL_FORCE | FOLL_SPLIT_PMD;
> > +
> > +	if (get_user_pages_remote(mm, addr, 1, gup_flags, &page, &vma, NULL) <= 0)
> > +		return -EINVAL;
> > +
> > +	kaddr = kmap_atomic(page);
> > +	*instr = *((u32 *)(kaddr + (addr & ~PAGE_MASK)));
> > +	kunmap_atomic(kaddr);
> > +	put_page(page);
> > +	return 0;
> > +}
> > +
> > +static int validate_prefixed_instr(struct mm_struct *mm, unsigned long addr)
> > +{
> > +	struct ppc_inst inst;
> > +	u32 prefix, suffix;
> > +
> > +	/*
> > +	 * No need to check if addr is pointing to beginning of the
> > +	 * page. Even if probe is on a suffix of page-unaligned
> > +	 * prefixed instruction, hw will raise exception and kernel
> > +	 * will send SIGBUS.
> > +	 */
> > +	if (!(addr & ~PAGE_MASK))
> > +		return 0;
> > +
> > +	if (get_instr(mm, addr, &prefix) < 0)
> > +		return -EINVAL;
> > +	if (get_instr(mm, addr + 4, &suffix) < 0)
> > +		return -EINVAL;
> > +
> > +	inst = ppc_inst_prefix(prefix, suffix);
> > +	if (ppc_inst_prefixed(inst) && (addr & 0x3F) == 0x3C) {
> > +		printk_ratelimited("Cannot register a uprobe on 64 byte "
> 		^^^^^^^^^^^^^^^^^^ pr_info_ratelimited()
> 
> It should be sufficient to check the primary opcode to determine if it 
> is a prefixed instruction. You don't have to read the suffix. I see that 
> we don't have a helper to do this currently, so you could do:
> 
> 	if (ppc_inst_primary_opcode(ppc_inst(prefix)) == 1)

Seeing the kprobes code, I realized that we have to check for another 
scenario (Thanks, Jordan!). If this is the suffix of a prefix 
instruction for which a uprobe has already been installed, then the 
previous word will be a 'trap' instruction. You need to check if there 
is a uprobe at the previous word, and if the original instruction there 
was a prefix instruction.

- Naveen

