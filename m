Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423193E33E9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 09:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhHGHXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 03:23:32 -0400
Received: from smtpbg127.qq.com ([109.244.180.96]:43394 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231317AbhHGHXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 03:23:30 -0400
X-QQ-mid: bizesmtp46t1628320958tjmcxxi0
Received: from localhost.localdomain (unknown [125.69.42.194])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 07 Aug 2021 15:22:36 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: Cjrn31CahfWgDw7UMKXdHlRwa6tXiaeZj606PdrsMAHJvFwTr0Ol7tAVgd2t8
        8UQrp4Od/ZW3X5HNjCgZFyNBvEbu9AafqzaF99RZi+ml2VeAYkbD7ps6SEejQPt3ujh/POt
        DnmqPAWay4LJ405EYx/Q2B6R32YTkLL7cfXmULMmWM8k+mB7j5GX3BlgLNtX5bbFKUzhMRc
        LcOdf4GZqbUdeHMjDZdMUEVRN7ILm9Nuy84E6fQq9/iD4FT+SJa4Egus2qLMfxzwNHL0vb8
        PaJSpLQmJw1g1FBgJpkg40ic34WVJ1QG+y81CR+1XCc/A3NkDtCUVVqsw5sEpF0MMJIdXOU
        aLLtFZw1qbGWCmoRNc=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, wangborong@cdjrlc.com,
        wangkefeng.wang@huawei.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: use strscpy to replace strlcpy
Date:   Sat,  7 Aug 2021 15:21:54 +0800
Message-Id: <20210807072154.64512-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy should not be used because it doesn't limit the source
length. As linus says, it's a completely useless function if you
can't implicitly trust the source string - but that is almost always
why people think they should use it! All in all the BSD function
will lead some potential bugs.

But the strscpy doesn't require reading memory from the src string
beyond the specified "count" bytes, and since the return value is
easier to error-check than strlcpy()'s. In addition, the implementation
is robust to the string changing out from underneath it, unlike the
current strlcpy() implementation.

Thus, We prefer using strscpy instead of strlcpy.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/platforms/powermac/bootx_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index d20ef35e6d9d..741aa5b89e55 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -243,7 +243,7 @@ static void __init bootx_scan_dt_build_strings(unsigned long base,
 		DBG(" detected display ! adding properties names !\n");
 		bootx_dt_add_string("linux,boot-display", mem_end);
 		bootx_dt_add_string("linux,opened", mem_end);
-		strlcpy(bootx_disp_path, namep, sizeof(bootx_disp_path));
+		strscpy(bootx_disp_path, namep, sizeof(bootx_disp_path));
 	}
 
 	/* get and store all property names */
-- 
2.32.0

