Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D5B3563CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbhDGGPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbhDGGPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:15:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E7AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 23:15:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r12so25706952ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 23:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ehA4+CBMgJnHxIWSDt3vvOqxWWCaIP+aC+c7RnHz298=;
        b=Lk/4dIH+N+ZBhhqfy2c2Qdk4QtOKSeqf1LT78mXobymqFqgJqkMB824FeJGHUDiyhF
         KucIfDxfs37T+/sOyyHlTTeh2qjtpw7LhgUw2eWYIjtmttz1qsSIqzb8l8fV9hd+Gyw3
         2DhQJORYW85r9enjZQbiKVSij37LcSMC8ntcU3wW3WBzaETMI9tC3kf+p9J0kQwywFBt
         AJwnZx8e7sPQcf7j7MyqCJikWbCQG0SuhaB8Lp3zyzLnBEvEVCCUYThp8XSKaCL69fj6
         UfQbBWAceDLK7FoRQLZBQ5AD3uQMZ6j9y5bXXBJlTz8q+c08TXMRO2QEik9yNYqrK9BX
         MlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ehA4+CBMgJnHxIWSDt3vvOqxWWCaIP+aC+c7RnHz298=;
        b=nXnhuvfWHEvmlLNYajTMD2ZfY3Rc8oWpVo6O3Hjq/E3D4QkP7GcQYyKAZ86Cc0W4zS
         OrwsqrgvZ0giK/SNXLpEXXqQ+W0abmGjTNiszWDgXXBEVhixLT71Y91jdZTC7dt4v50Q
         qFKOKXrxtKvZ+0S5QVtibAQSNXOxOtQvNCx0JLhj8x/9gP/Af3j9+bAAvRKDqzZARSYC
         88d9QaZIZsGf8G8GieRgG746kGGPaj9oCclbPAtcWJ3S/W+fa0oE3IsiQ4puqEvEWvMB
         jOiD4nMKj/4vWkEGc7ODIeHNxkB200khjQq2cFW+iDJCzuAbSGiErrXRulynnq8JlPFC
         c6gg==
X-Gm-Message-State: AOAM531RfUppb3RXcIT5W+G8XqFzEO9VHYfjLxufcn/H8eioteXVymap
        urBiMnPgyMtUIMiU7A7jD5N9amr3tteaivP1
X-Google-Smtp-Source: ABdhPJwQ379vqV1XC30k/xqIHl9h/QxnSq0OvT/EAGlbhR/8FFx8TlYbaYv8rxtNo3sERpkPm/PaCA==
X-Received: by 2002:a17:907:3f97:: with SMTP id hr23mr1881535ejc.69.1617776102928;
        Tue, 06 Apr 2021 23:15:02 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a12sm8130686ejy.87.2021.04.06.23.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:15:02 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     ndesaulniers@google.com, dan.j.williams@intel.com,
        andreyknvl@google.com, laniel_francis@privacyrequired.com,
        keescook@chromium.org, dja@axtens.net, akpm@linux-foundation.org,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH] lib/string: Introduce sysfs_streqcase
Date:   Wed,  7 Apr 2021 08:14:56 +0200
Message-Id: <20210407061456.5914-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the name shows, it checks if strings are equal in case insensitive
manner.

For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
strncasecmp to check that the input via sysfs is "mi". But it would
work even-if the input is "min-wrongcommand".

I found some more cases using strncasecmp to check the entire string
such as rtrs-clt-sysfs.c does. drivers/pnp/interface.c checks
"disable" command with strncasecmp but it would also work if the
command is "disable-wrong".

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 include/linux/string.h |  1 +
 lib/string.c           | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 4fcfb56abcf5..36d00ff8013e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -184,6 +184,7 @@ extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
 extern bool sysfs_streq(const char *s1, const char *s2);
+extern bool sysfs_streqcase(const char *s1, const char *s2);
 extern int kstrtobool(const char *s, bool *res);
 static inline int strtobool(const char *s, bool *res)
 {
diff --git a/lib/string.c b/lib/string.c
index 7548eb715ddb..5e6bc0d3d5c6 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -714,6 +714,29 @@ bool sysfs_streq(const char *s1, const char *s2)
 }
 EXPORT_SYMBOL(sysfs_streq);
 
+/**
+ * sysfs_streqcase - same to sysfs_streq and case insensitive
+ * @s1: one string
+ * @s2: another string
+ *
+ */
+bool sysfs_streqcase(const char *s1, const char *s2)
+{
+	while (*s1 && tolower(*s1) == tolower(*s2)) {
+		s1++;
+		s2++;
+	}
+
+	if (*s1 == *s2)
+		return true;
+	if (!*s1 && *s2 == '\n' && !s2[1])
+		return true;
+	if (*s1 == '\n' && !s1[1] && !*s2)
+		return true;
+	return false;
+}
+EXPORT_SYMBOL(sysfs_streqcase);
+
 /**
  * match_string - matches given string in an array
  * @array:	array of strings
-- 
2.25.1

