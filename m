Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9688F3D8C18
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhG1Koo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:44:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234181AbhG1Kod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:44:33 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SAYuwZ068054;
        Wed, 28 Jul 2021 06:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : references : date : message-id :
 content-type : mime-version; s=pp1;
 bh=3o/1rtqbIjEoMmEeqjHyEAAJVX7A7IT0MVoLF3igGQ4=;
 b=i1GxepscTdrOe5otvmSf+AaGULTq2srYxZlQHLQkE6TqLwLQ36KuExnLwckB8ZCMd075
 mu2i/qyx+3d+QJP9BahQn2lpfXqIu3T9/yfQGweEsr9y6O1vNHtGx7v91WURR7cXyhp5
 OWNZlwb0rqvSejLrhh0F7vwhn4e8bfwxgipWAiKagbIswkogftBVrRxr2+yq63ZRjCIC
 8pYrfp6yxBWCM9wvA/Ydt8jU/kciyzE6CcfMRSqf1fDzJxign2cAFc7R7Hnl0jU4zK8P
 GyfCqFx5oBvxHumsZpahEtkTfMMSTNHSV5WMlMgBbDEF4DwZYKlMI9AO7ryiVBKrB0jq Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a34vdsp48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 06:44:20 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SAYuwN068090;
        Wed, 28 Jul 2021 06:44:20 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a34vdsp3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 06:44:19 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SAb1Uk013784;
        Wed, 28 Jul 2021 10:44:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3a235kh04a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 10:44:17 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SAfX6V30867946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 10:41:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76A3911C080;
        Wed, 28 Jul 2021 10:44:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 416E211C07B;
        Wed, 28 Jul 2021 10:44:15 +0000 (GMT)
Received: from localhost (unknown [9.171.23.245])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 10:44:15 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        torvalds@linux-foundation.org, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
In-Reply-To: <YQAbZhCwLS7vb/ag@bombadil.infradead.org>
In-Reply-To: 
References: <87sg04p315.fsf@oc8242746057.ibm.com>
 <edb79b68-6dd0-ced5-17a0-fda7516d3529@rasmusvillemoes.dk>
 <CA+QYu4pDGHj--z6yUrkhFs7oW-LUrY23i+-vKJwLPWaCO=z4vA@mail.gmail.com>
 <YQAQFMDMk09wS6Qv@bombadil.infradead.org>
 <CA+QYu4qSw_W=hdOARxjfisRjx4Lpy-MSe1ZovfUtVb2GGMynkg@mail.gmail.com>
 <YQAWc/6I6MnOGZn1@bombadil.infradead.org>
 <CA+QYu4ofYOqcuCYohFnYYO+XhAjKfpyGQ4KJr5vE4Fo=whv7UA@mail.gmail.com>
 <YQAbZhCwLS7vb/ag@bombadil.infradead.org>
Date:   Wed, 28 Jul 2021 12:44:14 +0200
Message-ID: <87mtq6g1kx.fsf@oc8242746057.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PB88iuStVFCvDIy_xvaOz5ne9iRSQbg8
X-Proofpoint-ORIG-GUID: qJARTqNlQI9Kble0009qsZN7xPCS5F0n
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_07:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Tue, Jul 27, 2021 at 04:27:08PM +0200, Bruno Goncalves wrote:
>> On Tue, Jul 27, 2021 at 4:21 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>> >
>> > On Tue, Jul 27, 2021 at 04:12:54PM +0200, Bruno Goncalves wrote:
>> > > On Tue, Jul 27, 2021 at 3:55 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>> > > >
>> > > > On Tue, Jul 27, 2021 at 09:31:54AM +0200, Bruno Goncalves wrote:
>> > > > > On Mon, Jul 26, 2021 at 1:46 PM Rasmus Villemoes
>> > > > > <linux@rasmusvillemoes.dk> wrote:
>> > > > > >
>> > > > > > On 24/07/2021 09.46, Alexander Egorenkov wrote:
>> > > > > > > Hello,
>> > > > > > >
>> > > > > > > since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
>> > > > > > > started seeing the following problem on s390 arch regularly:
>> > > > > > >
>> > > > > > > [    5.039734] wait_for_initramfs() called before rootfs_initcalls
>> > > >
>> > > > So some context here, which might help.
>> > > >
>> > > > The initramfs_cookie is initialized until a a rootfs_initcall() is
>> > > > called, in this case populate_rootfs(). The code is small, so might
>> > > > as well include it:
>> > > >
>> > > > static int __init populate_rootfs(void)
>> > > > {
>> > > >         initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
>> > > >                                                  &initramfs_domain);
>> > > >         if (!initramfs_async)
>> > > >                 wait_for_initramfs();
>> > > >         return 0;
>> > > > }
>> > > > rootfs_initcall(populate_rootfs);
>> > > >
>> > > > The warning you see comes from a situation where a wait_for_initramfs()
>> > > > gets called but we haven't yet initialized initramfs_cookie.  There are
>> > > > only a few calls for wait_for_initramfs() in the kernel, and the only
>> > > > thing I can think of is that somehow s390 may rely on a usermode helper
>> > > > early on, but not every time.
>> > > >
>> > > > What umh calls does s390 issue?
>> > > >
>> > > > > Unfortunately, we haven't been able to find the root cause, but since
>> > > > > June 23rd we haven't hit this panic...
>> > > > >
>> > > > > Btw, this panic we were hitting only when testing kernels from "scsi"
>> > > > > and "block" trees.
>> > > >
>> > > > Do you use drdb maybe?
>> > >
>> > > No, the machines we were able to reproduce the problem don't have drdb.
>> >
>> > Are there *any* umh calls early on boot on the s390 systems? If so
>> > chances are that is the droid you are looking for.
>> 
>> Sorry Luis,
>> 
>> I was just replying the question mentioning an old thread
>> (https://lore.kernel.org/lkml/CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com/T/#u)
>> on ppc64le.
>> 
>> regarding the "umh" it doesn't show anything on ppc64le boot.
>
> There is not a single pr_*() call on kernel/umh.c, and so unless the
> respective ppc64le / s390 umh callers have a print, we won't know if you
> really did use a print.

I instrumented the UMH code and it seems that all wait_for_initramfs()
are triggered by request_module() from drbg.

>
> Can you reproduce the failure? How often?
>
>   Luis

The failure can be reproduced almost daily but on only one special test
machine and not immediately but after running many tests. I instrumented
our devel kernel in order to find out when/how the initramfs is being corrupted.

Still not reproducible on my own test machine. Very weird.

I'll report back as soon as we have something tangible.

Regards
Alex
