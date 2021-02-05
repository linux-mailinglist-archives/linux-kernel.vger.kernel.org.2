Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC842311AC4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBFERf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhBFCpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:45:40 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A36C08EDBE
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 15:53:13 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id u124so6096555pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 15:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=t77+PuCigeZOcF53sLtwu0Du9UKFrCGhrRKsmy3L6C4=;
        b=oiw8Q6GYyKteToglNy7gdpC0BukBR+3yrtUTagUwTRT+aluXP2YhlzxIytogmMfWMz
         pzArK1ylL5HXFjdTLFlotXqZY3ynows31B902aEnpyEPk+H08PGdPDxET+4iFl+lt0/s
         TswcIShTwC3LkJzv1KNMd2STFuQp4+YYC0KoI9L6zuSbPypmTs6v1JzKbPPvkGWgm2J9
         rS8fVrV4dFfiEXSN0d3Hr7JafjATZru6O+grs5EgBOALzgNj6xF/Qh71AsH+bDSjgIUy
         WVm4fNEMn5LLeEEXwRU7lFKAIT9l0DY7LDVGP3DdhhUoIEpP4Xn8Cke/s+2x4kStFA/s
         LvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t77+PuCigeZOcF53sLtwu0Du9UKFrCGhrRKsmy3L6C4=;
        b=q1ESxdL4INLVAYA9lh/EktcMWKcJjKWf4UUrc3Dnga0+7ClPtzt5EmCkjFQ0ZbwGio
         FTg3VtoosbliKjwQF4zOJVrOk797EdgjMczbU4sWzSJw7hLjaBuAyUavSRTfqZoWZ0vN
         O8Cgv574zF0ZX7z2bxwrGQgQyTNHex1rzaCuXIOHGSSDFtcRob1+hAOSXq91c8PghNIV
         Ggdm04VgjEb5clAeG2Bk/cw7blg6UOHYI3axwD6eygiIlGW/4ap2U9Whz1QQs036kZ8K
         ZjBC/Q6ufpDNFzl9gf4/gWPEiQRMeTjHfyJFasrdlqRLisMlmlt/yyr9qExgrsWn6bwF
         cwmw==
X-Gm-Message-State: AOAM532zHyLmhicvGItA7woOYGUhYWtV0M0ohLLh6OyBJ4QvAEG4piub
        nqMqPklDcomdsVvomA4VPdsNnPbRCWoieA==
X-Google-Smtp-Source: ABdhPJwUXTrySp7ZE4Eqsd+iiglqdwGlkHvNviLq7t8BzZfzBm3E2RtqKaaxIevIdIwPBBzGPCL9xi3H7rs3+g==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a8b1:128a:69fa:86fb])
 (user=dlatypov job=sendgmr) by 2002:a17:902:52a:b029:da:989f:6c01 with SMTP
 id 39-20020a170902052ab02900da989f6c01mr5920868plf.45.1612569192975; Fri, 05
 Feb 2021 15:53:12 -0800 (PST)
Date:   Fri,  5 Feb 2021 15:53:02 -0800
In-Reply-To: <20210205235302.2022784-1-dlatypov@google.com>
Message-Id: <20210205235302.2022784-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210205235302.2022784-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2 2/2] kunit: ubsan integration
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org,
        Uriel Guajardo <urielguajardo@google.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

Integrates UBSAN into the KUnit testing framework. It fails KUnit tests
whenever it reports undefined behavior.

When CONFIG_KUNIT=n, nothing is printed or even formatted, so this has
no behavioral impact outside of tests.

kunit_fail_current_test() effectively does a pr_err() as well, so
there's some slight duplication, but it also ensures an error is
recorded in the debugfs entry for the running KUnit test.

Print a shorter version of the message to make it less spammy.

Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/ubsan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index bec38c64d6a6..1ec7d6f1fe63 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <kunit/test-bug.h>
 
 #include "ubsan.h"
 
@@ -141,6 +142,8 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
 		"========================================\n");
 	pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
 		loc->line & LINE_MASK, loc->column & COLUMN_MASK);
+
+	kunit_fail_current_test("%s in %s", reason, loc->file_name);
 }
 
 static void ubsan_epilogue(void)
-- 
2.30.0.478.g8a0d178c01-goog

