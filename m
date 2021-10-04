Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3140442150B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhJDRTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:19:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233536AbhJDRTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:19:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194H9F86018107;
        Mon, 4 Oct 2021 13:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/LzhN2nc0xTevZq3pJNKQOS2fL9eKp7W5kcCVhO3PtQ=;
 b=KwqFRNvNdtWUGpisPTA1kiWL2o++QfFdYEyZT2dqwGvi7HOqT6M/1bxijD2eGo/b/2S0
 xIKYEMaL7LuOIYf7RrxmmG7+h9DxshokTYmqCWJNBI/yp3iHxgOIzIYvmyW+CSrCrsUM
 xKx63838L8V+dxhgsBucIXWI2uws9YkfrYKrwTE+nf13vZmmXmjBktUUzPwpFaDq1xWZ
 3ZqtY5jaTz8ZWEUi5/lzI48MFp8w92EWHB+sc2EJGpeimd9bgoSZOHr0A8Op05eqFsW/
 2MKYNec0eJzceGBcq+CAAuexqZBpOaYUJK57wGalDwAofb4cn6rfxl5btzV4fbzGqzu7 Mw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bg5rm046m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 13:17:40 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194HC2GF031066;
        Mon, 4 Oct 2021 17:17:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3bef29gg5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 17:17:38 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194HHYuZ15466942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 17:17:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74DD611C05B;
        Mon,  4 Oct 2021 17:17:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9E5111C04A;
        Mon,  4 Oct 2021 17:17:27 +0000 (GMT)
Received: from [9.43.74.5] (unknown [9.43.74.5])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Oct 2021 17:17:27 +0000 (GMT)
Message-ID: <496a0ddb-ec5d-e043-7045-779316cf9c56@linux.ibm.com>
Date:   Mon, 4 Oct 2021 22:47:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 3/3] powerpc: Set crashkernel offset to mid of RMA region
Content-Language: en-US
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, mpe@ellerman.id.au
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        Abdul haleem <abdhalee@linux.vnet.ibm.com>
References: <20211004151142.256251-1-sourabhjain@linux.ibm.com>
 <20211004151142.256251-4-sourabhjain@linux.ibm.com>
 <f13e218e-4e38-4076-672f-d555d7abfc02@linux.ibm.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <f13e218e-4e38-4076-672f-d555d7abfc02@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1kMUUUP74enlfqKdjWM-HOqkw46Cx7Fo
X-Proofpoint-GUID: 1kMUUUP74enlfqKdjWM-HOqkw46Cx7Fo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=902
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Aneesh,

@@ -1235,6 +1235,9 @@ int __init early_init_dt_scan_rtas(unsigned long 
node,
>>       entryp = of_get_flat_dt_prop(node, "linux,rtas-entry", NULL);
>>       sizep  = of_get_flat_dt_prop(node, "rtas-size", NULL);
>>   +    if (of_get_flat_dt_prop(node, "ibm,hypertas-functions", NULL))
>> +        powerpc_firmware_features |= FW_FEATURE_LPAR;
>> +
>
> The equivalent check that we currently do more than checking 
> ibm,hypertas-functions.
>
>     if (!strcmp(uname, "rtas") || !strcmp(uname, "rtas@0")) {
>         prop = of_get_flat_dt_prop(node, "ibm,hypertas-functions",
>                        &len);
>         if (prop) {
>             powerpc_firmware_features |= FW_FEATURE_LPAR;
>             fw_hypertas_feature_init(prop, len);
> }
>
If ibm,hypertas-functions prop has to be part of rtas or rtas@0 node to 
decide we are on LPAR then how about splitting the probe_fw_features 
functions into two functions, one to detect FW_FEATURE_LPAR and another 
function to do the rest?
>
> also do we expect other firmware features to be set along with 
> FW_FEATURE_LPAR?


No only FW_FEATURE_LPAR feature so that kernel can decide the 
crashkernel offset accordingly.


Thanks for the review.

- Sourabh Jain

