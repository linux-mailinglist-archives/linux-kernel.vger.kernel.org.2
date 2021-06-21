Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004923AE624
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFUJjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:39:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230157AbhFUJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:39:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15L9XqwC105046;
        Mon, 21 Jun 2021 05:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=4ZEyiBsbMbK1xEA4DpKUJ+TBbAvfCUs1ViNugB8goc0=;
 b=L/APn20XlVkCqViWjr2G7rUk6gwh4bzGrjl3dwluunEj8XCNQGrZj/c6wM1Ci2pN1GAv
 4WjAWWg8EQbU+wIXzCZGt+E3rm+9YuGH2Dab9dl3DhFR2gzT2Ycm/zXr2GJ8b66Bh/tQ
 iClc4Xb/QwWuSMhl+uYgbWFV8s3LiTpHhrEiozlRoVScueT0dDcl7KUDRnfgUTQww0Lq
 N/d84eTAWo7Dgtq47oOfccOf+VtOuS8nwSbm+GF9JVu/6IiC+3+KAi9pdALDBVRoP2Hq
 lprFY1QJci76hExmQTDQK/AMInyGFqzj6TbMddYFqEUyy65jeks7Ci74TsnXY+sh1onL nA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39aqh81e3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 05:36:31 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15L9XSkk023046;
        Mon, 21 Jun 2021 09:36:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3997uh8swr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 09:36:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15L9aRI933751526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 09:36:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDB86A405F;
        Mon, 21 Jun 2021 09:36:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75229A4054;
        Mon, 21 Jun 2021 09:36:26 +0000 (GMT)
Received: from localhost (unknown [9.85.73.168])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jun 2021 09:36:26 +0000 (GMT)
Date:   Mon, 21 Jun 2021 15:06:24 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, acme@kernel.org
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610191643.d24e7d56d102567070fe8386@kernel.org>
        <1623419180.o4u5xf72jm.naveen@linux.ibm.com>
        <20210611154021.008537b0@gandalf.local.home>
        <1623684632.0k2j6ky7k3.naveen@linux.ibm.com>
        <20210619011516.dadbd24e27996bae62fd288f@kernel.org>
In-Reply-To: <20210619011516.dadbd24e27996bae62fd288f@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1624266910.z97eue1i84.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2EEMzyilULTXk8SqlGrIbdodLq2zblMw
X-Proofpoint-GUID: 2EEMzyilULTXk8SqlGrIbdodLq2zblMw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_03:2021-06-20,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106210055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Masami Hiramatsu wrote:
> Hi Naveen,
>=20
> On Mon, 14 Jun 2021 21:00:52 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Steven Rostedt wrote:
>> > On Fri, 11 Jun 2021 19:25:38 +0530
>> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> >=20
>> >> We also have perf_event_open() as an interface to add probes, and I=20
>> >> don't think it would be helpful to require all tools to utilize the=20
>> >> error log from tracefs for this purpose.
>> >=20
>> > The there should be a perf interface to read the errors. I agree with
>> > Masami. Let's not have console logs for probe errors.
>>=20
>> Ok, understood.
>=20
> Will you update this?

Not sure if you are asking about error logging with perf_event_open(),=20
or about reading error_log from tracefs.

For perf_event_open(), I think we will just need to return the error=20
code, and interpret the return value in userspace. I don't think there=20
is any other way to pass error log or strings back from the kernel.

I will update this series to return the correct return value as=20
suggested.


Thanks,
Naveen

