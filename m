Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F7C339555
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhCLRqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:46:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232233AbhCLRqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:46:13 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12CHaB6L123980;
        Fri, 12 Mar 2021 12:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8eSFR7DloFmWUq9pd7am+E6Lmq3Acogf3AiN4OfbAHs=;
 b=JcBeGhQsNZAmH8XdFEGXTQnIWNJtiGm/FtZTwz4+17VMZ2BLpucbBNVDhJoTAgSv+Y+f
 p0yvyiX75O0+vbWTaxleK7H63x+5KXsJrX4So2FYihPF3CXZNQAECKcvbaTAcwyL3fER
 oiea61y+8FnkeZ9+c8qgmJ/I+cNrZI1ZZUmzwRGSg3Ubk/IHHkfmvepmqsCvfVTRgFTr
 m7RhIM2IOlxEkFBd3I6ejSiJFw8psCQvyAFR+sbf/uoW9sLx6KzJcEcN+RFgLo+tT42+
 Rk/KMpZLljjZTJbVggQkHrb2Wa/q1WV95nMzBo1cQi/6Pi5Kg1e9U6bhH94WzCdiuKtl EQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3788hg91gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Mar 2021 12:46:11 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12CHdSQl014532;
        Fri, 12 Mar 2021 17:46:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3768va1ntc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Mar 2021 17:46:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12CHk7En63242700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 17:46:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4840842047;
        Fri, 12 Mar 2021 17:46:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B8B242041;
        Fri, 12 Mar 2021 17:46:07 +0000 (GMT)
Received: from [9.145.48.156] (unknown [9.145.48.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Mar 2021 17:46:07 +0000 (GMT)
Subject: Re: [PATCH] gcov: fail build on gcov_info size mismatch
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210311130328.2859337-1-oberpar@linux.ibm.com>
 <CAHk-=whmwT-_VJJ72C1Wyzbzb_rRb9c7bc5RpGhdOXsyz4FDKQ@mail.gmail.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <1c7a49e7-0e27-561b-a2f9-d42a83dc4c29@linux.ibm.com>
Date:   Fri, 12 Mar 2021 18:46:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAHk-=whmwT-_VJJ72C1Wyzbzb_rRb9c7bc5RpGhdOXsyz4FDKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-12_06:2021-03-12,2021-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.2021 19:38, Linus Torvalds wrote:
> On Thu, Mar 11, 2021 at 5:07 AM Peter Oberparleiter
> <oberpar@linux.ibm.com> wrote:
>>
>> This patch adds a compile-time check to ensure that the kernel's version
>> of struct gcov_info has the same length as the one used by GCC as
>> determined by looking at GCC's assembler output.
> 
> So I don't think this is a bad idea, but if you end up test-compiling
> something, could we not verify things a bit more?

I thought about this as well, based on the idea to not only look at the
size, but potentially also at the assembler-level definition of GCC's
gcov_info version, and to compare that to how the kernel's version looks
like. But then I thought that this still doesn't catch the cases where
the semantics of a struct member changed.

> If you actually build the object file, you should be able to then
> check much more. You'll find the pointer to the struct gcov_info in
> "__gcov_.fn", which is admittedly hard to then link against a test
> program (because of that dot in the name that means that you can't
> even use "attribute((alias..))" to generate some other name for it).

This is an idea I hadn't considered - a user space test program that
accesses GCC's gcov_info data using the kernel's definition would be
able to fail a lot more gracefully than the kernel could.

Getting a pointer to the gcov_info struct in a program isn't actually
that difficult: just provide a custom function named __gcov_init and
don't link with libgcov. At program start constructor code will then
call this function with the gcov_info pointer as parameter. This is
exactly how the kernel collects all these gcov_info instances.

> But then you could test not only the size, but you could verify that
> the "filename" field matches, that the n_functions field should be 1
> etc.

Taking that idea a step further, a test program could exercise the exact
same code that the kernel uses to generate a .gcda file from in-memory
gcov_info data (or die/hang when there's a mismatch in the struct
definition) and write that out. The resulting .gcda file could then be
verified for correctness by passing it to GCC's gcov tool.

This shouldn't be too difficult to achieve since there is already a
kernel function that converts a gcov_info into .gcda file format
in-memory with no actual dependency on kernel infrastructure. Of course
this requires the gcov kernel code to be taught to live in user space
with a healthy dose of ifdef-ing.

Is there a convention on what is the lesser evil: adding multiple
ifdef-endifs all over the place or moving code around for no apparent
reason other than to gather all required parts in one place for a single
ifdef?

[...]

> I dunno. The gcov code has obviously never actually done anything like
> this before, so maybe I'm just taking the "we could verify
> _something_" and my reaction is that there could be even more
> verification if we really want to go down that rabbit hole..

I'll try to come up with a new patch that introduces a test like
described above. If that approach fails we can fall back to the original
approach (plus the fix for the kernel test robot findings).


Regards,
  Peter

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
