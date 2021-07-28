Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB83D8BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbhG1Kif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:38:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236007AbhG1KiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:38:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SAXs3A004097;
        Wed, 28 Jul 2021 06:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : references : date : message-id :
 mime-version : content-type; s=pp1;
 bh=GLHGz1FXxIhQ3XhDOzPPegQx13bF4kzSMFW01F22ZNM=;
 b=G30xu61jkJPek22b46lZ6aFxw1xkzwnHlTqFwSpy64bdjwsrPuO6z5ZcppgSP5hXejvZ
 Qlq0ByH1j7iN1XH6bb+WI0ExMEF+m93Wb3bf3hcUSleYpHOX784ySmiJrGB6A9/aDAoh
 3uTxEQTHDdhOL9v56Jq49032Z/ZhfstsEi4gYnx5BwcPsdGuIqkBlWg6A5Vt3oMLV44/
 a+CCZswrLFNCbk1LUYBpabpbsnIcX65Vhyu+mkRQdMomM6m7YtALP5XgNpNz99bB2Bjb
 Cz08jepfkmIPwpooivIPwxAxGjbVhDvjU8Q8W0zqTYNbPd/vOBH73UsPb84TBKHWwz7C aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a35dcgm7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 06:38:15 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SAY6cD005414;
        Wed, 28 Jul 2021 06:38:15 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a35dcgm5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 06:38:15 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SAameH013742;
        Wed, 28 Jul 2021 10:38:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3a235kh01j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 10:38:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SAc9IN26214682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 10:38:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0921C42059;
        Wed, 28 Jul 2021 10:38:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6ECB4205E;
        Wed, 28 Jul 2021 10:38:08 +0000 (GMT)
Received: from localhost (unknown [9.171.23.245])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 10:38:08 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        torvalds@linux-foundation.org, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
In-Reply-To: <YQAQFMDMk09wS6Qv@bombadil.infradead.org>
In-Reply-To: 
References: <87sg04p315.fsf@oc8242746057.ibm.com>
 <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
 <CA+QYu4pDGHj--z6yUrkhFs7oW-LUrY23i+-vKJwLPWaCO=z4vA@mail.gmail.com>
 <YQAQFMDMk09wS6Qv@bombadil.infradead.org>
Date:   Wed, 28 Jul 2021 12:38:08 +0200
Message-ID: <87pmv2g1v3.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: okvylCCKtII6JnkUWIkNJJLuwowrJmSr
X-Proofpoint-GUID: JG9nErZ17zV5vNk2QRDrKdn4U2vX4oTA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_07:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Tue, Jul 27, 2021 at 09:31:54AM +0200, Bruno Goncalves wrote:
>> On Mon, Jul 26, 2021 at 1:46 PM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>> >
>> > On 24/07/2021 09.46, Alexander Egorenkov wrote:
>> > > Hello,
>> > >
>> > > since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
>> > > started seeing the following problem on s390 arch regularly:
>> > >
>> > > [    5.039734] wait_for_initramfs() called before rootfs_initcalls
>
> So some context here, which might help.
>
> The initramfs_cookie is initialized until a a rootfs_initcall() is
> called, in this case populate_rootfs(). The code is small, so might
> as well include it:
>
> static int __init populate_rootfs(void)
> {
> 	initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
> 						 &initramfs_domain);
> 	if (!initramfs_async)
> 		wait_for_initramfs();
> 	return 0;
> }                                                                               
> rootfs_initcall(populate_rootfs);
>
> The warning you see comes from a situation where a wait_for_initramfs()
> gets called but we haven't yet initialized initramfs_cookie.  There are
> only a few calls for wait_for_initramfs() in the kernel, and the only
> thing I can think of is that somehow s390 may rely on a usermode helper
> early on, but not every time.
>
> What umh calls does s390 issue?
>
>> Unfortunately, we haven't been able to find the root cause, but since
>> June 23rd we haven't hit this panic...
>> 
>> Btw, this panic we were hitting only when testing kernels from "scsi"
>> and "block" trees.
>
> Do you use drdb maybe?
>
>   Luis

You are right, it looks like wait_for_initramfs() is being triggered by drbg:

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
