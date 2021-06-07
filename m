Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4628039DED4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFGOeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:34:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230482AbhFGOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:34:13 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157EPl5n089930;
        Mon, 7 Jun 2021 10:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DWW2uC4s31sQDhzOPH6ZTcX6VdddzpmfIN+KxzFhM+k=;
 b=EQ7g9EP4dW9AcfN1at+jU4VsuIrwFGftnBOmOTO/4Ar27gpUdIZw6HJglwl9NkbpksE8
 NkucJNoKB8GVzHH8dgwpWEIcBEXMVkDpiBeIKA7UybqJIBMHUvMkLp7Gkgwzh5hpw0ev
 mx9hUCUBGOTQ1kuFdIjIPUtUCry2YZ68dSG7emSobfeNdcGB0g0MqRjBFV0pXbXwEUdo
 vRzKeG+W79vU+/5Biqu2gdN/r/u84mAyu3JnFz4Utf6kv3givyjlY+F63SwHhQkLS0PQ
 322mP6GhHRjlnF3B6WGyL03tGfpvq6ITvfam7lZFeRNZNcecuZQWW3teIouvWPPFVUS+ Ow== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 391n7a86v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 10:32:19 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 157ESSk6024625;
        Mon, 7 Jun 2021 14:32:17 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3900w88hf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 14:32:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 157EWFWn28442896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jun 2021 14:32:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ED325204F;
        Mon,  7 Jun 2021 14:32:15 +0000 (GMT)
Received: from [9.145.172.247] (unknown [9.145.172.247])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EF1685204E;
        Mon,  7 Jun 2021 14:32:14 +0000 (GMT)
Subject: Re: gcov: NULL pointer dereference with gcc 9.3.1
To:     Luis Henriques <lhenriques@suse.de>
Cc:     linux-kernel@vger.kernel.org
References: <YLZYwgs5hyzFZMlw@suse.de>
 <0a013450-75eb-de2c-f90a-3df193800cea@linux.ibm.com>
 <YLeUMit+CTfZl8pw@suse.de>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <e8207b09-265b-60a6-7fb0-51dda7cf59d6@linux.ibm.com>
Date:   Mon, 7 Jun 2021 16:32:14 +0200
MIME-Version: 1.0
In-Reply-To: <YLeUMit+CTfZl8pw@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ahaQOWbbNczhPr2goL5yuD_Q7tmNKXNr
X-Proofpoint-ORIG-GUID: ahaQOWbbNczhPr2goL5yuD_Q7tmNKXNr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_11:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.2021 16:22, Luis Henriques wrote:
> On Wed, Jun 02, 2021 at 02:35:31PM +0200, Peter Oberparleiter wrote:
>> On 01.06.2021 17:56, Luis Henriques wrote:
>>> Hi!
>>>
>>> Maybe this is a known (gcc?) issue, but I'm seeing a NULL pointer splat if
>>> I instrument my kernel (or a module, more specifically) using gcc 9.3.1.
>>>
>>> It looks like, during initialization in __gcov_init(), gcov_info struct is
>>> invalid: the filename seems to be correct but ->function is NULL and
>>> ->n_functions contains garbage.
>>
>> Thanks for reporting this issue. The symptoms you're seeing look similar
>> to those that occur when the struct gcov_info layout emitted by GCC does
>> not match the one used by the kernel. In particular a change in the
>> GCOV_COUNTER value can cause this behavior.
>>
>> I've checked upstream GCC 9.3.1 and it seems to match what is used by
>> the kernel for that GCC version. Could you provide the exact version of
>> the compiler you are using? Both 'gcc --version' output and the GCC
>> package version should help. Also what architecture are you seeing this on?
> 
> Here's the output of 'gcc --version':
> 
> gcc (SUSE Linux) 9.3.1 20200903 [revision 9790fa53b48f3a48e0f7a7ad65e2bbf3b206a7b0]
> Copyright (C) 2019 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> This is the version shipped with openSUSE Tumbleweed, and I'm using it to
> compile an x86_64 kernel.  Regarding the 'package version', I'm assuming
> the packages as per the distro package version, right?  Here's the data
> from 'zypper info':
> 
> Information for package gcc9:
> -----------------------------
> Repository     : Main Repository (OSS)
> Name           : gcc9
> Version        : 9.3.1+git1684-3.5
> Arch           : x86_64
> Vendor         : openSUSE
> Installed Size : 94.6 MiB
> Installed      : Yes (automatically)
> Status         : up-to-date
> Source package : gcc9-9.3.1+git1684-3.5.src

I've checked the source you referenced and found that it contains a
backport of a change to gcov_info that was only introduced with GCC 10
to upstream source: the value of GCOV_COUNTERS was reduced from 9 to 8.

Since I don't think it's feasible to implement support for such
vendor-specific changes in the upstream kernel source my suggestion for
you would be to either

a) fall back to a vanilla GCC version,
b) fall back to a known-to-work vendor-specific GCC version (GCC 10
   should be fine), or
c) to manually change the GCOV_COUNTERS value in
   linux/kernel/gcov/gcc_4_7.c to 8.

> Do you have a link with binaries I could test for upstream 9.3.1?  I
> checked [1] but there's only 9.3.0.

I'm not sure there is any. My analysis was based on source code for
9.3.0 alone.


Regards,
  Peter Oberparleiter

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
