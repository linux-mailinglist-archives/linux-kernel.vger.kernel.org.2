Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515673F3E6E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhHVHwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 03:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhHVHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F1DC061796
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m17so1322112plc.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DEcxgVs1pQEerfVS+rAtkdPSoE4zT/Vk9kMK/QHD9zo=;
        b=S3EFqfUeYv09+M773x9XOkbEVaEKtQsjAe94UKpghb74KWtIHw5Wl9x5YHJc5KDLb5
         Z08MjlgC1zZD3eghEko3XCUFXQjmJicdeiOt8lzig9/IE83bQHqk6+HTn1xO1pDAr7y4
         HZhZpPoqy2DyW8m5nLuc8t1idwLC4mSHKrezc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEcxgVs1pQEerfVS+rAtkdPSoE4zT/Vk9kMK/QHD9zo=;
        b=EZqaYTChBOGYqrU7PzwSr+qQWJeOjCRyqBWN/Vs+SsrKfRXb8mT4sgMc6vAxvo5w4+
         bdpYJrpxcQ4EFf1ZLk60Ndo6n9Eh/wNLU3QVEtOsSlqVYtVMY/HUI3t1fBkeGzBkuKHU
         ULZXgvt3+bS9DB9W8/iJJ57otZBqPhXtjK5P94OxIQkTb1A5SqX9pUBlhWBb46fd5vHk
         E7LZQQcMYHHqCddaZiglQiCeA1d2pOUiriCaPhqkV90FudAcvSoNXlr9O1A1eqe8Y12p
         otZapz4fXyr3Yw8LxiWtbkLnYp3U3pQdzmXgNEYr1AXJxf/iv39at7yHvrcQqAjXoWSC
         Q3pw==
X-Gm-Message-State: AOAM531ITn6ZvG+NEjGxXjrNLwnSVT348MWKgsDQYWBZdnSiUhd2pigC
        RGDfcPj8pdrX/Z641OIw+OI7Kg==
X-Google-Smtp-Source: ABdhPJyAqNDeFUr1L4+uMN5tHh0G/x9yl00aSUkM1asxLXqcYw8VzEjByQHeYuWTxA/61wm9Kf9tgA==
X-Received: by 2002:a17:902:b717:b029:11a:fae3:ba7c with SMTP id d23-20020a170902b717b029011afae3ba7cmr23078166pls.28.1629618692452;
        Sun, 22 Aug 2021 00:51:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l126sm14090655pgl.14.2021.08.22.00.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 09/25] HID: cp2112: Use struct_group() for memcpy() region
Date:   Sun, 22 Aug 2021 00:51:06 -0700
Message-Id: <20210822075122.864511-10-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2250; h=from:subject; bh=n2+aRt88uxiLgSoHrUg0cSNfKLQxENn1KABr0kFU25o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH2FEUh//RbjPjaOyd8es3V309O0GjLE6nQLoq7 B0hxiv+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9gAKCRCJcvTf3G3AJj3ED/ 0ZsaQprx9neOaNOQN3MUk1sqeucal9QQ1yLOKav1NJPJGiOJfAbspSRgLphn6cqjU66nU9HjmUk19F K2nRieGFwIfIYmjVHsEGFpWyvPX2ceziaeyuWbyaXwgReIE4RFIhVVlL1fmfN4OPiSMifhsbAiJMRX z7nzRApkoNeo1viq83KgInyCeb89xa+FkyrBdP5q8VQmPElZlWPYHmdQRQwbg2K71eL/GOOA3h/MrE oumw0CDEt2cXgD+0onqk4Mki0gAElQou1Pph27qD4kg7zLlgS+twThHlzWia6JngCbfrLYyn6P0LfJ EtFMwqYlEa8ZqEg/ZuApZwe+onyf27Kuj81ArumrWxWf3OAaJE+1Qx3UNZWROBiay7UEtiWvRMHmCT q/k2vz8aGT4DBZRojLjzT3j1hW31SzMMtQayilfnSClxPMdDSn92W9T3GBeorSL+Q2ut+QNBMJKbFq 463knHTzWqubaPvVU8Xmr3uYmhHSLmNBj0+/G/OlbdP8h4WyLxMrBiDYrXVCnJsrfHeWkw948nMzlv WJIn3aKfn19uLK3hkrYQ7N7LQaU4shVZpdlbOb4G8ZWK5PB3bwn7JK3JbNC9mf9e5UUMwG3XeFiaAC L4weoGS/pZbqLaMsPG4RLOojoQh8c/HolxsRrUx1bXwUG29l7mF7Qz5E/gVw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct cp2112_string_report around members report,
length, type, and string, so they can be referenced together. This will
allow memcpy() and sizeof() to more easily reason about sizes, improve
readability, and avoid future warnings about writing beyond the end of
report.

"pahole" shows no size nor member offset changes to struct
cp2112_string_report.  "objdump -d" shows no meaningful object
code changes (i.e. only source line number induced differences.)

Acked-by: Jiri Kosina <jikos@kernel.org>
Link: https://lore.kernel.org/lkml/nycvar.YFH.7.76.2108201810560.15313@cbobk.fhfr.pm
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/hid/hid-cp2112.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 477baa30889c..ece147d1a278 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -129,10 +129,12 @@ struct cp2112_xfer_status_report {
 
 struct cp2112_string_report {
 	u8 dummy;		/* force .string to be aligned */
-	u8 report;		/* CP2112_*_STRING */
-	u8 length;		/* length in bytes of everyting after .report */
-	u8 type;		/* USB_DT_STRING */
-	wchar_t string[30];	/* UTF16_LITTLE_ENDIAN string */
+	struct_group_attr(contents, __packed,
+		u8 report;		/* CP2112_*_STRING */
+		u8 length;		/* length in bytes of everything after .report */
+		u8 type;		/* USB_DT_STRING */
+		wchar_t string[30];	/* UTF16_LITTLE_ENDIAN string */
+	);
 } __packed;
 
 /* Number of times to request transfer status before giving up waiting for a
@@ -986,8 +988,8 @@ static ssize_t pstr_show(struct device *kdev,
 	u8 length;
 	int ret;
 
-	ret = cp2112_hid_get(hdev, attr->report, &report.report,
-			     sizeof(report) - 1, HID_FEATURE_REPORT);
+	ret = cp2112_hid_get(hdev, attr->report, (u8 *)&report.contents,
+			     sizeof(report.contents), HID_FEATURE_REPORT);
 	if (ret < 3) {
 		hid_err(hdev, "error reading %s string: %d\n", kattr->attr.name,
 			ret);
-- 
2.30.2

