Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F36358426
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhDHNGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhDHNGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:06:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12669C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:06:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so2297460edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BW3yBesOwsPa0fb75giaiBu35Xqpu5oneSt6pOx7rnw=;
        b=fAxTUJQxaGb4BxQMvo4fvcM2em8z4M7o4Cz/4IJPAEkClnU9fNnHBQoQHoWfjEj5RV
         UVjCdn8o44c3SJlSE2/2dGW2+YjHDnNhINo0wxCfU1l/ZWwM1GzblwxAZ+uqHUKLawRw
         8UrY1PtRETDp0fi7jUhOXZWOSmqIN3Swut754LGvGAcOOYHwR5c98s9BKncfaMqI0YKq
         AhT/6J1NXlQ0XTYDQFSICb6/KpdpHBH7Zie1Afot2thzOFZ6yKCjVbDGrgg3S+nGfF1X
         H3HAT49+TBwaL6lLmYH8aLQSDAkGRUmpRyRE5CVtyvjLVLdtCB97FkeHx3Hb6I7VEq5N
         ecvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BW3yBesOwsPa0fb75giaiBu35Xqpu5oneSt6pOx7rnw=;
        b=EyfY224v+wfYND5sOEYv2kxPUwkcyxvU4PbDuZ9zT2EU9yNjAX9fU/LYd/GIY9GxWY
         Qa25lUmWD7hOJEs+AyzAQLrU7rw6qRhgYFFz9HP/I1G0hgM0YhNByqaKwjQkiMs1x1GM
         Fkqd/8VTIdzSJH753hFcmT3RcFvHeeyP2Vdrzp+6cdo2MM4BP1tvNvcdXK7LdfIvlWVr
         Br9fKSEDxxzOxk74Mca9rlyBBBteidhu2ahjtkUqnIvGI6OcuTFEVOunnosc/nLc0fJr
         n87cfl6laBL4gMgB8btcf47y7CbMw5wMLfNmX/v5ex/nDeuFSUSGe04xBnu+eEBeiL5b
         OeIw==
X-Gm-Message-State: AOAM530G4abphMB+LSVOhk94v8FbBVDaQ4a2+KxTryyvE5JbS6E8cyvt
        od0kO3mLDvR91wpPkjjaOGELZVrWBDDlBg==
X-Google-Smtp-Source: ABdhPJy2xUMZOZ6LNfgmc/xLNImWAZaHPP8Xk0T4GzM9OiQ4ed7qGcBJ2d/j6MlD3Y/v23YcMVcZzw==
X-Received: by 2002:a50:eb8f:: with SMTP id y15mr11402277edr.115.1617887168668;
        Thu, 08 Apr 2021 06:06:08 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y2sm14229010ejf.30.2021.04.08.06.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:06:08 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     ndesaulniers@google.com, dan.j.williams@intel.com,
        laniel_francis@privacyrequired.com, keescook@chromium.org,
        dja@axtens.net, akpm@linux-foundation.org, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH v4] lib/string: Introduce sysfs_streqcase
Date:   Thu,  8 Apr 2021 15:06:05 +0200
Message-Id: <20210408130605.541796-1-gi-oh.kim@ionos.com>
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
 lib/string.c           | 36 ++++++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

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
index 7548eb715ddb..d0fb02efd5da 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -687,6 +687,17 @@ char *strsep(char **s, const char *ct)
 EXPORT_SYMBOL(strsep);
 #endif
 
+static inline bool __streq_terminal(const char *s1, const char *s2)
+{
+	if (*s1 == *s2)
+		return true;
+	if (!*s1 && *s2 == '\n' && !s2[1])
+		return true;
+	if (*s1 == '\n' && !s1[1] && !*s2)
+		return true;
+	return false;
+}
+
 /**
  * sysfs_streq - return true if strings are equal, modulo trailing newline
  * @s1: one string
@@ -703,17 +714,26 @@ bool sysfs_streq(const char *s1, const char *s2)
 		s1++;
 		s2++;
 	}
-
-	if (*s1 == *s2)
-		return true;
-	if (!*s1 && *s2 == '\n' && !s2[1])
-		return true;
-	if (*s1 == '\n' && !s1[1] && !*s2)
-		return true;
-	return false;
+	return __streq_terminal(s1, s2);
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
+	return __streq_terminal(s1, s2);
+}
+EXPORT_SYMBOL(sysfs_streqcase);
+
 /**
  * match_string - matches given string in an array
  * @array:	array of strings
-- 
2.25.1

