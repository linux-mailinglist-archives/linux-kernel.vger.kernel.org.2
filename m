Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F78F424AE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbhJGAMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:12:19 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:58937 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbhJGAMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:12:08 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 0A7C772E;
        Wed,  6 Oct 2021 17:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633565410;
        bh=UaP+I3aEfwYCqu+AhNqB3qb/bc06VjyurZYTcvpHLj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z2Snd7k88x1gsHrzmMujLVxsaywkIr7HTLXrlaC7srgZaYPg+pJzqHfMo8wsy70ol
         QTU/iO/cgyzOYdcdlwjGmERFA8qiXXqzWLEeSr8mSCyCf4SKYh6Q7Mx0WWfHjxQdTh
         K+3X9qVLMl59O+YXwafMJQJ4Wq3nArSYPK+JNRJw=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] lib/string: add sysfs_buf_streq()
Date:   Wed,  6 Oct 2021 17:09:48 -0700
Message-Id: <20211007000954.30621-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is intended for use with mutable device-tree string properties.
As with sysfs_streq(), it accepts a trailing linefeed for convenient
shell access (e.g. 'echo foo > /sys/firmware/devicetree/...'), but
also accepts a trailing NUL terminator to match how DT string
properties are presented when read (so that we don't reject userspace
writing back exactly what it had previously read from the file).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 include/linux/string.h |  1 +
 lib/string.c           | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 5e96d656be7a..d066ff82d1ec 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -183,6 +183,7 @@ extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
 extern bool sysfs_streq(const char *s1, const char *s2);
+extern bool sysfs_buf_streq(const void *buf, size_t blen, const char *str);
 int match_string(const char * const *array, size_t n, const char *string);
 int __sysfs_match_string(const char * const *array, size_t n, const char *s);
 
diff --git a/lib/string.c b/lib/string.c
index b2de45a581f4..aab5cadb6b98 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -715,6 +715,40 @@ bool sysfs_streq(const char *s1, const char *s2)
 }
 EXPORT_SYMBOL(sysfs_streq);
 
+/**
+ * sysfs_buf_streq - check if a buffer matches a string, modulo trailing \n or \0
+ * @buf: pointer to the buffer to check
+ * @blen: length of the buffer to check
+ * @str: string to compare against
+ *
+ * This routine returns true iff the buffer equals the string, treating a
+ * trailing \n or \0 on the buffer as an accepted terminator, the length of
+ * which (aside from the optional terminator) must match the length of the
+ * string.  It's geared for use with sysfs bin_attribute inputs, which may
+ * terminate with newlines or NULs (the latter to match how device-tree string
+ * properties in particular are presented on read).
+ */
+bool sysfs_buf_streq(const void *buf, size_t blen, const char *str)
+{
+	const char *p = buf;
+	size_t slen = strlen(str);
+	if (blen < slen)
+		return false;
+
+	if (memcmp(p, str, slen))
+		return false;
+
+	switch (blen - slen) {
+	case 0:
+		return true;
+	case 1:
+		return p[slen] == '\n' || p[slen] == '\0';
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL(sysfs_buf_streq);
+
 /**
  * match_string - matches given string in an array
  * @array:	array of strings
-- 
2.33.0

