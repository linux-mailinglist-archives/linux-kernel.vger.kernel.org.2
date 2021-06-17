Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08503AB974
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhFQQWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 12:22:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231398AbhFQQWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:22:32 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HG3dma189626;
        Thu, 17 Jun 2021 12:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=F5HZkYdoPrbKmEsIFVYZT1eVa6wqsaU0I1Vhjae1Gc0=;
 b=hqGy/20wcNEndULpqQnto222YzbZ7EGHC6rSST3DIE2RER6JKgftXmqmfPZaqOTBiE6a
 ifErFb2t6wSNRffp1XctdoWihmMaRsbOCnVQ7Oy1dw2CnDE+sERHTc1DXQ3Eay8gZjLX
 MIHcFqlWf8J6ioyC7seruWesaWg0m9J1TlOkaXA3AinIJHRJaNf0SUF/hPtojsTY+RQs
 fZOsa/oaK74SGJTTs93Yafi+YTWAOVfzU898hEn5uxOQQF5/TrmuD490myJDdwiX1WTx
 iEgsvHg6kSErpDMvSs4TWCELE9WiaiLlEvMHV5EeblyMkbtsR3yEmeZRTL3l43zs8GHm Bg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3988gftxcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 12:19:43 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15HGEWGk027958;
        Thu, 17 Jun 2021 16:19:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 394m6h9jub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 16:19:40 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15HGJcNd27984172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 16:19:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E28B11C04A;
        Thu, 17 Jun 2021 16:19:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C38411C04C;
        Thu, 17 Jun 2021 16:19:38 +0000 (GMT)
Received: from localhost (unknown [9.85.123.186])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jun 2021 16:19:37 +0000 (GMT)
Date:   Thu, 17 Jun 2021 21:49:36 +0530
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
In-Reply-To: <20210616094622.c8bd37840898c67dddde1053@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1623934820.8pqjdszq8o.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sLi7ZYYQk8qxIUnfjPWNgd9NCfvrhURf
X-Proofpoint-GUID: sLi7ZYYQk8qxIUnfjPWNgd9NCfvrhURf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_14:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Tue, 15 Jun 2021 23:11:27 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Masami Hiramatsu wrote:
>> > On Mon, 14 Jun 2021 23:33:29 +0530
>> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> >=20
>> >> We currently limit maxactive for a kretprobe to 4096 when registering
>> >> the same through tracefs. The comment indicates that this is done so =
as
>> >> to keep list traversal reasonable. However, we don't ever iterate ove=
r
>> >> all kretprobe_instance structures. The core kprobes infrastructure al=
so
>> >> imposes no such limitation.
>> >>=20
>> >> Remove the limit from the tracefs interface. This limit is easy to hi=
t
>> >> on large cpu machines when tracing functions that can sleep.
>> >>=20
>> >> Reported-by: Anton Blanchard <anton@ozlabs.org>
>> >> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> >=20
>> > OK, but I don't like to just remove the limit (since it can cause
>> > memory shortage easily.)
>> > Can't we make it configurable? I don't mean Kconfig, but=20
>> > tracefs/options/kretprobe_maxactive, or kprobes's debugfs knob.
>> >=20
>> > Hmm, maybe debugfs/kprobes/kretprobe_maxactive will be better since
>> > it can limit both trace_kprobe and kprobes itself.
>>=20
>> I don't think it is good to put a new tunable in debugfs -- we don't=20
>> have any kprobes tunable there, so this adds a dependency on debugfs=20
>> which shouldn't be necessary.
>>=20
>> /proc/sys/debug/ may be a better fit since we have the=20
>> kprobes-optimization flag to disable optprobes there, though I'm not=20
>> sure if a new sysfs file is agreeable.
>=20
> Indeed.
>=20
>> But, I'm not too sure this really is a problem. Maxactive is a user=20
>> _opt-in_ feature which needs to be explicitly added to an event=20
>> definition. In that sense, isn't this already a tunable?
>=20
> Let me explain the background of the limiation.

Thanks for the background on this.

>=20
> Maxactive is currently no limit for the kprobe kernel module API,
> because the kernel module developer must take care of the max memory
> usage (and they can).
>=20
> But the tracefs user may NOT have enough information about what
> happens if they pass something like 10M for maxactive (it will consume
> around 500MB kernel memory for one kretprobe).

Ok, thinking more about this...

Right now, the only way for a user to notice that kretprobe maxactive is=20
an issue is by looking at kprobe_profile.  This is not even possible if=20
using a bcc tool, which uses perf_event_open().  It took the reporting=20
team some effort to even identify that the reason why they were getting=20
weird results when tracing was due to the default value used for=20
kretprobe maxactive; and then that 4096 was the hard limit through=20
tracefs.

So, IMO, anyone using any existing bcc tool, or a pre-canned perf script=20
will not even be able to identify this as a problem to begin with... at=20
least, not without some effort.

To address this, as a first step, we should probably consider parsing=20
kprobe_profile and printing a warning with 'perf' if we detect a=20
non-zero miss count for a probe -- both a regular probe, as well as a=20
retprobe.

If we do this, the nice thing with kprobe_profile is that the probe miss=20
count is available, and can serve as a good way to decide what a more=20
reasonable maxactive value should be. This should help prevent users=20
from trying with arbitrary maxactive values.

For perf_event_open(), perhaps we can introduce an ioctl to query the=20
probe miss count.

>=20
> To avoid such trouble, I had set the 4096 limitation for the maxactive
> parameter. Of course 4096 may not enough for some use-cases. I'm welcome
> to expand it (e.g. 32k, isn't it enough?), but removing the limitation
> may cause OOM trouble easily.

Do you have suggestions for how we can determine a better limit? As you=20
point out in the other email, there could very well be 64k or more=20
processes on a large machine. Since the primary concern is memory usage,=20
we probably need to decide this based on total memory. But, memory usage=20
will vary depending on system load...

Perhaps we can start by making maxactive limit be a tunable with a=20
default value of 4096, with the understanding that users will be careful=20
when bumping up this value. Hopefully, scripts won't simply start=20
writing into this file ;)

If we can feed back the probe miss count, tools should be able to guide=20
users on what would be a reasonable maxactive value to use.


Thanks,
Naveen

