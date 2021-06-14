Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB8D3A6A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhFNPk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:40:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56600 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233640AbhFNPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:40:24 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EFXQtl088641;
        Mon, 14 Jun 2021 11:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=VRJQggokzMxi018JzfgHujzoEYW9vFExxBrtqzRnA/s=;
 b=fthOb+SNlhLbK30ImY+qIBrFMb5hLzUj6LfggKDOfqZCyjGgBexVnOcgQInf8w94EU52
 UiQ/TMe8eh42LBpisJr9atxZlvF/AuRUIhLRFgxzAVuhPB7mR5xcGK96krjjZyP3eR/A
 8QBXLS7wBD7vCI3IbOKhc3S7su8S5rVD5sdia7GchhgothNIYA9gCI4/hiq5U39qavkH
 HQCztg18+fg/vvdMP4p08IvQIRSF6JTmT/EIAIt0+5qGT0JOfKHl0LR6LGDRMDRDcCCS
 f9wBvHLDj4XFhksIs61ULsamS2wuxTYsRLh7NxE1rD7ssZsBmnvGptKwcFdX13dAMbEZ MA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39697j1gdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 11:37:47 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15EFGJuR012143;
        Mon, 14 Jun 2021 15:37:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 394mj90jas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 15:37:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15EFahfG33358310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 15:36:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E35DAE055;
        Mon, 14 Jun 2021 15:37:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7D8CAE053;
        Mon, 14 Jun 2021 15:37:41 +0000 (GMT)
Received: from localhost (unknown [9.85.73.215])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 15:37:41 +0000 (GMT)
Date:   Mon, 14 Jun 2021 21:07:40 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610191643.d24e7d56d102567070fe8386@kernel.org>
        <1623419180.o4u5xf72jm.naveen@linux.ibm.com>
        <20210612101347.a8e317344b0e6380d41f1cfe@kernel.org>
In-Reply-To: <20210612101347.a8e317344b0e6380d41f1cfe@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1623684669.fagfzw6pyl.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CuoBVcRbukoNLsqkZ6NxJhSJu6mcCjeJ
X-Proofpoint-ORIG-GUID: CuoBVcRbukoNLsqkZ6NxJhSJu6mcCjeJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_10:2021-06-14,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> Hi Naveen,
>=20
> On Fri, 11 Jun 2021 19:25:38 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Hi Masami,
>> Thanks for the review.
>>=20
>>=20
>> Masami Hiramatsu wrote:
>> > Hi Naveen,
>> >=20
>> > On Thu, 10 Jun 2021 14:26:17 +0530
>> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> >=20
>> >> When probing at different locations in the kernel, it is not always
>> >> evident if the location can be probed or not. As an example:
>> >>=20
>> >>     $ perf probe __radix__flush_tlb_range:35
>> >>     Failed to write event: Invalid argument
>> >>       Error: Failed to add events.
>> >>=20
>> >> The probed line above is:
>> >>      35         if (!mmu_has_feature(MMU_FTR_GTSE) && type =3D=3D FLU=
SH_TYPE_GLOBAL) {
>> >>=20
>> >> This ends up trying to probe on BUILD_BUG_ON(), which is rejected.
>> >> However, the user receives no indication at all as to why the probe
>> >> failed. Print an error in such cases so that it is clear that the pro=
be
>> >> was rejected.
>> >=20
>> > Hmm, Nack for this way, but I understand that is a problem.
>> > If you got the error in perf probe, which uses ftrace dynamic-event in=
terface.
>> > In that case, the errors should not be output in the dmesg, but are re=
ported
>> > via error_log in tracefs.
>>=20
>> That would be a nice thing to add to perf, but I don't see why this=20
>> should be a either/or. I still think it is good to have the core kprobe=20
>> infrastructure print such errors in the kernel log.
>=20
> Yes, but that is only when if there is any unexpected errors.
>=20
> For the expected error (e.g. rejecting user input), the design policy is
> - kprobes API should return correct error code.
> - kprobe tracefs I/F should return correct error code and put a human
>   readable error mesage in the error_log.
> Thus, the perf probe should decode the error code or reuse the error_log.
>=20
>> It is easier to look=20
>> up such error strings in the kernel source to understand why a probe was=
=20
>> rejected.
>=20
> I don't like to put a log message for rejecting user input on dmesg anymo=
re.

Understood.

>=20
>=20
>> We also have perf_event_open() as an interface to add probes, and I=20
>> don't think it would be helpful to require all tools to utilize the=20
>> error log from tracefs for this purpose.
>=20
> No, perf probe doesn't use perf-event interface to add probes. It uses
> the tracefs for adding probes.

Yes, but I was referring to some of the bpf tools (bcc) that now use=20
perf_event_open() interface.


Thanks,
Naveen

