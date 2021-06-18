Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C766D3ACBFC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhFRNV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:21:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230438AbhFRNV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:21:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IDELW1144638;
        Fri, 18 Jun 2021 09:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=9WElNsztdLIBuwZhmn5+RVyTutN8t+G6ITl/P1IAki4=;
 b=LUV/HaJAwQGDZkUNr1HwggM2nvwSNlEa6qOmULiyTy0PEParjMragq04c1fqnB42vxo9
 zOH1bborShoIq7ufGY5z8AnFEPdhAAGCEBEQZBKL7UzRj8HVJIPxGm/nSr3T29WUAogl
 Kam6Sh2tJgJ7r6uyMgInozIRhmZZn06hkgSWXOx0YW00e4QC1q8AeegJZbdJZvKmsyFb
 iYc49llBxlF/Fxv7OKMaBSIYLD4uLLJEAAMPeeNefq39vtuYBBiFGhVjIZQbo4t4XRvo
 OFpLwAtFAT+kre/JEZqIy3Ujt1cj3Z6OGilrKo4JBcqDZpq7QzbrGVwNNd0bXLfQbMwE 0Q== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398v6pr5mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 09:19:13 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IDDXur019989;
        Fri, 18 Jun 2021 13:19:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 394mj8sud7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 13:19:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IDJ8eI15991224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 13:19:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81DB411C04C;
        Fri, 18 Jun 2021 13:19:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE87611C050;
        Fri, 18 Jun 2021 13:19:07 +0000 (GMT)
Received: from localhost (unknown [9.85.125.40])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 13:19:07 +0000 (GMT)
Date:   Fri, 18 Jun 2021 18:49:06 +0530
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
        <1623934820.8pqjdszq8o.naveen@linux.ibm.com>
        <20210618151714.3ae6528eba99eea39771b859@kernel.org>
In-Reply-To: <20210618151714.3ae6528eba99eea39771b859@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1624005747.j7xp8o9byl.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vmVOML3UhC9mUH7mzjlYJWidem2_7ICh
X-Proofpoint-GUID: vmVOML3UhC9mUH7mzjlYJWidem2_7ICh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_07:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
>=20
>> To address this, as a first step, we should probably consider parsing=20
>> kprobe_profile and printing a warning with 'perf' if we detect a=20
>> non-zero miss count for a probe -- both a regular probe, as well as a=20
>> retprobe.
>=20
> Yeah, it is doable. Note that perf-probe only set up the event and
> perf-trace or other commands will use it.
>=20
>=20
>> If we do this, the nice thing with kprobe_profile is that the probe miss=
=20
>> count is available, and can serve as a good way to decide what a more=20
>> reasonable maxactive value should be. This should help prevent users=20
>> from trying with arbitrary maxactive values.
>=20
> Such feedback loop is an interesting idea.
> Note that nmissed count is an accumulate value, not the max number of
> the instance which will be needed.

Yes, we will have to factor-in the duration during which the event was=20
active. This will still be an approximation, but serves as a good=20
starting point. It may need a few tries to get this right, but more
importantly, the user knows instantly that there are missed probes.

>=20
>> For perf_event_open(), perhaps we can introduce an ioctl to query the=20
>> probe miss count.
>=20
> Or, maybe we can expand the maxactive in runtime. e.g. add a shortage
> counter on the kretprobe, and run a monitor kernel thread (or kworker).
> If the shortage counter is incremented, the monitor allocates instances
> (2x counter) and give it to the kretprobe. And it resets the shortage
> counter. This adaptive maxactive may cause mis-hit in the beginning,
> but finally find the optimal maxactive value automatically.

I like this idea and I have been thinking along these lines too. If we=20
start with a better default (rather than just num_possible_cpus() used=20
today), I suspect we may be able to get this to work well enough to not=20
have to miss any probes. Specifying 'maxactive' can still serve as a=20
workaround to allocate a larger initial set of kretprobe_instances in=20
case this doesn't work.

>=20
>=20
>> > To avoid such trouble, I had set the 4096 limitation for the maxactive
>> > parameter. Of course 4096 may not enough for some use-cases. I'm=20
>> > welcome
>> > to expand it (e.g. 32k, isn't it enough?), but removing the limitation
>> > may cause OOM trouble easily.
>>=20
>> Do you have suggestions for how we can determine a better limit? As you=20
>> point out in the other email, there could very well be 64k or more=20
>> processes on a large machine. Since the primary concern is memory usage,=
=20
>> we probably need to decide this based on total memory. But, memory usage=
=20
>> will vary depending on system load...
>=20
> This is very good question. IMHO, it might better to calculate the total
> maxactive from the system memory size. For example, 1% of system memory
> can be used for the kretprobes, 16GB system will allow using 160MB for
> kretprobes, which means about "30M" is the max number of maxactive, or
> multiple kretprobes can share it. Doesn't it sound enough? Of course
> this will need to show the current usage of the kretprobe instance object=
s
> via tracefs or debugfs. But this total cap seems reasonable for me to
> avoid OOM trouble.
>=20
>> Perhaps we can start by making maxactive limit be a tunable with a=20
>> default value of 4096, with the understanding that users will be careful=
=20
>> when bumping up this value. Hopefully, scripts won't simply start=20
>> writing into this file ;)
>=20
> Yeah, that's what I suggested at first, because the best maxactive will
> depend on the max number of the *processes* and the probed function.
>=20
> If the probed function will NOT be preempted or slept, maxactive will be
> the number of *processor cores*. Or, if it can be preempted or slept, it
> will be the max number of *processes*. If the probed function can
> recursively called (Note: this is rare case), the maxactive has to
> be multiplied.
>=20
> It is hard to estimate the max number of processes, since it depends
> on the system. Small embedded systems don't run thousands of processes,
> but big servers will run more than ten thousands of processes.
> Thus make it tunable will be a good idea.

Agree.


Thanks,
Naveen

