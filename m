Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A9D34A7E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCZNOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:14:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230094AbhCZNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:14:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12QD3fFZ018587;
        Fri, 26 Mar 2021 09:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 message-id : references : content-type : in-reply-to : mime-version :
 subject; s=pp1; bh=MVLdHtOA9u66gCFQHhJSlZvgsY5KSAsBec7R26/rWHQ=;
 b=NiwwrclsXvqAraHQGyRDpUXcVje6Y7aS0tL7zDm8w19AReZifAJhs0uB6iTSRCbbLVsH
 Kq+XUZVK/LPtednIl5Cnj+2BLTDNEPt9JBAAi4eat/rvLy/GCDl8coMiTlcBmXovdRPQ
 lPek9U3TKEBGgoo5nPLwHRBfaSkVyrM9lPDAnurMO7fBJ0b+geQGIbfuwdve4RlRInNI
 xpXDjTpRwH31Q4GqLiiCvM3KKUQSESxRHA2umU13OZw2uWGrEt2PvR83aw0NoSOMoOnE
 rSvwoFPXAJ0uO9J6qQWclU460+CnJAI6xp+qhvdPKO0O7Um0uAB8TcoHi/c8sSztdSEG zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37hcd1pmv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 09:13:29 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12QD45d3022300;
        Fri, 26 Mar 2021 09:13:29 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37hcd1pmug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 09:13:28 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12QDBiBO024245;
        Fri, 26 Mar 2021 13:13:28 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 37h1536n65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 13:13:28 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12QDDQtm11469154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 13:13:26 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA8F1C6061;
        Fri, 26 Mar 2021 13:13:26 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88805C6057;
        Fri, 26 Mar 2021 13:13:24 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.85.182.100])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 26 Mar 2021 13:13:24 +0000 (GMT)
Date:   Fri, 26 Mar 2021 08:13:22 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, irogers@google.com,
        linuxarm@huawei.com, kjain@linux.ibm.com,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com
Message-ID: <20210326131322.GE8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <20210325203944.GD8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <dc17013d-2dcb-8ddf-a15a-e98cad3e2ae3@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc17013d-2dcb-8ddf-a15a-e98cad3e2ae3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tQCDVEmjJ3QU-DKDOVrpcwFkbVKKe39U
X-Proofpoint-ORIG-GUID: nIQaLixe-OXNeIlG23Q0RAOAymaHqlAk
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH v2 0/6] perf arm64 metricgroup support
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-26_06:2021-03-26,2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260098
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

This may be caused by me testing a new perf on an older kernel. Let me retest.

PC
