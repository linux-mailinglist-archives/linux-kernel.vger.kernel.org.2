Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA19737FE37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhEMTh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhEMThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:37:22 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D232C061756
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:36:12 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id h17-20020a0cb4d10000b02901c51890529dso22132339qvf.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2O58jXnETdEbs4jVdtA0T0Vt+DD9mkqY3jDs31OqI1U=;
        b=L5x5B79nG2yasENXeTN12F+UXiA4asq5ViYFWln7Wgad3Qkt8PMuW0BkX6fQT1iubG
         m9RbbydDyHxnzAJAJfxhxTv/Wv37BxU2F027eoJ/Otf2yzK1UlCglgzuHY/R/caTg7QO
         MkaiEaxFUk+D3r1/29ZVFB9ZL3LmyMHVew6pygLP8K/tlw4F7sWUWFAEaoE6c6GwgWj3
         ZAUVPawjvZsNk8frXZM0ti9Atnsvl1T1wcWQ1huhkVKmoXNCFnSZ8/rWjT1MNx0Y+EtH
         f1qN97pMU0vdzxIJ3eWXRTYCC+lodWI8DLV6bs5VWTHLxvGIyuM6jkuH7FFk/5DStlUT
         S7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2O58jXnETdEbs4jVdtA0T0Vt+DD9mkqY3jDs31OqI1U=;
        b=feNVCNaDFjS4dYeyW2L9baAp2AYfrgtH2Bx4XyBwBjCA4IaIgBcZXBcUqUZIPdlw0R
         zeI8evhyI/ByspT/FnKaybaA9D9UeweyY55U9uSYvmHcSba2GyaduyZEUzOblKY94H8g
         /DFI2/Len1rw4CKMEv0HmSF1sXKrtufCqFiHNJmG1B101MhZ0VJpDmSWdHTNTHYrPKgw
         Cwad4UDjeg0QlpfZylucnKEeb4vsn7j9+K3vQvFe0O9xKMjuaXg2XUjwbewuzFM3VNS+
         LVVJfjD1BooIdMdN1nbWQedskOPT5ppvB3uytvvWS8EpVBGe7fcu33+VJTmpXe1bk0sV
         Xc2w==
X-Gm-Message-State: AOAM530zDnHm/BSPwREXrakYQVUl0YsHvSWeV7411x1VemTEVcM48RIv
        9gRuCPLsgSD1jPP2ZPodY0mfRjoxFNKSkg==
X-Google-Smtp-Source: ABdhPJxNmOIByMOB6nwOsj8kvWrsLHtfRYpnAZL03VNkudsSypOoG1v/BHcAY8WJYP4Ng/S5PKoPTpK8/01asA==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a05:6214:951:: with SMTP id
 dn17mr42776333qvb.27.1620934571219; Thu, 13 May 2021 12:36:11 -0700 (PDT)
Date:   Thu, 13 May 2021 12:31:59 -0700
In-Reply-To: <20210513193204.816681-1-davidgow@google.com>
Message-Id: <20210513193204.816681-5-davidgow@google.com>
Mime-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 05/10] iio: Remove a cast in iio-test-format which is no
 longer required
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUnit's EXPECT macros no longer typecheck as stringently, so casting the
result of strcmp() is now unnecessary.

Signed-off-by: David Gow <davidgow@google.com>
---
This should be a no-op functionality wise, and while it depends on the
first couple of patches in this series, it's otherwise independent from
the others. I think this makes the test more readable, but if you
particularly dislike it, I'm happy to drop it.

 drivers/iio/test/iio-test-format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index 55a0cfe9181d..f1e951eddb43 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -8,7 +8,7 @@
 #include <linux/iio/iio.h>
 
 #define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val) do { \
-		KUNIT_EXPECT_EQ(_test, (int)strlen(_buf), _ret); \
+		KUNIT_EXPECT_EQ(_test, strlen(_buf), _ret); \
 		KUNIT_EXPECT_STREQ(_test, (_buf), (_val)); \
 	} while (0)
 
-- 
2.31.1.751.gd2f1c929bd-goog

