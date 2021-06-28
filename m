Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C0A3B5943
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhF1Gtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:49:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232251AbhF1Gtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:49:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S6XcXV142095;
        Mon, 28 Jun 2021 02:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fbzMSxAoDk8abX6CTk5eTkByd/mZ/OH52jI/lY9pR8U=;
 b=YOXpzxhFgkdEL17A9Yr6OMlMKlbXzp0bCswg5E74WtP3M83XZxgCLnvrPmMy+Y7gzlio
 LS2pEPB8zT4XcCAOUKCeiMtz+e9A/9FL/dkgBJjmijNxOLPOOqr2JySi2iykJQehaqnH
 0PDxGZYQ49UizLTF8OgSf4+6Bfv4Yz5kJmkimSYka+GrvCHcbZ/Qst6hHp4hoDJt7BHN
 972MwpNJuVKqOphvyzirdfJQwUm2kvfdudg5XsQXWc5x0VnkDJJIBqvi94V63M5tMs8+
 WtksUBBM87HqFpe4h1EZvFGTsp81bpj7loXAmFmj6s77vF7GiyAnwBegO9OWWGnz6PJp ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39f6sfbgwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 02:47:06 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15S6Xo6d142488;
        Mon, 28 Jun 2021 02:47:06 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39f6sfbgwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 02:47:05 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15S6cBqd026148;
        Mon, 28 Jun 2021 06:47:04 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 39duva2msp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 06:47:04 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15S6l3ql4326344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 06:47:04 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59CBE1120FE;
        Mon, 28 Jun 2021 06:47:02 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 014D36A66B;
        Mon, 28 Jun 2021 06:28:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.85.15])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 06:28:55 +0000 (GMT)
Subject: Re: [PATCH] perf vendor events power10: Adds 24x7 nest metric events
 for power10 platform
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     ravi.bangoria@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20210625115948.99579-1-kjain@linux.ibm.com>
 <20210625132151.GC142768@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <d2eaebb6-7cd6-d2e3-0bed-0c054e7d2207@linux.ibm.com>
Date:   Mon, 28 Jun 2021 11:58:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210625132151.GC142768@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UepIt-PruOstAyS9WrrNL5hFOpS08v3G
X-Proofpoint-GUID: ovEdCUOHX6ejR7GzESefNCSDRmSpvxjB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_03:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106280045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/21 6:51 PM, Paul A. Clarke wrote:
> On Fri, Jun 25, 2021 at 05:29:48PM +0530, Kajol Jain wrote:
>> Patch adds 24x7 nest metric events for POWER10.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>  .../arch/powerpc/power10/nest_metrics.json    | 491 ++++++++++++++++++
>>  1 file changed, 491 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/nest_metrics.json
>>
>> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power10/nest_metrics.json
>> new file mode 100644
>> index 000000000000..b79046cd8b09
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/powerpc/power10/nest_metrics.json
>> @@ -0,0 +1,491 @@
>> +[
>> +    {
>> +      "MetricName": "VEC_GROUP_PUMP_RETRY_RATIO_P01",
>> +      "BriefDescription": "VEC_GROUP_PUMP_RETRY_RATIO_P01",
> 
> Is it possible to get better descriptions than just a restatement of the
> name, or no description at all?
> 
> This comment obviously applies to almost all of the metrics herein.

Hi Paul,
   Thanks for reviewing the patch. Sure I will remove description part for now.


> 
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_VG_PUMP01\\,chip\\=?@ / hv_24x7@PM_PB_VG_PUMP01\\,chip\\=?@) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "VEC_GROUP_PUMP_RETRY_RATIO_P23",
>> +      "BriefDescription": "VEC_GROUP_PUMP_RETRY_RATIO_P23",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_VG_PUMP23\\,chip\\=?@ / hv_24x7@PM_PB_VG_PUMP23\\,chip\\=?@) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "LOCAL_NODE_PUMP_RETRY_RATIO_P01",
>> +      "BriefDescription": "LOCAL_NODE_PUMP_RETRY_RATIO_P01",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_LNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PB_LNS_PUMP01\\,chip\\=?@) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "LOCAL_NODE_PUMP_RETRY_RATIO_P23",
>> +      "BriefDescription": "LOCAL_NODE_PUMP_RETRY_RATIO_P23",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_LNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PB_LNS_PUMP23\\,chip\\=?@) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "GROUP_PUMP_RETRY_RATIO_P01",
>> +      "BriefDescription": "GROUP_PUMP_RETRY_RATIO_P01",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_GROUP_PUMP01\\,chip\\=?@ / hv_24x7@PM_PB_GROUP_PUMP01\\,chip\\=?@) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "GROUP_PUMP_RETRY_RATIO_P23",
>> +      "BriefDescription": "GROUP_PUMP_RETRY_RATIO_P23",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_GROUP_PUMP23\\,chip\\=?@ / hv_24x7@PM_PB_GROUP_PUMP23\\,chip\\=?@) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_GROUP_PUMPS_P01",
>> +      "BriefDescription": "TOTAL_GROUP_PUMPS_P01(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_GROUP_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_GROUP_PUMPS_P23",
>> +      "BriefDescription": "TOTAL_GROUP_PUMPS_P23(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_GROUP_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_GROUP_PUMPS_RETRIES_P01",
>> +      "BriefDescription": "TOTAL_GROUP_PUMPS_RETRIES_P01(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_GROUP_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_GROUP_PUMPS_RETRIES_P23",
>> +      "BriefDescription": "TOTAL_GROUP_PUMPS_RETRIES_P23(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_GROUP_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "REMOTE_NODE_PUMPS_RETRIES_RATIO_P01",
>> +      "BriefDescription": "REMOTE_NODE_PUMPS_RETRIES_RATIO_P01",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_RNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PB_RNS_PUMP01\\,chip\\=?@) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "REMOTE_NODE_PUMPS_RETRIES_RATIO_P23",
>> +      "BriefDescription": "REMOTE_NODE_PUMPS_RETRIES_RATIO_P23",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_RNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PB_RNS_PUMP23\\,chip\\=?@) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_VECTOR_GROUP_PUMPS_P01",
>> +      "BriefDescription": "TOTAL_VECTOR_GROUP_PUMPS_P01(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_VG_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_VECTOR_GROUP_PUMPS_P23",
>> +      "BriefDescription": "TOTAL_VECTOR_GROUP_PUMPS_P23(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_VG_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_LOCAL_NODE_PUMPS_P01",
>> +      "BriefDescription": "TOTAL_LOCAL_NODE_PUMPS_P01(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_LNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_LOCAL_NODE_PUMPS_P23",
>> +      "BriefDescription": "TOTAL_LOCAL_NODE_PUMPS_P23(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_LNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_VECTOR_GROUP_PUMPS_RETRIES_P01",
>> +      "BriefDescription": "TOTAL_VECTOR_GROUP_PUMPS_RETRIES_P01(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_VG_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_VECTOR_GROUP_PUMPS_RETRIES_P23",
>> +      "BriefDescription": "TOTAL_VECTOR_GROUP_PUMPS_RETRIES_P23(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_VG_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_LOCAL_NODE_PUMPS_RETRIES_P01",
>> +      "BriefDescription": "TOTAL_LOCAL_NODE_PUMPS_RETRIES_P01(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_LNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_LOCAL_NODE_PUMPS_RETRIES_P23",
>> +      "BriefDescription": "TOTAL_LOCAL_NODE_PUMPS_RETRIES_P23(PER-CYC)",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RTY_LNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_REMOTE_NODE_PUMPS_P01",
>> +      "BriefDescription": "TOTAL_REMOTE_NODE_PUMPS_P01",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_REMOTE_NODE_PUMPS_P23",
>> +      "BriefDescription": "TOTAL_REMOTE_NODE_PUMPS_P23",
>> +      "MetricExpr": "(hv_24x7@PM_PB_RNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_NEAR_NODE_PUMPS_P01",
>> +      "BriefDescription": "TOTAL_NEAR_NODE_PUMPS_P01",
>> +      "MetricExpr": "(hv_24x7@PM_PB_NNS_PUMP01\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_NEAR_NODE_PUMPS_P23",
>> +      "BriefDescription": "TOTAL_NEAR_NODE_PUMPS_P23",
>> +      "MetricExpr": "(hv_24x7@PM_PB_NNS_PUMP23\\,chip\\=?@ / hv_24x7@PM_PAU_CYC\\,chip\\=?@)",
>> +      "ScaleUnit": "4",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_INT_PB_BW",
>> +      "BriefDescription": "TOTAL_INT_PB_BW",
>> +      "MetricExpr": "(hv_24x7@PM_PB_INT_DATA_XFER\\,chip\\=?@)",
>> +      "ScaleUnit": "2.09MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK0_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "XLINK0_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK0_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK0_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK1_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "XLINK1_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK1_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK1_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK2_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "XLINK2_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK2_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK2_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK3_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "XLINK3_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK3_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK3_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK3_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK3_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK4_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "XLINK4_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK4_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK4_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK4_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK4_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK5_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "XLINK5_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK5_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK5_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK5_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK5_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK6_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "XLINK6_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK6_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK6_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK6_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK6_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK7_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "XLINK7_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK7_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK7_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_XLINK7_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK7_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK0_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "XLINK0_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK0_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK0_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK1_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "XLINK1_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK1_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK1_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK2_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "XLINK2_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK2_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK2_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK3_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "XLINK3_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK3_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK3_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK3_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK3_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK4_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "XLINK4_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK4_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK4_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK4_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK4_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK5_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "XLINK5_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK5_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK5_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK5_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK5_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK6_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "XLINK6_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK6_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK6_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK6_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK6_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "XLINK7_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "XLINK7_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_XLINK7_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_XLINK7_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_XLINK7_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_XLINK7_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK0_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "ALINK0_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK0_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK0_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK0_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK0_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK1_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "ALINK1_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK1_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK1_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK1_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK1_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK2_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "ALINK2_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK2_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK2_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK2_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK2_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK3_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "ALINK3_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK3_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK3_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK3_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK3_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK4_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "ALINK4_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK4_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK4_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK4_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK4_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK5_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "ALINK5_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK5_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK5_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK5_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK5_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK6_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "ALINK6_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK6_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK6_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK6_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK6_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK7_OUT_TOTAL_UTILIZATION",
>> +      "BriefDescription": "ALINK7_OUT_TOTAL_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK7_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_ALINK7_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@) / (hv_24x7@PM_ALINK7_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK7_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK0_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "ALINK0_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK0_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK0_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK0_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK0_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK1_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "ALINK1_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK1_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK1_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK1_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK1_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK2_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "ALINK2_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK2_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK2_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK2_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK2_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK3_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "ALINK3_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK3_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK3_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK3_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK3_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK4_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "ALINK4_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK4_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK4_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK4_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK4_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK5_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "ALINK5_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK5_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK5_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK5_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK5_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK6_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "ALINK6_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK6_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK6_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK6_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK6_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "ALINK7_OUT_DATA_UTILIZATION",
>> +      "BriefDescription": "ALINK7_OUT_DATA_UTILIZATION",
>> +      "MetricExpr": "((hv_24x7@PM_ALINK7_OUT_ODD_DATA\\,chip\\=?@ + hv_24x7@PM_ALINK7_OUT_EVEN_DATA\\,chip\\=?@) / (hv_24x7@PM_ALINK7_OUT_ODD_AVLBL_CYCLES\\,chip\\=?@ + hv_24x7@PM_ALINK7_OUT_EVEN_AVLBL_CYCLES\\,chip\\=?@)) * 100",
>> +      "ScaleUnit": "1.063%",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_DATA_BANDWIDTH_TRANSFERRED_OVER_PB_PCI1",
>> +      "BriefDescription": "TOTAL_DATA_BANDWIDTH_TRANSFERRED_OVER_PB_PCI1",
>> +      "MetricExpr": "(hv_24x7@PM_PCI1_32B_INOUT\\,chip\\=?@)",
>> +      "ScaleUnit": "3.28e-2MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_DATA_BANDWIDTH_TRANSFERRED_OVER_PB_PCI0",
>> +      "BriefDescription": "TOTAL_DATA_BANDWIDTH_TRANSFERRED_OVER_PB_PCI0",
>> +      "MetricExpr": "(hv_24x7@PM_PCI0_32B_INOUT\\,chip\\=?@)",
>> +      "ScaleUnit": "3.28e-2MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_MCS_READ_BW_MC0_CHAN01",
>> +      "BriefDescription": "TOTAL_MCS_READ_BW_MC0_CHAN01",
>> +      "MetricExpr": "(hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC0_CHAN01\\,chip\\=?@)",
>> +      "ScaleUnit": "5.24e-1MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_MCS_READ_BW_MC1_CHAN01",
>> +      "BriefDescription": "TOTAL_MCS_READ_BW_MC1_CHAN01",
>> +      "MetricExpr": "(hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC1_CHAN01\\,chip\\=?@)",
>> +      "ScaleUnit": "5.24e-1MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_MCS_READ_BW_MC2_CHAN01",
>> +      "BriefDescription": "TOTAL_MCS_READ_BW_MC2_CHAN01",
>> +      "MetricExpr": "(hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC2_CHAN01\\,chip\\=?@)",
>> +      "ScaleUnit": "5.24e-1MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_MCS_READ_BW_MC3_CHAN01",
>> +      "BriefDescription": "TOTAL_MCS_READ_BW_MC3_CHAN01",
>> +      "MetricExpr": "(hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC3_CHAN01\\,chip\\=?@)",
>> +      "ScaleUnit": "5.24e-1MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_MCS_WRITE_BW_MC0_CHAN01",
>> +      "BriefDescription": "TOTAL_MCS_WRITE_BW_MC0_CHAN01",
>> +      "MetricExpr": "(hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC0_CHAN01\\,chip\\=?@)",
>> +      "ScaleUnit": "2.6e-1MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_MCS_WRITE_BW_MC1_CHAN01",
>> +      "BriefDescription": "TOTAL_MCS_WRITE_BW_MC1_CHAN01",
>> +      "MetricExpr": "(hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC1_CHAN01\\,chip\\=?@)",
>> +      "ScaleUnit": "2.6e-1MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_MCS_WRITE_BW_MC2_CHAN01",
>> +      "BriefDescription": "TOTAL_MCS_WRITE_BW_MC2_CHAN01",
>> +      "MetricExpr": "(hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC2_CHAN01\\,chip\\=?@)",
>> +      "ScaleUnit": "2.6e-1MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricName": "TOTAL_MCS_WRITE_BW_MC3_CHAN01",
>> +      "BriefDescription": "TOTAL_MCS_WRITE_BW_MC3_CHAN01",
>> +      "MetricExpr": "(hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC3_CHAN01\\,chip\\=?@)",
>> +      "ScaleUnit": "2.6e-1MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricExpr": "(hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC0_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC1_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC2_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_128B_RD_DATA_BLOCKS_MC3_CHAN01\\,chip\\=?@)",
>> +      "MetricName": "Memory_RD_BW_Chip",
> 
> The pattern up until this point was "MetricName", then "BriefDescription",
> then "MetricExpr".  I think it would be helpful to continue that here,
> and for the next two as well.  That should include _having_ a description,
> obviously.  :-)
> 

Ok I will update it.

Thanks,
Kajol Jain

>> +      "MetricGroup": "Memory_BW",
>> +      "ScaleUnit": "5.24e-1MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricExpr": "(hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC0_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC1_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC2_CHAN01\\,chip\\=?@ + hv_24x7@PM_MCS_64B_WR_DATA_BLOCKS_MC3_CHAN01\\,chip\\=?@ )",
>> +      "MetricName": "Memory_WR_BW_Chip",
>> +      "MetricGroup": "Memory_BW",
>> +      "ScaleUnit": "2.6e-1MB",
>> +      "AggregationMode": "PerChip"
>> +    },
>> +    {
>> +      "MetricExpr": "(hv_24x7@PM_PAU_CYC\\,chip\\=?@ )",
>> +      "MetricName": "PowerBUS_Frequency",
>> +      "ScaleUnit": "2.56e-7GHz",
>> +      "AggregationMode": "PerChip"
>> +    }
>> +]
>> -- 
> 
> PC
> 
