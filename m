Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA1C391164
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhEZH2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:28:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232978AbhEZH2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:28:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14Q730H0132087;
        Wed, 26 May 2021 03:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=c9STaME5/gu1wo8vKEuUVygP/no3fdE29B/HI/RcCXU=;
 b=MQXZo2y8bfXZKnK+TjWFy0N5qv70M6TLxguPh1at21A1LF2LKrw4G3k93myERTvngWIa
 32h/niQ/7HOHbcIxYFPg705be1HfAkK74yp0sqzJdjsAufYro1W/D8hNJU/G/ou+q8WM
 F7S8gOVajkeon4XkqiKw9EQCGG71tNB/PcS7KDMWP2HpajKi9vzgwXe+xvFHnkxSN/WC
 t1YpxVP4AZaZoEmQ/vmaJp6AGXiGPSQSfcym2MGatq1AArfxi4jw6CK9J6CYM1jIc/hi
 /bFhJtdzfuCMlRNYwzKLnwtntH+BPKS+gHfXw9Cv9HDkiusVDFERW/zC6jvKZZv59iR4 Tg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38shad9428-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 03:27:08 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14Q7Bsvh010303;
        Wed, 26 May 2021 07:27:07 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 38s1q6pcsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 07:27:07 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14Q7R5Hn32375074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 07:27:05 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A14E46A098;
        Wed, 26 May 2021 07:27:05 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B4AC6A04D;
        Wed, 26 May 2021 07:27:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.104])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 26 May 2021 07:26:59 +0000 (GMT)
Subject: Re: [RFC v2 4/4] powerpc/papr_scm: Add cpu hotplug support for nvdimm
 pmu device
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        maddy@linux.vnet.ibm.com, santosh@fossix.org,
        aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        atrajeev@linux.vnet.ibm.com, tglx@linutronix.de,
        rnsastry@linux.ibm.com
References: <20210525132216.1239259-1-kjain@linux.ibm.com>
 <20210525132216.1239259-5-kjain@linux.ibm.com>
 <YK0G1nmvhOPimRay@hirez.programming.kicks-ass.net>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <b89d1954-638b-34c0-2d79-5d1ce4e72a3a@linux.ibm.com>
Date:   Wed, 26 May 2021 12:56:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YK0G1nmvhOPimRay@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -M87MocfDUmtPMjzmwQ6zYbl3o-iTrLc
X-Proofpoint-GUID: -M87MocfDUmtPMjzmwQ6zYbl3o-iTrLc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_04:2021-05-25,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=946
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/21 7:46 PM, Peter Zijlstra wrote:
> On Tue, May 25, 2021 at 06:52:16PM +0530, Kajol Jain wrote:
>> Patch here adds cpu hotplug functions to nvdimm pmu.
> 
> I'm thinking "Patch here" qualifies for "This patch", see
> Documentation/process/submitting-patches.rst .
> 
Hi Peter,
   I will reword this commit message.

>> It adds cpumask to designate a cpu to make HCALL to
>> collect the counter data for the nvdimm device and
>> update ABI documentation accordingly.
>>
>> Result in power9 lpar system:
>> command:# cat /sys/devices/nmem0/cpumask
>> 0
> 
> Is this specific to the papr thing, or should this be in generic nvdimm
> code?

This code is not specific to papr device and we can move it to
generic nvdimm interface. But do we need to add some checks on whether
any arch/platform specific driver want that support or we can assume 
that this will be something needed by all platforms?

Thanks,
Kajol Jain
