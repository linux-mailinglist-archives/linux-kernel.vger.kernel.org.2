Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694FC3B9C21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 08:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhGBGSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 02:18:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229696AbhGBGSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 02:18:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 162643Eb015250;
        Fri, 2 Jul 2021 02:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=6nNY+BQbDuZz+Df2jshSXLz50v32o/fcEIK3qvuyHzY=;
 b=jTEHmqQWGy+WXH5YWrs/GorsRi0HI7c6IyU/4qa6L/JlmLx9u6lIdZJdrhg/l7vFwYHJ
 r9OcZj9yT2CnP9egEZH0QSUXAlbYKY75vAHRedFV3RDZSmn+tIXR7cZpamgAKKpipU7a
 PH72SAzbE1vULiskXKPH5SgoNVFN29JUWBkbm22ET0qkOCRqh1P/4lGJUq71lOKyXygo
 3hbfxmQb658mp4Qlw0R2/m0qZo8Wt8SY4iJy+m57ojvkiyIIVQh7unnLOBl28KRRSmMb
 PcRENlgJua6qIOTWEe37lHLEBpTQn054QiIslpQ6zEYKfnBKwKvjVCTxQrXXBwm7W2Hc 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hsddnc44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jul 2021 02:15:37 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 162659jt018395;
        Fri, 2 Jul 2021 02:15:37 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hsddnc36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jul 2021 02:15:36 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1626CYkg015048;
        Fri, 2 Jul 2021 06:15:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 39fv59rv0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jul 2021 06:15:34 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1626FWZ931719758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Jul 2021 06:15:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 004E311C04C;
        Fri,  2 Jul 2021 06:15:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE2AD11C05E;
        Fri,  2 Jul 2021 06:15:29 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.85.118.157])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Jul 2021 06:15:29 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] sched/fair: Sync load_sum with load_avg after dequeue
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20210701171837.32156-1-vincent.guittot@linaro.org>
Date:   Fri, 2 Jul 2021 11:45:28 +0530
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org, odin@uged.al
Content-Transfer-Encoding: quoted-printable
Message-Id: <DAABF914-F5D0-4C92-BFE0-341D83B9F3D0@linux.vnet.ibm.com>
References: <20210701171837.32156-1-vincent.guittot@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e9hIC05t5gA5h07m0DVC3tTYzGju2RzJ
X-Proofpoint-GUID: SmllJ8trSvHVjvdOGJp25MLpZ0rMpPSS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_15:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107020033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 01-Jul-2021, at 10:48 PM, Vincent Guittot =
<vincent.guittot@linaro.org> wrote:
>=20
> commit 9e077b52d86a ("sched/pelt: Check that *_avg are null when *_sum =
are")
> reported some inconsitencies between *_avg and *_sum.
>=20
> commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay =
consistent")
> fixed some but one remains when dequeuing load.
>=20
> sync the cfs's load_sum with its load_avg after dequeuing the load of =
a
> sched_entity.
>=20
> Fixes: 9e077b52d86a ("sched/pelt: Check that *_avg are null when *_sum =
are")
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>=20
> I have been able to trigger a WARN on my system even with the patch
> listed above. This patch fixes it.
> Sachin could you test that it also fixes yours ?
>=20

I ran various LTP stress tests, scheduler tests and kernel compile =
operation for about 5 hours.
Haven=E2=80=99t seen the warning during the testing.

Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

I have left the tests running, will let it run for few more hours.

Thanks
-Sachin

> kernel/sched/fair.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 11d22943753f..48fc7dfc2f66 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3037,8 +3037,9 @@ enqueue_load_avg(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
> static inline void
> dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
> {
> +	u32 divider =3D get_pelt_divider(&se->avg);
> 	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
> -	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * =
se->avg.load_sum);
> +	cfs_rq->avg.load_sum =3D cfs_rq->avg.load_avg * divider;
> }
> #else
> static inline void
> --=20
> 2.17.1
>=20

