Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7A332CDD8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhCDHlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:41:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233206AbhCDHla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:41:30 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1247XTkd113406;
        Thu, 4 Mar 2021 02:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SwuOj+rC37ccGbLdcFkKLEcFhFZuVDdxMOE912kdLIU=;
 b=DqbHc/W4+Kr1quO3Br0tPO0XUz/DupNhjzAuZIqR00gn++CxpKZa5j2iNS6JHYYq50V1
 4s0d+brrp6YWxeDDsfO4bJE8syb9f+r5YAbNfRBohfKqjfza/Kmvmr2nCH67qnOxvjY+
 SDIkvIRlM8rQ9YPxMlPZsKvfnU5Re5igm2ZAqvKHrSWVS19OmHo/qfePkfJfMgwxDHQL
 w1/tTjJcfuo8BxnPFl0/M2KWNqEFCO9p0Ixq9PSu8Yu/URJqe03gSx9N5aB1EtJMQZPa
 BQuSSiBciL3e+PbiA5pIONixplceJrCynFZJey8wCMpgrByJfaCZPOfSiVT0itEoMOfH Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372tp192jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 02:40:08 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1247XXO5113604;
        Thu, 4 Mar 2021 02:40:07 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372tp192gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 02:40:07 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1247bPFC009638;
        Thu, 4 Mar 2021 07:40:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 37150cs94j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 07:40:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1247dk6R33948072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 07:39:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B63D04C046;
        Thu,  4 Mar 2021 07:40:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D89864C040;
        Thu,  4 Mar 2021 07:39:57 +0000 (GMT)
Received: from [9.199.37.77] (unknown [9.199.37.77])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Mar 2021 07:39:57 +0000 (GMT)
Subject: Re: [PATCH v3] powerpc/uprobes: Validation for prefixed instruction
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     mpe@ellerman.id.au, oleg@redhat.com, rostedt@goodmis.org,
        paulus@samba.org, jniethe5@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20210304050529.59391-1-ravi.bangoria@linux.ibm.com>
 <20210303083836.GD1913@DESKTOP-TDPLP67.localdomain>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <b2b25299-ca5a-1d43-5532-5a489d4de789@linux.ibm.com>
Date:   Thu, 4 Mar 2021 13:09:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210303083836.GD1913@DESKTOP-TDPLP67.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_02:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040031
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> @@ -41,6 +41,14 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
>>   	if (addr & 0x03)
>>   		return -EINVAL;
>>   
>> +	if (!IS_ENABLED(CONFIG_PPC64) || !cpu_has_feature(CPU_FTR_ARCH_31))
>> +		return 0;
> 
> Sorry, I missed this last time, but I think we can drop the above
> checks. ppc_inst_prefixed() already factors in the dependency on
> CONFIG_PPC64,

Yeah, makes sense. I initially added CONFIG_PPC64 check because
I was using ppc_inst_prefix(x, y) macro which is not available
for !CONFIG_PPC64.

> and I don't think we need to confirm if we're running on a
> ISA V3.1 for the below check.

Prefixed instructions would be supported only when ARCH_31 is set.
(Ignoring insane scenario where user probes on prefixed instruction
on p10 predecessors). So I guess I still need ARCH_31 check?

Ravi
