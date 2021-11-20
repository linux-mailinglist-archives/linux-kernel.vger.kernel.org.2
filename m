Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE3A457E9D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhKTNEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbhKTNEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F8CC06173E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:31 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso12635664wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PKR3Wajo2CQl10ZJ+naQ1DEifKzro/43atvyZuXSpE=;
        b=LH94A78VllQtJ7DAzQpcHvcTkvwY5Ryg9iDK5GlTmIIjLxsWnTlfM6U/faAOgvFGaY
         wI99mxL9k0JwZauT6Fpnw0BXIOGGKjyXsUco83IF8ykOJXE9dX+d+u9DbfLxubfKNHtf
         A3OQNHjW4CsHwRghq00wmKwXAPDIRHaIlossbJFLC6q7h+Ek8yMrkf8nqvCCDc9q/bO0
         2WvK4HcLNaZY7Co3CnnbvwnvUj67agTi7+Zu6lf8x6ANZdbSgOblgJzpBONhC6k0pKTS
         yLRohIr3pT4Zb+H2Bu+9d4MUtLBImwR5nSpQNrLlAnOx6Lc4Fdz0ckad9A/eIcLIM7wV
         /f/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PKR3Wajo2CQl10ZJ+naQ1DEifKzro/43atvyZuXSpE=;
        b=KEpgMqQM+HS2LR4894N1YczVAJF1GoOz/bD+Toxh4+zZRzBZUwub0MqpVLTMoGAzK3
         fZ3SaJQp08TJNUZxUqKYO1E+6R1N9t3TWn+IMkzAaWH5jKNabH9zMWwi6tGCXFPc+Pvh
         wlBVnoiF7EDMdazpgO1vPiy8j3THYXgmPrYMEUcsKV67RRbGjP9n+20sE1V9JxhiELVZ
         oK6Yexs2kJ8GUAdUPYBI16sgYD1QQOfE0mWNcjAa3o/vQe5BiKULt0ztjUSkmIZZqmfL
         Ef3Yj5JRR9/b5mvYRgI3rzwiY1SqN8fpFYPqNn6g7u0ExfWbFmcz9fmvaq+DKKBUS4Gs
         ZXkg==
X-Gm-Message-State: AOAM530aLLSWNnSRY1atULmwGO3xd0Y3p1ZjOF7dLQgLDhgyvtr0LEow
        BnUMSwdcNashnVn6xmQz4s89QjlNvGZHXg==
X-Google-Smtp-Source: ABdhPJwOS9vN2ZE1kb9hn21hHqpP9pl6rkBOUHcbDxuQKuhQk9oObbecau9J+rHYju14X43dU0WUiQ==
X-Received: by 2002:a05:600c:500b:: with SMTP id n11mr9992017wmr.38.1637413289690;
        Sat, 20 Nov 2021 05:01:29 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:29 -0800 (PST)
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
Subject: [PATCH v2 12/20] linux/must_be.h: Add must_be() to improve readability of BUILD_BUG_ON_ZERO()
Date:   Sat, 20 Nov 2021 14:00:55 +0100
Message-Id: <20211120130104.185699-13-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically, BUILD_BUG_ON_ZERO() has been hard to read.
__must_be_array() is based on BUILD_BUG_ON_ZERO(),
and unlike BUILD_BUG_ON_*(),
it has a pretty readable name.

Let's generalize it with this kind of usage:

	#define __must_be_array(a)  must_be(__is_array(a))

So next step is to create macros of the kind:
__is_array(a)

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/must_be.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 include/linux/must_be.h

diff --git a/include/linux/must_be.h b/include/linux/must_be.h
new file mode 100644
index 000000000000..a2e0b0c890a6
--- /dev/null
+++ b/include/linux/must_be.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MUST_BE_H
+#define _LINUX_MUST_BE_H
+
+
+#define __must_be(e)  BUILD_BUG_ON_ZERO(!(e))
+
+
+#endif	/* _LINUX_MUST_BE_H */
-- 
2.33.1

