Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4AB438DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhJYDZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:25:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232008AbhJYDZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:25:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19ONmxBf022124;
        Sun, 24 Oct 2021 23:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=xdTKzE5hKjGfbm7Yv4KPBnSFUd4ZwCzWWIp2z0Y9Ai0=;
 b=Gc+SGal3hLb8w74OGeWJLN3sHkAxd7pJGKYtOPask+9gz98lEtedWHgFiWQaWG4w445p
 I/UkMTrMRqxACMGR7EShizDvXbdG9yoZqKEFMwadFCDVK1EldkEGUa0J0+rczAvmHGif
 gmc/lEypRR+/pa67cdPEA3SwRrcJihqjnRi1wwV6fHl3ORJiY7SZypDlJN203KOpRHrY
 zv9nkOBGohDLPl89omcllAFejPATEtCkCKTRLapHrRPWwYEwyMXrhdEsoLliY2giB8Rq
 axaVEni2By9LmG8bnmtJsWTs6SfzD5t1+T7DayFu7YZCTfsNJP/12BvTuwibJDzqtuUD aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bvygr7fck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Oct 2021 23:23:26 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19P3NQsH010135;
        Sun, 24 Oct 2021 23:23:26 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bvygr7fc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Oct 2021 23:23:25 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19P3Cev5028523;
        Mon, 25 Oct 2021 03:23:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3bv9nj99f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 03:23:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19P3HGSs64356620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Oct 2021 03:17:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1A6CAE057;
        Mon, 25 Oct 2021 03:23:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26467AE051;
        Mon, 25 Oct 2021 03:23:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Oct 2021 03:23:20 +0000 (GMT)
Received: from localhost (unknown [9.81.195.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 97D6B6023F;
        Mon, 25 Oct 2021 14:23:18 +1100 (AEDT)
From:   Michael Ellerman <michaele@au1.ibm.com>
To:     "Paul A. Clarke" <pc@us.ibm.com>, Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] perf vendor events power10: Add metric events json
 file for power10 platform
In-Reply-To: <20211022144910.GC104437@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20211022062505.78767-1-kjain@linux.ibm.com>
 <20211022144910.GC104437@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Date:   Mon, 25 Oct 2021 14:23:15 +1100
Message-ID: <87wnm1bxek.fsf@mpe.ellerman.id.au>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GqZ0IucobX69kzSVHu3sPHv8EXvSrr8l
X-Proofpoint-ORIG-GUID: GaA7mFTouG50tus64Xo2tqDsc52UM6ad
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_01,2021-10-25_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul A. Clarke" <pc@us.ibm.com> writes:
> Thanks for the changes!
> More nits below (many left over from prior review)...
>
> On Fri, Oct 22, 2021 at 11:55:05AM +0530, Kajol Jain wrote:
>> Add pmu metric json file for power10 platform.
>> 
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>> Changelog v1 -> v2:
>> - Did some nit changes in BriefDescription field
>>   as suggested by Paul A. Clarke
>> 
>> - Link to the v1 patch: https://lkml.org/lkml/2021/10/6/131
>> 
>>  .../arch/powerpc/power10/metrics.json         | 676 ++++++++++++++++++
>>  1 file changed, 676 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/metrics.json
>> 
>> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/metrics.json b/tools/perf/pmu-events/arch/powerpc/power10/metrics.json
>> new file mode 100644
>> index 000000000000..8adab5cd9934
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/powerpc/power10/metrics.json
>> @@ -0,0 +1,676 @@
>> +[
>> +    {
>> +        "BriefDescription": "Percentage of cycles that are run cycles",
>> +        "MetricExpr": "PM_RUN_CYC / PM_CYC * 100",
>> +        "MetricGroup": "General",
>> +        "MetricName": "RUN_CYCLES_RATE",
>> +        "ScaleUnit": "1%"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per completed instruction",
>> +        "MetricExpr": "PM_CYC / PM_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "CYCLES_PER_INSTRUCTION"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled for any reason",
>> +        "MetricExpr": "PM_DISP_STALL_CYC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled because there was a flush",
>> +        "MetricExpr": "PM_DISP_STALL_FLUSH / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_FLUSH_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled because the MMU was handling a translation miss",
>> +        "MetricExpr": "PM_DISP_STALL_TRANSLATION / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_TRANSLATION_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled waiting to resolve an instruction ERAT miss",
>> +        "MetricExpr": "PM_DISP_STALL_IERAT_ONLY_MISS / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_IERAT_ONLY_MISS_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled waiting to resolve an instruction TLB miss",
>> +        "MetricExpr": "PM_DISP_STALL_ITLB_MISS / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_ITLB_MISS_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled due to an icache miss",
>> +        "MetricExpr": "PM_DISP_STALL_IC_MISS / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_IC_MISS_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled while the instruction was fetched from the local L2",
>> +        "MetricExpr": "PM_DISP_STALL_IC_L2 / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_IC_L2_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled while the instruction was fetched from the local L3",
>> +        "MetricExpr": "PM_DISP_STALL_IC_L3 / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_IC_L3_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled while the instruction was fetched from any source beyond the local L3",
>> +        "MetricExpr": "PM_DISP_STALL_IC_L3MISS / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_IC_L3MISS_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled due to an icache miss after a branch mispredict",
>> +        "MetricExpr": "PM_DISP_STALL_BR_MPRED_ICMISS / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_BR_MPRED_ICMISS_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled while instruction was fetched from the local L2 after suffering a branch mispredict",
>> +        "MetricExpr": "PM_DISP_STALL_BR_MPRED_IC_L2 / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_BR_MPRED_IC_L2_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled while instruction was fetched from the local L3 after suffering a branch mispredict",
>> +        "MetricExpr": "PM_DISP_STALL_BR_MPRED_IC_L3 / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_BR_MPRED_IC_L3_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled while instruction was fetched from any source beyond the local L3 after suffering a branch mispredict",
>> +        "MetricExpr": "PM_DISP_STALL_BR_MPRED_IC_L3MISS / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_BR_MPRED_IC_L3MISS_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled due to a branch mispredict",
>> +        "MetricExpr": "PM_DISP_STALL_BR_MPRED / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_BR_MPRED_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction was held at dispatch for any reason",
>> +        "MetricExpr": "PM_DISP_STALL_HELD_CYC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_HELD_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction was held at dispatch because of a synchronizing instruction that requires the ICT to be empty before dispatch",
>> +        "MetricExpr": "PM_DISP_STALL_HELD_SYNC_CYC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISP_HELD_STALL_SYNC_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction was held at dispatch while waiting on the scoreboard",
>> +        "MetricExpr": "PM_DISP_STALL_HELD_SCOREBOARD_CYC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISP_HELD_STALL_SCOREBOARD_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction was held at dispatch due to issue queue full",
>> +        "MetricExpr": "PM_DISP_STALL_HELD_ISSQ_FULL_CYC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISP_HELD_STALL_ISSQ_FULL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction was held at dispatch because the mapper/SRB was full",
>> +        "MetricExpr": "PM_DISP_STALL_HELD_RENAME_CYC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_HELD_RENAME_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction was held at dispatch because the STF mapper/SRB was full",
>> +        "MetricExpr": "PM_DISP_STALL_HELD_STF_MAPPER_CYC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_HELD_STF_MAPPER_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction was held at dispatch because the XVFC mapper/SRB was full",
>> +        "MetricExpr": "PM_DISP_STALL_HELD_XVFC_MAPPER_CYC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_HELD_XVFC_MAPPER_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction was held at dispatch for any other reason",
>> +        "MetricExpr": "PM_DISP_STALL_HELD_OTHER_CYC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_HELD_OTHER_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction has been dispatched but not issued for any reason",
>> +        "MetricExpr": "PM_ISSUE_STALL / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "ISSUE_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is waiting to be finished in one of the execution units",
>> +        "MetricExpr": "PM_EXEC_STALL / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "EXECUTION_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction spent executing an NTC instruction that gets flushed some time after dispatch",
>> +        "MetricExpr": "PM_EXEC_STALL_NTC_FLUSH / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "NTC_FLUSH_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTF instruction finishes at dispatch",
>> +        "MetricExpr": "PM_EXEC_STALL_FIN_AT_DISP / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "FIN_AT_DISP_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is executing in the branch unit",
>> +        "MetricExpr": "PM_EXEC_STALL_BRU / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "BRU_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is a simple fixed point instruction that is executing in the LSU",
>> +        "MetricExpr": "PM_EXEC_STALL_SIMPLE_FX / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "SIMPLE_FX_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is executing in the VSU",
>> +        "MetricExpr": "PM_EXEC_STALL_VSU / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "VSU_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is waiting to be finished in one of the execution units",
>> +        "MetricExpr": "PM_EXEC_STALL_TRANSLATION / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "TRANSLATION_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is a load or store that suffered a translation miss",
>> +        "MetricExpr": "PM_EXEC_STALL_DERAT_ONLY_MISS / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DERAT_ONLY_MISS_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is recovering from a TLB miss",
>> +        "MetricExpr": "PM_EXEC_STALL_DERAT_DTLB_MISS / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DERAT_DTLB_MISS_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is executing in the LSU",
>> +        "MetricExpr": "PM_EXEC_STALL_LSU / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "LSU_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is a load that is executing in the LSU",
>> +        "MetricExpr": "PM_EXEC_STALL_LOAD / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "LOAD_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is waiting for a load miss to resolve from either the local L2 or local L3",
>> +        "MetricExpr": "PM_EXEC_STALL_DMISS_L2L3 / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DMISS_L2L3_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is waiting for a load miss to resolve from either the local L2 or local L3, with an RC dispatch conflict",
>> +        "MetricExpr": "PM_EXEC_STALL_DMISS_L2L3_CONFLICT / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DMISS_L2L3_CONFLICT_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is waiting for a load miss to resolve from either the local L2 or local L3, without an RC dispatch conflict",
>> +        "MetricExpr": "PM_EXEC_STALL_DMISS_L2L3_NOCONFLICT / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DMISS_L2L3_NOCONFLICT_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is waiting for a load miss to resolve from a source beyond the local L2 and local L3",
>> +        "MetricExpr": "PM_EXEC_STALL_DMISS_L3MISS / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DMISS_L3MISS_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is waiting for a load miss to resolve from a neighbor chiplet's L2 or L3 in the same chip",
>> +        "MetricExpr": "PM_EXEC_STALL_DMISS_L21_L31 / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DMISS_L21_L31_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is waiting for a load miss to resolve from L4, local memory or OpenCapp chip",
>
> What is "OpenCapp"?  Is is different from OpenCAPI?
>
>> +        "MetricExpr": "PM_EXEC_STALL_DMISS_LMEM / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DMISS_LMEM_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is waiting for a load miss to resolve from a remote chip (cache, L4, memory or OpenCapp) in the same group",
>> +        "MetricExpr": "PM_EXEC_STALL_DMISS_OFF_CHIP / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DMISS_OFF_CHIP_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is waiting for a load miss to resolve from a distant chip (cache, L4, memory or OpenCapp chip)",
>> +        "MetricExpr": "PM_EXEC_STALL_DMISS_OFF_NODE / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DMISS_OFF_NODE_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is executing a TLBIEL instruction",
>> +        "MetricExpr": "PM_EXEC_STALL_TLBIEL / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "TLBIEL_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is finishing a load after its data has been reloaded from a data source beyond the local L1, OR when the LSU is processing an L1-hit, OR when the NTF instruction merged with another load in the LMQ",
>> +        "MetricExpr": "PM_EXEC_STALL_LOAD_FINISH / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "LOAD_FINISH_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is a store that is executing in the LSU",
>> +        "MetricExpr": "PM_EXEC_STALL_STORE / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "STORE_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is in the store unit outside of handling store misses or other special store operations",
>
> Is "store unit" not the same as "LSU" ?  Use "LSU" uniformly if appropriate:
> s/store unit/LSU/
>
>> +        "MetricExpr": "PM_EXEC_STALL_STORE_PIPE / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "STORE_PIPE_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is a store whose cache line was not resident in the L1 and had to wait for allocation of the missing line into the L1",
>> +        "MetricExpr": "PM_EXEC_STALL_STORE_MISS / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "STORE_MISS_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is a TLBIE instruction waiting for a response from the L2",
>> +        "MetricExpr": "PM_EXEC_STALL_TLBIE / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "TLBIE_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is executing a PTESYNC instruction",
>> +        "MetricExpr": "PM_EXEC_STALL_PTESYNC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "PTESYNC_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction cannot complete because the thread was blocked",
>> +        "MetricExpr": "PM_CMPL_STALL / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "COMPLETION_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction cannot complete because it was interrupted by ANY exception",
>> +        "MetricExpr": "PM_CMPL_STALL_EXCEPTION / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "EXCEPTION_COMPLETION_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is stuck at finish waiting for the non-speculative finish of either a STCX instruction waiting for its result or a load waiting for non-critical sectors of data and ECC",
>> +        "MetricExpr": "PM_CMPL_STALL_MEM_ECC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "MEM_ECC_COMPLETION_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction cannot complete the instruction is a STCX instruction waiting for resolution from the nest",
>
> Need to reword this, I think.  I propose "Average cycles per instruction
> when the NTC instruction is a STCX instruction waiting for resolution
> from the nest", which follows the form used by HWSYNC_COMPLETION_STALL_CPI,
> below.
>
>> +        "MetricExpr": "PM_CMPL_STALL_STCX / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "STCX_COMPLETION_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is a LWSYNC instruction waiting to complete",
>> +        "MetricExpr": "PM_CMPL_STALL_LWSYNC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "LWSYNC_COMPLETION_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction is a HWSYNC instruction stuck at finish waiting for a response from the L2",
>> +        "MetricExpr": "PM_CMPL_STALL_HWSYNC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "HWSYNC_COMPLETION_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction required special handling before completion",
>> +        "MetricExpr": "PM_CMPL_STALL_SPECIAL / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "SPECIAL_COMPLETION_STALL_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when dispatch was stalled because fetch was being held, so there was nothing in the pipeline for this thread",
>> +        "MetricExpr": "PM_DISP_STALL_FETCH / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_FETCH_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Average cycles per instruction when the NTC instruction was held at dispatch because of power management",
>> +        "MetricExpr": "PM_DISP_STALL_HELD_HALT_CYC / PM_RUN_INST_CMPL",
>> +        "MetricGroup": "CPI",
>> +        "MetricName": "DISPATCHED_HELD_HALT_CPI"
>> +    },
>> +    {
>> +        "BriefDescription": "Percentage of flushes per completed run instruction",
>
> s/per completed run instruction/per instruction/

I'm not sure we want to drop "completed" from this and all the following
descriptions.

There is a meaningful distinction between completed and dispatched
instructions, I think it's useful to be explicit about which the event
is counting.

I agree dropping "run" is a good idea, most people won't understand that
"run" means "non-idle", and I think don't expect idle instructions to be
counted anyway.

...
>
>> +        "MetricExpr": "PM_RUN_INST_CMPL / PM_RUN_CYC",
>> +        "MetricGroup": "General",
>> +        "MetricName": "RUN_IPC"
>> +    },
>> +    {
>> +        "BriefDescription": "Average number of instructions completed per instruction group",
>
> s/completed//

And here the meaning is different if you drop "completed".

cheers
