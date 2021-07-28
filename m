Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0733A3D8BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhG1KhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:37:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231238AbhG1KhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:37:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SAYOWc055520;
        Wed, 28 Jul 2021 06:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : references : date : message-id :
 mime-version : content-type; s=pp1;
 bh=L3qOVQePpespo4jSf0ZX1126DNl3LPZw535i2ueR/OQ=;
 b=hnbDM3sYg/xvLwCIx326X83tdfDvjZl2Wt4IAZ0P+r6+gmhwi0r+g1bru4LZjPNUV//r
 rKCz68ZQePzov1sVG6fPuYSsScrsR653iiCv+NhdrEDw7HgAi40aS3CXGVdt0lSmlO/l
 s0BKc70Mgj8eN+0JgDjIfpFWUTwJJ1r196WEuEVNtAxVgXUWov4Rw/sG6F6Ntab/OnZ3
 f4vupGfHoQHKRV/Y7KUeDAJXss+eHwfUq+oTMFnJbf9zn0ZSQTNoPSo8jYNtSrO8a0pt
 chk553CdTKjGZrhaYvJx0pnIi+2PPPm9tSZaQo3WnWVIv7lqBsKelWJUYpH5RbDNWHbA 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a32r3naf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 06:36:57 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SAYebm057099;
        Wed, 28 Jul 2021 06:36:57 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a32r3nac1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 06:36:57 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SAWDbn017597;
        Wed, 28 Jul 2021 10:36:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3a235xrn38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 10:36:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SAapd931326510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 10:36:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72142A408F;
        Wed, 28 Jul 2021 10:36:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 444C1A408C;
        Wed, 28 Jul 2021 10:36:51 +0000 (GMT)
Received: from localhost (unknown [9.171.23.245])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 10:36:51 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux@rasmusvillemoes.dk
Cc:     akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        ndesaulniers@google.com, torvalds@linux-foundation.org,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
In-Reply-To: <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
In-Reply-To: 
References: <87sg04p315.fsf@oc8242746057.ibm.com>
 <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
Date:   Wed, 28 Jul 2021 12:36:50 +0200
Message-ID: <87sfzyg1x9.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ns4HuF818WyqYfBsaAzOad-P3kWnk__M
X-Proofpoint-ORIG-GUID: 5-a5NMjhgQnVDPjiZKkiOa5ckBByFIt_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_07:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Villemoes <linux@rasmusvillemoes.dk> writes:

> On 24/07/2021 09.46, Alexander Egorenkov wrote:
>> Hello,
>> 
>> since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
>> started seeing the following problem on s390 arch regularly:
>> 
>> [    5.039734] wait_for_initramfs() called before rootfs_initcalls
>
> While that message was added as part of the same patch, it's a red
> herring: It merely means that something ends up calling usermodehelper
> (perhaps a request_module) before the init sequence has come around to
> rootfs_initcalls. At that point, the rootfs is (with or without my async
> patch) entirely empty, so those usermodehelper calls have always failed
> with -ENOENT.
>
> If you have CONFIG_UEVENT_HELPER=y and CONFIG_UEVENT_HELPER_PATH set to
> a non-empty string, you can try setting the latter to the empty string.
> But the message won't go away if it's really a request_module() and not
> a uevent notification.
>

Thanks for the helpful explanation. I disabled UEVENT on my test machine and
as you said, the message is being triggered by request_module() now.

[    3.396467]  [<00000001f8d917e4>] call_usermodehelper_exec+0x44/0x1c8
[    3.396470]  [<00000001f8da5524>] __request_module+0x17c/0x3d0
[    3.396473]  [<00000001f93b4808>] crypto_alg_mod_lookup+0x228/0x290
[    3.396475]  [<00000001f93b4aae>] crypto_alloc_tfm_node+0x5e/0x158
[    3.396477]  [<00000001f93bbe14>] crypto_alloc_shash+0x34/0x40
[    3.396480]  [<00000001f93d2ee2>] drbg_init_hash_kernel+0x3a/0x100
[    3.396482]  [<00000001f93d306e>] drbg_alloc_state+0xc6/0x280
[    3.396484]  [<00000001f93d33d8>] drbg_kcapi_seed+0x1b0/0x310
[    3.396486]  [<00000001f93d1884>] crypto_rng_reset+0x5c/0xe0
[    3.396488]  [<00000001f93c1750>] alg_test_drbg+0x300/0x478
[    3.396490]  [<00000001f93c0934>] alg_test+0x304/0x530
[    3.396493]  [<00000001f93bedb8>] cryptomgr_test+0x68/0x70
[    3.396495]  [<00000001f8d9f40c>] kthread+0x14c/0x160
[    3.396497]  [<00000001f8d2af14>] __ret_from_fork+0x3c/0x58
[    3.396500]  [<00000001f984c86a>] ret_from_fork+0xa/0x30

Regards
Alex
