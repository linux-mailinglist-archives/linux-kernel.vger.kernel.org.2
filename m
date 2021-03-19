Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD4434115C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 01:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhCSAOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 20:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhCSAO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 20:14:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFC9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 17:14:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v186so2505742pgv.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 17:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nImVFX0jHIhN0AQMf7mlChRUcX4c7OdbdSzNaG+1joo=;
        b=VYobYUYJBVLE4rY0oHs1cir/oZDQmgFpjTaTcE3ahMAv32RQwzlVhkZcQnxuqxMboD
         syx0rhp7cMU/fUAOeJM2D5nAvjyenAJNzX0Usz1g3ouBPyILDHCkWJml8p0iWdGCjNVV
         N21QOjNwZhDxd2ACdbHLO1muRmYHI0DuotKO28t0JDy+v0pfpBXCriWKDOQE9++1E0u2
         QweK0vXWsdYWx3KmvCioFJvcWqg1HGk180OJQz5ifgTNIw+phU7LoxjCtECaozXKsVHs
         omwOA7Y/T5qq+uJ6MB5UBVfJDIR4RLAlVluOms8v/1BuNNoumG58cR/zJak172oRhSwH
         C0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nImVFX0jHIhN0AQMf7mlChRUcX4c7OdbdSzNaG+1joo=;
        b=Y29vBN0hUfPtAg+iKHI6es76S3UCxtJXMPY05EVFWP8P4HKh7PhAyW7WbGYDV1hrCH
         /q0h4vfrWp2V0mMy2tyrdCD3br+ZkwNzp2uLMR+IIip1wahmJ2SQdM3r4ha0bQhx4/dw
         4DE7Jk73XV2q/lu2zRbIkk6AZI3uuH4brnHvF+jjtp4ux59zryTS8o0GInMXgOXPH+Qq
         uLlKLfX6ld1472SIEYQ1sO/nsZp1ahXbK6BD/xDa30IEht3EGt555c0r+srgbQWQs3KY
         ry2AK6Jx5rL3HplvFbN6XYXec3ETL2Nf/RNrEqr79pvst6aT4MFO9HH+Ch8JQqwKph0x
         qCQA==
X-Gm-Message-State: AOAM5315xGa49wR2hV/Llw3YzwhdvOvgMuiUwatR1+BuO06gfxtU1gJh
        SOfuqIxrvrwNg9JLfeJv7/U=
X-Google-Smtp-Source: ABdhPJxBCzt3FsDvyqPu+9m5bBHlP2Yiq9Ljx9UohFWa0OMfI9X8NNmtIqfsmysSmgezIvwryHjhdw==
X-Received: by 2002:a63:7e51:: with SMTP id o17mr20231pgn.281.1616112866206;
        Thu, 18 Mar 2021 17:14:26 -0700 (PDT)
Received: from localhost.localdomain ([121.160.199.16])
        by smtp.gmail.com with ESMTPSA id r9sm3136344pgg.12.2021.03.18.17.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:14:25 -0700 (PDT)
From:   hyunji-Hong <onlygod0807@gmail.com>
X-Google-Original-From: hyunji-Hong <hyunji_hong@korea.ac.kr>
To:     acme@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Tools: lib: string: Fix isspace() parameter to avoid undefined behavior
Date:   Fri, 19 Mar 2021 09:14:15 +0900
Message-Id: <20210319001415.8928-1-hyunji_hong@korea.ac.kr>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isspace() could be vulnerable in terms of unpredictable results. So, the parameter of the isspace() should be cast with 'unsigned int'. We found out that information through these sites. (Microsoft, Stack Overflow)
url: [https://docs.microsoft.com/en-us/cpp/code-quality/c6328?view=msvc-160]
url: [https://stackoverflow.com/questions/122721]

Signed-off-by: SeungHoon Woo, Hyunji Hong, Kyeongseok Yang <hyunji_hong@korea.ac.kr>
---
 tools/lib/string.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/string.c b/tools/lib/string.c
index 8b6892f959ab..7d01be5cdcf8 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -123,7 +123,7 @@ size_t __weak strlcpy(char *dest, const char *src, size_t size)
  */
 char *skip_spaces(const char *str)
 {
-	while (isspace(*str))
+	while (isspace((unsigned char)*str))
 		++str;
 	return (char *)str;
 }
@@ -146,7 +146,7 @@ char *strim(char *s)
 		return s;
 
 	end = s + size - 1;
-	while (end >= s && isspace(*end))
+	while (end >= s && isspace((unsigned char)*end))
 		end--;
 	*(end + 1) = '\0';
 
-- 
2.17.1

