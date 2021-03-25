Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AF7349B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 21:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhCYUkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 16:40:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230284AbhCYUkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:40:22 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12PKYmvP180694;
        Thu, 25 Mar 2021 16:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 message-id : references : content-type : in-reply-to : mime-version :
 subject; s=pp1; bh=E83qJwL994tWNvZoPHAqPVwTyBeNoD1TzqnUPAxaQi8=;
 b=TtbtDhGsaVgN6T5Me7RI043XlPc9psFADWN94RUl91jwvI5PUDpEWSebjgG3Jx2XJaZW
 UB2+bDoaOqg66OiJmivYSYJxqWC0INU4L64kFbbkhixDYvTBIsP8iMZH+uTgB/kRNKN5
 DaBJzAVnp+iGs0k028A64r6t0Z2QIfVJI8X2EqaMxKJ/Zz0ktyit2SQ5aF84H9LHnNcm
 2CrDK2IMzv1ATdjenC1vzAbCM7yhvvvXDUlN4acCoUmt69BdqlhqgK0NrRRQIiP7+Lci
 z0W6VAUWcMFjCft4vZkxBGqPQ/SkwQpaYHvrSW+3yTJ5GnShDZEh2Dmqg53xKfpTanls 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37h17jrvs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 16:39:51 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12PKZ029182096;
        Thu, 25 Mar 2021 16:39:51 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37h17jrvrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 16:39:51 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12PKaeAb021668;
        Thu, 25 Mar 2021 20:39:49 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 37h158073b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 20:39:49 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12PKdmR827918840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 20:39:48 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACF9E7805F;
        Thu, 25 Mar 2021 20:39:48 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A21E478063;
        Thu, 25 Mar 2021 20:39:46 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.80.228.20])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Mar 2021 20:39:46 +0000 (GMT)
Date:   Thu, 25 Mar 2021 15:39:44 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, irogers@google.com,
        linuxarm@huawei.com, kjain@linux.ibm.com,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com
Message-ID: <20210325203944.GD8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yu9QP0jAGjDtuV-JEzmB9W5Rh6qNAlIt
X-Proofpoint-GUID: OOybH2SzF2Q0pP8gIM3wn6_U6x3VLvlp
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: Re:  [PATCH v2 0/6] perf arm64 metricgroup support
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_08:2021-03-25,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250143
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 06:33:12PM +0800, John Garry wrote:
> Metric reuse support is added for pmu-events parse metric testcase.
> This had been broken on power9 recentlty:
> https://lore.kernel.org/lkml/20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com/

Much better.  Before:
--
$ perf test -v 10 2>&1 | grep -i error | wc -l
112
--
After:
--
$ perf test -v 10 2>&1 | grep -i error | wc -l
17
--

And these seem like different types of issues:
--
$ perf test -v 10 2>&1 | grep -i error
Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_powerbus0_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
--

(Added Kajol Jain to CC)

PC
