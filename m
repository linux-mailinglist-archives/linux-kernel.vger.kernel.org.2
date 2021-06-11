Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1393A4398
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhFKN6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:58:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231944AbhFKN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:58:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15BDiXII108909;
        Fri, 11 Jun 2021 09:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=HRN5N6RZlQJDjs7/ssNMqWtrWKTO7YKHGKdUURSiIJ4=;
 b=f9o6CDMBk6l72UvJZHqsigw5LOsxhuaKAHblJoShjepl78ywtLCTCEdswkrTGimFFAd9
 UTz5WZWfl1DcjmAGjm1fB6tQ+L0bLNRNPDJF6/hUiKGazR58zHkjcVKQ17B/qhxaVU2k
 RC0gRj7DV06uKcCaTHQ9JVEYYV0rGM+NvBD0iKo7zaCu/XrbnMtuAqrd3GfDFJeDgfX/
 7IQ19f1GhaBr/eSnZp2J+qP57IfXlnLkQt305NmmamQenFzaW+wZx9y9By01fC4wYvdk
 dtATXSd36driOtsT21LKiVKaZfMbJZ82cqHa8I6BFkjzUXlz+JFOE/VE5uGhrV27zAtT dQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3948yqra12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 09:55:46 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15BDsAiL006344;
        Fri, 11 Jun 2021 13:55:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3900w8bfr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 13:55:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15BDtfto19530208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 13:55:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A30311C074;
        Fri, 11 Jun 2021 13:55:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1DE411C058;
        Fri, 11 Jun 2021 13:55:40 +0000 (GMT)
Received: from localhost (unknown [9.85.120.213])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Jun 2021 13:55:40 +0000 (GMT)
Date:   Fri, 11 Jun 2021 19:25:38 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610191643.d24e7d56d102567070fe8386@kernel.org>
In-Reply-To: <20210610191643.d24e7d56d102567070fe8386@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1623419180.o4u5xf72jm.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fihj06wMDXPi2FdFTFaRthoqWHgCElbJ
X-Proofpoint-GUID: Fihj06wMDXPi2FdFTFaRthoqWHgCElbJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-11_05:2021-06-11,2021-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,
Thanks for the review.


Masami Hiramatsu wrote:
> Hi Naveen,
>=20
> On Thu, 10 Jun 2021 14:26:17 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> When probing at different locations in the kernel, it is not always
>> evident if the location can be probed or not. As an example:
>>=20
>>     $ perf probe __radix__flush_tlb_range:35
>>     Failed to write event: Invalid argument
>>       Error: Failed to add events.
>>=20
>> The probed line above is:
>>      35         if (!mmu_has_feature(MMU_FTR_GTSE) && type =3D=3D FLUSH_=
TYPE_GLOBAL) {
>>=20
>> This ends up trying to probe on BUILD_BUG_ON(), which is rejected.
>> However, the user receives no indication at all as to why the probe
>> failed. Print an error in such cases so that it is clear that the probe
>> was rejected.
>=20
> Hmm, Nack for this way, but I understand that is a problem.
> If you got the error in perf probe, which uses ftrace dynamic-event inter=
face.
> In that case, the errors should not be output in the dmesg, but are repor=
ted
> via error_log in tracefs.

That would be a nice thing to add to perf, but I don't see why this=20
should be a either/or. I still think it is good to have the core kprobe=20
infrastructure print such errors in the kernel log. It is easier to look=20
up such error strings in the kernel source to understand why a probe was=20
rejected.

We also have perf_event_open() as an interface to add probes, and I=20
don't think it would be helpful to require all tools to utilize the=20
error log from tracefs for this purpose.


- Naveen

