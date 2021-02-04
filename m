Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B600530F136
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhBDKvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:51:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235450AbhBDKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:51:15 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 114AgTUw002255;
        Thu, 4 Feb 2021 05:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3upmjPHk1Jp16W7e/Lhw3FXopwlhH4hy8FhsNbN6oAg=;
 b=hZlh/8TDj0JVnfLPup2pGaoB3Y43sa8iYvkxigRERaPcjqcYx7lPR22Oj9Q232+/4Ypn
 hdK46puSp5FRWP8PZBdwNOJcXhjbGx5HHbBNPzkkCf1wkhgY8kcJ8zxgkxPAUXnRt9rS
 2DwV3/u9r7p81Y+YJdbung0nvu1Xi+RsLXjnAhKEdCz0aWyrAEMaOS/Fu0CIfpaIRCHq
 50AcbUyDKVUlZxR48FdRieVrv4b22TuVnv29xcnHNg4HeL0niepCcvwy1oJOq39Uas8l
 6upjrI2jLaFKCRiSyAA1BV6J9TXZ64GR6yFN7//iaQQg9s/RxmKTCGah3j33bsva9udq 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36gfdg06h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 05:49:48 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 114AgcSk002555;
        Thu, 4 Feb 2021 05:49:48 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36gfdg06gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 05:49:47 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 114AmRjV022467;
        Thu, 4 Feb 2021 10:49:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 36fwcw0ts0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 10:49:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 114AnYRH37814674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 10:49:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 067F2AE053;
        Thu,  4 Feb 2021 10:49:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECE67AE04D;
        Thu,  4 Feb 2021 10:49:40 +0000 (GMT)
Received: from [9.199.39.112] (unknown [9.199.39.112])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Feb 2021 10:49:40 +0000 (GMT)
Subject: Re: [PATCH v2] powerpc/uprobes: Validation for prefixed instruction
To:     mpe@ellerman.id.au
Cc:     oleg@redhat.com, rostedt@goodmis.org, paulus@samba.org,
        jniethe5@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20210204104703.273429-1-ravi.bangoria@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <79b0bed7-8b98-d58d-dc47-644195bbc095@linux.ibm.com>
Date:   Thu, 4 Feb 2021 16:19:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204104703.273429-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_05:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/21 4:17 PM, Ravi Bangoria wrote:
> Don't allow Uprobe on 2nd word of a prefixed instruction. As per
> ISA 3.1, prefixed instruction should not cross 64-byte boundary.
> So don't allow Uprobe on such prefixed instruction as well.
> 
> There are two ways probed instruction is changed in mapped pages.
> First, when Uprobe is activated, it searches for all the relevant
> pages and replace instruction in them. In this case, if we notice
> that probe is on the 2nd word of prefixed instruction, error out
> directly. Second, when Uprobe is already active and user maps a
> relevant page via mmap(), instruction is replaced via mmap() code
> path. But because Uprobe is invalid, entire mmap() operation can
> not be stopped. In this case just print an error and continue.

@mpe,

arch_uprobe_analyze_insn() can return early if
cpu_has_feature(CPU_FTR_ARCH_31) is not set. But that will
miss out a rare scenario of user running binary with prefixed
instruction on p10 predecessors. Please let me know if I
should add cpu_has_feature(CPU_FTR_ARCH_31) or not.

- Ravi
