Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B176C37FE29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhEMTdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhEMTda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:33:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD1FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:32:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so33159438ybp.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UG4DRgps52OAiZfNV/lZ0BYy7DJApRr1J3Fdn5d6SOI=;
        b=KANv2qwDOqKW0FC+g0njej0NjGjlVChYKPW+DOiX8ImpyDmo766P3ods4/mfOwqaeJ
         vbHDPPbMvoDYgPtvU0yATr6ch9bkAJRJBTGUs4igfyUqf5gqzTBr/cH/YAlkY74ba/Y0
         v/GhIXmawVuEqtVKXwR0aCbzf+aKZUZhm4uq8GMykVh5J7UnUx2rNkR4Ao5adLYj26ib
         TWUJl5qiBiysxUuo7H3ic1mKteW1ZnLVo35yYFJvALSI1xnkGO3xt+e3tWdG9jg0+iaf
         M0mZGEpPAdkr2geDb+Y1TyfloZhrANyQCPriODVViZZvEBawEosodTwMzOJpKtH2tB9+
         HJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UG4DRgps52OAiZfNV/lZ0BYy7DJApRr1J3Fdn5d6SOI=;
        b=JiZiyRIFwHhdXANLv2ir7Uah++OsiCGGYbXI3RoJpM+BovDcoao2K2skkDYZkx/s8H
         bL9mKk4+FnS9QjvrWNA+5i1Pkno7Oyeq7rpNSxu6BrFMYbc2PexVYgT24h+E3gPygAXR
         NGSFZ16+fUvhOntAVaeX+cZi6TGBB1Ti9k0TNbJDpfAiayodN4FHQwbp+2sxH3RyfsR3
         9LWzM6HrVnY/n86oSYpVtJwlSAZvcAZAXteskIoO46JSyNnVaPjrynjVDTzZc+yLks7o
         X+6ZNUjINSn0x9jA0DMPGJ13OUBaxp0KZOEclGfCmkhZvc5eE/JkEG11vju/m4hlzMxj
         25eQ==
X-Gm-Message-State: AOAM53235jtNBrWwcioF90dcEp3dWn5NMbJI1tiWMeQ4VPlrKWlvgE+4
        qJByBniRRv3V80u978N+1vrHXQXf2HwfLQ==
X-Google-Smtp-Source: ABdhPJyulUyLZhj+uB13ai/E+4hJ6nrll6+iCFLMp64vZXUvfU/8xlLalxrIG2KVD4MuXQ+3dfaKzBBAb3Qj1A==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a25:74d3:: with SMTP id
 p202mr37721158ybc.38.1620934339592; Thu, 13 May 2021 12:32:19 -0700 (PDT)
Date:   Thu, 13 May 2021 12:31:56 -0700
In-Reply-To: <20210513193204.816681-1-davidgow@google.com>
Message-Id: <20210513193204.816681-2-davidgow@google.com>
Mime-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 02/10] kunit: Assign strings to 'const char*' in STREQ assertions
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the KUNIT_EXPECT_STREQ() and related macros assign both
string arguments to variables of their own type (via typeof()). This
seems to be to prevent the macro argument from being evaluated multiple
times.

However, this doesn't work if one of these is a fixed-length character
array, rather than a character pointer, as (for example) char[16] will
always allocate a new string.

By always using 'const char*' (the type strcmp expects), we're always
just taking a pointer to the string, which works even with character
arrays.

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Changes since v1:
https://lore.kernel.org/linux-kselftest/20210507050908.1008686-2-davidgow@google.com/
- Fix a typo in the description ('yhis' -> 'this').


diff --git a/include/kunit/test.h b/include/kunit/test.h
index 4c56ffcb7403..b68c61348121 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1128,8 +1128,8 @@ do {									       \
 				   fmt,					       \
 				   ...)					       \
 do {									       \
-	typeof(left) __left = (left);					       \
-	typeof(right) __right = (right);				       \
+	const char *__left = (left);					       \
+	const char *__right = (right);				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
 			strcmp(__left, __right) op 0,			       \
-- 
2.31.1.751.gd2f1c929bd-goog

