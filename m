Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA87844C5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 18:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhKJRJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 12:09:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhKJRJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:09:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AAGH9W4030075
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 17:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : subject : from
 : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=Yk3cHWP742vBHB4thVRR3JQ32BPj70Jto97RwUAnsCo=;
 b=gEMxbzQpMp0GOfHW2XCn7ztSdR+I/qx+Ce1AT3u/kXDOgkrloaIVGamYtL4GMgMrvRPG
 O5T34EeIp7Zj+cZfskKSZEsBK5WAvF3toR1279IPbw708pdNkKVX/qcRmhCfcTILfo3T
 wBsD5C1ApBCUFAKgLUVSkSJYEn+mdxZ5ayI6K3HonKjQWR7PVdKkxeP4OndCVG83tDzH
 6Gmg50VqiMW5DKASAFHFVZNyVShNPydl6wTJh0tstffwqR6YYPDY1SO9vJcROB6O62mt
 hSIAnrXbZ6kxQuSSppDtVtDURmYvKIYEXqCkVrYHuzlla1uxBaTnQ8PDZE52Gw/mPvZ0 uA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c8hfg163u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 17:06:22 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AAGvZPD006426
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 17:06:21 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 3c5hbcj2g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 17:06:21 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AAH6KZT63832536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 17:06:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D612B2070;
        Wed, 10 Nov 2021 17:06:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59876B206E;
        Wed, 10 Nov 2021 17:06:20 +0000 (GMT)
Received: from mww0141.wdc07m.mail.ibm.com (unknown [9.208.70.161])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Nov 2021 17:06:20 +0000 (GMT)
To:     linux-kernel@vger.kernel.org
Cc:     "Aniket Kulkarni" <aniket.kulkarni@us.ibm.com>,
        "Rajshekar Iyer" <iyerr@us.ibm.com>,
        "Pawan Powar" <ppowar@us.ibm.com>, ask@linux.vnet.ibm.com
Subject: [BUG: Bad page map in process XXXXX  pte:8000000e72680867 pmd:ff48e6067]
 Application is getting bad data when trying to mmap memory allocated by
 kernel device drivers
From:   "Harish Mara" <Harish.Mara@ibm.com>
Message-ID: <OFC9FBB3AB.B34DAD21-ON00258789.005D2811-85258789.005DF5B3@ibm.com>
Date:   Wed, 10 Nov 2021 13:06:17 -0400
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KeepSent: C9FBB3AB:B34DAD21-00258789:005D2811; name=$KeepSent; type=4
X-Mailer: HCL Notes Build V1101FP3_03312021 SHF15 May 21, 2021
X-Disclaimed: 50439
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jUCoFJkxLMwz3YLRD_vy5ZZ-r-7FOrj3
X-Proofpoint-ORIG-GUID: jUCoFJkxLMwz3YLRD_vy5ZZ-r-7FOrj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_06,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 clxscore=1011 mlxlogscore=903 phishscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have kernel drivers that allocate memory using ?alloc=5Fpages=5Fnode?, t=
he=20
size of the memory allocation is fixed at 128KB.
The pages are allocated with ?GFP=5FKERNEL | =5FGFP=5FCOMP?. And the pages =
thus=20
allocated are marked as Reserved.
The driver does multiple such allocations at the beginning. This memory is =

reused for various requests the driver handles.
The linux kernel device drivers also create char devices. The char devices =

are initialized with our own file=5Foperations that overload owner, read,=20
poll, unlocked=5Fioctl, mmap, open, release, compat=5Fioctl.
The mmap also registers vm=5Foperations=5Fstruct to the vm=5Farea=5Fstruct =
and=20
sets the VM=5FDONTEXPAND flag. The vm=5Foperations=5Fstruct.fault implement=
ation=20
finds the appropriate page and increments the refcount and sets the=20
vmf->page.
The user space processes open these device file and mmap the address=20
range. The size of mmap could be a single allocation (128KB) or multiple=20
allocations.

The problem we are facing is when the user space mmap?s a size of 2MB.=20
Sometimes the memory that gets mapped is garbage (not correct) and we=20
always notice ?Bad page map? errors.=20

P.S: To solve this issue, we removed the ?=5FGFP=5FCOMP? flag from allocati=
on.=20
However this created a different problem on some cloud instances, we are=20
seeing the ?Bad page? errors during the memory allocation that happens at=20
the initialization phase.

