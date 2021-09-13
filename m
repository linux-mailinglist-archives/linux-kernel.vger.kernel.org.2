Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489984082EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 04:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhIMCuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 22:50:37 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34650 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236902AbhIMCug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 22:50:36 -0400
X-UUID: 736645b2051b4fdc9a00226ec62e7e60-20210913
X-UUID: 736645b2051b4fdc9a00226ec62e7e60-20210913
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1364295399; Mon, 13 Sep 2021 10:49:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Sep 2021 10:49:14 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Sep 2021 10:49:14 +0800
Message-ID: <78cf3af71e035a79d021d17c6fd8a09dd1e4984d.camel@mediatek.com>
Subject: Re: Build error: =?UTF-8?Q?=E2=80=98EM=5FRISCV=E2=80=99?= undeclared
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Palmer Dabbelt" <palmerdabbelt@google.com>
Date:   Mon, 13 Sep 2021 10:49:14 +0800
In-Reply-To: <e8965b25-f15b-c7b4-748c-d207dda9c8e8@i2se.com>
References: <e8965b25-f15b-c7b4-748c-d207dda9c8e8@i2se.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-09-12 at 12:29 +0200, Stefan Wahren wrote:
> Hi,
> 
> i tried to compile current torvalds tree
> ("78e709522d2c012cb0daad2e668506637bffb7c2") for
> arm/multi_v7_defconfig
> and get the following build issue:
> 
>   UPD     include/generated/utsrelease.h
> scripts/sorttable.c: In function ‘do_file’:
> scripts/sorttable.c:352:7: error: ‘EM_RISCV’ undeclared (first use in
> this function)
>   case EM_RISCV:
>        ^
> scripts/sorttable.c:352:7: note: each undeclared identifier is
> reported
> only once for each function it appears in
> 
> I assume this is caused by:
> 
> 54fed35fd3939398be292e4090b0b1c5ff2238b4 ("riscv: Enable
> BUILDTIME_TABLE_SORT")

I hit this error too. I add the follow conditional EM_RISCV
definition in sorttable.c to build pass (arm64/defconfig).

I will submit a patch out.

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index f355869c65cd..6ee4fa882919 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -54,6 +54,10 @@
 #define EM_ARCV2       195
 #endif

+#ifndef EM_RISCV
+#define EM_RISCV       243
+#endif
+
> 
> Best regards
> Stefan
> 
> 

