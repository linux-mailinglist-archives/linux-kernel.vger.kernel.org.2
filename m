Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AA94136C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhIUP7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:59:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234155AbhIUP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:59:05 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LFAbpb001486;
        Tue, 21 Sep 2021 11:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7Lpkn/u5xGsMYp+J1oFAP+wMpssgRZ41XS56R0aByXE=;
 b=LZcmfahfTR/T+uAWCPY/9PsGBwQ7Liy8c6LPDVrxK/e8lFFaAWKUUaxjTHzcwgpKR8w3
 3rOI82JBUgAuIjZYjMI319qvhauRspR1RZRe2JKIUve55MfmbaTsuIaaCImnciVtRKgP
 HtfHpG7bBynNk3RQSWXqpKLTA65qyDUrPCzkFaNSVQA4yogafjsuLZfgzpIzQXG9uq8W
 DPJDMd3vfGr2DGvd559cfdS7d78XwNQPFbEsBeDIoyoyFdvSlWoEfR+RbbJwrBBFoaeA
 YLxuHEh1DFxXj5u/gCh1FY85+aQCBAkRON8Uu6EMVQ5DL0cvNgohvBjZxP1VPrG6i3EA MQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b75vb2cw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 11:57:10 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18LFmFOH002133;
        Tue, 21 Sep 2021 15:57:10 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 3b57rb2j3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 15:57:09 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18LFv8uc50135306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 15:57:08 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A680C6A05A;
        Tue, 21 Sep 2021 15:57:08 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 492A26A04D;
        Tue, 21 Sep 2021 15:57:08 +0000 (GMT)
Received: from [9.211.74.125] (unknown [9.211.74.125])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 Sep 2021 15:57:08 +0000 (GMT)
Subject: Re: [PATCH 3/3] hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsi@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au, linux@roeck-us.net,
        jdelvare@suse.com, alistair@popple.id.au, jk@ozlabs.org
References: <20210914213543.73351-1-eajames@linux.ibm.com>
 <20210914213543.73351-4-eajames@linux.ibm.com> <YUn8JcqBQVy2Nwd3@kroah.com>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <990b5434-ed3e-7fe0-488f-f3ad55d48cee@linux.ibm.com>
Date:   Tue, 21 Sep 2021 10:57:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUn8JcqBQVy2Nwd3@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vRqr_UXAwPZYQQaa9zdf0EpRlzWS1MNe
X-Proofpoint-ORIG-GUID: vRqr_UXAwPZYQQaa9zdf0EpRlzWS1MNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_04,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=705 spamscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/21/21 10:37 AM, Greg KH wrote:
> On Tue, Sep 14, 2021 at 04:35:43PM -0500, Eddie James wrote:
>> Save any FFDC provided by the OCC driver, and provide it to userspace
>> through a binary sysfs entry. Do some basic state management to
>> ensure that userspace can always collect the data if there was an
>> error. Notify polling userspace when there is an error too.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/hwmon/occ/p9_sbe.c | 98 +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 97 insertions(+), 1 deletion(-)
> You forgot a Documentation/ABI/ entry :(
>
> Binary sysfs files are for "pass through to the hardware" only, you
> should not be dumping kernel data to userspace through them.  I can't
> really determine if this is the case here or not, as there's no
> documentation saying what you are trying to represent here...


Ok oops. I will add an entry, thanks.

I believe this qualifies for binary sysfs then, since the data is an 
error response from the hardware directly.


Thanks,

Eddie


>
> thanks,
>
> greg k-h
