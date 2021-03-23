Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D37346251
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhCWPGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:06:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232630AbhCWPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:06:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NF5u0c005358;
        Tue, 23 Mar 2021 11:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 message-id : references : mime-version : content-type : in-reply-to :
 subject; s=pp1; bh=J17wW6Pczzjq3J9Dvl5O9H1jJPqHnDvVJ7svk2OM+Fk=;
 b=W2vEg3P/WmazqYzBvFk62nt39p4r3W3MnqbFoSSHsK8hD9qRjmk1rjXxMWVbRqkiGLXI
 V1bqJtXRF+WAyDgPWVtJClq6ImgIzmfvIvZVwHFwOT3xXiJm1cfWn12HvAHj+sbL3Jsh
 IUJShpmE4MrAlnwzXfxvvQGGPunUTjAbuG0ThQA7g0oNfv4SUmH0V6+TM3RTTxW8euyS
 e7jtYTfVZS8dBLpA7mGYZCe2HU/4VePxrpNepTCuSlZWaWlil3fRJXRrtKZhkig30tNp
 yH6I1s23ahg/TQQX8H2mlr8Eif0hVLUbXmaSS2xhIRWcTM8ZDG4PTAV6y6VflXIrNBOI Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37fjp180jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 11:06:16 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NF65RE005864;
        Tue, 23 Mar 2021 11:06:15 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37fjp180dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 11:06:15 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NF4T3d031416;
        Tue, 23 Mar 2021 15:06:10 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 37d9bevcuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 15:06:10 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NF69k031260966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 15:06:09 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E539AC605B;
        Tue, 23 Mar 2021 15:06:08 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E771C605A;
        Tue, 23 Mar 2021 15:06:07 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.80.223.181])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 23 Mar 2021 15:06:06 +0000 (GMT)
Date:   Tue, 23 Mar 2021 10:06:04 -0500
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
Message-ID: <20210323150604.GB8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20200729091908.1378911-1-jolsa@kernel.org>
 <20200801114050.GB377079@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <7682e4c3-5840-bb6d-5e76-6b3fd37b04c0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7682e4c3-5840-bb6d-5e76-6b3fd37b04c0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
Subject: RE: [PATCHv4 00/19] perf metric: Add support to reuse metric
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_06:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:36:23AM +0000, John Garry wrote:
> On 01/08/2020 12:40, Paul A. Clarke wrote:
> > > v4 changes:
> > >    - removed acks from patch because it changed a bit
> > >      with the last fixes:
> > >        perf metric: Collect referenced metrics in struct metric_ref_node
> > >    - fixed runtime metrics [Kajol Jain]
> > >    - increased recursion depth [Paul A. Clarke]
> > >    - changed patches due to dependencies:
> > >        perf metric: Collect referenced metrics in struct metric_ref_node
> > >        perf metric: Add recursion check when processing nested metrics
> > >        perf metric: Rename struct egroup to metric
> > >        perf metric: Rename group_list to metric_list
> > > 
> > > Also available in here:
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > >    perf/metric
> > I built and ran from the above git branch, and things seem to work.
> > Indeed, I was able to apply my changes to exploit the new capabilities
> > via modifications to tools/perf/pmu-events/arch/powerpc/power9/metrics.json,
> > as I posted earlier (and will submit once this set gets merged).

> I was just wondering: Does perf subtest 10.3 work ok for you with the metric
> reuse?
> 
> That's "Parsing of PMU event table metrics" subtest.

I confess I'm not sure what you are asking. Using the latest mainline
(84196390620ac0e5070ae36af84c137c6216a7dc), perf subtest 10.3 does
pass for me:
--
$ ./perf test 10
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Ok
10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
--

PC
