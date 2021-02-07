Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6F31261A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 17:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBGQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 11:46:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhBGQp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 11:45:58 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 117GWuDQ106151;
        Sun, 7 Feb 2021 11:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=P/nx59+Gbnp+sQZMxdpPOZ7n/OYnKxlisKnmjIUM5fc=;
 b=BkPaq1kCV9h66BwCssd0VyRul6irQuI5Oo5indQBlDTbvHLcOGbFNHI76sf8tOGnc+OQ
 X2SFkedLxPz8/Y+viYCPMPlW2rI0EHCmF3NJL/+DzyCJNlNSKUicfAyOGLgXtwydUjo4
 QvivuLbEa3eIP8hApD4EarAdxwFNWnKsCY4DO83BHaolUTTx5VtlRHApB1lzjgTFEBJF
 5MXhlmxHbjWFwpbGfU8z8pJAXeerWQM47ySwx4yzXFnN8sGDoTfPR7009Q9HjS03siBm
 5adVtHq5/H96kPo275hB/PeMVIP0lZezCR1qML39N16kluoN6sV8O4AB6eFPSpZ9igUV Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36jk5d0r37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Feb 2021 11:45:11 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 117GX8oJ106498;
        Sun, 7 Feb 2021 11:45:10 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36jk5d0r2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Feb 2021 11:45:10 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 117Ghk0N001573;
        Sun, 7 Feb 2021 16:45:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 36hjr80km1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Feb 2021 16:45:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 117Gj51O20382006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Feb 2021 16:45:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BC60AE05D;
        Sun,  7 Feb 2021 16:45:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 222DCAE04D;
        Sun,  7 Feb 2021 16:45:03 +0000 (GMT)
Received: from [9.79.226.154] (unknown [9.79.226.154])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  7 Feb 2021 16:45:02 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 6/9] perf report: Support instruction latency
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <2f2ede9e-b098-4921-59e2-1289bdc87ba1@linux.intel.com>
Date:   Sun, 7 Feb 2021 22:15:00 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, maddy@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D97FEF4F-DD88-4760-885E-9A6161A9B48B@linux.vnet.ibm.com>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
 <A90940CE-3DFB-4774-BA46-0C5FEB4953A0@linux.vnet.ibm.com>
 <27633871-eda5-7faa-8783-84dd49f8a6cd@linux.intel.com>
 <6F377E9D-89F8-414F-A2CC-C96797697159@linux.vnet.ibm.com>
 <2f2ede9e-b098-4921-59e2-1289bdc87ba1@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-07_08:2021-02-05,2021-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102070117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 05-Feb-2021, at 8:21 PM, Liang, Kan <kan.liang@linux.intel.com> =
wrote:
>=20
>=20
>=20
> On 2/5/2021 7:55 AM, Athira Rajeev wrote:
>>>> Because in other archs, the var2_w of =E2=80=98perf_sample_weight=E2=80=
=99 could be used to capture something else than the Local INSTR =
Latency.
>>>> Can we have some weak function to populate the header string ?
>>> I agree that the var2_w has different meanings among architectures. =
We should not force it to data->ins_lat.
>>>=20
>>> The patch as below should fix it. Does it work for you?
>> My point about weak function was actually for the arch specific =
header string. But I guess we should not force it to data->ins_lat
>=20
> Yes, I don't think PowerPC should force var2_w to data->ins_lat. I =
think you can create your own field.
>=20
>> as you mentioned. I checked the below patch defining an =
=E2=80=98arch_perf_parse_sample_weight' for powerpc and it works.
>> But one observation is that, for cases with kernel having support for =
PERF_SAMPLE_WEIGHT_STRUCT but missing arch specific support for  =
=E2=80=98arch_perf_parse_sample_weight', it will report =E2=80=98Local =
Weight=E2=80=99 wrongly since weak function takes it as 64 bit. Not sure =
if that is a valid case to consider though.
>=20
> Currently, the PERF_SAMPLE_WEIGHT_STRUCT is only enabled on X86 by =
default.
> =
https://lore.kernel.org/lkml/1612296553-21962-6-git-send-email-kan.liang@l=
inux.intel.com/
>=20
> For PowerPC, the PERF_SAMPLE_WEIGHT is still the default setting. =
There is no way to set PERF_SAMPLE_WEIGHT_STRUCT via perf tool.
> I don't think the above case will happen.

Yes.=20

I tested with kernel changes from perf/core branch of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
And perf tools side changes from tmp.perf/core branch of =
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git along with =
the above change.=20
The default setting for powerpc works with out breaking anything and =
verified using =E2=80=9Cperf mem record <workload>=E2=80=9D

Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira Rajeev
>=20
> Thanks,
> Kan

