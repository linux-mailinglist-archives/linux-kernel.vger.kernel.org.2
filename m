Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C599F34D974
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhC2VJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:09:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231303AbhC2VJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:09:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TL36uo133759;
        Mon, 29 Mar 2021 17:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 message-id : references : content-type : in-reply-to : mime-version :
 subject; s=pp1; bh=84FSmOxSe00ijv5LL4qlj56mILtsHfbF9ZKiO/6taZw=;
 b=NVfTPT1Jgy1IH9pzAXV5odz0UaeY0sTzQU+WatDkSn7COTbbJTQthy74jm3iMflIxXCa
 uxdbtg5d89vFeHP4i6kBHglVutDvEsdzMp+/SingE/wwcSaqzuni8ixO05XVGV5GbsQg
 fsPMKtV4ec4JfEOlnfVhxa/7UGXXRPJZegNy6W+bOz2xrxhMej/PrO98aulp7qKi7S32
 XdRZel2JtNppkwmCDKMEaTZ4qXqzcJT0cEf8IxvkYx9JK2910rbZbcuF462Fx4In+afW
 bzcnnaWd+qza2ytB0WhE80FSQ4YCcJqiKriMqc6sMzurhrgxeZcJlsFhXrDZhUf0dli3 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhsb3vqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 17:07:24 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12TL5FgO143865;
        Mon, 29 Mar 2021 17:07:24 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhsb3vq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 17:07:24 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12TL1jVD010119;
        Mon, 29 Mar 2021 21:07:23 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03wdc.us.ibm.com with ESMTP id 37jqmn154v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 21:07:23 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12TL7MKm30605726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 21:07:22 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CC6D6A04F;
        Mon, 29 Mar 2021 21:07:22 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C95BA6A054;
        Mon, 29 Mar 2021 21:07:19 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.80.204.95])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 29 Mar 2021 21:07:19 +0000 (GMT)
Date:   Mon, 29 Mar 2021 16:07:17 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, irogers@google.com,
        linuxarm@huawei.com, kjain@linux.ibm.com,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com
Message-ID: <20210329210717.GF8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <20210325203944.GD8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <dc17013d-2dcb-8ddf-a15a-e98cad3e2ae3@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc17013d-2dcb-8ddf-a15a-e98cad3e2ae3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N7PTF-kQ-25AhyM4F_NNmDqAKWWzSobJ
X-Proofpoint-GUID: RwizZF46QlD5oQdnPCFSCAlndJErbdAE
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH v2 0/6] perf arm64 metricgroup support
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_12:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290156
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:57:40AM +0000, John Garry wrote:
> On 25/03/2021 20:39, Paul A. Clarke wrote:
> > On Thu, Mar 25, 2021 at 06:33:12PM +0800, John Garry wrote:
> > > Metric reuse support is added for pmu-events parse metric testcase.
> > > This had been broken on power9 recentlty:
> > > https://lore.kernel.org/lkml/20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com/
> > 
> > Much better.  Before:
> > --
> > $ perf test -v 10 2>&1 | grep -i error | wc -l
> > 112
> > --
> > After:
> > --
> > $ perf test -v 10 2>&1 | grep -i error | wc -l
> > 17
> > --
> > 
> > And these seem like different types of issues:
> > --
> > $ perf test -v 10 2>&1 | grep -i error
> > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_powerbus0_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> > --
> > 
> 
> This looks suspicious.
> 
> Firstly, does /sys/bus/event_source/devices/nest_mcs01_imc (or others,
> above) exist on your system? I guess not.
> 
> Secondly, checking Documentation/powerpc/imc.rst, we have examples of:
> nest_mcs01/PM_MCS01_64B_R...
> 
> So is the PMU name correct in the metric file for nest_mcs01_imc? Looking at
> the kernel driver file, arch/powerpc/perf/imc-pmu.c, it seems to be correct.
> Not sure.

I ran with a newer kernel, and the above errors disappeared, replaced with
about 10 of:
--
Error string 'Cannot find PMU `hv_24x7'. Missing kernel support?' help '(null)'
--

...but I was running without a hypervisor, so I tried the same kernel on a
PowerVM-virtualized system and the "hv_24x7" messages went away, but the
"nest" messages returned.  This may all be expected behavior... I confess
I haven't followed these new perf capabilities closely.

It's extremely likely that none of these errors has anything to do with your
changes. :-)

PC
