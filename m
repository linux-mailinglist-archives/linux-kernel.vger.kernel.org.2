Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73DB32AE5C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838237AbhCBXGt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Mar 2021 18:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376685AbhCBWe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:34:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA84464F2D;
        Tue,  2 Mar 2021 22:33:36 +0000 (UTC)
Date:   Tue, 2 Mar 2021 17:33:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will@kernel.org>
Cc:     Li Huafei <lihuafei1@huawei.com>, gregory.herrero@oracle.com,
        catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, zhangjinhao2@huawei.com,
        yangjihong1@huawei.com, xukuohai@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Chen Jun <chenjun102@huawei.com>
Subject: Re: [PATCH] recordmcount: Fix the wrong use of w* in
 arm64_is_fake_mcount()
Message-ID: <20210302173335.71eded37@gandalf.local.home>
In-Reply-To: <20210302173058.28fd3d36@gandalf.local.home>
References: <20210225140747.10818-1-lihuafei1@huawei.com>
        <20210225094426.7729b9cc@gandalf.local.home>
        <20210225160116.GA13604@willie-the-truck>
        <20210302173058.28fd3d36@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 17:30:58 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I just realized that I received this patch twice, and thought it was the
> same patch! Chen was three days ahead of you, so he get's the credit ;-)
> 
>  https://lore.kernel.org/r/20210222135840.56250-1-chenjun102@huawei.com

I'm applying this patch (same one here but came earlier).

Will, you still OK with your acked-by on it?

-- Steve

From 999340d51174ce4141dd723105d4cef872b13ee9 Mon Sep 17 00:00:00 2001
From: Chen Jun <chenjun102@huawei.com>
Date: Mon, 22 Feb 2021 13:58:40 +0000
Subject: [PATCH] ftrace: Have recordmcount use w8 to read relp->r_info in
 arm64_is_fake_mcount

On little endian system, Use aarch64_be(gcc v7.3) downloaded from
linaro.org to build image with CONFIG_CPU_BIG_ENDIAN = y,
CONFIG_FTRACE = y, CONFIG_DYNAMIC_FTRACE = y.

gcc will create symbols of _mcount but recordmcount can not create
mcount_loc for *.o.
aarch64_be-linux-gnu-objdump -r fs/namei.o | grep mcount
00000000000000d0 R_AARCH64_CALL26  _mcount
...
0000000000007190 R_AARCH64_CALL26  _mcount

The reason is than funciton arm64_is_fake_mcount can not work correctly.
A symbol of _mcount in *.o compiled with big endian compiler likes:
00 00 00 2d 00 00 01 1b
w(rp->r_info) will return 0x2d instead of 0x011b. Because w() takes
uint32_t as parameter, which truncates rp->r_info.

Use w8() instead w() to read relp->r_info

Link: https://lkml.kernel.org/r/20210222135840.56250-1-chenjun102@huawei.com

Fixes: ea0eada45632 ("recordmcount: only record relocation of type R_AARCH64_CALL26 on arm64.")
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Chen Jun <chenjun102@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/recordmcount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index b9c2ee7ab43f..cce12e1971d8 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -438,7 +438,7 @@ static int arm_is_fake_mcount(Elf32_Rel const *rp)
 
 static int arm64_is_fake_mcount(Elf64_Rel const *rp)
 {
-	return ELF64_R_TYPE(w(rp->r_info)) != R_AARCH64_CALL26;
+	return ELF64_R_TYPE(w8(rp->r_info)) != R_AARCH64_CALL26;
 }
 
 /* 64-bit EM_MIPS has weird ELF64_Rela.r_info.
-- 
2.25.4

