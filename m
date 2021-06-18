Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290543AC658
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhFRIoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:44:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233129AbhFRIoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:44:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I8YW21042057;
        Fri, 18 Jun 2021 04:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=VzJZbU24UjaUkIsDGeUDG6u7Ex4eYhsh7hI8VLLst/I=;
 b=KTBcKPLHsVx1QK/sD6YtOlnx8WXv3qiXwrmW8yViVX8uQV+OxxPVviiadUGzHX3eEe9e
 eCyZYUI8Zg+IhuIdfcgZ9S87FSwrweVt2c3PIdj2itjBysA1x0YbdjFpp1fDWd2Nni8T
 oLbcn3JFc4cEwsHLtPcXHDqjRJCviun7+fqZOv/qurkUjzRl61jZHjzFD5pPvqG8MQ5e
 3MjQJ15arw4Rg4Tx5ReYraNekeGQKkoldU9ptjAXgOoLfp0HlzLj9m+uso0i2aWa3TBv
 W/unZIJmQk2YV5iHNhpIqnrXsBpkT8lnvyBWZoUUraz+9iE0G5J3AEUqkWpe2b49gnjl pw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 398ph7ju4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 04:41:19 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15I8Wutu021245;
        Fri, 18 Jun 2021 08:41:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3966jph8he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 08:41:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15I8fFoC15532480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 08:41:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FF184C046;
        Fri, 18 Jun 2021 08:41:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41F8C4C044;
        Fri, 18 Jun 2021 08:41:14 +0000 (GMT)
Received: from localhost (unknown [9.85.125.40])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 08:41:13 +0000 (GMT)
Date:   Fri, 18 Jun 2021 14:11:12 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
        <1623777582.jsiokbdey1.naveen@linux.ibm.com>
        <20210616094622.c8bd37840898c67dddde1053@kernel.org>
        <20210615210351.602bc03e@rorschach.local.home>
        <20210616112711.ce318fc66b389038203331d1@kernel.org>
        <20210617001009.d5ae7b2edfdc34f4f8c19ab5@kernel.org>
        <1623946796.80yhllbpmp.naveen@linux.ibm.com>
        <20210617130713.194a7152@gandalf.local.home>
        <20210618132636.ceef49ba0fd01bd26508f672@kernel.org>
In-Reply-To: <20210618132636.ceef49ba0fd01bd26508f672@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1624005597.xbhcy9xr3f.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FPQT2sqVzapU3jqnRHEZ39pEZIE49PBl
X-Proofpoint-GUID: FPQT2sqVzapU3jqnRHEZ39pEZIE49PBl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_17:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106180048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Thu, 17 Jun 2021 13:07:13 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>> On Thu, 17 Jun 2021 22:04:34 +0530
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>>=20
>> > > 2. Move the kretprobe instance pool from kretprobe to struct task.
>> > >   This pool will allocates one page per task, and shared among all
>> > >   kretprobes. This pool will be allocated when the 1st kretprobe
>> > >   is registered. maxactive will be kept for someone who wants to
>> > >   use per-instance data. But since dynamic event doesn't use it,
>> > >   it will be removed from tracefs and perf. =20
>> >=20
>> > Won't this result in _more_ memory usage compared to what we have now?
>>=20
>> Maybe or maybe not. At least with this approach (or the function graph
>> one), you will allocate enough for the environment involved. If there's
>> thousands of tasks, then yes, it will allocate more memory. But if you a=
re
>> running thousands of tasks, you should have a lot of memory in the machi=
ne.
>>=20
>> If you are only running a few tasks, it will be less than the current
>> approach.
>=20
> Right, this depends on how many tasks you are running on your machine.
> Anyway, since you may not sure how much maxactive is enough, you will
> set maxactive high, then it can consume more than that. Of course you
> can optimize by trial and error. But that does not guarantee all cases,
> because the number of tasks can be increased while tracing. You might
> need to re-configure it by checking the nmissed count again.

Yes. If we go down this route, we should limit the per-task allocation=20
to a more reasonable 4k -- powerpc uses 64k pages.

Thanks,
Naveen

