Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B233EFE32
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbhHRHu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:50:57 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:30371 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbhHRHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:50:56 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210818075018epoutp040eaefc2121da578c2480df530db7bcd6~cVy2i3sDm0692606926epoutp04X
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:50:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210818075018epoutp040eaefc2121da578c2480df530db7bcd6~cVy2i3sDm0692606926epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629273018;
        bh=M9QkWflZWhzJ8C4UH0KXV/Xs5kR42oPIJsd+pOc8ukY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=indZTeAGBmt6W96Ak6bwlxSyUnU4UcIumxF2CvQ64RhrTejvJ8cLJgBFPX2nc2L3r
         E8GCQQpYrxv7poogyGdZK8pcmjdOgAlRGSfKXR8L1q9WIVgehwKRe8p7rnaVpe428u
         /uJ7L2GeSJEXLi/1JmrwzxiBEEPjnZcZIgwUoGdU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210818075017epcas5p17c8978ebda5ba5e27ed6b8d0d0b8f7af~cVy1cbJkX0231402314epcas5p1q;
        Wed, 18 Aug 2021 07:50:17 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.4F.40257.9BBBC116; Wed, 18 Aug 2021 16:50:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210818071602epcas5p4fecf459638312c95c5d5aaa29e7e983a~cVU7kK0KC2682326823epcas5p4w;
        Wed, 18 Aug 2021 07:16:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210818071602epsmtrp24cf8c22343093d9852b6140df47a26fc~cVU7jB2ba0816408164epsmtrp2D;
        Wed, 18 Aug 2021 07:16:02 +0000 (GMT)
X-AuditID: b6c32a49-ed1ff70000019d41-ae-611cbbb9017f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.EF.08394.2B3BC116; Wed, 18 Aug 2021 16:16:02 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210818071559epsmtip2108c951d98b4365cb1f7f4385e4d91b9~cVU4xyQ8L2341823418epsmtip2g;
        Wed, 18 Aug 2021 07:15:59 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
        pcc@google.com, amit.kachhap@arm.com, ryabinin.a.a@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, v.narang@samsung.com,
        a.sahrawat@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] exception/stackdepot: add irqentry section in case of
 STACKDEPOT
Date:   Wed, 18 Aug 2021 12:45:43 +0530
Message-Id: <1629270943-9304-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0gTYQDnu7vdzsXqXKO+pvawh2XlNIo+InuA5SlJIVHR+6hrWm6tnZb2
        oKUhbWmltkw3a5RZmaZNM6cZNK1lgihDl6TZw8rsoaYE0ZPtFv33e36/j4+PwmVWkYJK1CRz
        Og2bFExKiJrGObPn2+sD2XDbmSDUXs8hS0UZic4P1YrQYEkWQOdeZYrRaEYmhm6868WQ7U2n
        CLnqLCRymBoAarycSaBr7nYM2S3NInS2200i591qHDmaiwA62b1ohT9TdqkMMK7OdpyxF/aI
        Gasthbmf00wytlIDyTy5+INgqoqPM2eqSwEzYpu8TrJZsnQ3l5R4kNMpl+2UJDQ97QTadFlq
        /s3XhB44xhkBRUF6Iaz8mWgEEkpG1wNY8d0lFshXAPMeP8MF8g3AwZJfpBH4eRvWd899qQYA
        TZZWTCCjAPab33pTJB0GS+vuEx5DTg8BWNWR763g9AMAWzuyCM/6eHojbBse64EEPRMWte3w
        dKX0avjh0x3f2mTY1WrwXgPSBRT83ZiLC0YUbHp42hcaDwec1WIBK+DIlwZSKJwGsMDi8rVv
        AWjrd4uE1HL4MUOPeZZxeg6sqFMKchA0Pb2NeTBOj4XZP/owQZfC2kv/8Ex4sqvSd0wAHBke
        JoSXZGBx+VSPLKO3wRfXW/FzIKjw/4AVgFIwidPyahXHL9JGaLhDYTyr5lM0qrBd+9U24P1E
        oTG1oOflUJgDYBRwAEjhwXJpCKVgZdLdbNphTrd/hy4lieMdIIAigidKt64JYGW0ik3m9nGc
        ltP9czHKT6HHTkUc4DRRI9NLTmXlhBwtezxpU3Fm/uifUVVC4DaNfZ3+WJ9se/c0oonLvVpw
        wvy+Rx89EBVdGN8sl1cuaVrb8Ssj9Y2Z35iurHrSVs7Me+vMXlpDy78n14ZevqvckHpt3gmD
        n3igKHBqlDaSiF7fG3NvS3F15Hbj4T0riwL0ufZdg4trutdfeWg5Juo/b9gZHyo2m6pU6avi
        yseZxnxu6ZOvWTBsVF44qOCPA1H6hNyQyL603ot5sRPqugYfPQo35RjytWm80xo9d6vFFZv6
        U6qehW7GO6e4pTcOzVDHvTC/8l+9MLztyBQYsznlSvjyxg8W+/S97uwWDi3Tt/CbYoMJPoGN
        CMV1PPsXZhRjELMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSvO6mzTKJBjNOS1lc3J1qMWf9GjaL
        KR92sFq8X9bDaDHhYRu7xZfmNiaLFc/uM1lsenyN1eLyrjlsFoem7mW0ODy/jcVi6fWLTBY7
        55xktei/c53N4vjWLcwWh07OZbRouWPqIOixZt4aRo/L1y4ye+ycdZfdY8GmUo89E0+yeWxa
        1cnmcWLGbxaPzUvqPfq2rGL0+LxJLoArissmJTUnsyy1SN8ugSvjyKlrjAVNQhXTVz5iaWA8
        xN/FyMkhIWAiseDZbXYQW0hgN6PEtWYriLi0xM9/71kgbGGJlf+eA9VwAdV8YpQ48a0VLMEm
        oCexatceFpCEiMA/RokzR+YzgzjMAkcYJa5sP8kGUiUsECox59Rrxi5GDg4WAVWJuRfiQcK8
        Am4SL99sZIPYICdx81wn8wRGngWMDKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKD
        WktzB+P2VR/0DjEycTAeYpTgYFYS4VXnkEoU4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8
        kEB6YklqdmpqQWoRTJaJg1OqgWlVRuv2kHl12zn2rvViu7Jk3hN1nyfnb4o9uV2Xnn7vn3TI
        NDmt5Y+rfgs4bjh+NTf/qsTXNyxNamdOb7xkJWpzcKc1a++RU5PjPa1N26ecPffOhPVNULlL
        Ia+YlclXyS8uOl+kVJ7oMbdODkph53zjxXdlomrM0v6/r2qrSrf7yH82Y7ZZIrIm+sH7bpdO
        BsFNFhpTjwby9L2alpDsP3dNaYxguufMOxMyF0XeDw8+xVqyqG/yv5dsxR8ccn1zHZp8tWVb
        P8sIz664wpHIufXAkq7rCkwN3pqrW8pYX4m/Obvg898jHkdO+Xk23q/Qn8vcZdZwmYer02SR
        6Mq1S865mdXYfN/OXHRnF0NurBJLcUaioRZzUXEiAO+3Lu7ZAgAA
X-CMS-MailID: 20210818071602epcas5p4fecf459638312c95c5d5aaa29e7e983a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210818071602epcas5p4fecf459638312c95c5d5aaa29e7e983a
References: <CGME20210818071602epcas5p4fecf459638312c95c5d5aaa29e7e983a@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now if CONFIG_FUNCTION_GRAPH_TRACER is disabled some functions
like gic_handle_irq will not be added in irqentry text section.

which leads to adding more stacks in stackdepot as frames below IRQ
will not be filtered with filter_irq_stack() function.

checked with debug interface for satckdepot:
https://lkml.org/lkml/2017/11/22/242

e.g. (ARM)
stack count 23188 backtrace
 prep_new_page+0x14c/0x160
 get_page_from_freelist+0x1258/0x1350
...
 __handle_domain_irq+0x1ac/0x4ac
 gic_handle_irq+0x44/0x80
 __irq_svc+0x5c/0x98
 __slab_alloc.constprop.0+0x84/0xac
 __kmalloc+0x31c/0x340
 sf_malloc+0x14/0x18

and for same _irq_svc there were 25000 calls which was causing
memory pressure of 2MB more on satckdepot, which will keep increasing.

Before patch memory consumption on ARM target after 2 hours:
Memory consumed by Stackdepot:3600 KB

After change:
============
Memory consumed by Stackdepot:1744 KB

 prep_new_page+0x14c/0x160
 get_page_from_freelist+0x2e4/0x1350
...
 __handle_domain_irq+0x1ac/0x4ac
 gic_handle_irq+0x44/0x80

^^^^^ no frames below this.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
 arch/arm/include/asm/exception.h   | 2 +-
 arch/arm64/include/asm/exception.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/exception.h b/arch/arm/include/asm/exception.h
index 58e039a851af..3f4534cccc0f 100644
--- a/arch/arm/include/asm/exception.h
+++ b/arch/arm/include/asm/exception.h
@@ -10,7 +10,7 @@
 
 #include <linux/interrupt.h>
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_STACKDEPOT)
 #define __exception_irq_entry	__irq_entry
 #else
 #define __exception_irq_entry
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 339477dca551..ef2581b63405 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -13,7 +13,7 @@
 
 #include <linux/interrupt.h>
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_STACKDEPOT)
 #define __exception_irq_entry	__irq_entry
 #else
 #define __exception_irq_entry	__kprobes
-- 
2.17.1

