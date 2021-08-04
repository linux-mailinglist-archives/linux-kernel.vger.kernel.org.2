Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04443DFEB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbhHDKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:02:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237322AbhHDKCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:02:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1749YBTD061927;
        Wed, 4 Aug 2021 06:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=Si2RaYEKACLc9gmdxcROUfh0ObjMKmBVxrlDiI0m+P8=;
 b=ceTPa6JehcJh6u1IYa79vhNqhiaGEvErhoJJwneWRZm+xq2iVBK4Mk38NPYU9KVZ/Mf1
 KYSvDyHeOxx6tCwuHj3UuxzLmaNYtSLdhP9hfaAKWjY3m1xyKTMcnnae9R+k/UcJtkwR
 q5WhXH8JZLp21nxIZ9rlyesSZeLFEd2g6HjYw9ADdXSfLh1WM0t1ZAu6ELQDjOrptdzz
 7nrXCTbauVmIEdtBykdtE47gjV56EHEucs502RZIoQl5ISYJHvP1XP8eM/yoDUOAqeGT
 6NoPtkyLRJQX4K+V5/d0a+tjSyeKdtg6eMfHIhuo48naWKi7ffOv6qDQNYK8/hWVz+qt zA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a7cfc8erg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Aug 2021 06:02:06 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1749vMqE017669;
        Wed, 4 Aug 2021 10:02:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3a4x58r3j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Aug 2021 10:02:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 174A1x8A47448328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Aug 2021 10:01:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D132A407B;
        Wed,  4 Aug 2021 10:01:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01E0DA4040;
        Wed,  4 Aug 2021 10:01:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  4 Aug 2021 10:01:55 +0000 (GMT)
Date:   Wed, 4 Aug 2021 15:31:55 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] sched/topology: Skip updating masks for
 non-online nodes
Message-ID: <20210804100155.GE4072958@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210701041552.112072-1-srikar@linux.vnet.ibm.com>
 <20210701041552.112072-2-srikar@linux.vnet.ibm.com>
 <875yxu85wi.mognet@arm.com>
 <20210712124856.GA3836887@linux.vnet.ibm.com>
 <87zguqmay9.mognet@arm.com>
 <20210723143914.GI3836887@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210723143914.GI3836887@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kyLPPIU7EN9hswyoUw8Cy49AOnuzhdLT
X-Proofpoint-GUID: kyLPPIU7EN9hswyoUw8Cy49AOnuzhdLT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-04_03:2021-08-04,2021-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108040047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2021-07-23 20:09:14]:

> * Valentin Schneider <valentin.schneider@arm.com> [2021-07-13 17:32:14]:
> 
> > On 12/07/21 18:18, Srikar Dronamraju wrote:
> > > Hi Valentin,
> > >
> > >> On 01/07/21 09:45, Srikar Dronamraju wrote:
> > >> > @@ -1891,12 +1894,30 @@ void sched_init_numa(void)
> > >> >  void sched_domains_numa_masks_set(unsigned int cpu)
> > >> >  {
> > >

Hey Valentin / Peter

Did you get a chance to look at this?

-- 
Thanks and Regards
Srikar Dronamraju
