Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA533B3073
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhFXNvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:51:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17628 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231405AbhFXNvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:51:14 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ODWwaD016438;
        Thu, 24 Jun 2021 09:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=N455BUTjpf71iv1l8JoIEFYzXp+Fe2eQfoCt7EG6fUk=;
 b=fE4kdTOmnuH3pyPtRWkhiRuZVRivklyOEwqEjJwsNTbQyAENYxJwRNqRoOsJYOe8PlZ0
 Kt0EEYf1TGX8s3KNY6SBfrny5511Fif8aD34ZV8pstys6XgWnKUmgmIYXSKE/C8PWFL6
 qy2dP+YAxVwK6/puqTIa/ZgPTQ2FYAkzuivHLOM9OmG+/Kw1tzT1vLZryYY1HtBkai/C
 pP43fo29ZI82Ffcv0B2m2jURdqtbOTOJXCTGSCcqWWi2GbVkd1GbpDR9Ius4uKUD5whm
 mfSYSFoyCKnaHizHBXdeI9vgPHVTEeo10JWdg4I5yhlLvX+/bzhbqqBs7QHiqiucVpRu Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ctbtt5hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 09:48:17 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15ODXApg017384;
        Thu, 24 Jun 2021 09:48:16 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ctbtt5gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 09:48:16 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15ODmFuL003128;
        Thu, 24 Jun 2021 13:48:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3998789eax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 13:48:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15ODmCS434996534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 13:48:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90617A4040;
        Thu, 24 Jun 2021 13:48:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B32CA404D;
        Thu, 24 Jun 2021 13:48:10 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.102.30.53])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Jun 2021 13:48:10 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH] sched/fair: Ensure _sum and _avg values stay consistent
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20210624111815.57937-1-odin@uged.al>
Date:   Thu, 24 Jun 2021 19:18:09 +0530
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Message-Id: <5EA7BE86-F610-424F-B443-69C87944E48A@linux.vnet.ibm.com>
References: <20210624111815.57937-1-odin@uged.al>
To:     Odin Ugedal <odin@uged.al>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DT7KN5PCDIdhRgMWDmXHEE0NEhPqxhcS
X-Proofpoint-ORIG-GUID: andZG3ch7CYG3m-LpLEJVyj3X6WqY5EM
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_11:2021-06-24,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106240074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 24-Jun-2021, at 4:48 PM, Odin Ugedal <odin@uged.al> wrote:
>=20
> The _sum and _avg values are in general sync together with the PELT
> divider. They are however not always completely in perfect sync,
> resulting in situations where _sum gets to zero while _avg stays
> positive. Such situations are undesirable.
>=20
> This comes from the fact that PELT will increase period_contrib, also
> increasing the PELT divider, without updating _sum and _avg values to
> stay in perfect sync where (_sum =3D=3D _avg * divider). However, such PE=
LT
> change will never lower _sum, making it impossible to end up in a
> situation where _sum is zero and _avg is not.
>=20
> Therefore, we need to ensure that when subtracting load outside PELT,
> that when _sum is zero, _avg is also set to zero. This occurs when
> (_sum < _avg * divider), and the subtracted (_avg * divider) is bigger
> or equal to the current _sum, while the subtracted _avg is smaller than
> the current _avg.
>=20
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Odin Ugedal <odin@uged.al>
> ---
>=20

Thank You for the fix. Works for me.

Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

Thanks
-Sachin

> Reports and discussion can be found here:
>=20
> https://lore.kernel.org/lkml/2ED1BDF5-BC0C-47CD-8F33-9A46C738F8CF@linux.v=
net.ibm.com/
> https://lore.kernel.org/lkml/CA+G9fYsMXELmjGUzw4SY1bghTYz_PeR2diM6dRp2J37=
bBZzMSA@mail.gmail.com/
>=20
> kernel/sched/fair.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bfaa6e1f6067..def48bc2e90b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3688,15 +3688,15 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cf=
s_rq)
>=20
> 		r =3D removed_load;
> 		sub_positive(&sa->load_avg, r);
> -		sub_positive(&sa->load_sum, r * divider);
> +		sa->load_sum =3D sa->load_avg * divider;
>=20
> 		r =3D removed_util;
> 		sub_positive(&sa->util_avg, r);
> -		sub_positive(&sa->util_sum, r * divider);
> +		sa->util_sum =3D sa->util_avg * divider;
>=20
> 		r =3D removed_runnable;
> 		sub_positive(&sa->runnable_avg, r);
> -		sub_positive(&sa->runnable_sum, r * divider);
> +		sa->runnable_sum =3D sa->runnable_avg * divider;
>=20
> 		/*
> 		 * removed_runnable is the unweighted version of removed_load so we
> --=20
> 2.32.0
>=20

