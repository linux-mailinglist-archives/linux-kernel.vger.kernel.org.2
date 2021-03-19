Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E0A341439
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhCSE3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhCSE3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:29:30 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDEDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:29:30 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k8so4730910iop.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOSuT4H6WBsdge+ZQLbZaZiGAa1JAYNZuZZGRCXBZw4=;
        b=qatE2pCuVbZ9AiG8D68hOg5EioDi8h52YCrCz3/3WAkV8a4ENNF+Oh0Ye2AO3w+z4N
         QVI4jLPWCvqI9y1yQm5V5lAj48NbBuif9NMsOO2oWWomtTQDlFAZJhstaP4ieaTx/Flw
         Vsf+HSuDzsWP0IH3xMa5uEV0daiGZMvIlrQyXgRWM3Fzrz4XIl0B51jE9WeY7KjD+aDn
         5P2hJX8Cyd/X59gSGPVvor3tcZ8oJjIUXat5vC5Hx/ijwtAXMXm8pDr+TEgNIn0abzQr
         otGreeTCR+i/6Qz6BzQBPrv6JdHz8mlEOp8eABPrk+PG4pDtVUqeM5dYy3bmeab/U5ob
         2iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOSuT4H6WBsdge+ZQLbZaZiGAa1JAYNZuZZGRCXBZw4=;
        b=axTFyXLnxcIrX7JMUdijgCNBPiFZSL6f434XYE3+W039IETYmH7kRc2+NUM6GG8kOr
         1uPfjamfnizS2VIz/4reSDjFFU0gHHKJqBpSlQnsnaFTASNdWopaEfLxSjyUhA1HAUZy
         faW6AjMZ4x/wnMXKgKagFA5eVD7J+eoFi7bxoKTmix7XmE5Aa4WlIaBtg8ugpcBOTHnp
         JcFX1sh9xE6snWSwNpTw1WTve5t6czqsCQhoVKwRC5e1T/Wm+pMcwEujlxLp0101jzmv
         v4czbIHu5+MZZqm1xMdfmPBbsp5EI+qtbXnB3PDBDspRHmcC9bBGR9g4B8HaOl+cBTOB
         eimg==
X-Gm-Message-State: AOAM532L++U05gZM6kDIkz6XVqzLaNOTUYRJdq7cgBzmIZJXFM2scZw7
        kJang8i4Y0etXjAhCeX1i5uLyw==
X-Google-Smtp-Source: ABdhPJxr2vHJcqHwaZPXZdnkS9Ka6P/i0AKs2EXuPENfRie58LenmSaKRFmRmVSnh6LHdkfojw8ArQ==
X-Received: by 2002:a05:6602:228f:: with SMTP id d15mr1310725iod.141.1616128169777;
        Thu, 18 Mar 2021 21:29:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k3sm1985940ioj.35.2021.03.18.21.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 21:29:29 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: ipa: introduce ipa_assert()
Date:   Thu, 18 Mar 2021 23:29:22 -0500
Message-Id: <20210319042923.1584593-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319042923.1584593-1-elder@linaro.org>
References: <20210319042923.1584593-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new macro ipa_assert() to verify that a condition is true.
This produces a build-time error if the condition can be evaluated
at build time; otherwise __ipa_assert_runtime() is called (described
below).

Another macro, ipa_assert_always() verifies that an expression
yields true at runtime, and if it does not, reports an error
message.

When IPA validation is enabled, __ipa_assert_runtime() becomes a
call to ipa_assert_always(), resulting in runtime verification of
the asserted condition.  Otherwise __ipa_assert_runtime() has no
effect, so such ipa_assert() calls are effectively ignored.

IPA assertion errors will be reported using the IPA device if
possible.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_assert.h | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 drivers/net/ipa/ipa_assert.h

diff --git a/drivers/net/ipa/ipa_assert.h b/drivers/net/ipa/ipa_assert.h
new file mode 100644
index 0000000000000..7e5b9d487f69d
--- /dev/null
+++ b/drivers/net/ipa/ipa_assert.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Linaro Ltd.
+ */
+#ifndef _IPA_ASSERT_H_
+#define _IPA_ASSERT_H_
+
+#include <linux/compiler.h>
+#include <linux/printk.h>
+#include <linux/device.h>
+
+/* Verify the expression yields true, and fail at build time if possible */
+#define ipa_assert(dev, expr) \
+	do { \
+		if (__builtin_constant_p(expr)) \
+			compiletime_assert(expr, __ipa_failure_msg(expr)); \
+		else \
+			__ipa_assert_runtime(dev, expr); \
+	} while (0)
+
+/* Report an error if the given expression evaluates to false at runtime */
+#define ipa_assert_always(dev, expr) \
+	do { \
+		if (unlikely(!(expr))) { \
+			struct device *__dev = (dev); \
+			\
+			if (__dev) \
+				dev_err(__dev, __ipa_failure_msg(expr)); \
+			else  \
+				pr_err(__ipa_failure_msg(expr)); \
+		} \
+	} while (0)
+
+/* Constant message used when an assertion fails */
+#define __ipa_failure_msg(expr)	"IPA assertion failed: " #expr "\n"
+
+#ifdef IPA_VALIDATION
+
+/* Only do runtime checks for "normal" assertions if validating the code */
+#define __ipa_assert_runtime(dev, expr)	ipa_assert_always(dev, expr)
+
+#else /* !IPA_VALIDATION */
+
+/* "Normal" assertions aren't checked when validation is disabled */
+#define __ipa_assert_runtime(dev, expr)	\
+	do { (void)(dev); (void)(expr); } while (0)
+
+#endif /* !IPA_VALIDATION */
+
+#endif /* _IPA_ASSERT_H_ */
-- 
2.27.0

