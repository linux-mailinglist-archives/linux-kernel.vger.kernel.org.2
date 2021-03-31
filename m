Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864E13509EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhCaWDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:03:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbhCaWDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:03:31 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VLYOGV115406;
        Wed, 31 Mar 2021 18:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0s80tVd1/+xxWvcVo0goiNeMZ99Cty098sGMsWOUfWA=;
 b=gMd8e2A2WI19C72rRErzSgE+xcF0p/AHUSWZz7Y/rTUqBzK42r7yU4qaQBBRqWqwUpj9
 Ig24PhBcbsp6DpcFccAiTuak0Os9aobR9yPISnIE5g4sbSvp9pOBdAsVWAR6PZ0QMVpp
 afjV7zYV9NP8CuYGpNktfBCiz5sY6gpdBe+e7o6ao1PY+hEqQ5D9Stvu1saBfNayLr87
 h3k6GbLXes7nEyzcanRKgKc+HBUsZvF2ehG+S+YRc22zwXeBbRlaNPLPwrbzhiGQugFr
 lj4/ivczJeQzMiL6u2hpPTAFQeC9iGR8NCo0JUg7NG7d26kO235MJfDVl15jyE0jovON Bw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mnfte6wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 18:03:03 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12VM2UhQ007893;
        Wed, 31 Mar 2021 22:03:01 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 37marxggjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 22:03:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12VM2xM536766040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 22:02:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25143A4051;
        Wed, 31 Mar 2021 22:02:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA5F8A4040;
        Wed, 31 Mar 2021 22:02:58 +0000 (GMT)
Received: from localhost (unknown [9.171.77.178])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Mar 2021 22:02:58 +0000 (GMT)
Date:   Thu, 1 Apr 2021 00:02:57 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josef Bacik <jbacik@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: User stacktrace garbage when USER_STACKTRACE_SUPPORT is not
 enabled
Message-ID: <your-ad-here.call-01617228177-ext-4428@work.hours>
References: <your-ad-here.call-01617191565-ext-9692@work.hours>
 <20210331103749.01a7c283@gandalf.local.home>
 <your-ad-here.call-01617223875-ext-7005@work.hours>
 <20210331170900.5f41bcd7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210331170900.5f41bcd7@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xjcwSAf-x6Rd-Llh7mXPrt6UEX5AQwi1
X-Proofpoint-ORIG-GUID: xjcwSAf-x6Rd-Llh7mXPrt6UEX5AQwi1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_10:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0 mlxlogscore=980
 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 05:09:00PM -0400, Steven Rostedt wrote:
> On Wed, 31 Mar 2021 22:51:15 +0200
> Vasily Gorbik <gor@linux.ibm.com> wrote:
> 
> > It does! Thanks for the explanation and for the fix. I wonder why nobody
> > noticed and complained about that since v5.6.
> 
> Because it didn't lose data, just added extra junk.
> 
> > 
> > Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> 
> Want to give a "tested-by" too?

I only tested it on s390 (manually + ftrace selftest), quite frankly.
If it qualifies:

Tested-by: Vasily Gorbik <gor@linux.ibm.com> # s390 only
