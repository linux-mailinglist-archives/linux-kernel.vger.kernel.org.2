Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1631308B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhBHLTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:19:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233075AbhBHLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:08:09 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 118B1GtB142216;
        Mon, 8 Feb 2021 06:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=D1045OOgRUGLm4fkj+HoCDKh84em/j3peBwyygyFmjM=;
 b=MmoyrAe2VuTpJ7kwSe3foYT6MjQ4QFFU/eMXmPk0piwijmTZ7RJoJscN3YIwfP3IHWtd
 ZdLLv7yNS0AHfTF3RbkPEPJqn778zcrr15UJHma0tZIsTJRvh9kE1LLNUgThmJI3giSu
 itTibOwDleYW236m+YdZ1if65U8mO66V4BHrAcZlDMVYZ88iPbDBIHr5EHwpS0vg4TEl
 F6FMVm7BXaHimu4Pk1aOCyKDrJqjoGjzxhhphR6oXrc+tlceyrjfl5ubIqXulWsKBZ9a
 xbO9HILZBk+96dafxtsWbpY9LOs/7ekclW6vLF2MDGRgV8ALEtLucalgHKCJDRhwaMWg 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36k0t05ydw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 06:06:25 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 118B1paZ145230;
        Mon, 8 Feb 2021 06:06:23 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36k0t05ycd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 06:06:23 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 118B352g030526;
        Mon, 8 Feb 2021 11:06:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 36j94wh6e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 11:06:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 118B68q812059050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Feb 2021 11:06:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CCC542042;
        Mon,  8 Feb 2021 11:06:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15BD242041;
        Mon,  8 Feb 2021 11:06:16 +0000 (GMT)
Received: from [9.199.47.177] (unknown [9.199.47.177])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Feb 2021 11:06:15 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/uprobes: Validation for prefixed instruction
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     mpe@ellerman.id.au, rostedt@goodmis.org, paulus@samba.org,
        jniethe5@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20210204104703.273429-1-ravi.bangoria@linux.ibm.com>
 <20210206180604.GA8897@redhat.com>
Message-ID: <8fe4d62a-8873-d436-d20b-da3027103fe1@linux.ibm.com>
Date:   Mon, 8 Feb 2021 16:36:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210206180604.GA8897@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_03:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/21 11:36 PM, Oleg Nesterov wrote:
> On 02/04, Ravi Bangoria wrote:
>>
>> +static int get_instr(struct mm_struct *mm, unsigned long addr, u32 *instr)
>> +{
>> +	struct page *page;
>> +	struct vm_area_struct *vma;
>> +	void *kaddr;
>> +	unsigned int gup_flags = FOLL_FORCE | FOLL_SPLIT_PMD;
>> +
>> +	if (get_user_pages_remote(mm, addr, 1, gup_flags, &page, &vma, NULL) <= 0)
>> +		return -EINVAL;
> 
> "vma" is not used,

Ok.

> and I don't think you need FOLL_SPLIT_PMD.
Isn't it needed if the target page is hugepage?

> Otherwise I can't really comment this ppc-specific change.
> 
> To be honest, I don't even understand why do we need this fix. Sure, the
> breakpoint in the middle of 64-bit insn won't work, why do we care? The
> user should know what does he do.

That's a valid point. This patch is to protract user from doing
invalid thing.

Though, there is one minor scenario where this patch will help. If
the original prefixed instruction is 64 byte unaligned, and say
user probes it, Uprobe infrastructure will emulate such instruction
transparently without notifying user that the instruction is
improperly aligned.

> Not to mention we can't really trust get_user_pages() in that this page
> can be modified by mm owner or debugger...

As Naveen pointed out, there might be existing uprobe on the prefix
and this patch will fail to detect such scenario. So I'm thinking to
read the instruction directly from file backed page (like copy_insn),
in which case I won't use get_user_pages().

Thanks Oleg for the review!

Ravi
