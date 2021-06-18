Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E43AD339
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhFRT7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFRT7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:59:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCCCC061574;
        Fri, 18 Jun 2021 12:57:40 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id v6so8435801qta.9;
        Fri, 18 Jun 2021 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gSHy9XX5ac0SC74X1Qc4ytfVVZa0gXuutSCszNjEEA=;
        b=P3zKx9s1ebph/IX+4ttM6AepayvpE8rGn7SyAYCcjtXDqBYrYBWjeJ++n4MCreKnxF
         hLl6dFC7kI4ig/EveA1eamsWjPsu5M//0GU1mROdaQELL9lQ4Qq+7gpKwRWUEn6BT7Ja
         QNzv58Z26BLi4xcv0rZEdEhISqvsLlZL8GIho1WLINgavduXAXaf37PsHDw9Ka6kg4gc
         HVOdw05u/k9zaPHfop4JHuueoqquej0OLWuvmxgySSvCyWfC7DLTNzyvzdVmLh0ekPP3
         CdcrMjqjv2Net5J58Dprgso4BfvZNgiN3N//jb7aTItfO6fAWupm3+THRCQ30wEkzYQp
         +aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gSHy9XX5ac0SC74X1Qc4ytfVVZa0gXuutSCszNjEEA=;
        b=kER3W6VbkaWRdqMxuWD+DG0SYHGoBUXeEqffvSOMbQ8935TGk5J+I55mVUXcdCg5Vm
         GV2tHKIA/CoeuJzBe6mXxdx0v6ry3PH71qlGeaSEwE6OhHS3t52M+4OVwUzG5/AaSlNG
         MEiQyDJXwGuWT0ky5HbQcZ7Dp6ueNxHzANsKhtUEPfwog8RuGGNJQuW83c0Tenxsjxyi
         kh4Ubt3ep/dGaLv64581Epn/S5jrNvb/yNtCT6bVTklrw2G84Dqs2Er0pg1UqyqgauN2
         roQ/C7SieEzk19H6VOhS6bIzwivkMXY/CG+dI8+AXqVHcPwE6w8Ehdubv59xZW/8ydRH
         Rd2A==
X-Gm-Message-State: AOAM5324ZpomRvD7R64vnFoJDut6u8S89zKne4IQFSiy7jgx3/4dp5Wr
        rA65bse/ye6Q1pz05PvgONo=
X-Google-Smtp-Source: ABdhPJy0vQHcbSO0Lh+HkuZlTrl2tpjc8loroDs42HJwo2FSOVgKoongnr62EXADc6zdqh5JuTxsaw==
X-Received: by 2002:ac8:6717:: with SMTP id e23mr11952711qtp.328.1624046259112;
        Fri, 18 Jun 2021 12:57:39 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id o13sm4604820qkg.33.2021.06.18.12.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:57:38 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Klimov <aklimov@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/3] include/linux: move for_each_bit() macros from bitops.h to find.h
Date:   Fri, 18 Jun 2021 12:57:33 -0700
Message-Id: <20210618195735.55933-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618195735.55933-1-yury.norov@gmail.com>
References: <20210618195735.55933-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_bit() macros depend on find_bit() machinery, and so the
proper place for them is the find.h header.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitops.h | 34 ----------------------------------
 include/linux/find.h   | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 26bf15e6cd35..31ae1ae1a974 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -31,40 +31,6 @@ extern unsigned long __sw_hweight64(__u64 w);
  */
 #include <asm/bitops.h>
 
-#define for_each_set_bit(bit, addr, size) \
-	for ((bit) = find_first_bit((addr), (size));		\
-	     (bit) < (size);					\
-	     (bit) = find_next_bit((addr), (size), (bit) + 1))
-
-/* same as for_each_set_bit() but use bit as value to start with */
-#define for_each_set_bit_from(bit, addr, size) \
-	for ((bit) = find_next_bit((addr), (size), (bit));	\
-	     (bit) < (size);					\
-	     (bit) = find_next_bit((addr), (size), (bit) + 1))
-
-#define for_each_clear_bit(bit, addr, size) \
-	for ((bit) = find_first_zero_bit((addr), (size));	\
-	     (bit) < (size);					\
-	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
-
-/* same as for_each_clear_bit() but use bit as value to start with */
-#define for_each_clear_bit_from(bit, addr, size) \
-	for ((bit) = find_next_zero_bit((addr), (size), (bit));	\
-	     (bit) < (size);					\
-	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
-
-/**
- * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
- * @start: bit offset to start search and to store the current iteration offset
- * @clump: location to store copy of current 8-bit clump
- * @bits: bitmap address to base the search on
- * @size: bitmap size in number of bits
- */
-#define for_each_set_clump8(start, clump, bits, size) \
-	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
-	     (start) < (size); \
-	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
-
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/include/linux/find.h b/include/linux/find.h
index 6048f8c97418..4500e8ab93e2 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -279,4 +279,38 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 #error "Please fix <asm/byteorder.h>"
 #endif
 
+#define for_each_set_bit(bit, addr, size) \
+	for ((bit) = find_first_bit((addr), (size));		\
+	     (bit) < (size);					\
+	     (bit) = find_next_bit((addr), (size), (bit) + 1))
+
+/* same as for_each_set_bit() but use bit as value to start with */
+#define for_each_set_bit_from(bit, addr, size) \
+	for ((bit) = find_next_bit((addr), (size), (bit));	\
+	     (bit) < (size);					\
+	     (bit) = find_next_bit((addr), (size), (bit) + 1))
+
+#define for_each_clear_bit(bit, addr, size) \
+	for ((bit) = find_first_zero_bit((addr), (size));	\
+	     (bit) < (size);					\
+	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
+
+/* same as for_each_clear_bit() but use bit as value to start with */
+#define for_each_clear_bit_from(bit, addr, size) \
+	for ((bit) = find_next_zero_bit((addr), (size), (bit));	\
+	     (bit) < (size);					\
+	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
+
+/**
+ * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
+ * @start: bit offset to start search and to store the current iteration offset
+ * @clump: location to store copy of current 8-bit clump
+ * @bits: bitmap address to base the search on
+ * @size: bitmap size in number of bits
+ */
+#define for_each_set_clump8(start, clump, bits, size) \
+	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
+
 #endif /*__LINUX_FIND_H_ */
-- 
2.30.2

