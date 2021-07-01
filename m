Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A03B9157
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhGALxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:53:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37998 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236306AbhGALxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:53:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161BWr4h028347;
        Thu, 1 Jul 2021 07:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CojOA0Cd6D44w89fGful52nUI3MSzEEZZlqaey3DZ9E=;
 b=gOBbk0rP05XSU8lQ5OmAkivFJ6P7Wr+jSVsRakBGY2dRfWEpVdMfPtkjKqT8XENejFRu
 sWiBTeT10Ox0yqpIoclsXVEVzwIa8MOJTFER8L+LFbr3P8gTsY7oB0g7DNgst5elOWV5
 LqkVWJndzXy1cdbcvg60f7U2YcBCcX/tocxVet8u4RiZ5gKnUaMgNBL26km9bPwsStSM
 5FCQYptFIxPQWLG3KmSJiwBk3K0xLOEZrhhowOQzJRjptuykqZtItw2X/p0QyieddWto
 foKsYdEPaeo7EXP2kvdJWckkRUB0xJ+D3NmaD1I3QPoGgZNDivHouh5gaLbnyWznYR8N 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hc20278q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 07:51:06 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 161BX9Lc029817;
        Thu, 1 Jul 2021 07:51:05 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hc20277x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 07:51:05 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161BldrJ009847;
        Thu, 1 Jul 2021 11:51:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 39h19bgc81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:51:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161Bp1rN25625030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 11:51:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A4ECA235B;
        Thu,  1 Jul 2021 11:45:34 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.199.58.175])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 31079A2358;
        Thu,  1 Jul 2021 11:45:33 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH] sched/fair: Ensure _sum and _avg values stay consistent
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <CAFpoUr1mpErE1Soa05p36wL1uTeojQ2mqNLJ1GKVnpJ+x-3itw@mail.gmail.com>
Date:   Thu, 1 Jul 2021 17:15:31 +0530
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Message-Id: <C253482E-0B1E-4F38-92D6-6F00AFFA7DEF@linux.vnet.ibm.com>
References: <20210624111815.57937-1-odin@uged.al>
 <E16E71B3-E941-4522-AFF1-ABDF918FED19@linux.vnet.ibm.com>
 <20210701103448.GL3840@techsingularity.net>
 <CAFpoUr1mpErE1Soa05p36wL1uTeojQ2mqNLJ1GKVnpJ+x-3itw@mail.gmail.com>
To:     Odin Ugedal <odin@uged.al>,
        Mel Gorman <mgorman@techsingularity.net>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TZ7z7bYZq0gtBFQlY98jyY8oklaKIpDi
X-Proofpoint-ORIG-GUID: CBEB11oueOe_45huybhkWihmbwQs3sF3
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_07:2021-06-30,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107010075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 01-Jul-2021, at 4:39 PM, Odin Ugedal <odin@uged.al> wrote:
>=20
> tor. 1. jul. 2021 kl. 12:34 skrev Mel Gorman <mgorman@techsingularity.net=
>:
>>=20
>> What was HEAD when you checked this? 1c35b07e6d39 was merged in the
>> 5.14-rc1 merge window so would not be in 5.13.
>=20
> From the kernel log it looks like he used commit dbe69e433722
> (somewhere in Linus' tree), and that should include my patch. I don't
> think the patches from Vincent in the previous thread have been posted
> properly, and I think those can fix the edge case you are seeing.
>=20
Sorry about the confusion. Yes I am using this code level.

commit dbe69e43372212527abf48609aba7fc39a6daa27 (HEAD -> master, origin/mas=
ter, origin/HEAD)
Merge: a6eaf3850cb1 b6df00789e28
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jun 30 15:51:09 2021 -0700

This does contain the patch from Odin.

> This should mitigate some issues:
> https://lore.kernel.org/lkml/20210622143154.GA804@vingu-book/
>=20
> while
> https://lore.kernel.org/lkml/20210623071935.GA29143@vingu-book/
> might also help in some cases as well.
>=20
> Both of those are needed to make sure that *_avg is zero whenever *_sum i=
s zero.

Okay, so additional patches are required to fix this problem completely.
I can help test these.

Thanks
-Sachin

