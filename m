Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866744189C8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhIZPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhIZPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:12:41 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778BC061714
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w8so15302630pgf.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCyxXp6YhEkTYhQl4V4f1d1n0+TejnqWneDkxQhc6BY=;
        b=DY1HfLro95ZdGJZAGx80gMhkpt4zBcVnWSBKF/r9oEWeCSUsam4V+Cp8ZZATkwxwgB
         MBJm32uQXy9+2SMtKNk/QvGbStsPg8ByoQhi0PlJne+Qihn/tTakoNHD3nyVi+TyRxk5
         Kdx7qDPzZLayVOjR1cB3MTL8jvQrT3TcqVIdalcuOgvrtpoa7INv2q6gSiFt/yRx7j58
         h+R2QkFCHzM6W4j+l1anYKPpob5GqdbcFwgydrEnYk0fZHNcmQUQXMHvqUXXpV81Ylg8
         661tSifYkhWiGcAHcc/BF858J8bnCblf/W9Ikw4Gh3WsRSpWl26YKo5VU71NkeyK+plm
         eXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCyxXp6YhEkTYhQl4V4f1d1n0+TejnqWneDkxQhc6BY=;
        b=CLWQVVFD5cStjerfCZTMVh/mxMD2c7DKxpKizra363F4ZP514xRNpv14omfng1I5Hg
         XosyXeVgQL93+VaegRsueAO/11+y9vEoOSQg5KAX1CpKZqLXrorXsB0y599hRgg5DnqD
         0xp71kpqTZDRofNnoUjEkz5OtcGvny7cTJ8okrnb/bypIEopSPFjT165anftRV5W+Ifz
         WTr+UIGzZNrzNeonhOEUOTVyuUiTuRUpXFTVFakcgzqi5D8G31g1WnWGPh6fr1ce/cLG
         HxbLiIkoH8/BbzywbdOWAqWcFE8mk0P7vagkURHthpv/CgWBdrV4u7JoTQR4V8Tw/mSj
         s/yg==
X-Gm-Message-State: AOAM53122Uip6BH2hkVUjC8vrVX0tfCg+sIY8QDFjcUR/sf6q7YEz6QB
        44A4Yaa+erWLdHP1amqRiHFI/PA1bz4LMQ==
X-Google-Smtp-Source: ABdhPJxQty9G0YY7MWiRWIj6ahokeGWO7oiykDGLpf8tpTKqi3PZaMFPdrAYrpqVxOmbqFG0eaRxBw==
X-Received: by 2002:aa7:8609:0:b0:44b:346a:7404 with SMTP id p9-20020aa78609000000b0044b346a7404mr19135700pfn.86.1632669064086;
        Sun, 26 Sep 2021 08:11:04 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id m186sm12588914pfb.165.2021.09.26.08.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:11:03 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 22/41] x86/entry: Add the C version get_percpu_base()
Date:   Sun, 26 Sep 2021 23:08:19 +0800
Message-Id: <20210926150838.197719-23-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It implements the C version of asm macro GET_PERCPU_BASE().

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 2db9ae3508f1..b939b56d985d 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -193,3 +193,39 @@ struct pt_regs *error_entry(struct pt_regs *eregs)
 	/* Enter from kernel, don't move pt_regs */
 	return eregs;
 }
+
+#ifdef CONFIG_SMP
+/*
+ * CPU/node NR is loaded from the limit (size) field of a special segment
+ * descriptor entry in GDT.
+ *
+ * Do not use RDPID, because KVM loads guest's TSC_AUX on vm-entry and
+ * may not restore the host's value until the CPU returns to userspace.
+ * Thus the kernel would consume a guest's TSC_AUX if an NMI arrives
+ * while running KVM's run loop.
+ */
+static __always_inline unsigned int gdt_get_cpu(void)
+{
+	unsigned int p;
+
+	asm ("lsl %[seg],%[p]" : [p] "=a" (p) : [seg] "r" (__CPUNODE_SEG));
+
+	return p & VDSO_CPUNODE_MASK;
+}
+
+/*
+ * Fetch the per-CPU GSBASE value for this processor.
+ *
+ * We normally use %gs for accessing per-CPU data, but we are setting up
+ * %gs here and obviously can not use %gs itself to access per-CPU data.
+ */
+static __always_inline unsigned long get_percpu_base(void)
+{
+	return __per_cpu_offset[gdt_get_cpu()];
+}
+#else
+static __always_inline unsigned long get_percpu_base(void)
+{
+	return pcpu_unit_offsets;
+}
+#endif
-- 
2.19.1.6.gb485710b

