Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1198A357F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhDHJeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhDHJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:34:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C6BC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 02:34:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id v6so635781ejo.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 02:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWS3czF7Gor+EpZRRL7CevuQ+anxu+m9nrECxKec31U=;
        b=YDGNKInjVacC9HJBhcRPf3I13TWtPELrMQbE0up5+hi49kFnuhL5xCyJsSbgkV5vQC
         nlUVVPvhz69jpJDkeIlMt6TOPX0YQQPOQFSGASgxY0SQCMEB8cKTV8p37Ajk2ovfHstu
         Gs5BQF2WRCDprMwb9meRC+zAQf30+BpzNCgW4vsi0M0XZCA2lyhV7N/3RxSOUa9f6k6t
         pNZkO/spLsD/LNSZ2Euyxe8WRcZwsH+Mt12imOUXChbWV+VLRaRvhNc1SDCr66nEMhXX
         nBnbBR+kYX54PW0ZC35wp3/Q7GL550FAN/n8OL/RC4ueGz7SShaTcnJKd8+wh0hwK/+W
         SZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWS3czF7Gor+EpZRRL7CevuQ+anxu+m9nrECxKec31U=;
        b=cb28g9CTvSL1VkkUdN37RSimNmC2EQqyTzCycqfVxpqf42BlCURZH6ZuuxJbAf2QrV
         STyEmQIjMp9n+Lvhqg9Mq151sUVlQnAUH7C/ZkuUtHeRw3RBq7Vkv6nGf2NkMZNOKlPY
         o126xfphd3aiETS4PzkYepG0tsn0mIa8q/qAaF4bfko+LMOO35U+8tvRDIIwLxPSRdcb
         wft2n2tiNVDbnuXRGrQUizYF88FJo2sTZTx+X3AFpdygF5P3sT5K51MrW107Gtt/s+WG
         a+LQT4tMu1YrNEl7fO9saNCRExWrCpdt/h8b/1GEQ95ug8sGOl4AF+emwhX/oGPeHyd/
         qkgQ==
X-Gm-Message-State: AOAM533sDicqIaEgbTugVgXh/4m4kDfurGGGqUR4SxVysuOuHYTv/RlN
        I+OglvgW/ZwwD8gVyNXPplq6Ch6bao+rLQ==
X-Google-Smtp-Source: ABdhPJwZeEk1ND2pbYdzL68IJzqIz3+F+G3jjjwTWzaplLXV+4d1VPnYAtSQB/wZBAv8jiRlpGvFAA==
X-Received: by 2002:a17:906:af91:: with SMTP id mj17mr8789955ejb.228.1617874443394;
        Thu, 08 Apr 2021 02:34:03 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id u24sm13890887ejn.5.2021.04.08.02.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 02:34:03 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     ndesaulniers@google.com, dan.j.williams@intel.com,
        laniel_francis@privacyrequired.com, keescook@chromium.org,
        dja@axtens.net, akpm@linux-foundation.org, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH v3] lib/string: Introduce sysfs_streqcase
Date:   Thu,  8 Apr 2021 11:33:54 +0200
Message-Id: <20210408093354.509810-1-gi-oh.kim@ionos.com>
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
 lib/string.c           | 38 ++++++++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 8 deletions(-)

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
index 7548eb715ddb..cb53845cc4ac 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -687,6 +687,18 @@ char *strsep(char **s, const char *ct)
 EXPORT_SYMBOL(strsep);
 #endif
 
+#ifdef CONFIG_SYSFS
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
@@ -703,17 +715,27 @@ bool sysfs_streq(const char *s1, const char *s2)
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
+#endif
+
 /**
  * match_string - matches given string in an array
  * @array:	array of strings
-- 
2.25.1

