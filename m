Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3F3A6A69
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhFNPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:33:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233269AbhFNPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:33:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EF5iB1192491;
        Mon, 14 Jun 2021 11:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=hLsXeOBkv72opN43YUx6sNzvlPUqUR08kd4/eoVxwjI=;
 b=BCYhBHJVEvA0iUmH/tQi+2Tn28ts+5LVJlgPSbI2xRTUgG0eMh+wr1HuFchfAO26k0CB
 sBbJD+rWkm5eM7Ya91vX/9ML6Oh2CLcQEogmqhYk3JB7vvmEHyd4ESx5yrdeY36ApNLM
 lRQ5uF+TMkruWE1nDRcxdGAnJ7WDPZr689cs17zgu1UJPCbuxpq8kU2fTBKfZIH3qxvX
 Xh4yNA7O8aRWXknTYeBRVzSWaDVMokpCP086aLAo1EUoMzELDQtFARVp/uDAwsz4fO5c
 v02XlEmtEH3FzATl7fCUpWQd3s99QJrRX568XtWTTvIaoYLHuVQyFKa+ApdRkTsHgoHg hw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3967cmngpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 11:30:59 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15EFNfUI026676;
        Mon, 14 Jun 2021 15:30:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 394mj8rjab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 15:30:57 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15EFTtPH21037538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 15:29:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3597A4064;
        Mon, 14 Jun 2021 15:30:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A958A405B;
        Mon, 14 Jun 2021 15:30:54 +0000 (GMT)
Received: from localhost (unknown [9.85.73.215])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 15:30:54 +0000 (GMT)
Date:   Mon, 14 Jun 2021 21:00:52 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610191643.d24e7d56d102567070fe8386@kernel.org>
        <1623419180.o4u5xf72jm.naveen@linux.ibm.com>
        <20210611154021.008537b0@gandalf.local.home>
In-Reply-To: <20210611154021.008537b0@gandalf.local.home>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1623684632.0k2j6ky7k3.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MpC_ZTVqH_XNESWeO5BGGYkM1N90qWMR
X-Proofpoint-GUID: MpC_ZTVqH_XNESWeO5BGGYkM1N90qWMR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_09:2021-06-14,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106140098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 11 Jun 2021 19:25:38 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> We also have perf_event_open() as an interface to add probes, and I=20
>> don't think it would be helpful to require all tools to utilize the=20
>> error log from tracefs for this purpose.
>=20
> The there should be a perf interface to read the errors. I agree with
> Masami. Let's not have console logs for probe errors.

Ok, understood.


Thanks,
Naveen

