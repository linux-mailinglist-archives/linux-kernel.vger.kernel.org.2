Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396E93D3D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGWPeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:34:36 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13692 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229564AbhGWPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:34:35 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16NEvUOY009361;
        Fri, 23 Jul 2021 11:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=NCbMd3kdrwYFFiK/GCKAJEAs+CigW+ViuzHbEl9T9mA=;
 b=eCe9ElXa05yBJf3vNVa9nWQsotll8HO/8dmLwB+zhjnuBg4spTmYBNU1/GoCFM3Pet8M
 DqVygJNTw5qBpc4OpMH68JBIOkV2+JimtPEeCnxsgOskYXpT9FqbkAkkudHGvJs7iwxS
 fdgkUL+KEqHoe1TS0aLVZ6y8JVe2VDW4zXF+pzCcVdKRXzCZSJKrN5Pkv2R2TVHiL6b2
 gZdZkmKUazcMgk8W0RxHPboGYsXtLTa17J7UvS4IkR8hnNTV3NnDtGxZfG14plN++iRh
 FbTk1epFZt8uh3roM15lDf9C19shDk3To5KVN+TmZd1SlL5yJDa9z6llMS6ybPr7u6Ra 1g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 39ya2r9mnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Jul 2021 11:15:03 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 17:15:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 23 Jul 2021 17:15:01 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.17])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 37F112BA;
        Fri, 23 Jul 2021 16:15:01 +0000 (UTC)
Subject: Re: lib/test_scanf.c:531:1: warning: the frame size of 2080 bytes is
 larger than 2048 bytes
To:     Petr Mladek <pmladek@suse.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        - <patches@opensource.cirrus.com>
References: <202107131602.8qHTzV8q-lkp@intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <870e7908-113c-0eed-264e-8a9832202bfe@opensource.cirrus.com>
Date:   Fri, 23 Jul 2021 17:15:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107131602.8qHTzV8q-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hPGpFU0GGo4bNuv7Q4wInmuYXFkTY_1n
X-Proofpoint-ORIG-GUID: hPGpFU0GGo4bNuv7Q4wInmuYXFkTY_1n
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2021 09:21, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
>     lib/test_scanf.c: In function 'numbers_list_field_width_val_width':
>>> lib/test_scanf.c:531:1: warning: the frame size of 2080 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>       531 | }
>           | ^
>     lib/test_scanf.c: In function 'numbers_list_field_width_typemax':
>     lib/test_scanf.c:489:1: warning: the frame size of 2552 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>       489 | }
>           | ^
>     lib/test_scanf.c: In function 'numbers_list':
>     lib/test_scanf.c:438:1: warning: the frame size of 2080 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>       438 | }
>           | ^
> 

I haven't been able to reproduce this. I've tried these compilers:

Linaro AArch32 GCC 10.2.1 20201103(-O2 or -Os optimization): stack 
frames < 200 bytes

Linaro ARM32 7.5-2019.12 -Os: maximum of 384 bytes

Debian 6.3.0-18+deb9u1, x86_64 -O2: frames < 200 bytes

(The GCC fetched with the reproduction instructions from the krobot
report doesn't work on my Debian system.)

The sizes reported by the krobot are the total of all stack variable in
the function, but they all have limited scope. Obviously my GCC versions
are optimizing by effectively making a union of stack variable that are
used in different scope. So presumably the GCC version used by krobot is
missing this optimization. That feels to me more like a compiler bug if
it is allocating 12 times more stack than is actually necessary for the
function.

Output from my 10.2.1 compiler (-O2):

lib/test_scanf.c: In function 'numbers_list_field_width_val_width':
lib/test_scanf.c:530:1: warning: the frame size of 176 bytes is larger 
than 128 bytes [-Wframe-larger-than=]
   530 | }
       | ^
lib/test_scanf.c: In function 'numbers_list_field_width_typemax':
lib/test_scanf.c:488:1: warning: the frame size of 184 bytes is larger 
than 128 bytes [-Wframe-larger-than=]
   488 | }
       | ^
lib/test_scanf.c: In function 'numbers_list':
lib/test_scanf.c:437:1: warning: the frame size of 168 bytes is larger 
than 128 bytes [-Wframe-larger-than=]
