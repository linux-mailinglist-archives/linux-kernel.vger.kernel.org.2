Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4371C3AEA86
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFUN4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:56:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229747AbhFUN4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:56:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LDYHii133966;
        Mon, 21 Jun 2021 09:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9iODRwHV+KkdTt6FfaUgzfaq3KIbniuN823W91WdpWQ=;
 b=ZQaH2xgT7eWgtNku2HhxSQrpcjx2SCO16k4n8wPEaYIu3y7DgRxeFq9+hpExCXj7C1uV
 YxVsrCyGVFAfNOm3UjOVs8qmVo9I8YjTBv2D12qN8yIfUesPAAzVxMei7bVqHGtbg0Y8
 D4SIGEqhPD5a947X1ANcHnPG6VH452KsrvateHzXUnto3Y5Cofqf8PfowOfHAz4J98LV
 ngX2fBXbQuJRzT5ytMo2dAOlaryzhW5HZHsQXtXppWFBHTDZGdprnLAWRbTfYLEZABFr
 M/IwrDzF1lmNHOiauv8zTS5QLDc9lTrtMIu1SvR1JWeU+YnTzVL4rSqdd04uGmc8CxxW bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39aufxs7gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 09:53:54 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15LDZEcC137987;
        Mon, 21 Jun 2021 09:53:54 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39aufxs7fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 09:53:54 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15LDrpeI006331;
        Mon, 21 Jun 2021 13:53:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 399878rgq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 13:53:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15LDrn6r33423684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 13:53:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45A324C04E;
        Mon, 21 Jun 2021 13:53:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F37D94C044;
        Mon, 21 Jun 2021 13:53:48 +0000 (GMT)
Received: from [9.145.162.96] (unknown [9.145.162.96])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jun 2021 13:53:48 +0000 (GMT)
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        johannes.berg@intel.com, ndesaulniers@google.com,
        nathan@kernel.org, keescook@chromium.org, elver@google.com,
        mark.rutland@arm.com
References: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
 <2f8a4e21-a09b-8c8d-54ce-45cf2f0e83ff@linux.ibm.com>
 <YMx/9Xv8BF7ghAO6@hirez.programming.kicks-ass.net>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <0df5ec31-46ac-4f50-26f5-c761371198c9@linux.ibm.com>
Date:   Mon, 21 Jun 2021 15:53:48 +0200
In-Reply-To: <YMx/9Xv8BF7ghAO6@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DvKKHJltdzQw4UTf_L-VICcc8TL5Wkpj
X-Proofpoint-GUID: BGvaG9Hln6JTpB0yttkhRYqz4QV0GxN3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_06:2021-06-21,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106210080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.06.2021 13:13, Peter Zijlstra wrote:
> On Mon, Jun 14, 2021 at 04:43:27PM +0200, Peter Oberparleiter wrote:
>> On 14.06.2021 12:17, Peter Zijlstra wrote:
>> If there was a way to automatically identify 'noinstr'-afflicted source
>> files (e.g. by grepping the pre-processed source files), one could also
>> automate this process by adjusting the kbuild-code that adds profiling
>> flags to automatically exclude such files.
> 
> Or we just wait for the compilers to implement the required function
> attribute and then make the whole thing depend on having a recent enough
> compiler, which is what I'm hoping for.

Sounds like the best approach given the current situation.

> Developers should use recent compilers anyway...
> 
>>> Until such time as that compilers have added a function attribute to
>>> disable this instrumentation, mark GCOV as broken.
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[...]

>> Users that are absolutely sure that their code can work with
>> gcov-profiling can manually edit their sub-Makefiles to list those files
>> that should be instrumented. In my opinion your introduction of
>> ARCH_HAS_GCOV_BROKEN unnecessarily takes away this capability.
> 
> Are there any users?

I honestly cannot tell how many people are using the gcov-kernel
facility, but I guess that is true for most kernel functions. I do get
regular bug reports if things break due to GCC changes though, so there
are definitely some users.

> Who uses this GCOV stuff, and should we migrate them to KCOV?

I have not used KCOV myself, but based on the documentation available
about the mechanism itself and some of its users it appears that GCOV
and KCOV are not feature-equivalent:

KCOV provides an opt-in capability for user-space processes to record a
history of kernel code executed on their behalf. Opt-in means the
process must include code to start recording. There's also some limited
support for collecting data for kernel background tasks.

The output is a sequence of kernel addresses relating to executed basic
blocks - great for consumption in automated mechanisms like fuzzers and
the like, but tooling for post-processing the data into human-readable
format for general purpose review seems to be scarce.

GCOV provides a build-time configurable option to instrument almost all
kernel code or, if requested, only specific parts. There's no need to
opt-in at run-time, all execution of instrumented code running since
boot will be recorded, including interrupt handlers, background tasks,
etc. Of course this also means there's no means to filter by the process
causing the kernel code execution.

The output is GCC's .gcda data format. Using GCC's gcov tool this can be
directly converted into annotated source code containing statement,
function, and branch coverage data. Also there are tools building on
gcov output to create overview pages for the thousands of kernel source
files and detailed graphical output based on this information. This kind
of representation is great for manual review to answer questions like
"all my tests ran, why is there still an uncovered piece of kernel code?"

So to summarize:

KCOV => Great for automated processing (e.g. fuzzing)

GCOV => Great for manual review (e.g. improving test coverage)

> The thing is, I got dead kernel reports from KCOV users really quickly
> after all this landed, I've never even heard of a GCOV user, let alone
> had a problem report from one.

KCOV is used 24/7 by automated fuzzing code - I would assume that those
catch fatal errors rather quickly. GCOV is used when a developer/tester
has a need to review their test coverage. And even then they may only
instrument portions of the kernel that may not affected by the noinstr
problem.

> Given all this seems mostly unused, I suppose we can wait for the
> compilers to implement the attribute and simply ignore any and all
> problems stemming from the use of GCOV -- telling them to go use KCOV
> instead.

It seems this might be resolved for GCC rather quickly...

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80223#c11

> At the same time; since there are no users (that I know of), I don't see
> the problem with killing the entire thing for x86 either.

If there really were no more GCOV users and KCOV would provide the same
functionality and level of tool support I would not object. But IMO none
of these requirements are met today.


Regards,
  Peter

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
