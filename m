Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482B63A7975
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhFOIxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhFOIxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:53:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4087EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 01:51:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t7so4818059edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jl4uU2kHs6S35w6+VABeqJHWmzLL/AUBcvWycmFwhus=;
        b=QjlsvLR2wY4koxzpm3dZVTqMCEbU0NrXsPF3yhk+ZupFtoxCaYuTOjd/cJTGTF8nNL
         FbNnRmWXiVKoUC5BSpKeu+XwmTEZ1uOvNwSCYgW0iPMGsUNFHZpUdS2ZaI1TQbx43qU4
         nQTC6Jw3GXWUllycPv2wT8e8+XtSxkr9oy8bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jl4uU2kHs6S35w6+VABeqJHWmzLL/AUBcvWycmFwhus=;
        b=k9OrlImMGEW4XJaa9hPcfKQJ7ALLkpuQIPN9wVaeQU5+31Dv2wiDYPOVvu08ksUn4O
         jCd/FigbNGPE733VL7QwhJcZxHOcjdiIgpt8yBlwP9EfWxB2OFwkuWudQHwlIuDbUScK
         79/YccDjTtWixUgMAkBlVj6ItziQZTWo22tLR0yvlDnxic/FeUoFtpuWL1eGThv29li3
         /YBtv+5MuI0v9t4UguzWbDwWaUW7FH93HyrrT4kL7uBe2xmvuwZ9hFfPL7qaGyHxFoKH
         K/p0caQSUTccYLXuR6oHjYsMJQj5/HeE+lgSxJH/L/PXLYOVAMHmTAKFR/GPhrVygEwd
         51jw==
X-Gm-Message-State: AOAM533PQjgklqsAG2zNnv2JL8AIjux8qQkjMr89OVpuYJCptm6Q7409
        uNDDznprf5qE9V2ZPPrcVarvJw==
X-Google-Smtp-Source: ABdhPJzc+Ey3yPqQzHYHX2LWIHyqYf4ooTuT83ut4Aoka/wHludEMF2zhEct/8CscYKnkChOQhA5Qg==
X-Received: by 2002:a50:8e18:: with SMTP id 24mr21920623edw.275.1623747069454;
        Tue, 15 Jun 2021 01:51:09 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id w24sm7909857eju.73.2021.06.15.01.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 01:51:08 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Justin He <Justin.He@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/test_printf.c: split write-beyond-buffer check in two
Date:   Tue, 15 Jun 2021 10:50:44 +0200
Message-Id: <20210615085044.1923788-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before each invocation of vsnprintf(), do_test() memsets the entire
allocated buffer to a sentinel value. That buffer includes leading and
trailing padding which is never included in the buffer area handed to
vsnprintf (spaces merely for clarity):

  pad  test_buffer      pad
  **** **************** ****

Then vsnprintf() is invoked with a bufsize argument <=
BUF_SIZE. Suppose bufsize=10, then we'd have e.g.

 |pad |   test_buffer    |pad |
  **** pizza0 **** ****** ****
 A    B      C    D           E

where vsnprintf() was given the area from B to D.

It is obviously a bug for vsnprintf to touch anything between A and B
or between D and E. The former is checked for as one would expect. But
for the latter, we are actually a little stricter in that we check the
area between C and E.

Split that check in two, providing a clearer error message in case it
was a genuine buffer overrun and not merely a write within the
provided buffer, but after the end of the generated string.

So far, no part of the vsnprintf() implementation has had any use for
using the whole buffer as scratch space, but it's not unreasonable to
allow that, as long as the result is properly nul-terminated and the
return value is the right one. However, it is somewhat unusual, and
most %<something> won't need this, so keep the [C,D] check, but make
it easy for a later patch to make that part opt-out for certain tests.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/test_printf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index ec0d5976bb69..d1d2f898ebae 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -78,12 +78,17 @@ do_test(int bufsize, const char *expect, int elen,
 		return 1;
 	}
 
-	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
+	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
 		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
 			bufsize, fmt);
 		return 1;
 	}
 
+	if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize)) {
+		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n", bufsize, fmt);
+		return 1;
+	}
+
 	if (memcmp(test_buffer, expect, written)) {
 		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
 			bufsize, fmt, test_buffer, written, expect);
-- 
2.31.1

