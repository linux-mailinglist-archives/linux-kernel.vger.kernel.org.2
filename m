Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132743921FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 23:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhEZVZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 17:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbhEZVZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 17:25:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6CC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:24:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e125-20020a25d3830000b029051975a6c1e9so3234300ybf.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+MABw3mk6SDmog98V7M1cVD+iqYLPOe0caTHFqlTqzM=;
        b=JRzF0HJaNEuDYUyhRH3agZv2u0Ntn1Qr3prXMKDAHhx9lHyYto06ZBcggqFfUy8C38
         uozr2YzjAUAdGNIhawuv6J3pCLTXiobX/yrUqeR3KWfl/bd7A3/5dY2GUPpKc9qNHDPG
         V+GfOpk6dr/73/Y8uJFfw9/BllJrEqaNzIKHUYiGoSTiVWKEwN2NwWTrgHmw0mEXzXrM
         sRQziDFTTRuo7jJlmB10NUGQjJhXmmx6bHI2i3K6mryZMG33wBGA1OVcMaKKJEqEECWZ
         TLkw9mqmTPgqaszFEB6twbmgMKdh+7rXfG+nLF55vHAk6zqMF8LGzrEq+23kC/p32Mcw
         v0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+MABw3mk6SDmog98V7M1cVD+iqYLPOe0caTHFqlTqzM=;
        b=jBcpo0le7Kidd162JCKDUgKqTyLYzsLdrc+0NwZ+gj3drFxyNH5VkyKtRwZujaHd8+
         UusHV/m7PC3KB2SAmERPKzSJnT7er8Ka0vC+rdco8odj/9nIISMWMpGH2oRCIX8MazPC
         U8Ir79/rbx/+dsV8NGSHCFXj9GdguERPQelqeI1HfyIuw0AIv2vQOm44ni4eJoslFQCR
         0K3+ouWRsjZXTbQ+t+35CJb2u+zJL1jhyOJMdTqhdUNNFK+gRWE4YVYYASiAh5m+Are0
         tHEoTF/bJrG8BeRyS3oRDqiqdOCO6ln8whd+mLbQHP0NFrLuxh9ja2i2cEFfefsn0IoV
         NtYQ==
X-Gm-Message-State: AOAM5320VyO6F8FaekKlC0kTSD/S9TOWBbUg5GYE+KDBK2DZpSGlxjlU
        9UBppXvkIEpHX9j4RzIyHOPypX3sDUyMHsM1Z5OvTg==
X-Google-Smtp-Source: ABdhPJzOZTeIlOrb0MDScNCCSZQ2m5YAyXW4/oOh83LwqnfngvwDw1k3N/oz+WNIQYVb5so32/+A1M63dcRUUZLLIM0+jA==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:2a22:5aa3:3643:4ddb])
 (user=brendanhiggins job=sendgmr) by 2002:a25:6ec1:: with SMTP id
 j184mr77386ybc.126.1622064257601; Wed, 26 May 2021 14:24:17 -0700 (PDT)
Date:   Wed, 26 May 2021 14:24:05 -0700
In-Reply-To: <20210526212407.2753879-1-brendanhiggins@google.com>
Message-Id: <20210526212407.2753879-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210526212407.2753879-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2 2/4] Documentation: Add kunit_shutdown to kernel-parameters.txt
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, sboyd@kernel.org, keescook@chromium.org,
        frowand.list@gmail.com, dlatypov@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: David Gow <davidgow@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc463..78c22bd55b92e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2256,6 +2256,14 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown=[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running built-in tests. Tests configured as modules will
+			not be run.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests
+			halt:		halt the kernel after running tests
+			reboot:		reboot the kernel after running tests
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.31.1.818.g46aad6cb9e-goog

