Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFAF30D810
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhBCLBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:01:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233508AbhBCLBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:01:19 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 113AVS9c000907;
        Wed, 3 Feb 2021 06:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=GDYq4I+T5EpQpfmBYOVPSoNRRZobwHssNzSwI/bSDyA=;
 b=W8GLfKg5jLk25fgAwv6sP5GP8Oc5u5/6hQiXdbxf5V/XH0sKWEeAkYoo6dO1VFiOXKS4
 RMh6OWqLyG1l/O40ZSaGJfWt1n4wocLlf0SFOp7coXHtbRjJXY9KwqloMNQr6DqEPPxB
 6HV0MCkvzniUQGzEcfNEZiQvRij/6KwzSnlXF1W3ek2wDkhJF0tAeokxMZX3D8m4H4Sm
 jjEtu2HW67WKWJPt8a6Q2Rf3HV5h7GvhNLq+K/egEe5TN4637hsMMnoF7GPmWHETvNg9
 nsXoOT/0DeJY/2B4Bts4fp8go4i4RGueHf6H+GWkZ7hz+WV5SbFapdWdTVq7+MyJSMC2 lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36fsncsvq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 06:00:03 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 113Ak0SV060791;
        Wed, 3 Feb 2021 06:00:03 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36fsncsvnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 06:00:03 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 113AwA50009326;
        Wed, 3 Feb 2021 11:00:01 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 36cy381yu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 11:00:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 113AxxNP48365846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Feb 2021 10:59:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E965411C052;
        Wed,  3 Feb 2021 10:59:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85ABC11C050;
        Wed,  3 Feb 2021 10:59:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  3 Feb 2021 10:59:56 +0000 (GMT)
Date:   Wed, 3 Feb 2021 16:29:55 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] sched/topology: Switch to sched_debug() for conditional
 sched domain printk
Message-ID: <20210203105955.GF1239129@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210203042010.799-1-zbestahu@gmail.com>
 <20210203095256.vzduw2gpcpum6a7g@linux.vnet.ibm.com>
 <20210203181019.00007024.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210203181019.00007024.zbestahu@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_04:2021-02-03,2021-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yue Hu <zbestahu@gmail.com> [2021-02-03 18:10:19]:

> On Wed, 3 Feb 2021 15:22:56 +0530
> Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:
> 
> > * Yue Hu <zbestahu@gmail.com> [2021-02-03 12:20:10]:
> > 
> > 
> > sched_debug() would only be present in CONFIG_SCHED_DEBUG. Right?
> > In which case there would be a build failure with your change in
> > !CONFIG_SCHED_DEBUG config.
> > 
> > or Am I missing something?
> 
> sched_debug() is also defined for !CONFIG_SCHED_DEBUG as below:
> 
> static inline bool sched_debug(void)
> {
> 	return false;
> }
> 

ah .. right .. somehow I missed this. 

-- 
Thanks and Regards
Srikar Dronamraju
