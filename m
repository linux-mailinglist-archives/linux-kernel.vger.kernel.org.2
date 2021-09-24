Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620C4417AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348075AbhIXSVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 14:21:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348057AbhIXSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 14:21:16 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OHtRuX030663;
        Fri, 24 Sep 2021 14:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=DCB4ZcC2apNQaN2mSRaE8wUmEftiZ+pRER0r/dypdTY=;
 b=hryLBPy7ncXL1F/sERfRvVtn1mkVNVt7QySLXFpJsbBt9Zg4mhrzrclNt2VtdrqAjleb
 IHfOf1G7LyRsyYvePQmPEPb8l/S9mjMmoAtkmJO8S74wkStUaK3cZ5LUagHaYYQVikfF
 TtsWvWu/2QhZF5gpEVEh3H+eRYSmE8puxwab/ywDXyaQERPNK4DbRvwAa+Pk4CYsQbuN
 58qvff0Mh2Np8IdXXwkT6/mzhQE1IP0Ye4w0O+nAMcRpKplg9DnIzkIHYtovK/c3B6ap
 hxSDqvtRI5sGuyzI2pOa/54PuLD3JIthy9jXbgSS2jra+gX2LZy5z241/WId0NNm+0DX gA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b9duq9xnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 14:19:25 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18OHqPkh008458;
        Fri, 24 Sep 2021 18:19:23 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3b93ga8fv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 18:19:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18OIETPq61276636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 18:14:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 340EB5204F;
        Fri, 24 Sep 2021 18:19:21 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id DB14D52051;
        Fri, 24 Sep 2021 18:19:20 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kprobes: convert tests to kunit
References: <20210914070816.3516994-1-svens@linux.ibm.com>
        <202109150545.FABUL0Nv-lkp@intel.com>
Date:   Fri, 24 Sep 2021 20:19:20 +0200
In-Reply-To: <202109150545.FABUL0Nv-lkp@intel.com> (kernel test robot's
        message of "Wed, 15 Sep 2021 05:56:05 +0800")
Message-ID: <yt9dlf3ln8ev.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6LmtHjFjezNfB7CUQomx7JUgJzQd1xpb
X-Proofpoint-GUID: 6LmtHjFjezNfB7CUQomx7JUgJzQd1xpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_05,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=679 spamscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109240113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Hi Sven,
>
> Thank you for the patch! Yet something to improve:
>
[..]
>    ia64-linux-ld: kernel/test_kprobes.o: in function `entry_handler':
>>> test_kprobes.c:(.text+0x150): undefined reference to `kunit_unary_assert_format'
>>> ia64-linux-ld: test_kprobes.c:(.text+0x212): undefined reference to `kunit_do_assertion'
>    ia64-linux-ld: kernel/test_kprobes.o: in function `return_handler2':
>>> test_kprobes.c:(.text+0x2f0): undefined reference to `kunit_binary_assert_format'
>    ia64-linux-ld: test_kprobes.c:(.text+0x452): undefined reference to `kunit_do_assertion'
>    ia64-linux-ld: test_kprobes.c:(.text+0x522): undefined reference to `kunit_do_assertion'

I missed that kunit can be built as module. I'll fix it an send a v3.
