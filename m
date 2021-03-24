Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD90C346F18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhCXByf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:54:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43278 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232101AbhCXBya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:54:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12O1Ygu9116639;
        Tue, 23 Mar 2021 21:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 message-id : references : mime-version : content-type : in-reply-to :
 subject; s=pp1; bh=5jW7gfzb7xC4j2UP6SQKB5rXAdkeaw0c+uJONfxf5vM=;
 b=MyzUYimdnFFbJgVkBc7g+9KS30FSNvs+FS7e1rhpGBYapLkw6VBFIwnQcVBadxAo4qu4
 yA4WkV0QI7HV/TsSqO09gp935Z1WRzh4zNXkICyhxV+Tw8SDGp7zw1g8soVwLJJOLWwF
 cRuwK0nZ9Ngp2dMtAnSRe/MVr0RVC9+h81qm8cHOiR9uJRQsSuBtYn0bBfZNG7lpJZtR
 Nin3+C8B8vgWtXsyyHA1qk2stDYrsum+CQtXu6InzIJsnewkjyBywOHU72CEXHt9KD0Z
 wP9gPH40s30WmGxYzsxhXeT5zTudGFGLPDVB22HxojigdGjOW9DCj61r3J/2jeYJbjOn Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fuq40gyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 21:54:22 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12O1aBY6123178;
        Tue, 23 Mar 2021 21:54:22 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37fuq40gyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 21:54:22 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12O1pjSW018941;
        Wed, 24 Mar 2021 01:54:21 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 37d99rafhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 01:54:21 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12O1sLGb28705036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 01:54:21 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 406C4AE060;
        Wed, 24 Mar 2021 01:54:21 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57CFFAE05C;
        Wed, 24 Mar 2021 01:54:20 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.80.214.185])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Mar 2021 01:54:20 +0000 (GMT)
Date:   Tue, 23 Mar 2021 20:54:18 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Message-ID: <20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20200729091908.1378911-1-jolsa@kernel.org>
 <20200801114050.GB377079@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <7682e4c3-5840-bb6d-5e76-6b3fd37b04c0@huawei.com>
 <20210323150604.GB8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <a233702a-89b7-ae47-d47a-a7b4539c191e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a233702a-89b7-ae47-d47a-a7b4539c191e@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
Subject: RE: [PATCHv4 00/19] perf metric: Add support to reuse metric
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_01:2021-03-23,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 03:15:16PM +0000, John Garry wrote:
> On 23/03/2021 15:06, Paul A. Clarke wrote:
> > On Mon, Mar 22, 2021 at 11:36:23AM +0000, John Garry wrote:
> > > On 01/08/2020 12:40, Paul A. Clarke wrote:
> > > > > v4 changes:
> > > > >     - removed acks from patch because it changed a bit
> > > > >       with the last fixes:
> > > > >         perf metric: Collect referenced metrics in struct metric_ref_node
> > > > >     - fixed runtime metrics [Kajol Jain]
> > > > >     - increased recursion depth [Paul A. Clarke]
> > > > >     - changed patches due to dependencies:
> > > > >         perf metric: Collect referenced metrics in struct metric_ref_node
> > > > >         perf metric: Add recursion check when processing nested metrics
> > > > >         perf metric: Rename struct egroup to metric
> > > > >         perf metric: Rename group_list to metric_list
> > > > > 
> > > > > Also available in here:
> > > > >     git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > > > >     perf/metric
> > > > I built and ran from the above git branch, and things seem to work.
> > > > Indeed, I was able to apply my changes to exploit the new capabilities
> > > > via modifications to tools/perf/pmu-events/arch/powerpc/power9/metrics.json,
> > > > as I posted earlier (and will submit once this set gets merged).
> > > I was just wondering: Does perf subtest 10.3 work ok for you with the metric
> > > reuse?
> > > 
> > > That's "Parsing of PMU event table metrics" subtest.
> > I confess I'm not sure what you are asking. Using the latest mainline
> > (84196390620ac0e5070ae36af84c137c6216a7dc), perf subtest 10.3 does
> > pass for me:
> > --
> > $ ./perf test 10
> > 10: PMU events                                                      :
> > 10.1: PMU event table sanity                                        : Ok
> > 10.2: PMU event map aliases                                         : Ok
> > 10.3: Parsing of PMU event table metrics                            : Ok
> > 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> > --
> Since commit 8989f5f07605 ("perf stat: Update POWER9 metrics to utilize
> other metrics"), power9 has reused metrics.
> 
> And I am finding that subtest 10.3 caused problems when I tried to introduce
> metric reuse on arm64, so I was just asking you to check.
> 
> Now I am a bit confused...

I now understand your original request! :-)

The above test was run on a POWER8 system.

I do see failures on a POWER9 system:
--
$ ./perf test 10
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
$ ./perf test --verbose 10 2>&1 | grep -i '^Parse event failed' | wc -l
112
--

PC
