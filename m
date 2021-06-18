Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E306A3AD33B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhFRT7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhFRT7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:59:50 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA1EC061574;
        Fri, 18 Jun 2021 12:57:41 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l2so5698856qtq.10;
        Fri, 18 Jun 2021 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GY9x7msUmJcvaumS+lj9smAT8dHRMoBPIwcLcMKiK3A=;
        b=JdNn1KT6TaQiFeDktSjY8UE5naaRUyEo00QMZxWZ9sw35X6hk+553w0kNL3zV410JW
         L0Qp1o8ZkEhtOtAPbaSOKdK/GrfFzjPu8BEk9xexJEGgU/7ug2sB2vjt4b8GgBLtu4hn
         TwQ+DN8Sq9naCNurHRsMXJHDC70tVQP4fSf8t+V72eAK9ptEBZlnrd09dbjAn7yLw+JL
         XQHN0tLJdkWG5xcDJMXyergwK6RJX1NdaMlDDgy6pK9qFvjZedSRg1xaoBNEfGRchE6G
         jnK8fez/fvUKesUSARApcZ3MLPratI2k5reCSwouuTQHvZZQcmNXWqDBY8jSL3+0FnGF
         MIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GY9x7msUmJcvaumS+lj9smAT8dHRMoBPIwcLcMKiK3A=;
        b=gtvSpvxQP/qccRta8HSwAIPhPf2nG+iuoBJ6/fiMV+s0xH5W5bx1kib77bdxzTbXpA
         jLhiB21SSLkutW96vlkTV9xByp56J3PT98vHveCYg/ssK5VRQa0dJZ6xARvkj7M2Lcyd
         VMaawskFROFa4YK3ddiD98gGJp2vVHza2hB5/QDSldLlEacV+WkfnxAVGZ3ui4VgGtP9
         B8TPwyZ1ycBahzvvb8VmfvyLtNBmhhl+5LXVvwlYd0uyo1NPOwJoOET8yyZr6TgA1hrN
         VWsxQ7eApkJdu2w3CM3AEOX7tCFRN3cReaP38X/oGcwZcezTZBvagK5vulyJWCcASVi3
         yWCw==
X-Gm-Message-State: AOAM5323VBd1IFrSa6dgjTFSAA1tJY0Y24lljWKbJOvcZRpWz1eJg+DX
        9VhkksVcu1+E7Z3KkNc+Wqs=
X-Google-Smtp-Source: ABdhPJxMXyrerRHfnKt4Y5jcTbuNcjxScLwJjwRAfJiwC4Sjv0jNq9Ke3GcbBRz8auKFW61AAw6YEw==
X-Received: by 2002:ac8:694b:: with SMTP id n11mr12234191qtr.97.1624046260236;
        Fri, 18 Jun 2021 12:57:40 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id o13sm23438qki.44.2021.06.18.12.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:57:39 -0700 (PDT)
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
Subject: [PATCH 2/3] find: micro-optimize for_each_{set,clear}_bit()
Date:   Fri, 18 Jun 2021 12:57:34 -0700
Message-Id: <20210618195735.55933-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618195735.55933-1-yury.norov@gmail.com>
References: <20210618195735.55933-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros iterate thru all set/clear bits in a bitmap. They search a
first bit using find_first_bit(), and the rest bits using find_next_bit().

Since find_next_bit() is called shortly after find_first_bit(), we can
save few lines of I-cache by not using find_first_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 4500e8ab93e2..ae9ed52b52b8 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -280,7 +280,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 #endif
 
 #define for_each_set_bit(bit, addr, size) \
-	for ((bit) = find_first_bit((addr), (size));		\
+	for ((bit) = find_next_bit((addr), (size), 0);		\
 	     (bit) < (size);					\
 	     (bit) = find_next_bit((addr), (size), (bit) + 1))
 
@@ -291,7 +291,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 	     (bit) = find_next_bit((addr), (size), (bit) + 1))
 
 #define for_each_clear_bit(bit, addr, size) \
-	for ((bit) = find_first_zero_bit((addr), (size));	\
+	for ((bit) = find_next_zero_bit((addr), (size), 0);	\
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
-- 
2.30.2

