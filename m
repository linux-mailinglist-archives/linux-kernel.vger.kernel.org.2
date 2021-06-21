Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2BE3AE64B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFUJm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:42:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6160 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhFUJmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:42:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15L9XXk3020386;
        Mon, 21 Jun 2021 05:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=E8QS2SI8nZorl7Spwf50uyddtVQOnPoeiT4M4UMBtec=;
 b=nGdqsqJ65PLrruaStrm2//s0qFrbgxMxnZbp83B/hKGEkb10QlpRQcoUjGYg2fBTHorl
 Ni967fToZ8WbjxycGYnafKFQ8CS0LQ0CynnR1IjQBlXQZfUc9KP8EFGYA6eFAQyhNC0u
 9o3VlmsCXirPpQ9+Y2EmNtV5mffVG9AtIgJwqDxapmiScSEd78XLgffte0KxJCkEnaGj
 DIud/QsiPJZ5iMQDYrkSFjoU3qTX0f7saNZOu1cCekvctbf168rQwU6Clzuron+YcWS3
 7fPYGonqDi7ZyPF4eaIXoJHqTb4ICo8uwVuwgKWaPS64NwM/FcEV0VKc5wZNK7OQPBBz lA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39aq86a2gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 05:40:39 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15L9cvsb028968;
        Mon, 21 Jun 2021 09:40:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3998788e8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 09:40:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15L9eZq224379786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 09:40:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB3B6AE051;
        Mon, 21 Jun 2021 09:40:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6972FAE045;
        Mon, 21 Jun 2021 09:40:34 +0000 (GMT)
Received: from localhost (unknown [9.85.73.168])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jun 2021 09:40:34 +0000 (GMT)
Date:   Mon, 21 Jun 2021 15:10:33 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] tools/perf probe: Print a hint if adding a probe fails
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20210610094442.1602714-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610192926.6f7b606f1fefd285b3907cd5@kernel.org>
        <YMycflwgCrosgTcb@kernel.org>
In-Reply-To: <YMycflwgCrosgTcb@kernel.org>
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1624268198.nw42tdsihr.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tvS_2eOWtZU2DA8_FH94FxWlCUmWniSO
X-Proofpoint-ORIG-GUID: tvS_2eOWtZU2DA8_FH94FxWlCUmWniSO
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_03:2021-06-20,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106210055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 10, 2021 at 07:29:26PM +0900, Masami Hiramatsu escreveu:
>> Hi Naveen,
>>=20
>> On Thu, 10 Jun 2021 15:14:42 +0530
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>>=20
>> > Adding a probe can fail in a few scenarios. perf already checks for the
>> > address in the kprobe blacklist. However, the address could still be a
>> > jump label, or have a BUG_ON(). In such cases, it isn't always evident
>> > why adding the probe failed. Add a hint so that the user knows how to
>> > proceed.
>> >=20
>>=20
>> Thanks for the report.
>>=20
>> Since now there is <tracefs>/error_log, if you see any errors in registe=
ring
>> probe-events, perf probe should dump the error_log for the hint message.
>> Also, kprobes should return the correct different error code for each
>> errors.
>=20
> Was there any followup on this? I think we should do as Masami suggests,
> Naveen, could you do it?

Thanks for checking. We have been discussing this on the kernel side of=20
things here (sorry, missed copying you on that):
http://lkml.kernel.org/r/20210610085617.1590138-1-naveen.n.rao@linux.vnet.i=
bm.com

I will work on the related changes to perf after the kernel changes.


Thanks,
Naveen

