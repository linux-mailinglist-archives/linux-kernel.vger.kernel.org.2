Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622D8362891
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbhDPTYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbhDPTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:24:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D437C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 12:24:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w8so15513533pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au1OzdUxzPBTnWVZvWu79dip0mAHZrKvjjowjMqY2UE=;
        b=SFC7x0J8SZ4vw/i2LY+v4bsGGAoWUKBp0ag81cE6lwfqHZz/brkekp9aUSxYBRvG6G
         iFnjHIE6BbuPkqiiYjQ5D6x9Xklg64ZwzU+USKoO83qddMKI4KalsjjG//3jECdmEPIz
         YrD7UcN7g69P97mMV2DO1f3I/bBZANGQCDqfxIelUt7Iv8KgUkheX2MVvzT8QMAOD2KK
         EdQOT9gTvNfhJXcloJ1YqsmxVX4TkYcwclCAVRrSzhoGOkIf1HXzB14MLqU3TR8IX6gp
         P+hUO376GN0wkefINe8RVxRmynRyqpnXvyRnRYSeBWBpW34Lu+XxCxT81KHfbK4zaQ8I
         Znhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au1OzdUxzPBTnWVZvWu79dip0mAHZrKvjjowjMqY2UE=;
        b=HEh0PXPziJIcl6IMk1Deg4TAlBpziS/DjoGCuO9bfhZi8QWFyD1+2Wtu/u7WDVhSEK
         3PG6s4X6VMfSOMXov8E1mlB1EvvRkj7swOXXTik9ip3agiElY5jpfuAMTU2ClzLFo581
         0JmwJnFnAqMfIGolEOlIkG17IK2hDTEQ1DI/MJvQuPTRoHQNr3OoeRdanLLS+bg/IKWh
         fm2STrPTayFtoShgZyH5271I3tK6iyOcJFsZmkwK9gcDs7xh501otEGF8Ku7Ntn07i9z
         Ymj+i4XhZDZVlghvrfJjmQn3qvgXe1cM5/15sZLZqGfvz0iUdaRzPdebjZ8n7p4iF/fQ
         XUeg==
X-Gm-Message-State: AOAM530fmhOYuAqPe4s+jGRQh3kEwSUZcUaiBuVNrJ2nS12IXfyoWK/Y
        yJ3Q88xkwTOxV1Xw/nuttGs=
X-Google-Smtp-Source: ABdhPJzPf3TWr7284RoYUQ0sJc3eJmD6QfqWAVAfiEO+BRc+oBNCBMo3hWTvRdIIM7/mWO2GWGhYjQ==
X-Received: by 2002:a63:e552:: with SMTP id z18mr588609pgj.100.1618601058251;
        Fri, 16 Apr 2021 12:24:18 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:8178:2218:96f0:c55c])
        by smtp.gmail.com with ESMTPSA id s9sm5440076pfc.192.2021.04.16.12.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 12:24:17 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
Date:   Fri, 16 Apr 2021 12:24:13 -0700
Message-Id: <20210416192413.1514419-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

We have to loop only to copy u64 values.
After this first loop, we copy at most one u32, one u16 and one byte.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 arch/x86/include/asm/uaccess.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c9fa7be3df82ddb9495961b3e2f22b1ac07edafa..ddb19bb8c86786d78407dcfb59623943ccbce8a8 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -517,15 +517,23 @@ do {										\
 		len -= sizeof(type);						\
 	}
 
+#define unsafe_copy_elem(dst, src, len, type, label)				\
+	if (len >= sizeof(type)) {						\
+		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
+		dst += sizeof(type);						\
+		src += sizeof(type);						\
+		len -= sizeof(type);						\
+	}
+
 #define unsafe_copy_to_user(_dst,_src,_len,label)			\
 do {									\
 	char __user *__ucu_dst = (_dst);				\
 	const char *__ucu_src = (_src);					\
 	size_t __ucu_len = (_len);					\
 	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+	unsafe_copy_elem(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
+	unsafe_copy_elem(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
+	unsafe_copy_elem(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
 } while (0)
 
 #define HAVE_GET_KERNEL_NOFAULT
-- 
2.31.1.368.gbe11c130af-goog

