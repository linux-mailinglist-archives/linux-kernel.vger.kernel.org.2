Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F233807C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhENK4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:56:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229973AbhENK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:56:18 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EAWlrr095697
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 06:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=+RSdmym1kc5gt+TnCYRTbJB1jLoZmHK3rRgcrKx2/7g=;
 b=bnib+I4z3qbkjaV32ulYGLMCF4qKj5H6J/zeY9f3DfUxKJ88+OAvlY6R3ll5R64dYiPc
 PQHHspftOYUYvBXNlFi/c303g27s3PHQspx7ONat9Tb15YcWAFOT+oyFFdwFAyE+1gY0
 I7WZINEh1fFlenQhVqAk4xMSRML4SgsH6qFeEbbYBTZXbEUNEqGZa1leGsjP5EQ5gJuY
 rnUSOp+BrRFPvpPJGIfQpjQzGXwaefolB9aaywe+vwa2e6mKuw7naoDHuxHR52YJxZbN
 0YCpFlnTVxe4EuSAZ65SCWIRClFho2LPBKeH4rPN6q8jhD28di9gFGFGqkBHBM3eLN+s bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38hq0jh6ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 06:55:06 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14EAXHF1097282
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 06:55:06 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38hq0jh6a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 06:55:06 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14EAt4kt011276;
        Fri, 14 May 2021 10:55:04 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 38hc6pg81j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 10:55:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14EAsZgf13828542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 10:54:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27F9511C050;
        Fri, 14 May 2021 10:55:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03E8511C04A;
        Fri, 14 May 2021 10:55:02 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 May 2021 10:55:01 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] kfence: only handle kernel mode faults
References: <20210514092139.3225509-1-svens@linux.ibm.com>
        <20210514092139.3225509-3-svens@linux.ibm.com>
        <CANpmjNOLSuqeTr8YOnvz-V=eudBwraNvm+9V+YxEBUCm=EFwxw@mail.gmail.com>
Date:   Fri, 14 May 2021 12:55:01 +0200
In-Reply-To: <CANpmjNOLSuqeTr8YOnvz-V=eudBwraNvm+9V+YxEBUCm=EFwxw@mail.gmail.com>
        (Marco Elver's message of "Fri, 14 May 2021 12:52:38 +0200")
Message-ID: <yt9dk0o1inzu.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LWWZ9zHpMnXYcG1caCzx19ZK3q7g4A7L
X-Proofpoint-ORIG-GUID: YsZF-kRGQLoSqbutal39t4So0nl5zcJO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_04:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=839
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Fri, 14 May 2021 at 11:22, Sven Schnelle <svens@linux.ibm.com> wrote:
>>
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> ---
>>  mm/kfence/core.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>> index bc15e3cb71d5..161df492750c 100644
>> --- a/mm/kfence/core.c
>> +++ b/mm/kfence/core.c
>> @@ -813,6 +813,9 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
>>         enum kfence_error_type error_type;
>>         unsigned long flags;
>>
>> +       if (user_mode(regs))
>> +               return false;
>> +
>
> I don't think it's required on all architectures, correct? If so, I
> think this should be part of the arch-specific code, i.e. just do "if
> (user_mode(regs) && kfence_handle_page_fault(...))" or similar.
> Because otherwise we'll wonder in future why we ever needed this, and
> e.g. determine it's useless and remove it again. ;-) Either that, or a
> comment. But I'd prefer to just keep it in the arch-specific code if
> required, because it seems to be the exception rather than the norm.

Ok, that's fine, i add it to our code then.

Thanks
Sven
