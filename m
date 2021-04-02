Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEDE3528FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhDBJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbhDBJlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:41:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB54C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 02:41:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e7so4876638edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AHk8iEZeim6Q8wJThBXwpknvDgYOM/IHRVqiIW3xB0Y=;
        b=CoO2fwb0aukPQDInlSiIrAjBzz+DAh3pfw3zURNvXhaUXAour+5LvGu6Dv1lm14MzF
         tDKCQPqfGw1uc5z4v129xm7M/45P448pOvHZ9QoYsvsuI0DwbCLSlzPpUuz0+fmXyBA7
         wFZZYz72civ3liQMXdwl+dboMN93W36CW3ne4JarCATJJ5G+l6C2LNLIxL6BNazrKawo
         lP5PmMFNo+Lg8FYlWeBo9YHBhfmYJD7Hud7mS2pc/5V9lrre+Y65Xlujnk4d2CIhO+G+
         UNPMJ21ujnX1tWcCaqcHp34bMD7FVVDuyEBe0yP/QO63GOgWaxhzK3jipjN0PXJJX5By
         NeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AHk8iEZeim6Q8wJThBXwpknvDgYOM/IHRVqiIW3xB0Y=;
        b=ey2HaiUHuNhQ37maaY0L/HzXNuQgZwl6Mvo4xFSr5JLdliDDqsD0ABBWUZuODj5q5X
         Tk7iMwjxxcZA2FS2JNcBYdCLLVSq8diPlYMzcPK6LFU5mWQ9EfZtezBMLFfEIteKWRot
         vKEG2uu6ZACjg1ow1lMWiS5fPH2qIO5IMAaBEJxUBNdw+LHwKvHDZSt7lC6IKf1cUdEz
         w77/9HxLKMeVxjwpSk7KURXY5WK9M7do4QmS7GcJSPZrniRuHOoZf2Qpl7zZGbleymJH
         SnxtcMwjel3MubdrVDULv2PVaCQ2k63N7OQRqKi/notr3si8LYSgIvJnyx9gucAsxCaG
         Ee+g==
X-Gm-Message-State: AOAM533OMmAESuzFszX8a+Cz2Kq7o89qCYFp8BSLlJaq9ONTGsY8aCNp
        H6v6CyoKCwi8ScQnZSfPLItH1A4q5mZRLA==
X-Google-Smtp-Source: ABdhPJyU0DdHuedMPqlnAWgIZn7VdywAN+vqoI1NU4tw5ogSlot3RzkgNk/Pa/vyQteTfDmMm4fxWQ==
X-Received: by 2002:aa7:d917:: with SMTP id a23mr14551671edr.122.1617356467091;
        Fri, 02 Apr 2021 02:41:07 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id c12sm5456841edx.54.2021.04.02.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:41:06 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     ndesaulniers@google.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH] lib/string: Introduce sysfs_streqcase
Date:   Fri,  2 Apr 2021 11:40:42 +0200
Message-Id: <20210402094042.9218-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the name shows, it checks if strings are equal in case insensitive
manner. I found some cases using strncasecmp to check the entire
strings and they would not work as intended.

For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
strncasecmp to check that the input via sysfs is "mi". But it would
work even-if the input is "min-wrongcommand".
And also drivers/pnp/interface.c checks "disable" command with
strncasecmp but it would also work if the command is "disable-wrong".

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 lib/string.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

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

