Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35C3FB1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhH3HSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:18:03 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:64211 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhH3HSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:18:02 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210830071707epoutp025dee6994fb1ea3493466cced3a9e9d6e~gBFTSyPTL1867018670epoutp02V
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:17:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210830071707epoutp025dee6994fb1ea3493466cced3a9e9d6e~gBFTSyPTL1867018670epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630307827;
        bh=ZDC2xTZuSK55t0V8aQf8pSsiEvOfn0p17TQ+RPhTN00=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=q8FKjjnWc3HAzu9KggIx8wdo56JNtDrQwtHoTqUJ9tL6T0Qw7gpwu3AxUPPaVmoRv
         xTVZKiv1TT2rTPobqkA2H9pHopKnETuPEkI4bo6jm+5ZVlrySbxv2D3Gix9j2hKjGp
         74ExJJG2FsVUFwaVYWWe1xpXTxVlmS33ZcSpBgr8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210830071707epcas1p14a94340ed0469b9e88ba6636143c9c20~gBFS-YQYW1777517775epcas1p1r;
        Mon, 30 Aug 2021 07:17:07 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.243]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GyhTY0LgWz4x9Q9; Mon, 30 Aug
        2021 07:17:05 +0000 (GMT)
X-AuditID: b6c32a39-6a7ff70000002618-77-612c85ee86b6
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.53.09752.EE58C216; Mon, 30 Aug 2021 16:17:02 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] printk: use kvmalloc instead of kmalloc for devkmsg_user
Reply-To: ytk.lee@samsung.com
Sender: =?UTF-8?B?7J207Jqp7YOd?= <ytk.lee@samsung.com>
From:   =?UTF-8?B?7J207Jqp7YOd?= <ytk.lee@samsung.com>
To:     "pmladek@suse.com" <pmladek@suse.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?UTF-8?B?7J207Jqp7YOd?= <ytk.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210830071701epcms1p70f72ae10940bc407a3c33746d20da771@epcms1p7>
Date:   Mon, 30 Aug 2021 16:17:01 +0900
X-CMS-MailID: 20210830071701epcms1p70f72ae10940bc407a3c33746d20da771
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmru67Vp1Eg6NbBCy2XZnPaHF51xw2
        i/+Pv7Ja7Ot4wGSxe+MiNovH67kd2DxmN1xk8WjZd4vd4925c+wefVtWMXqs33KVxePzJrkA
        tqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BWYFesWJucWleel6eaklVoYGBkamQIUJ
        2RkdO1+xFDwRqNi5cyVzA+Mt3i5GTg4JAROJWWsmMYLYQgI7GCX+bQrrYuTg4BUQlPi7Qxgk
        LCzgKbFg5kFmkLCQgKxEa68KRNhM4nXPFCYQmw1oyo7Hf4FKuDhEBLqZJNpn3GEFSTALGEn0
        rtjICLGKV2JG+1MWCFtaYvvyrVBxUYmbq9+yw9jvj82HiotItN47ywxhC0o8+LkbKi4lMf3k
        DjaQZRIC8xklDv3cwA7hdDBKfPn6kg2iylzi2YYWsKm8Ar4SO54+AbuIRUBV4vXURVDbXCT+
        dC9mgrhUW2LZwtdgXzILaEqs36UPUaIosfP3XEaIEj6Jd197WGGe2THvCRNMTfOJXqi4uMS9
        eX1Q4z0klndPZoOEbaDE1ok3WCcwys9CBO8sJItnISxewMi8ilEstaA4Nz212LDAFB6hyfm5
        mxjBiVDLcgfj9Lcf9A4xMnEwHmKU4GBWEuHNfqOVKMSbklhZlVqUH19UmpNafIjRFOjlicxS
        osn5wFScVxJvaGJpYGJmZGJhbGlspiTOy/hKJlFIID2xJDU7NbUgtQimj4mDU6qBKahaWaxU
        wE1Uslt47a+vLkx5bIw2r59kO+73zJS4HL9YYdOSjqoTTXY/+Bquhz6q+cke8PVt2mfBj183
        s5v1XfZ+HsKsM7NMhfGOToH8dZU3b7ZvibK/UX7meHDOV95l/N+TT82qnc2dVLUy+ZDsmh0L
        s+c97Zse0iAqqTRT8NEXG4ulO2+yqmvkpuid97PJLeBf/f1h9NYP08WZ4qRvrY2pagzoeWtv
        Veds8lKh9lG7BM/9OXNC16/QXC0u6M4+4yLDZ8uHST+el4rtPbbjPNf67JXZdv2OZe2Rp+62
        PsrrtBdtTdZ9WanwuFT/ztlySY4JzIu+5h64sYV16r+NE+NqFc8cezIrsGL2BX9JJZbijERD
        Leai4kQApVj8Vg0EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210830071701epcms1p70f72ae10940bc407a3c33746d20da771
References: <CGME20210830071701epcms1p70f72ae10940bc407a3c33746d20da771@epcms1p7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Size of struct devkmsg_user increased to 16784 by commit 896fbe20b4e2
(=22printk: use the lockless ringbuffer=22) so order3(32kb) is needed for
kmalloc. Under stress conditions the kernel may temporary fail to
allocate 32k with kmalloc. Use kvmalloc instead of kmalloc to aviod
this issue.

qseecomd invoked oom-killer: gfp_mask=3D0x40cc0(GFP_KERNEL=7C__GFP_COMP), o=
rder=3D3, oom_score_adj=3D-1000
Call trace:
 dump_backtrace+0x0/0x34c
 dump_stack_lvl+0xd4/0x16c
 dump_header+0x5c/0x338
 out_of_memory+0x374/0x4cc
 __alloc_pages_slowpath+0xbc8/0x1130
 __alloc_pages_nodemask+0x170/0x1b0
 kmalloc_order+0x5c/0x24c
 devkmsg_open+0x1f4/0x558
 memory_open+0x94/0xf0
 chrdev_open+0x288/0x3dc
 do_dentry_open+0x2b4/0x618
 path_openat+0xce4/0xfa8
 do_filp_open+0xb0/0x164
 do_sys_openat2+0xa8/0x264
 __arm64_sys_openat+0x70/0xa0
 el0_svc_common+0xc4/0x270
 el0_svc+0x34/0x9c
 el0_sync_handler+0x88/0xf0
 el0_sync+0x1bc/0x200

 DMA32: 4521*4kB (UMEC) 1377*8kB (UMECH) 73*16kB (UM) 0*32kB 0*64kB 0*128kB=
 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 30268kB
 Normal: 2490*4kB (UMEH) 277*8kB (UMH) 27*16kB (UH) 1*32kB (H) 0*64kB 0*128=
kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 12640kB

Signed-off-by: Yong-Taek Lee <ytk.lee=40samsung.com>
---
 kernel/printk/printk.c =7C 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 142a58d124d9..8ba1602232ec 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
=40=40 -862,7 +862,7 =40=40 static int devkmsg_open(struct inode *inode, st=
ruct file *file)
                        return err;
        =7D

-       user =3D kmalloc(sizeof(struct devkmsg_user), GFP_KERNEL);
+       user =3D kvmalloc(sizeof(struct devkmsg_user), GFP_KERNEL);
        if (=21user)
                return -ENOMEM;

=40=40 -892,7 +892,7 =40=40 static int devkmsg_release(struct inode *inode,=
 struct file *file)
        ratelimit_state_exit(&user->rs);

        mutex_destroy(&user->lock);
-       kfree(user);
+       kvfree(user);
        return 0;
 =7D

--
2.17.1
=C2=A0
