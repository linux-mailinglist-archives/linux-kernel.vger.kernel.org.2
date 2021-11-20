Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC55457EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbhKTNFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbhKTNEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453D5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n29so23117211wra.11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9sCY/yevwhFH9rAyrT9wBHZNyuugv7YZkcW3TXKw58=;
        b=TJdzYSAcjmggqB/WRU8tTQ9d0ODOH/DcI10FtsxFelmknUP9v/aOHfWA5Q3Xj5GGMH
         KnMAfnALhaKsn/ZP4LuSk6bG6BCWHNIoiOVFUee6RqibptZnWgVlRJMUiS3Keql6ObDt
         K1wkGB4O+ucfuUmkxF75Fewa6DrN06qt0Zr7XjB36fAMPBHkuQYfuo/pl1F8xoDrXHLS
         yzfYu7C4j45BWItKVYjLvrRbMCLM4DiKtiZGhLTnklzztFd+LuCuP2qL8p1Sj1t1CZf3
         2dtX3wiNTodUqwqAjrh/mBHKCvhQ1zfsimz88RKMK03UYHJacktAu7WK7V+FqYt7z/Yq
         aZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9sCY/yevwhFH9rAyrT9wBHZNyuugv7YZkcW3TXKw58=;
        b=GosygqSKiH3+GBo48alnuC5dg5Z0lxeshpJuj8VI7VSjrRPkm6w66HxV2TOMh40WDl
         Umx0Kj0ERyFWTqhFJmYemAfSnFZDxinEgfSCzrPjyOdkTFgmM7OGinrI0wKAl85cgEhy
         YFgmu/e4DZMN0xK5HvM5PIyOSIgnZeM9hoKmWsQd6do7zz7VSeY3uddlJaoW2RNUVuv8
         U8gvUFHGj4BPWHDU/AoQoJvCBWS01qIbVVh86N7N0JIFvCXmiSLV1HJDuy1Hytw7Xsj0
         1WTNGapsbqLjE/F+YxMu2+w78X+nbDLJ/s5jWCOB7RTbsG1p5XOCf5vvJSH/yMM9lIg3
         z9aw==
X-Gm-Message-State: AOAM5313MiKwbv6hO3AiLkKvg2nhhLoErBYID8gzKxTbOqnWWDg3n+QK
        T0IiFf6PcYd3M3DYH9fq3fjzSG8VAZMRog==
X-Google-Smtp-Source: ABdhPJwizQ13xo1o7r77qBgs7rR5jhHSsfi3ox2QCzn3b/eunY3OoB+D4K/DBQfa4ELN+jxiQaC1sQ==
X-Received: by 2002:a5d:59ab:: with SMTP id p11mr17172505wrr.340.1637413294942;
        Sat, 20 Nov 2021 05:01:34 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:34 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 17/20] linux/array_size.h: Add __is_array(a) to help readability
Date:   Sat, 20 Nov 2021 14:01:01 +0100
Message-Id: <20211120130104.185699-19-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/array_size.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/array_size.h b/include/linux/array_size.h
index c2b4fddba564..4d364f8a1f50 100644
--- a/include/linux/array_size.h
+++ b/include/linux/array_size.h
@@ -7,7 +7,9 @@
 
 
 /* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)  __must_be(!__same_type((a), &(a)[0]))
+#define __is_array(a)  (!__same_type((a), &(a)[0]))
+
+#define __must_be_array(a)  __must_be(__is_array(a))
 
 /**
  * ARRAY_SIZE - get the number of elements in array @a
-- 
2.33.1

