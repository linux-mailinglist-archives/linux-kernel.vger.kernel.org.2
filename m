Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAB1446704
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhKEQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhKEQeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:34:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5ABC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:31:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r10so14754194ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QO84fTKdeSMmm9QNKq6SjNHfztt5W0wJHSODBJ8ZtRQ=;
        b=Zj3KicFxHklL6gL6RLRmq5P3kJ493cqHFhK/GOV0mcMbwhDhOiILWvYZcT+HR6uowo
         QgzqvPSrZ8eN1+WHeuLX4/EtKpQJiVf8DnMpN2abq3qiOGfYsFNguaB046j19cFxpH+X
         WGbJ1IFtYHQD+c2w0jCgpK3ytizPY9sBRBiARXZAlHBER+xBG8dMQwNQe2Q/wUGQtwE2
         fzSk68NG0DXrWfnHcPypDoB4IP6LZyZwp5CdeFUP7Nw1Rittw/eM/qQUqHNSnqnR5SMt
         BT0Y1bJrDBJz3p4vfSzisCuZJlFsST2R5lhCY3jcYVhgRP2f++yIvMdPlsl3GDBN/No+
         EWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QO84fTKdeSMmm9QNKq6SjNHfztt5W0wJHSODBJ8ZtRQ=;
        b=levGvKWfCudQJnDuqid85KgOwAVjMk9MTzLf0RzPJktPPkPwEFqi6EPV+x+YYu9/WG
         0RJ9i7YBQctAvmoFD5WMlHt3+oyP96uiMm5lZt7mn3jxcksUGL2mKURza3YIPpXxOtnG
         i3ShH3tHGdo/+jo4j7+oJINWOPqJA4AqptEe3/Cf3Do4Wlj71zJWndBB7TWoDEkrXBGt
         Hgo16Up17tt+VhxcgDMKrLNp/7xD/WKpZb3Cgo2UlcQW24shQGMfdrvwEZpQCBvCpiCo
         aLJ8WeykR2/1s7+EtAxcHLv/xUyS43Zx7/TsfhdKUdisswnoZiMC9UkGb94lVqnLTWSu
         BYtw==
X-Gm-Message-State: AOAM531ZBRGp0Vv/oovEaH/ufxfqI3M10/VKz2IyciqBCCMeDHwJ4kci
        4Y0wjDUn7uHK7/qK3lO8q2Yojw==
X-Google-Smtp-Source: ABdhPJwRU0Hv8s5/OoopP3Oc9keJl5PGu73f4BB84MA4jNWit0XnQiLj/PheRa4C/FFO8OnGzrTzlA==
X-Received: by 2002:a2e:4952:: with SMTP id b18mr52307516ljd.255.1636129899645;
        Fri, 05 Nov 2021 09:31:39 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id s6sm877010lfs.236.2021.11.05.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:31:39 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/2] selftests: timens: use 'llabs()' over 'abs()'
Date:   Fri,  5 Nov 2021 17:31:36 +0100
Message-Id: <20211105163137.3324344-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building selftests/timens with clang, the compiler warn about the
function abs() see below:

timerfd.c:64:7: error: absolute value function 'abs' given an argument of type 'long long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
                if (abs(elapsed - 3600) > 60) {
                    ^
timerfd.c:64:7: note: use function 'llabs' instead
                if (abs(elapsed - 3600) > 60) {
                    ^~~
                    llabs

The note indicates what to do, Rework to use the function 'llabs()'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/timens/timer.c   | 2 +-
 tools/testing/selftests/timens/timerfd.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 5e7f0051bd7b..5b939f59dfa4 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime");
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index 9edd43d6b2c1..a4196bbd6e33 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime(%d)", clockid);
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
-- 
2.33.0

