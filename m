Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993CA390FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 06:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhEZEzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 00:55:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49338 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230419AbhEZEzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 00:55:00 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14Q4WiCI042371;
        Wed, 26 May 2021 00:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7pP7CxtCt1O/THb/5YJznPuB0UF+WIAlLEPOj/s7eSw=;
 b=eFGaQfD78Z5eypmVTAEZh33A3wPaj4qdIJjAlyslxpG9m1VoZQp37oOJ0KVDO5FaCHxh
 WhaeD+Ytgov3rNfJGs7UCFKANKtdzQALtqONTiUdY/KVtdecVlBrxhAIlBUyt8G4IdBG
 6AsQbH/skj0CrbIkIy7sye57HA6bU1KSV4sSm4vJd7MHzo1vHxLpOHb7n1mwY4vCcRaD
 Di/W5xshFKVSK4Kk+cZ++M/iNUjgmNmGtaox4tettZ/pQkU4b8reZYYue2bCZiYye1/C
 Cqam14XF8BX7goPqwdBKnKtrZ0+KzIhmLb18sNMYDBve9NnASGR8dv5J4G4vU0Xse1Tf 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sb5jdd23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 00:53:25 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14Q4XnK1044985;
        Wed, 26 May 2021 00:53:25 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sb5jdd1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 00:53:25 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14Q4rN2N014268;
        Wed, 26 May 2021 04:53:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 38s1r505ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 04:53:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14Q4rKO527263310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 04:53:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78BFEAE055;
        Wed, 26 May 2021 04:53:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F40D9AE045;
        Wed, 26 May 2021 04:53:18 +0000 (GMT)
Received: from [9.199.44.68] (unknown [9.199.44.68])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 May 2021 04:53:18 +0000 (GMT)
Subject: Re: [PATCH] perf probe: Provide more detail with relocation warning
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20210525043744.193297-1-ravi.bangoria@linux.ibm.com>
 <20210525214858.33a66846ac09e499c3268a63@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <05e32c82-1009-03ba-d973-8b1bc0582ce2@linux.ibm.com>
Date:   Wed, 26 May 2021 10:23:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210525214858.33a66846ac09e499c3268a63@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jcXjU2DxqWhtS7Vscir9hqHWI6cJ_UIJ
X-Proofpoint-ORIG-GUID: Byv_vLfWZbCDsBDvdzgYHT-O_FRWBwBV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_02:2021-05-25,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/21 6:18 PM, Masami Hiramatsu wrote:
> On Tue, 25 May 2021 10:07:44 +0530
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
> 
>> When run as normal user with default sysctl kernel.kptr_restrict=0
>> and kernel.perf_event_paranoid=2, perf probe fails with:
>>
>>    $ ./perf probe move_page_tables
>>    Relocated base symbol is not found!
>>
>> The warning message is not much informative. The reason perf fails
>> is because /proc/kallsyms is restricted by perf_event_paranoid=2
>> for normal user and thus perf fails to read relocated address of
>> the base symbol.
>>
>> Tweaking kptr_restrict and perf_event_paranoid can change the
>> behavior of perf probe. Also, running as root or privileged user
>> works too. Add these details in the warning message.
>>
>> Plus, kmap->ref_reloc_sym might not be always set even if
>> host_machine is initialized. Above is the example of the same.
>> Remove that comment.
> 
> Yes, those are restricted in some cases. Anyway without priviledged
> (super) user, perf probe can not set the probe in ftrace.
> 
> Hmm, I think it should check the effective user-id at first. If it
> is not super user and the action will access tracefs and kallsyms,
> it should warn at that point.

If kptr_restrict=2, perf probe fails with same error even for root user.
That's why I thought to just change this warning message.

Different combinations of privilege, perf_event_paranoid, kptr_restrict:

   Normal/Root user
    |   perf_event_paranoid
    V    V   kptr_restrict        perf probe error
   ----------------------------------------------------------------
    N   -1    0     Failed to open kprobe_events: Permission denied
    N    0    0     Failed to open kprobe_events: Permission denied
    N    1    0     Failed to open kprobe_events: Permission denied
    N    2    0     Relocated base symbol is not found!
   
    N   -1    1     Relocated base symbol is not found!
    N    0    1     Relocated base symbol is not found!
    N    1    1     Relocated base symbol is not found!
    N    2    1     Relocated base symbol is not found!
   
    N   -1    2     Relocated base symbol is not found!
    N    0    2     Relocated base symbol is not found!
    N    1    2     Relocated base symbol is not found!
    N    2    2     Relocated base symbol is not found!
   
    R   -1    0     No error.
    R    0    0     No error.
    R    1    0     No error.
    R    2    0     No error.
   
    R   -1    1     No error.
    R    0    1     No error.
    R    1    1     No error.
    R    2    1     No error.
   
    R   -1    2     Relocated base symbol is not found!
    R    0    2     Relocated base symbol is not found!
    R    1    2     Relocated base symbol is not found!
    R    2    2     Relocated base symbol is not found!

Ravi
