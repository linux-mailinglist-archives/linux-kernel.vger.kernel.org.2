Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C047032C009
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580709AbhCCSeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233615AbhCCRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=veDG5mWnaW2Ixi8XXsaq9WVUVN6IJdn0R3qA8goBbxk=;
        b=JESHL22cVsNiqSB573rcRtypgoGuicyr3AI6YzvlrscyEMWmcSzdpScIt4Ljl1z2tTqmTv
        fE/JNxFJ/IX6opRe6BaIurpY8Ho+ti3b7LXTPPn6IzUXl+wBcgrflDcmN86GakYLk+4Ocv
        s7II6u102DYijwVK7h+yol85JlyeUTU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-WGtdc4hLM8aXiQjIb-Tydw-1; Wed, 03 Mar 2021 12:09:38 -0500
X-MC-Unique: WGtdc4hLM8aXiQjIb-Tydw-1
Received: by mail-wm1-f69.google.com with SMTP id 73so3238317wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veDG5mWnaW2Ixi8XXsaq9WVUVN6IJdn0R3qA8goBbxk=;
        b=qpx1jAGFo14m7lRrEb6snXj2ID1dd4RZoRIOuWl2Che6M7QRQ0E2J1+jxk9CDkokro
         0HGLLzoc4xYmDyEia+8WEs9Ql0PG6KkVD5SsunNAAECnfFEcSlmGPeFTiJMaRiQzAOpw
         zjzQafK+DqQmtcUGI+F+AuXMVVCde+U+1HRX3J9MZoAFBaZyQIYskeUtsNNzHtGkiYG5
         +hmKWTtLE5gzCaZKjk8AaA+2EiePV+5KiKaeafnhp/vLTE4aN7XeLGu/cTfKsLsMxYnA
         HvARw/3//7xW5/ad7U/jA11SKz5BiRXvJHbIfHtEglGUdHp+renraSINI4OS4w/8Oz5z
         6xEQ==
X-Gm-Message-State: AOAM533eyMXVmvyJ9Ibgl/YFTMIdTuqzKmWZcxc4YEavYWKVXxVVwjmH
        NzmaKOqapw22S+CTgbledy9b9+vPOfowbnQCl/1H/RoSlTfmOQtMDusTlY44VA4+/04WRmwF1KP
        TUv+evyomlhF9hhHYFZN9PLuEEYyx73LT25ROB/bOCSMDupObhAWNmCAaVkPIAqdZL1OUekWskn
        yF
X-Received: by 2002:a1c:61c5:: with SMTP id v188mr59159wmb.20.1614791376751;
        Wed, 03 Mar 2021 09:09:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzhDQZ+s/NI/1B1EbyXSt31bBGjjeVdDK85kcAh88dezDt+gBgYoYgN+Eti1TVjzq8OWbTJQ==
X-Received: by 2002:a1c:61c5:: with SMTP id v188mr59124wmb.20.1614791376321;
        Wed, 03 Mar 2021 09:09:36 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:35 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 01/13] tools: Add some generic functions and headers
Date:   Wed,  3 Mar 2021 18:09:20 +0100
Message-Id: <20210303170932.1838634-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be needed to be able to use arm64 instruction decoder in
userland tools.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/include/asm-generic/bitops/__ffs.h | 11 +++++++
 tools/include/linux/kernel.h             | 21 +++++++++++++
 tools/include/linux/printk.h             | 40 ++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 tools/include/linux/printk.h

diff --git a/tools/include/asm-generic/bitops/__ffs.h b/tools/include/asm-generic/bitops/__ffs.h
index 9d1310519497..963f8a22212f 100644
--- a/tools/include/asm-generic/bitops/__ffs.h
+++ b/tools/include/asm-generic/bitops/__ffs.h
@@ -42,4 +42,15 @@ static __always_inline unsigned long __ffs(unsigned long word)
 	return num;
 }
 
+static inline unsigned long __ffs64(u64 word)
+{
+#if BITS_PER_LONG == 32
+	if (((u32)word) == 0UL)
+		return __ffs((u32)(word >> 32)) + 32;
+#elif BITS_PER_LONG != 64
+#error BITS_PER_LONG not 32 or 64
+#endif
+	return __ffs((unsigned long)word);
+}
+
 #endif /* _TOOLS_LINUX_ASM_GENERIC_BITOPS___FFS_H_ */
diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index a7e54a08fb54..e748982ed5c1 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -114,6 +114,27 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 
+/**
+ * upper_32_bits - return bits 32-63 of a number
+ * @n: the number we're accessing
+ *
+ * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
+ * the "right shift count >= width of type" warning when that quantity is
+ * 32-bits.
+ */
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+
+/**
+ * lower_32_bits - return bits 0-31 of a number
+ * @n: the number we're accessing
+ */
+#define lower_32_bits(n) ((u32)(n))
+
+/* Inspired from ALIGN_*_KERNEL */
+#define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+#define __ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a) - 1)
+#define ALIGN_DOWN(x, a)	__ALIGN((x) - ((a) - 1), (a))
+
 #define current_gfp_context(k) 0
 #define synchronize_rcu()
 
diff --git a/tools/include/linux/printk.h b/tools/include/linux/printk.h
new file mode 100644
index 000000000000..515ebdc47e6e
--- /dev/null
+++ b/tools/include/linux/printk.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_KERNEL_PRINTK_H_
+#define _TOOLS_LINUX_KERNEL_PRINTK_H_
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#define printk(fmt, ...) fprintf(stdout, fmt, ##__VA_ARGS__)
+#define pr_info printk
+#define pr_notice printk
+#define pr_cont printk
+
+#define pr_warn(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
+#define pr_err pr_warn
+#define pr_alert pr_warn
+#define pr_emerg pr_warn
+#define pr_crit pr_warn
+
+/*
+ * Dummy printk for disabled debugging statements to use whilst maintaining
+ * gcc's format checking.
+ */
+#define no_printk(fmt, ...)				\
+({							\
+	if (0)						\
+		printk(fmt, ##__VA_ARGS__);		\
+	0;						\
+})
+
+/* pr_devel() should produce zero code unless DEBUG is defined */
+#ifdef DEBUG
+#define pr_devel(fmt, ...) printk
+#else
+#define pr_devel(fmt, ...) no_printk
+#endif
+
+#define pr_debug pr_devel
+
+#endif /* _TOOLS_LINUX_KERNEL_PRINTK_H_ */
-- 
2.25.4

