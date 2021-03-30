Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52FC34E166
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhC3Gm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:42:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231258AbhC3GmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:42:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U6WcqV097630;
        Tue, 30 Mar 2021 02:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8n/OgzSq8yggUYBh5wJylzCoYdZATjKdar89QHn7dWk=;
 b=qGkzgfBgOgIRBQwDJWHQF2LnNhP/2pSERv0OnFqzk13kkLSD4jED9915KqY0MYwzMHVs
 620WiSGihFmytTfVaM6lY4HvIb+XY1m16f7gsJI526l8VMSMuOnKIXD72bG6SLPfFSkD
 V7a/ej8Zrl1lHAlRhO2RrUAVsyXr468rshSDS0jgtCs/GogByiRr0gfrhMkaDsjm4jDa
 yDLJZId/lHu/b/o84MO8aFvyaqtzGZ0krIkmsmiqDJSLy8UPSUvTKzr3kzuQcmJ9Zir/
 BNpvwyRdN4SMAxTglNQctT/CK3yLXwW+GjpLg5P06Lsl/VhZ8ugSS/WeKw80pHNt1L1k Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37jj60pysk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 02:41:46 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12U6XaAH106638;
        Tue, 30 Mar 2021 02:41:45 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37jj60pys9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 02:41:45 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12U6e4Fm006167;
        Tue, 30 Mar 2021 06:41:44 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 37jqmn3qka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 06:41:44 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12U6fiXk20513098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 06:41:44 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44AD428058;
        Tue, 30 Mar 2021 06:41:44 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2997F28059;
        Tue, 30 Mar 2021 06:41:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.9])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Mar 2021 06:41:38 +0000 (GMT)
Subject: Re: [PATCH v2 0/6] perf arm64 metricgroup support
To:     "Paul A. Clarke" <pc@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, irogers@google.com,
        linuxarm@huawei.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <20210325203944.GD8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <dc17013d-2dcb-8ddf-a15a-e98cad3e2ae3@huawei.com>
 <20210329210717.GF8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <247e9484-34c8-544a-e268-b025ecb317fe@linux.ibm.com>
Date:   Tue, 30 Mar 2021 12:11:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20210329210717.GF8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ljOeFSKg9zl9YdPGqHSm7Nzsj9bCyBcS
X-Proofpoint-ORIG-GUID: qcqhjw8kqx_USdH6Bi91kGtrkL6WozwJ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_01:2021-03-26,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103300043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/21 2:37 AM, Paul A. Clarke wrote:
> On Fri, Mar 26, 2021 at 10:57:40AM +0000, John Garry wrote:
>> On 25/03/2021 20:39, Paul A. Clarke wrote:
>>> On Thu, Mar 25, 2021 at 06:33:12PM +0800, John Garry wrote:
>>>> Metric reuse support is added for pmu-events parse metric testcase.
>>>> This had been broken on power9 recentlty:
>>>> https://lore.kernel.org/lkml/20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com/
>>>
>>> Much better.  Before:
>>> --
>>> $ perf test -v 10 2>&1 | grep -i error | wc -l
>>> 112
>>> --
>>> After:
>>> --
>>> $ perf test -v 10 2>&1 | grep -i error | wc -l
>>> 17
>>> --
>>>
>>> And these seem like different types of issues:
>>> --
>>> $ perf test -v 10 2>&1 | grep -i error
>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_powerbus0_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>> --
>>>
>>
>> This looks suspicious.
>>
>> Firstly, does /sys/bus/event_source/devices/nest_mcs01_imc (or others,
>> above) exist on your system? I guess not.
>>
>> Secondly, checking Documentation/powerpc/imc.rst, we have examples of:
>> nest_mcs01/PM_MCS01_64B_R...
>>
>> So is the PMU name correct in the metric file for nest_mcs01_imc? Looking at
>> the kernel driver file, arch/powerpc/perf/imc-pmu.c, it seems to be correct.
>> Not sure.
> 
> I ran with a newer kernel, and the above errors disappeared, replaced with
> about 10 of:
> --
> Error string 'Cannot find PMU `hv_24x7'. Missing kernel support?' help '(null)'
> --
> 
> ...but I was running without a hypervisor, so I tried the same kernel on a
> PowerVM-virtualized system and the "hv_24x7" messages went away, but the
> "nest" messages returned.  This may all be expected behavior... I confess
> I haven't followed these new perf capabilities closely.
> 

Hi Paul/John,
   This is something expected. For nest-imc we need bare-metal system and for
hv-24x7 we need VM environment. Since you are checking this test in VM machine,
there nest events are not supported and hence we are getting this error.

Thanks,
Kajol Jain

> It's extremely likely that none of these errors has anything to do with your
> changes. :-
> 
> PC
> 
