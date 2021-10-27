Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D0B43D19E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 21:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbhJ0T2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbhJ0T2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:28:48 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C1C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 12:26:22 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y14so4127491ilv.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/e5YZjIqFS3XEM8PNKx7ucxOOTkjl+7hvUjE9ax3Rto=;
        b=SAc4jpTlJZ5sfMgAG4HnrkkNmqiWa6azmcMKvJMA03VZnqOQ0gsUv/p0VVmLew6oDj
         dNvuJKiOix7Ypt6QqbN9kbd7EX8r61IHAf01YKPIi7pdeMKOc68DddbS2TTVPHer/h0T
         sPLJf/xodHmfyCWK7PbJfKtc0pA12FcAlH4PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/e5YZjIqFS3XEM8PNKx7ucxOOTkjl+7hvUjE9ax3Rto=;
        b=hfdKLM2EJKVI2Oq4MAQylkgkGwQgFJjk+AzCbL2KtUR0XVebTCtAD2Ri7vK+rltkaW
         s/FCvdcYzZvq6/SK30kJqY1XnrjZLtgH/uUhcrp77QR9nRhsCaLqVqN+Arzgv7gXWAlt
         KFazEKlJGvd/5PYHr8Fl8O5f3bXWIJ7zvVh+GzS3KJSr6mV49mwA3V3wzSUlSyr6juiN
         4eMAPYWy6Y2t4Zv5vu2BcUW3LnDbaC+ktSLHhOZrEB/m4hNdVY1iZnU/qM7OHacVkJQo
         m+27OfpFUX2/uZzLo4Ve37dNVB+u33dFyw86MFrtSaCKusoREA/AYwJL9NV4jtiJjV3+
         lQug==
X-Gm-Message-State: AOAM530OngQoo3sRTgwTrhDeDvbbk/BwyWA7FotUYVFrw+DaY8TCWYd+
        8DjxJ4gTxxd+L4CTHGDg76sb6Bu/0gWQEA==
X-Google-Smtp-Source: ABdhPJxaaXFdZYD44Y9Hl85VrAmCVXcDpARlqiFpS4FLbe06gx8CH2vrI0MnmsIH1AagHnB+qQOW6w==
X-Received: by 2002:a05:6e02:190f:: with SMTP id w15mr8451092ilu.121.1635362781924;
        Wed, 27 Oct 2021 12:26:21 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w11sm377796ior.40.2021.10.27.12.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 12:26:21 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, christian.brauner@ubuntu.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/core: fix conflicting types compile error for close_range()
Date:   Wed, 27 Oct 2021 13:26:19 -0600
Message-Id: <20211027192619.21813-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

close_range() test type conflicts with close_range() library call in
x86_64-linux-gnu/bits/unistd_ext.h. Fix it by changing the name to
core_close_range().

gcc -g -I../../../../usr/include/    close_range_test.c  -o ../tools/testing/selftests/core/close_range_test
In file included from close_range_test.c:16:
close_range_test.c:57:6: error: conflicting types for ‘close_range’; have ‘void(struct __test_metadata *)’
   57 | TEST(close_range)
      |      ^~~~~~~~~~~
../kselftest_harness.h:181:21: note: in definition of macro ‘__TEST_IMPL’
  181 |         static void test_name(struct __test_metadata *_metadata); \
      |                     ^~~~~~~~~
close_range_test.c:57:1: note: in expansion of macro ‘TEST’
   57 | TEST(close_range)
      | ^~~~
In file included from /usr/include/unistd.h:1204,
                 from close_range_test.c:13:
/usr/include/x86_64-linux-gnu/bits/unistd_ext.h:56:12: note: previous declaration of ‘close_range’ with type ‘int(unsigned int,  unsigned int,  int)’
   56 | extern int close_range (unsigned int __fd, unsigned int __max_fd,
      |            ^~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/core/close_range_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 73eb29c916d1..aa7d13d91963 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -54,7 +54,7 @@ static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
 
-TEST(close_range)
+TEST(core_close_range)
 {
 	int i, ret;
 	int open_fds[101];
-- 
2.32.0

