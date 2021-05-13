Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A9537FE85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 22:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhEMUFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 16:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhEMUFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 16:05:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551A4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 13:03:54 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u126-20020a3792840000b02902e769005fe1so20273538qkd.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=+7MBFOMP+9qhj4nTOUAyFZTGUvJgJzKaN8FiT0vK5W0=;
        b=LytmX3GH84CK+JYXC6VsjxILP1fGNOki49+2NV1X6rGRNoXVNQm2gFhAbzQ2qcxogZ
         Hwc0kn7Okl2PK7MbBhk6tP92prP8Yf4tR/VKeiH1gqxpwC4h16fBrvPSHV0CJqIjfIbR
         /rW458L0dwQ6Qo5nyrCJTf7GZoOi7cXDrItMBVtynWg+2DqO6WC8NOZpFbgk4phHQFnQ
         ol5N14qR4H9x3F5fSvrFBLFdpS4HfxGwslQel95kojG3ysyKLapA/hj5tZNt96A8Pw0c
         zRibIIriE6xFK66jPixIWG9xcGX1dlZuNT295Av80yogihYZOvrjTHBbHjeIJCHlaUNr
         +lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=+7MBFOMP+9qhj4nTOUAyFZTGUvJgJzKaN8FiT0vK5W0=;
        b=c/zvVLszdrlU/yeYBpZgpNBbP/N5r4jWAkmbojufa9vfgTNc57TPflFWq8F3QbE7ex
         w/fCKAV7GtUyyZTxFw8y83TQW/ip4M9gpkUiORnLCgIQss99FxcocKtnbRPjPA8tnUTD
         Dimg97sclRgNeygICNLfNrBB0HfXP700Qpq3S+nOAwuCGrm/UljBgx3XZrk6iGQZcr3R
         5ODyCmBu0NMSLlKHgbR+SEcxj1pnxqlA3yBEA6Ws2GONsHdE4mPWV+ecVqbttiNz31ph
         //W+4VEJm/MTUT6C/M8pe7Md5YQOv8O+1NGD/sW60NQac7bPzsUXKgqXTN+7enSLaO+5
         lxDQ==
X-Gm-Message-State: AOAM532avNuMWg+ujwBgUkJo0oNql49sWZfBQodE2N/7MtdNq78uPOyF
        r4BhZwQs2w5Ff5zbAhvlS+tAFFNeZ0y9VQ==
X-Google-Smtp-Source: ABdhPJwF/HNk4eZe2OFi8GWBMFB0qI61s8TnYScLURduynGnfYqhBDlgCvotGuT6/BsWnj6jX4cqYtJDMoczow==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a0c:9b83:: with SMTP id
 o3mr14712045qve.4.1620936233432; Thu, 13 May 2021 13:03:53 -0700 (PDT)
Date:   Thu, 13 May 2021 13:03:50 -0700
Message-Id: <20210513200350.854429-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH] kunit: Add gnu_printf specifiers
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some KUnit functions use variable arguments to implement a printf-like
format string. Use the __printf() attribute to let the compiler warn if
invalid format strings are passed in.

If the kernel is build with W=3D1, it complained about the lack of these
specifiers, e.g.:
../lib/kunit/test.c:72:2: warning: function =E2=80=98kunit_log_append=E2=80=
=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribute =
[-Wsuggest-attribute=3Dformat]

Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/test.h      | 2 +-
 lib/kunit/string-stream.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 49601c4b98b8..af2e386b867c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -610,7 +610,7 @@ static inline void *kunit_kzalloc(struct kunit *test, s=
ize_t size, gfp_t gfp)
=20
 void kunit_cleanup(struct kunit *test);
=20
-void kunit_log_append(char *log, const char *fmt, ...);
+void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
=20
 /*
  * printk and log to per-test or per-suite log buffer.  Logging only done
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index fe98a00b75a9..5e94b623454f 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -35,9 +35,9 @@ struct string_stream *alloc_string_stream(struct kunit *t=
est, gfp_t gfp);
 int __printf(2, 3) string_stream_add(struct string_stream *stream,
 				     const char *fmt, ...);
=20
-int string_stream_vadd(struct string_stream *stream,
-		       const char *fmt,
-		       va_list args);
+int __printf(2, 0) string_stream_vadd(struct string_stream *stream,
+				      const char *fmt,
+				      va_list args);
=20
 char *string_stream_get_string(struct string_stream *stream);
=20
--=20
2.31.1.751.gd2f1c929bd-goog

