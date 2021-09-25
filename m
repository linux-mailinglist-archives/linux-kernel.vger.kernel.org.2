Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7B41800B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 08:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbhIYGla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 02:41:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229669AbhIYGl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 02:41:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18P4K4KY031654;
        Sat, 25 Sep 2021 02:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=5me2+ekSnpcDlXPCLovxM0CpHMMlnRrTqlEYtp+qgC8=;
 b=tZ+XzHpFL3qrQnUtzvziqDgSyxSFv9J84hDdxriac9ZEF+XxRCY3LbYz83BWmZLf0l76
 A1gxR+YGGU3xUUB860HjzZUhvCjXhnOpFh2oxzacCCDzI9d10dz3pRq50v+Hu+3js1wS
 5lOKb+mg/Y7KpwnSbwkcC+Gfs0br94xqQAHEfqXMquw2+cX3v9jSsSeDTeRjyeYMxK28
 1qX91WS9qlOALkTPmunrqexvxhg/XyhUHe1vXGgy+LYM+zARCHk+n3VglVCuyCz3dOlP
 sGS+IGzAX86uK93Qv0UIp9flvrx/FfZ3B/d15EFmuTbMvkz9GtB8ldKkh3wEIAdb1ssA 2w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b9vnc9qmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Sep 2021 02:39:36 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18P6OJpX010275;
        Sat, 25 Sep 2021 06:39:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3b9ud98tua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Sep 2021 06:39:33 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18P6dUSV44827050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Sep 2021 06:39:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0CB2A405F;
        Sat, 25 Sep 2021 06:39:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74C4CA4054;
        Sat, 25 Sep 2021 06:39:30 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 25 Sep 2021 06:39:30 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kprobes: convert tests to kunit
References: <20210914070816.3516994-1-svens@linux.ibm.com>
        <202109150545.FABUL0Nv-lkp@intel.com> <yt9dlf3ln8ev.fsf@linux.ibm.com>
        <20210925104726.043885d4c8f7ec80de2746c9@kernel.org>
Date:   Sat, 25 Sep 2021 08:39:30 +0200
In-Reply-To: <20210925104726.043885d4c8f7ec80de2746c9@kernel.org> (Masami
        Hiramatsu's message of "Sat, 25 Sep 2021 10:47:26 +0900")
Message-ID: <yt9d8rzlgnvh.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o8XBVVRHXOef0ZfYgABqSdhpkqis0qHm
X-Proofpoint-ORIG-GUID: o8XBVVRHXOef0ZfYgABqSdhpkqis0qHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-25_02,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=682
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109250045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Masami Hiramatsu <mhiramat@kernel.org> writes:

> On Fri, 24 Sep 2021 20:19:20 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> kernel test robot <lkp@intel.com> writes:
>> 
>> > Hi Sven,
>> >
>> > Thank you for the patch! Yet something to improve:
>> >
>> [..]
>> >    ia64-linux-ld: kernel/test_kprobes.o: in function `entry_handler':
>> >>> test_kprobes.c:(.text+0x150): undefined reference to `kunit_unary_assert_format'
>> >>> ia64-linux-ld: test_kprobes.c:(.text+0x212): undefined reference to `kunit_do_assertion'
>> >    ia64-linux-ld: kernel/test_kprobes.o: in function `return_handler2':
>> >>> test_kprobes.c:(.text+0x2f0): undefined reference to `kunit_binary_assert_format'
>> >    ia64-linux-ld: test_kprobes.c:(.text+0x452): undefined reference to `kunit_do_assertion'
>> >    ia64-linux-ld: test_kprobes.c:(.text+0x522): undefined reference to `kunit_do_assertion'
>> 
>> I missed that kunit can be built as module. I'll fix it an send a v3.
>
> Does this mean we can not use KUnit for the feature which is not exposed to module?

I changed the test_kprobes so that it can be build as a module now. (i
guess you already noticed that when looking at the v3 patch).
