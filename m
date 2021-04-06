Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A466B35537F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbhDFMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:19:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241983AbhDFMTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:19:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136CBmn9110521;
        Tue, 6 Apr 2021 08:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 message-id : references : content-type : in-reply-to : mime-version :
 subject; s=pp1; bh=zRWvsb4XuGZMzURwTRd+STVFZ07kypvKJ1Wvk1rlDiE=;
 b=IhAeqqcZ5aP5MHBfiJ750+I3o35J5dwJMr54xtGaFmlr9VtXLdalPVKl1AbGbtkGAhm7
 MmWe2QvCvVUJPgO/OISScB+IIGIuw0JjO2vbBcJ2eSn20VZel3UcxgClc+QiB2FL7Lor
 CaCpkFHhteg6mMdi0MGWNBAzFzeiZukhXZihKhKH+JmIG9TH6udWSfCgottiOvToBN/U
 +h+0t6m1CHj5qEyGihceqt6eufcPQJZ4Bvq+1y9/6FbZ7Ga7Bbnr2vzNuNB1R6edRErv
 9+vjVe2IdeV/SdIzHUDTNSqPlyQ6DVGf6B+vOAwsf33ZKnrTni2t86N0/5ifmr8ygW/h CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rq1w0yxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 08:18:48 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 136CCB8f112973;
        Tue, 6 Apr 2021 08:18:48 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rq1w0ywy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 08:18:48 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 136C7ZIr022908;
        Tue, 6 Apr 2021 12:18:46 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 37q2n6bjgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 12:18:46 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 136CIjN628639728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Apr 2021 12:18:45 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D8116E04C;
        Tue,  6 Apr 2021 12:18:45 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A03206E052;
        Tue,  6 Apr 2021 12:18:42 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.85.178.250])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue,  6 Apr 2021 12:18:42 +0000 (GMT)
Date:   Tue, 6 Apr 2021 07:18:40 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     kajoljain <kjain@linux.ibm.com>, will@kernel.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, irogers@google.com,
        linuxarm@huawei.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com
Message-ID: <20210406121840.GK8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <20210325203944.GD8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <dc17013d-2dcb-8ddf-a15a-e98cad3e2ae3@huawei.com>
 <20210329210717.GF8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <247e9484-34c8-544a-e268-b025ecb317fe@linux.ibm.com>
 <1d800da3-ec94-3a37-eca9-1d3cf8543ba6@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d800da3-ec94-3a37-eca9-1d3cf8543ba6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ea4gPTtHTMP5FYvzmn0KrtI5KMaoHrd-
X-Proofpoint-GUID: ZNKRsBlKyIdmHkBe1RUg5EIwA4fIsrU0
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH v2 0/6] perf arm64 metricgroup support
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_03:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 12:02:36PM +0100, John Garry wrote:
> On 30/03/2021 07:41, kajoljain wrote:
> > On 3/30/21 2:37 AM, Paul A. Clarke wrote:
> > > On Fri, Mar 26, 2021 at 10:57:40AM +0000, John Garry wrote:
> > > > On 25/03/2021 20:39, Paul A. Clarke wrote:
> > > > > On Thu, Mar 25, 2021 at 06:33:12PM +0800, John Garry wrote:
> > > > > > Metric reuse support is added for pmu-events parse metric testcase.
> > > > > > This had been broken on power9 recentlty:
> > > > > > https://lore.kernel.org/lkml/20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com/
> > > > > 
> > > > > Much better.  Before:
> > > > > --
> > > > > $ perf test -v 10 2>&1 | grep -i error | wc -l
> > > > > 112
> > > > > --
> > > > > After:
> > > > > --
> > > > > $ perf test -v 10 2>&1 | grep -i error | wc -l
> > > > > 17
> > > > > --
> > > > > 
> > > > > And these seem like different types of issues:
> > > > > --
> > > > > $ perf test -v 10 2>&1 | grep -i error
> > > > > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_powerbus0_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > > > > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > > > > --
> > > > > 
> > > > 
> > > > This looks suspicious.
> > > > 
> > > > Firstly, does /sys/bus/event_source/devices/nest_mcs01_imc (or others,
> > > > above) exist on your system? I guess not.
> > > > 
> > > > Secondly, checking Documentation/powerpc/imc.rst, we have examples of:
> > > > nest_mcs01/PM_MCS01_64B_R...
> > > > 
> > > > So is the PMU name correct in the metric file for nest_mcs01_imc? Looking at
> > > > the kernel driver file, arch/powerpc/perf/imc-pmu.c, it seems to be correct.
> > > > Not sure.
> > > 
> > > I ran with a newer kernel, and the above errors disappeared, replaced with
> > > about 10 of:
> > > --
> > > Error string 'Cannot find PMU `hv_24x7'. Missing kernel support?' help '(null)'
> > > --
> > > 
> > > ...but I was running without a hypervisor, so I tried the same kernel on a
> > > PowerVM-virtualized system and the "hv_24x7" messages went away, but the
> > > "nest" messages returned.  This may all be expected behavior... I confess
> > > I haven't followed these new perf capabilities closely.
> > > 
> > 
> > Hi Paul/John,
> >     This is something expected. For nest-imc we need bare-metal system and for
> > hv-24x7 we need VM environment. Since you are checking this test in VM machine,
> > there nest events are not supported and hence we are getting this error.
> > 
> > Thanks,
> > Kajol Jain
> 
> Cool, so I hope that tested-by or similar can be provided :) [obviously
> pending any changes that come from reviews]

Certainly!

Tested-by: Paul A. Clarke <pc@us.ibm.com>

PC
