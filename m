Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACF5401B58
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbhIFMpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:45:01 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10817 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241553AbhIFMo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:44:59 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210906124353epoutp01687bb91844789e19320ba8260c30c8ab~iPDnJ3udW2982129821epoutp01o
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:43:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210906124353epoutp01687bb91844789e19320ba8260c30c8ab~iPDnJ3udW2982129821epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630932233;
        bh=EFp0m3tslH5KjpSoT1hMcrA4KY3cyIg9bqTxXSjX/RA=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=sgVa/UyRiFBfk60bo/Ud0GRrn5zBibnpSK0IJXD8qwRbEj93MiwxMry30BUVHUM0L
         84vd67MAMueyPgKao22rQv1CGia2jR+WU2k9+oEL38Xj5pmdqYZbaM01jArJp/OfAl
         hQZ0CzeIXq1E4O3dHAHH/qzeZZ7q3ZXos/Kevyzo=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210906124352epcas5p415d157ca83aad931d48291f6992220f5~iPDl82cyn1714217142epcas5p43;
        Mon,  6 Sep 2021 12:43:52 +0000 (GMT)
X-AuditID: b6c32a4b-23bff700000095ca-5b-61360d082cab
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.55.38346.80D06316; Mon,  6 Sep 2021 21:43:52 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] exception/stackdepot: add irqentry section in case
 of STACKDEPOT
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Maninder Singh <maninder1.s@samsung.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "joey.gouly@arm.com" <joey.gouly@arm.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "pcc@google.com" <pcc@google.com>,
        "amit.kachhap@arm.com" <amit.kachhap@arm.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Vaneet Narang <v.narang@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1629270943-9304-1-git-send-email-maninder1.s@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210906124351epcms5p6020fbfe5f885f1e8834a72784b28d434@epcms5p6>
Date:   Mon, 06 Sep 2021 18:13:51 +0530
X-CMS-MailID: 20210906124351epcms5p6020fbfe5f885f1e8834a72784b28d434
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7bCmui4Hr1miwcGZ8hYXd6dazFm/hs1i
        yocdrBbvl/UwWkx42MZu8aW5jclixbP7TBabHl9jtbi8aw6bxaGpexktDs9vY7FYev0ik8XO
        OSdZLfrvXGezOL51C7PFoZNzGS1a7pg6CHqsmbeG0ePytYvMHjtn3WX3WLCp1GPPxJNsHptW
        dbJ5nJjxm8Vj85J6j74tqxg9Pm+SC+CK4rJJSc3JLEst0rdL4Mp4OamLvaBNuOLlNY8GxhkC
        XYycHBICJhJ35q9j7WLk4hAS2M0oMeldE1MXIwcHr4CgxN8dwiA1wgLREhvOXmMHsYUEFCUu
        zFjDCFIiLGAg8WurBkiYTUBPYtWuPSwgY0QE1rJIzH69C8xhFljIJLHswSxmiGW8EjPan7JA
        2NIS25dvZQSxOQXcJU4fW8gKEReVuLn6LTuM/f7YfEYIW0Si9d5ZqDmCEg9+7oaKy0is3twL
        tkxCoJtRYv27vVDODEaJnkfToDrMJdYvWQU2lVfAV2Ljv9lgV7AIqEpcf/GPHeQdCQEXia2T
        REHCzALyEtvfzmEGCTMLaEqs36UPEeaT6P39hAnmlx3zYGxViZabG1hh/vr88SMLxEQPiSVr
        FSBh28co8WHGKeYJjPKzEME7C8myWQjLFjAyr2KUTC0ozk1PLTYtMM5LLdcrTswtLs1L10vO
        z93ECE5uWt47GB89+KB3iJGJg/EQowQHs5IIb7SzUaIQb0piZVVqUX58UWlOavEhRmkOFiVx
        Xt1XMolCAumJJanZqakFqUUwWSYOTqkGpnnGOzm1lnjrv1e3ET18XOHtVd3XXGwVx7iMPRZu
        8U8we78/miW0a5dlzO3EebsWvbizfub01RuvrAvaeiFev3CWWiCf72xxdoXnv6afWXqs88qk
        3S/OMAhLOph2XJFedfWZn8zeZPm/app6IVIpX0okdcXNLycc+v1ValOAZqh56xoegy3PzaM/
        zloVvSVu/WG/kuUi8+r0/ZjO7/yf/v38jddBe/8n1q0XXOLjFbimI+KMiK7fX3uJdJUM9YCS
        2riZYQIXNBYdNlK3zT+f0Rf/qKzhimV8ruhs8bTdklN0AwrfyS6aNP1x0Debp5/X/gipzW5n
        V3zoFMcaypDNpdNhKf21UlUq96fbI9VaJZbijERDLeai4kQAQrbsb90DAAA=
X-CMS-RootMailID: 20210818071602epcas5p4fecf459638312c95c5d5aaa29e7e983a
References: <1629270943-9304-1-git-send-email-maninder1.s@samsung.com>
        <CGME20210818071602epcas5p4fecf459638312c95c5d5aaa29e7e983a@epcms5p6>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Any inputs on this?

>As of now if CONFIG_FUNCTION_GRAPH_TRACER is disabled some functions
>like gic_handle_irq will not be added in irqentry text section.
> 
>which leads to adding more stacks in stackdepot as frames below IRQ
>will not be filtered with filter_irq_stack() function.
> 
>checked with debug interface for satckdepot:
>https://lkml.org/lkml/2017/11/22/242
> 
>e.g. (ARM)
>stack count 23188 backtrace
> prep_new_page+0x14c/0x160
> get_page_from_freelist+0x1258/0x1350
>...
> __handle_domain_irq+0x1ac/0x4ac
> gic_handle_irq+0x44/0x80
> __irq_svc+0x5c/0x98
> __slab_alloc.constprop.0+0x84/0xac
> __kmalloc+0x31c/0x340
> sf_malloc+0x14/0x18
> 
>and for same _irq_svc there were 25000 calls which was causing
>memory pressure of 2MB more on satckdepot, which will keep increasing.
> 
>Before patch memory consumption on ARM target after 2 hours:
>Memory consumed by Stackdepot:3600 KB
> 
>After change:
>============
>Memory consumed by Stackdepot:1744 KB
> 
> prep_new_page+0x14c/0x160
> get_page_from_freelist+0x2e4/0x1350
>...
> __handle_domain_irq+0x1ac/0x4ac
> gic_handle_irq+0x44/0x80
> 
>^^^^^ no frames below this.
> 
>Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
>Signed-off-by: Vaneet Narang <v.narang@samsung.com>
>---
> arch/arm/include/asm/exception.h   | 2 +-
> arch/arm64/include/asm/exception.h | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
> 
>diff --git a/arch/arm/include/asm/exception.h b/arch/arm/include/asm/exception.h
>index 58e039a851af..3f4534cccc0f 100644
>--- a/arch/arm/include/asm/exception.h
>+++ b/arch/arm/include/asm/exception.h
>@@ -10,7 +10,7 @@
> 
> #include <linux/interrupt.h>
> 
>-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>+#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_STACKDEPOT)
> #define __exception_irq_entry        __irq_entry
> #else
> #define __exception_irq_entry
>diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
>index 339477dca551..ef2581b63405 100644
>--- a/arch/arm64/include/asm/exception.h
>+++ b/arch/arm64/include/asm/exception.h
>@@ -13,7 +13,7 @@
> 
> #include <linux/interrupt.h>
> 
>-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>+#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_STACKDEPOT)
> #define __exception_irq_entry        __irq_entry
> #else
> #define __exception_irq_entry        __kprobes
>-- 

 
 
