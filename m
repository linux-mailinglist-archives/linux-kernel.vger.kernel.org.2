Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB840F203
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245047AbhIQGM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245073AbhIQGMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:12:53 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4DAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:11:31 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 70-20020a370b49000000b003d2f5f0dcc6so62605665qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=I4FOT8yOHsLhfAzdZiAF0l/kcO/QKiXi6j8WbW9LXJI=;
        b=UY3TinilJRju1u6lzAykebCAKMTWaSuBZvn8jYC8UK4+LbXvIlCflfwHlFEphBHs8B
         1iFMgEZGban4DYDF7Ng4Bxjo8NRN9zOf3LLvDcjhZho+zGb8eIYgXkYwA0Otb0f/FShE
         yCmK2uqakDDxdXMcri2Lg+CMzpqgtphiucDdAVEWrO4iTlv4H6bq8Gawab6VO22To9bF
         X7RxLGWNSjvgLN+qQRj6LibXm4BaLGhu5Xy+N2dBaNZPk7IY2MX6VGtuGBV+XMHGYz17
         gK2smKuDIdXkivtrGOnp7UxDzkVWma4nv+Xs6OV5VYWRjcuzPSQps0HL5bUHRRb0Qx+d
         Iq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=I4FOT8yOHsLhfAzdZiAF0l/kcO/QKiXi6j8WbW9LXJI=;
        b=UilEgoi518VsF+gqBkMesjzeZhmwuAFjGZpJosaKbtO6tVDeEBHth103yTRV7u+kkR
         B985EPBw7yKcYgheFjmYiZZmAmrLhZV/x32G/YGc1ou6dbq1ZO//HdjY8/A8pJ3fM6Vo
         RZVb3qALTg8gtQdhfUqqPa3E+34IkJ8y4H0035rKEDz+9jIFu6FQYzRh9KXds7xq8E3E
         IwBRKYOu2q6V5gSgj0nZSwYhpM8ONbRri/fn8RsKT3/MutVE3Vqk3FyHUohHMqJI0vga
         A2pUU71fPRpOtaeKcCJkcBn0ySJV0KGnARh8J1AbLKfojcIFraTCOOhSqTRu7BlXiSHs
         ekSA==
X-Gm-Message-State: AOAM531B2h/2WWCe5wePjcQD7L5fgXY15MQ1ovf4HtdEvojwrRkbC8Kl
        ez8OXVLDbL2+28+UoFSEfjQVhKzSediR0MQ2ja7pHg==
X-Google-Smtp-Source: ABdhPJxQU9dA2VoByCENV7Js4YP5bqWeXxiNL61cyojxtkYNrLzgmDJAwC0DC/PduGlki5LgIsdKe1pz5QUxEe86UMUTvA==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:4845:43ba:3ff5:2de1])
 (user=brendanhiggins job=sendgmr) by 2002:a25:6d43:: with SMTP id
 i64mr11100758ybc.252.1631859090133; Thu, 16 Sep 2021 23:11:30 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:11:00 -0700
In-Reply-To: <20210917061104.2680133-1-brendanhiggins@google.com>
Message-Id: <20210917061104.2680133-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 2/6] iio/test-format: build kunit tests without structleak plugin
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structleak plugin causes the stack frame size to grow immensely when
used with KUnit:

../drivers/iio/test/iio-test-format.c: In function =E2=80=98iio_test_iio_fo=
rmat_value_fixedpoint=E2=80=99:
../drivers/iio/test/iio-test-format.c:98:1: warning: the frame size of 2336=
 bytes is larger than 2048 bytes [-Wframe-larger-than=3D]

Turn it off in this file.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/iio/test/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index f1099b4953014..467519a2027e5 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -5,3 +5,4 @@
=20
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_TEST_FORMAT) +=3D iio-test-format.o
+CFLAGS_iio-test-format.o +=3D $(DISABLE_STRUCTLEAK_PLUGIN)
--=20
2.33.0.464.g1972c5931b-goog

