Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE133DA44F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhG2NaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:30:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238094AbhG2N3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:29:31 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TD4Iin118142;
        Thu, 29 Jul 2021 09:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=pAg0CgoQ0cRO5DuQ5uVcCcUSv5Qx+tg3L6oB/EKkeRo=;
 b=TPWNEUf8N8/9reR0yp4ZV2sOeN92SrSgl8ae8BVsR14Z8ATC0WjiC5VjP9KDl3L7+74K
 dRSeZ4AcZx5pu4FyXBg3UNc2GzjamX6G/jkkE7XcD0OnwAJHoScZgWNAXyK1sg8QRDpw
 TP+GcY1bCKIMYAX+RfGVyBI9nQmWm/PvcegdM0DukRWr6jgt36ENuWeO+lFA9lfSbnBl
 30sufu9tUjBZctrQpZdduiSiAUPwb3cOJ/ichgwFjOrEUXfjVVX404WcqUsfwG4OvAOy
 wcK91MeX/GPBolPI7bF6v3xV3cb2MMzAqKwZPcKAKJpzKv/x0ltvbUBxfTKNUvcmbirS XA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3v5s2t61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 09:29:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TDIw2S013339;
        Thu, 29 Jul 2021 13:29:22 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3a235m1qx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 13:29:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TDQbwA19792214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 13:26:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B981E4C046;
        Thu, 29 Jul 2021 13:29:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A6384C04A;
        Thu, 29 Jul 2021 13:29:18 +0000 (GMT)
Received: from localhost (unknown [9.171.66.47])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 29 Jul 2021 13:29:18 +0000 (GMT)
Date:   Thu, 29 Jul 2021 15:29:16 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: decompressor.c:undefined reference to `__clzdi2'
Message-ID: <cover.thread-f0f589.your-ad-here.call-01627564869-ext-2765@work.hours>
References: <202107280146.D9p1EaKo-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202107280146.D9p1EaKo-lkp@intel.com>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vnv-tr5IBAJrsJO1GipHPe45AARSnMnn
X-Proofpoint-GUID: vnv-tr5IBAJrsJO1GipHPe45AARSnMnn
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=939 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:27:54AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ff1176468d368232b684f75e82563369208bc371
> commit: 7b034d9c1b08b3d06ad712283c1115a7fe39e354 s390/boot: add zstd support
> date:   6 weeks ago
> config: s390-randconfig-r026-20210727 (attached as .config)
...
>    s390-linux-ld: arch/s390/boot/compressed/decompressor.o: in function `HUF_decompress1X2_usingDTable_internal':
> >> decompressor.c:(.text+0x2152): undefined reference to `__clzdi2'

haaaahh.... Not very nice, but that would work:

Vasily Gorbik (1):
  s390/boot: fix zstd build for -march=z900

 arch/s390/boot/compressed/Makefile  | 1 +
 arch/s390/boot/compressed/clz_ctz.c | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 arch/s390/boot/compressed/clz_ctz.c

-- 
2.25.4
