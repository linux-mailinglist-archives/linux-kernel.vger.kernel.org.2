Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE33AB9CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 18:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFQQhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 12:37:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229671AbhFQQhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:37:22 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HGY2BW155142;
        Thu, 17 Jun 2021 12:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=/sPXZunF9nblcWygwPRcOY/gzNe54CJjCcPZXy/7Q14=;
 b=sh+MmPRP27VJgFWUbi02FtXTWQujsustk8cQKYQkmli600WK1WCJ+14e9tFXroikc86o
 +rkc4krTMOVcx2wb491sWUlGysg2U1ObWOpavB2sofLd0UtSvqP46i95lsX5yL3x/DDr
 m3CfMNgdmpd7cWzEskYS5/l6H7QTzEg9NryAx63MTB/uvspryVt7uxL3xK8ZxeAzwExL
 MWuVpsk/Jo1LSMOKw42IpZZIkFsUOE5TF898WiOgxvTamNJJFwdpl6u5BI8PAV8hiJX9
 5s4DLOX2hqd6gYICC+elqnrR8HKMFfonQWrau8apeoDZ6nW3PwVkggsiMKXNeS2qDwjX 6Q== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3988v1jfxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 12:34:41 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15HGScDB017338;
        Thu, 17 Jun 2021 16:34:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 395c3t9bbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 16:34:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15HGYaib25166228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 16:34:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A66142042;
        Thu, 17 Jun 2021 16:34:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8FFF42041;
        Thu, 17 Jun 2021 16:34:35 +0000 (GMT)
Received: from localhost (unknown [9.85.123.186])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jun 2021 16:34:35 +0000 (GMT)
Date:   Thu, 17 Jun 2021 22:04:34 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
        <1623777582.jsiokbdey1.naveen@linux.ibm.com>
        <20210616094622.c8bd37840898c67dddde1053@kernel.org>
        <20210615210351.602bc03e@rorschach.local.home>
        <20210616112711.ce318fc66b389038203331d1@kernel.org>
        <20210617001009.d5ae7b2edfdc34f4f8c19ab5@kernel.org>
In-Reply-To: <20210617001009.d5ae7b2edfdc34f4f8c19ab5@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1623946796.80yhllbpmp.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K0ijb9ok1twIhuZ83R2JmFplVvsnQ1v3
X-Proofpoint-ORIG-GUID: K0ijb9ok1twIhuZ83R2JmFplVvsnQ1v3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_14:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106170104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Wed, 16 Jun 2021 11:27:11 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>=20
>> On Tue, 15 Jun 2021 21:03:51 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>=20
>> > On Wed, 16 Jun 2021 09:46:22 +0900
>> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
>> >=20
>> > > To avoid such trouble, I had set the 4096 limitation for the maxacti=
ve
>> > > parameter. Of course 4096 may not enough for some use-cases. I'm wel=
come
>> > > to expand it (e.g. 32k, isn't it enough?), but removing the limitati=
on
>> > > may cause OOM trouble easily.
>> >=20
>> > What if you just made the max as 10 * number of possible cpus, or 4096=
,
>> > which ever is greater? Why would a user need more?
>>=20
>> It could be. But actually, that is not correct number because the
>> number of instances depends on the number of processes and the possiblit=
y
>> of recursive. Thus the huge system which runs more than 64k processes,
>> may need more than that.
>>=20
>> > I'd still like to get a wrapper around function graph tracing so that
>> > kretprobes could use it. I think that would get rid of the requirement
>> > of maxactive, because isn't that just used to have a way to know the
>> > original return value?
>>=20
>> Hmm, yes, on some arch, it can be done. But on other arch we still need
>> current implementation for generic solution.
>> What I need is not fully wrapped by the function graph, but just share
>> the per-task (software) shadow stack.
>=20
> BTW, I have 2 ideas to fix this except for wrapper.
>=20
> 1. Use func-graph tracer API directly from dynamic event instead of
>   kretprobes. This will be enabled only if the arch supports fgraph
>   tracer and enable it. maxactive will be ignored if this is enabled,
>   and tracefs user may not need except for the return value=20
>   (BTW, is that possible to access the stack? In some case, return
>   value can be passed via stack)
>=20
> 2. Move the kretprobe instance pool from kretprobe to struct task.
>   This pool will allocates one page per task, and shared among all
>   kretprobes. This pool will be allocated when the 1st kretprobe
>   is registered. maxactive will be kept for someone who wants to
>   use per-instance data. But since dynamic event doesn't use it,
>   it will be removed from tracefs and perf.

Won't this result in _more_ memory usage compared to what we have now?

Thanks,
Naveen

