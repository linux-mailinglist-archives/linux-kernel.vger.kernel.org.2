Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D9F3912AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhEZIrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:47:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232913AbhEZIr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:47:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14Q8WgEo070256;
        Wed, 26 May 2021 04:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HVeUcYXlful+b6a4wRWi1RS15JlEiihXe60vxwCunHA=;
 b=kWmqFGpZ1eKi5r7/TFsEts7AExVdFgNg9CX4ulkEhtjFGhx3L8QVk9+E/BSvt4zUvnsC
 mCDIuw7pG8yB/+R2pcaWxL40LO9BZdYesj9WoStABq+NGYceijyczM+5jiRmQGaKx3Nm
 TkYaEGtaNRWYqLKd9rhu+QmMCW+f5DDmO6TV7+O9/UzDw4DbC5nYH9qNNtuO9uwI6an0
 vzJFKRKx7Pg9002D7R7Op1bfZj3a1HpCjC6PfSy3lIJr2IOPX9va9LL7rnZMnk9swgeb
 1pXYWDBgDzAryYOwcZGLMARQs2lNnbNQHPBK2qSCoMpCDJlhn/EZeLUfTvL+A6au8ruq ag== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sjnj90ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 04:45:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14Q8jGZ6011101;
        Wed, 26 May 2021 08:45:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 38sba2r5ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 08:45:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14Q8jCir14746080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 08:45:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D345B52057;
        Wed, 26 May 2021 08:45:11 +0000 (GMT)
Received: from [9.85.86.138] (unknown [9.85.86.138])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E75CA52052;
        Wed, 26 May 2021 08:45:08 +0000 (GMT)
Subject: Re: [RFC v2 4/4] powerpc/papr_scm: Add cpu hotplug support for nvdimm
 pmu device
To:     kajoljain <kjain@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        maddy@linux.vnet.ibm.com, santosh@fossix.org,
        vaibhav@linux.ibm.com, dan.j.williams@intel.com,
        ira.weiny@intel.com, atrajeev@linux.vnet.ibm.com,
        tglx@linutronix.de, rnsastry@linux.ibm.com
References: <20210525132216.1239259-1-kjain@linux.ibm.com>
 <20210525132216.1239259-5-kjain@linux.ibm.com>
 <YK0G1nmvhOPimRay@hirez.programming.kicks-ass.net>
 <b89d1954-638b-34c0-2d79-5d1ce4e72a3a@linux.ibm.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <569ee30d-29c0-37c4-6f3e-9dd1345f837e@linux.ibm.com>
Date:   Wed, 26 May 2021 14:15:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b89d1954-638b-34c0-2d79-5d1ce4e72a3a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PZ3iGSmsrXTcwPv1frRIUKlpIS2kuaac
X-Proofpoint-ORIG-GUID: PZ3iGSmsrXTcwPv1frRIUKlpIS2kuaac
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_06:2021-05-25,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=865 priorityscore=1501 clxscore=1011 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 12:56 PM, kajoljain wrote:
> 
> 
> On 5/25/21 7:46 PM, Peter Zijlstra wrote:
>> On Tue, May 25, 2021 at 06:52:16PM +0530, Kajol Jain wrote:
>>> Patch here adds cpu hotplug functions to nvdimm pmu.
>>
>> I'm thinking "Patch here" qualifies for "This patch", see
>> Documentation/process/submitting-patches.rst .
>>
> Hi Peter,
>     I will reword this commit message.
> 
>>> It adds cpumask to designate a cpu to make HCALL to
>>> collect the counter data for the nvdimm device and
>>> update ABI documentation accordingly.
>>>
>>> Result in power9 lpar system:
>>> command:# cat /sys/devices/nmem0/cpumask
>>> 0
>>
>> Is this specific to the papr thing, or should this be in generic nvdimm
>> code?
> 
> This code is not specific to papr device and we can move it to
> generic nvdimm interface. But do we need to add some checks on whether
> any arch/platform specific driver want that support or we can assume
> that this will be something needed by all platforms?
> 

It says the cpu that should be used to make the hcall. That makes it 
PAPR specific.

-aneesh

