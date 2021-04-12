Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E534435BA1C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhDLGZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:25:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhDLGZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:25:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13C649on134311;
        Mon, 12 Apr 2021 02:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=eQDF9ujJJY1Oib2WDryZnxZgAzRGulf0L4Jpj2/mffg=;
 b=FunUbA/BVdEqCWavf3QheCKwzK6NsedM3tdgVe3YutaQNrwfVqkSjJ1DO19ridOjhP6/
 j0TK0R8C50hqx/6NmpfYWbjY6KL+y6VTw9OfcyNcr0Guy5JWCKEzlajndGcq337xwYbL
 VPy6waYsD9aFH7us2E6BAnqifi9xVm9MXtQPesrmKz6oiyK78pcblGp4gS6H4l6xABiZ
 9c1xJif355leB3N+P9R9u7geiNjhfdnZK0vJDUz7g84BQ9ZchtKpMRq66cySI2iwzInu
 WW+YGxxXemdDfyD0IdqPlIJtdPYUnGk3Tv3hukZCRdQgQolsee6j5pLcbdsbdzNun/bj /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37us0ypnj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 02:24:45 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13C6JaRB041340;
        Mon, 12 Apr 2021 02:24:44 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37us0ypnhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 02:24:44 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13C69De7023086;
        Mon, 12 Apr 2021 06:24:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 37u3n89hfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 06:24:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13C6OdHL47055284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 06:24:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A07ECA405E;
        Mon, 12 Apr 2021 06:24:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2133A4055;
        Mon, 12 Apr 2021 06:24:36 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 12 Apr 2021 06:24:36 +0000 (GMT)
Date:   Mon, 12 Apr 2021 11:54:36 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Parth Shah <parth@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC/PATCH] powerpc/smp: Add SD_SHARE_PKG_RESOURCES flag to MC
 sched-domain
Message-ID: <20210412062436.GB2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -c-LAaG1u6T276gOvFfbJbWJAq4uSFoW
X-Proofpoint-ORIG-GUID: EhsRFdFm16QVdzrJrN4Lf8CqVbkQThNl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_03:2021-04-09,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 lowpriorityscore=0
 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=715 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104120040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2021-04-02 11:07:54]:

> 
> To remedy this, this patch proposes that the LLC be moved to the MC
> level which is a group of cores in one half of the chip.
> 
>       SMT (SMT4) --> MC (Hemisphere)[LLC] --> DIE
> 

I think marking Hemisphere as a LLC in a P10 scenario is a good idea.

> While there is no cache being shared at this level, this is still the
> level where some amount of cache-snooping takes place and it is
> relatively faster to access the data from the caches of the cores
> within this domain. With this change, we no longer see regressions on
> P10 for applications which require single threaded performance.

Peter, Valentin, Vincent, Mel, etal

On architectures where we have multiple levels of cache access latencies
within a DIE, (For example: one within the current LLC or SMT core and the
other at MC or Hemisphere, and finally across hemispheres), do you have any
suggestions on how we could handle the same in the core scheduler?

-- 
Thanks and Regards
Srikar Dronamraju
