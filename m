Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A24543618B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhJUMZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:25:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231452AbhJUMZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:25:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LBfAQj009745;
        Thu, 21 Oct 2021 08:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=3h0s/Q4jO7CyjJ9vQgvE5C6x7tYfUNUnkTzGLorSCd8=;
 b=AzlvgaLe7tHFHsRy5fiLm60ZOwmqPc9Pe1tBUbbmo+JwYxV5stmE4j7al/qv5qBlgoh1
 JVm8OM+OTu2qFjgUERk2F+GGlyCoqgTgWj1FKnwHuCnYNDUMUt8DTGdLbMoqE3X/mGJJ
 kI58s9Pp53DuleSjlHDUBMXOR7c3BdtqLCeaQS4fscIPWytWsjy7H79kkAr5Ds79yIgQ
 sTTlhDnVZRDC7XXF8V6lnT6BL5SGUWH3Ct1xrq2UDG1Ti2ZhixkmZaPKm4stXceMZZKz
 5O4VD7CkSYqabk35SWrs1eojs36DFk61YrEXavYq8WNjJy5Cljre8kh5jhqIU/pCzD6b bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bty9ekjk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 08:22:58 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LAURXh016288;
        Thu, 21 Oct 2021 08:22:58 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bty9ekjjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 08:22:58 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LCDfLs026944;
        Thu, 21 Oct 2021 12:22:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3bqpcc3qa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 12:22:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LCGxaL53346744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 12:16:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB366A4066;
        Thu, 21 Oct 2021 12:22:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F37AA4065;
        Thu, 21 Oct 2021 12:22:51 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.79.186.49])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Oct 2021 12:22:50 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [V2] perf/core: Avoid calling perf_mux_hrtimer_restart multiple
 times when scheduling event groups
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <YW1ViqOYaVi8NnqE@hirez.programming.kicks-ass.net>
Date:   Thu, 21 Oct 2021 17:52:10 +0530
Cc:     Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maddy@linux.vnet.ibm.com" <maddy@linux.vnet.ibm.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "eranian@google.com" <eranian@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF5305ED-4A51-48D5-AB89-7E4A32DD3E7A@linux.vnet.ibm.com>
References: <20211015070403.4809-1-atrajeev@linux.vnet.ibm.com>
 <6E561141-B584-4DB8-A33E-BCD3FF572FA4@fb.com>
 <YW1ViqOYaVi8NnqE@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0Ngq8a3GaGe_pwSnNR8us3AHgeIu2Ih9
X-Proofpoint-GUID: jTnuwRJajPBaIRpRSjCg_tnejEk1sbkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_02,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 18-Oct-2021, at 4:37 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Sat, Oct 16, 2021 at 01:08:04AM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Oct 15, 2021, at 12:04 AM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>>>=20
>>> Perf uses multiplexing if there are more events to be scheduled than =
the
>>> available counters. With multiplexing, event groups will be rotated =
at
>>> specified interval of time which is set using "hrtimer". During =
event
>>> scheduling, if any of the event group fails to schedule, =
multiplexing
>>> gets enabled by setting "rotate_necessary" for that event context =
and
>>> starting the hrtimer by calling "perf_mux_hrtimer_restart".
>>>=20
>>> Patch adds an optimisation to avoid calling =
"perf_mux_hrtimer_restart"
>>> multiple times if already rotate_necessary is set for that context.
>>> Even though "perf_mux_hrtimer_restart" will just return if hrtimer =
is
>>> already active, this could avoid the overhead of calling this =
function
>>> multiple times if there are many event groups. Patch adds the check =
to
>>> avoid calling perf_mux_hrtimer_restart() for each event group on
>>> every schedule.
>>>=20
>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>=20
>> Acked-by: Song Liu <song@kernel.org>
>=20
> Thanks!

Thanks for checking the patch.

Hi Peterz,
Should I resend this patch with Acked-by or can you consider pulling it, =
if the patch looks fine to you.

Thanks
Athira.=
