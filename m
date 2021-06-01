Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E199396FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhFAIzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:55:44 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:60526
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S233490AbhFAIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=m9LL399ILz
        20RgYF3fYOGvoXzm8cDo6cEirQKcwpM3g=; b=Ye+QssGeu0AQrRLF9Lu5++m35U
        qM3mBeVTjFk8EA77CJzGDOwVsQhrDB+GFxGuTLrANYTfsY8mpYG91dNkQQ4ZXPE7
        NSgBouXfw0zjgUV0yZ/bCJZ9ojsaYTktcOAVRYnv40ZeRgbQCtzYKsYUXiqZdVs5
        9P2mvAeVCs65FAxcQ=
Received: from localhost.localdomain (unknown [222.29.156.242])
        by front01 (Coremail) with SMTP id 5oFpogBXOe5f9bVgA6tTAA--.10742S2;
        Tue, 01 Jun 2021 16:52:53 +0800 (CST)
From:   Jiashuo Liang <liangjs@pku.edu.cn>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Jiashuo Liang <liangjs@pku.edu.cn>
Subject: [PATCH] signal/x86: Don't send SIGSEGV twice on SEGV_PKUERR
Date:   Tue,  1 Jun 2021 16:52:03 +0800
Message-Id: <20210601085203.40214-1-liangjs@pku.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBXOe5f9bVgA6tTAA--.10742S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1xuw1DGr1ftF4kGFy7GFg_yoWkAwb_ZF
        yIvayUua1rX39xu3WUKr17Wr4S93WDJF1rGr10vFZ0q34YqFZ3KayIkF4jqr1jqa10kF9x
        Jr9IvrW5Kw1IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbaAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2z280
        aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07
        x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAF
        wVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFV
        Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
        x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
        1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j
        6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7VUjNJ55UUUUU==
X-CM-SenderInfo: isqqijqrtqmio6sn3hxhgxhubq/1tbiAwETBVPy7ruQCgAFs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch, the __bad_area_nosemaphore function calls both
force_sig_pkuerr and force_sig_fault when handling SEGV_PKUERR. This does
not cause problems because the second signal is filtered by the
legacy_queue check in __send_signal. But it causes the kernel to do
unnecessary work.

This patch should fix it.

Fixes: 9db812dbb29d ("signal/x86: Call force_sig_pkuerr from __bad_area_nosemaphore")
Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Jiashuo Liang <liangjs@pku.edu.cn>
---
 arch/x86/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1c548ad00752..6bda7f67d737 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -836,8 +836,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 
 	if (si_code == SEGV_PKUERR)
 		force_sig_pkuerr((void __user *)address, pkey);
-
-	force_sig_fault(SIGSEGV, si_code, (void __user *)address);
+	else
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 
 	local_irq_disable();
 }
-- 
2.31.1

