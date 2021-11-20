Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C755457EA1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhKTNE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhKTNEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B7C061748
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c4so23132710wrd.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8QYh8YBjRKByTC+Lvnd0i8PZtksTa5K8+1o0gs270g=;
        b=AnY7nmk9kQ0ZF1cOBaKXx9ns/8WRw4hRt/zywsdhO9gX6V+rzRAtXwJcFIVl/sf+J9
         qAFMyjfJgbYDfnT9n20MCd60qOqnK3sN7bIRWDRHl4GMOKMh5orZeggH5rT3+s1tED/h
         sxuy1nPZyqFs5+aN9BRACqd8tcYFMhnxsniK6vt1tmyYTJnx+DDVChhJVn8ZgWzeNQQC
         ka8L28VNTD4mm45oh1A2x3OYNj725fE/O/tv91YokPHQNJcKnp/nB4QGw6ZryTfReLzN
         ZQMDZJ2dQoylgFlTjOS/40c4MplcD7KJDGHS0QqeW/dIjNMIyzIAeR2q78MRJxeB6edT
         Ofew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8QYh8YBjRKByTC+Lvnd0i8PZtksTa5K8+1o0gs270g=;
        b=joMZRQFqZ/9SUjVeFbiqq2woYZz1gxieaHFweHkpp3Th2Ubmeo5Ry6jHCF9P8kAvcY
         S4098uAZqHZkNmXT3CMQOHQIp2cV6fcrluphoLfZ9dY5o4Uz2OPYGVpdyWkRO2twvqMm
         +MlVt8W4O16kjccUxT6R90f5t+dk1ZcNws7tPX2knkg1Olu9V8Ve3sSdbf1f1KVkrepi
         otJ9OU5l+9jtfv7kzYoQyc8yC9bTioQZYvrohQnT5u54KYpwD4PQbMkPRr2qFNWdDl7Q
         emnqpeJl60vP/9ai646y/QtCUF6Bt2Mm69zSoqHGyvzprABsSXHNpvYCj4jI09SbOcY8
         IObQ==
X-Gm-Message-State: AOAM531MV79HNlJdHw3PdXm69IAy2Ldxf5poRelDJXt0XPeVQ7EiNkUs
        gqUdfXYNNfT+KcJrTq6DicN3+lip7h/7gQ==
X-Google-Smtp-Source: ABdhPJzUkUv8QKOhpadzEe1WwNM9azvvTEhiFwP++ImI2P0yhFHZNJbdYZJbqxlRpbEJChGVulMdRA==
X-Received: by 2002:adf:dec9:: with SMTP id i9mr17893712wrn.18.1637413293130;
        Sat, 20 Nov 2021 05:01:33 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:32 -0800 (PST)
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
Subject: [PATCH v2 15/20] linux/compiler.h: Implement __must_be_array() in terms of __must_be()
Date:   Sat, 20 Nov 2021 14:00:59 +0100
Message-Id: <20211120130104.185699-17-alx.manpages@gmail.com>
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
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 3d5af56337bd..64d99335874d 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -255,7 +255,7 @@ static inline void *offset_to_ptr(const int *off)
 #endif /* __ASSEMBLY__ */
 
 /* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+#define __must_be_array(a)  __must_be(!__same_type((a), &(a)[0]))
 
 /*
  * This is needed in functions which generate the stack canary, see
-- 
2.33.1

