Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5E3A6930
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhFNOp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:45:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232798AbhFNOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:45:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EEXSLv138823;
        Mon, 14 Jun 2021 10:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BRzXoekHpQIcqP+Wrzi+wUkPG8kyErOkd763Vuqzaz0=;
 b=PcfyZvKe+ng+/7NDpCcvmCgWnf7ORidibLHSJtwISGfT1mQ5MU6BFh8YsoC7XelgXeys
 rDeI+qXzMP7yEDvKpim1VZYAQmO54IouOLgqiGI4uhc9x+sXjvs/OTxVTuGBvQeZVB7o
 j335KuITHo5VoHtdyX6NGF8FLVHrJl70+8F7PdE6aP7E2rrKD379y77Hk6Aax2QkEKIs
 H7w+qErukJODl0MBGKUUjF2ZNqb6AQBm5K+ek3cnwBbsRyQiNnnZZyUoFB5rrM2CjagF
 aPR8VgMTsNXm77LEPI6DKZLpgGUiSnfyjZAM/3rJemUnlgU2JY2grwUt2SR1bKE8YfjT rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39671amm2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 10:43:33 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15EEXrX8140475;
        Mon, 14 Jun 2021 10:43:32 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39671amm1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 10:43:32 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15EEgPMQ017918;
        Mon, 14 Jun 2021 14:43:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 394mj90hx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 14:43:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15EEhSWk30015854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 14:43:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F47342047;
        Mon, 14 Jun 2021 14:43:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28F344203F;
        Mon, 14 Jun 2021 14:43:28 +0000 (GMT)
Received: from [9.145.17.205] (unknown [9.145.17.205])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 14:43:28 +0000 (GMT)
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     johannes.berg@intel.com, ndesaulniers@google.com,
        nathan@kernel.org, keescook@chromium.org, elver@google.com,
        mark.rutland@arm.com
References: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <2f8a4e21-a09b-8c8d-54ce-45cf2f0e83ff@linux.ibm.com>
Date:   Mon, 14 Jun 2021 16:43:27 +0200
MIME-Version: 1.0
In-Reply-To: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1iuG3h-z5-DcvqwERyuxIFJW0BKgyJ86
X-Proofpoint-ORIG-GUID: gCNDwVqtasWfd6a6jUNOSYgUXL46o7NK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_09:2021-06-14,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.2021 12:17, Peter Zijlstra wrote:
> As recently discovered, there is no function attribute to disable the
> -fprofile-generate instrumentation. As such, GCOV is fundamentally
> incompatible with architectures that rely on 'noinstr' for correctness.

Does this problem affect all code or just those pieces that use
'noinstr'? Doing a quick grep over kernel source shows me ~40 source
files containing 'noinstr' vs. ~30000 that don't.

It seems to me like an extreme measure to disable gcov-based profiling
for all files on an architecture when only a small fraction of code
would actually be affected.

I'll gladly admit that I haven't followed the full discussion that lead
to your patch, so maybe some of the following suggestions may already
have been proposed.

What about marking source files that contain 'noinstr' using the

  GCOV_PROFILE_<filename.o> := n

directive that gcov-kernel profiling provides to exclude those files
from being compiled with the corresponding profiling flags? If that's
too much effort there's also a directive for excluding all files in a
directory.

If there was a way to automatically identify 'noinstr'-afflicted source
files (e.g. by grepping the pre-processed source files), one could also
automate this process by adjusting the kbuild-code that adds profiling
flags to automatically exclude such files.

> 
> Until such time as that compilers have added a function attribute to
> disable this instrumentation, mark GCOV as broken.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/Kconfig    | 2 +-
>  kernel/gcov/Kconfig | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 86dae426798b..c0f8c9d4c31a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -75,7 +75,7 @@ config X86
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FILTER_PGPROT
>  	select ARCH_HAS_FORTIFY_SOURCE
> -	select ARCH_HAS_GCOV_PROFILE_ALL
> +	select ARCH_HAS_GCOV_BROKEN

Assuming none of the above mentioned alternatives are viable, removing
ARCH_HAS_GCOV_PROFILE_ALL should be enough for your purpose. This way
you are already excluding all source files from automatic profiling on x86.

Users that are absolutely sure that their code can work with
gcov-profiling can manually edit their sub-Makefiles to list those files
that should be instrumented. In my opinion your introduction of
ARCH_HAS_GCOV_BROKEN unnecessarily takes away this capability.


Regards,
  Peter Oberparleiter

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
