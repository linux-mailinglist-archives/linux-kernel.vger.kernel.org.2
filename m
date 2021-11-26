Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C0B45EF3D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353673AbhKZNjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbhKZNhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:37:38 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4BBC061D61
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 04:48:07 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso5376741wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 04:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bOAgTPG+aazim//zgR5B0N7H6IQzA2XMfOeXBLYH/J4=;
        b=UtrPhcH+CtAU21bpu/2JDOkxE2DZ074L/MQNFNMfWYDYmZX9F/qdm+7EAlRo1i8ONK
         eN6DSNKkPwqkrOaTuCvYGOBz3McoW+4+kQ3gUWZdQOMjgwiDcGdce+Dc8Dk3ePOIbLLZ
         W6wd0bTV8Pg0nJ50HQ0OmmMHHO4J1PTXw+c9kOcmbBnb1oP/Jmry40/DW0n0HeIn4nEd
         RXwzzKI7UDzREtodYx0rqJLA0BvwN47uVlA0s80c4RlFCqkmqc3TuPcvvo010sDo2ppE
         aOnY2zGtc5XB4vfMbesNSLlJwRVC5X7egQu3KKE9zIsElhf0xmp0vEumERVf4S8yCoum
         BDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bOAgTPG+aazim//zgR5B0N7H6IQzA2XMfOeXBLYH/J4=;
        b=kJZVn3rM6nXQjoeG/rtN26vosQceeQc61Zg1CDaYV5SGcaQYspi8t3t1Jr8kOKj/OL
         qA+qz+Fb2yVzIALmo/SgxVNif0u3Z/3utt538q2LnGV5oILBCD58e4jGf2DCr7E893UF
         p1T21y4Dl5Dba5Nnk0Zym6WeRjnuQUujOlBUgnEv/DR1wE2BZJ/MeGaRYSQdQsWbIzi6
         YocMJYvvCbG/am5+nb1JPhWmxX2RGIIPLbQ9Nk6Hr2EIg7lZHLIQG04r+Uoxjemjx5oV
         jri11EMzYk1JeZD6LQ8X7IA36oldlA6XQku/qoq0nhrvCfdD7AxRQuuVfNpr0izU11oA
         S35g==
X-Gm-Message-State: AOAM533n9MnLyNjXFXJEE2lL3SLjSz0emagaFgxqmoP5iDWnzbTKgj1k
        jA1tHZJ1lzZXZ7k/wJaI+T/otKtQCcs=
X-Google-Smtp-Source: ABdhPJxol6QbasPt5xTk04oKl0Y0sRQPpyymixpwHGL7zgu+aRt+F3dF5zbRy04k0liS7eWu3xi7uImiASY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:113a:6874:5633:ed1b])
 (user=glider job=sendgmr) by 2002:a05:600c:1ca4:: with SMTP id
 k36mr15019165wms.169.1637930885532; Fri, 26 Nov 2021 04:48:05 -0800 (PST)
Date:   Fri, 26 Nov 2021 13:47:46 +0100
Message-Id: <20211126124746.761278-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] x86/fpu/signal: initialize sw_bytes in save_xstate_epilog()
From:   Alexander Potapenko <glider@google.com>
To:     tglx@linutronix.de, chang.seok.bae@intel.com, bp@suse.de
Cc:     dvyukov@google.com, elver@google.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

save_sw_bytes() did not fully initialize sw_bytes, which caused KMSAN
to report an infoleak (see below).
Initialize sw_bytes explicitly to avoid this.

KMSAN report follows:

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user ./include/linux/instrumented.h:121
BUG: KMSAN: kernel-infoleak in __copy_to_user ./include/linux/uaccess.h:154
BUG: KMSAN: kernel-infoleak in save_xstate_epilog+0x2df/0x510 arch/x86/kernel/fpu/signal.c:127
 instrument_copy_to_user ./include/linux/instrumented.h:121
 __copy_to_user ./include/linux/uaccess.h:154
 save_xstate_epilog+0x2df/0x510 arch/x86/kernel/fpu/signal.c:127
 copy_fpstate_to_sigframe+0x861/0xb60 arch/x86/kernel/fpu/signal.c:245
 get_sigframe+0x656/0x7e0 arch/x86/kernel/signal.c:296
 __setup_rt_frame+0x14d/0x2a60 arch/x86/kernel/signal.c:471
 setup_rt_frame arch/x86/kernel/signal.c:781
 handle_signal arch/x86/kernel/signal.c:825
 arch_do_signal_or_restart+0x417/0xdd0 arch/x86/kernel/signal.c:870
 handle_signal_work kernel/entry/common.c:149
 exit_to_user_mode_loop+0x1f6/0x490 kernel/entry/common.c:173
 exit_to_user_mode_prepare kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290
 syscall_exit_to_user_mode+0x7e/0xc0 kernel/entry/common.c:302
 do_syscall_64+0x60/0xd0 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x44/0xae ??:?

Local variable sw_bytes created at:
 save_xstate_epilog+0x80/0x510 arch/x86/kernel/fpu/signal.c:121
 copy_fpstate_to_sigframe+0x861/0xb60 arch/x86/kernel/fpu/signal.c:245

Bytes 20-47 of 48 are uninitialized
Memory access of size 48 starts at ffff8880801d3a18
Data copied to user address 00007ffd90e2ef50
=====================================================

Reported-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Fixes: 53599b4d54b9b8dd ("x86/fpu/signal: Prepare for variable sigframe length")
Link: https://lore.kernel.org/all/CAG_fn=V9T6OKPonSjsi9PmWB0hMHFC=yawozdft8i1-MSxrv=w@mail.gmail.com/
---
 arch/x86/kernel/fpu/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index d5958278eba6d..91d4b6de58abe 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -118,7 +118,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 				      struct fpstate *fpstate)
 {
 	struct xregs_state __user *x = buf;
-	struct _fpx_sw_bytes sw_bytes;
+	struct _fpx_sw_bytes sw_bytes = {};
 	u32 xfeatures;
 	int err;
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

