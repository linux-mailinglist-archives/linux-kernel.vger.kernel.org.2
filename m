Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6023A87E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhFORoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:44:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231405AbhFORoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:44:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FHYKRW027726;
        Tue, 15 Jun 2021 13:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=hQ5yfa7ZmNNvxQU7HdEd2DusJShKN88IYrn11BzDBNQ=;
 b=Upbp/cBCfMHObvtVDu4iCUS9EPJrtscIeZInMx+LWXvP54YiQyrBt/dTGveB+APCXekE
 O6O+18TWirHSMU75tdSkYhs0I7XJcFuPwAirewubogRaaH15rVqcZbjThHUv7StRzwW4
 CuVd+oTYRSEALB69dVJibkPpON56/eZU1SrMMGEf93K+4JJRA+LMyo3sEYTjN0HC6Tie
 cbJckHXHGkPLYTUN+vrp1FpDMhHnSQTFdJJpnENMUCJuSUyqG3rqSsTRG12lEzvwnX69
 A9r8E8IOd+oPqNx84ZhB4bZqE9tIWWc6YC5+gGEgJsg0FqFKcBughoCXLEXvUcZE9H4f Vw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39702ushes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 13:41:36 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15FHWPbq030596;
        Tue, 15 Jun 2021 17:41:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 394mj8smnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 17:41:34 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15FHeOfx30278084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 17:40:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C97FAE051;
        Tue, 15 Jun 2021 17:41:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBE8DAE053;
        Tue, 15 Jun 2021 17:41:28 +0000 (GMT)
Received: from localhost (unknown [9.85.114.12])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Jun 2021 17:41:28 +0000 (GMT)
Date:   Tue, 15 Jun 2021 23:11:27 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
In-Reply-To: <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1623777582.jsiokbdey1.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RINidExqPA0w3Etzkgz8NmAFiaa8TY7e
X-Proofpoint-GUID: RINidExqPA0w3Etzkgz8NmAFiaa8TY7e
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_07:2021-06-15,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Mon, 14 Jun 2021 23:33:29 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> We currently limit maxactive for a kretprobe to 4096 when registering
>> the same through tracefs. The comment indicates that this is done so as
>> to keep list traversal reasonable. However, we don't ever iterate over
>> all kretprobe_instance structures. The core kprobes infrastructure also
>> imposes no such limitation.
>>=20
>> Remove the limit from the tracefs interface. This limit is easy to hit
>> on large cpu machines when tracing functions that can sleep.
>>=20
>> Reported-by: Anton Blanchard <anton@ozlabs.org>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>=20
> OK, but I don't like to just remove the limit (since it can cause
> memory shortage easily.)
> Can't we make it configurable? I don't mean Kconfig, but=20
> tracefs/options/kretprobe_maxactive, or kprobes's debugfs knob.
>=20
> Hmm, maybe debugfs/kprobes/kretprobe_maxactive will be better since
> it can limit both trace_kprobe and kprobes itself.

I don't think it is good to put a new tunable in debugfs -- we don't=20
have any kprobes tunable there, so this adds a dependency on debugfs=20
which shouldn't be necessary.

/proc/sys/debug/ may be a better fit since we have the=20
kprobes-optimization flag to disable optprobes there, though I'm not=20
sure if a new sysfs file is agreeable.


But, I'm not too sure this really is a problem. Maxactive is a user=20
_opt-in_ feature which needs to be explicitly added to an event=20
definition. In that sense, isn't this already a tunable?


- Naveen

