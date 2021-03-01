Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C043297CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344446AbhCAWyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238451AbhCARtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:49:42 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF44EC061356
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:47:55 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id o188so5343478pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItGCDxvyYxZfILSMfywaFDYs06YJdDuKqI6U+nyptpg=;
        b=KwWp8C5VPoFXSV/3//5YSsuhMUx+vxxI2poB9pUjthuYZQTDXSuVmTWK7fEeP9jT+3
         w5GfrT6xCmKcdHGFlaOoVz9CVRbPpH6Z+1Uxpmo80Psqqh7RyVBD+2eHpeUbRKyioy3h
         NbdaOQoWGcBAIQgORmRvtFpi8SJSmkzdg5cJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItGCDxvyYxZfILSMfywaFDYs06YJdDuKqI6U+nyptpg=;
        b=fiMaIfEqUK005f+q17AUlZeBOoHrkU/w3gSFwQdXd2WcoxuuFZ0eShwP2M2LZoyG+y
         Xf3hWM+cJa32rKMf3x98Vw/2OKTlww5TdLm6cLLtv5pBIaXCoYAA/b0HX40aAL3j6FHM
         WXGrgWnV1L77M/QtmcjX4PhicqwUJprTl7Bcj23MiOsC6YwYQ8Wmy11x1vKoW8uLNJF/
         VEJFZakPSkvUSWIgOJA2yeuLLL0059eUzn12d9y7vPG1qC7C8SYn871cQqw171wsXVZJ
         xPUCLSE/4LTEwGjeTs9xyTZP3ClVnYHJC9ilJ0HguwAWa1Dlfs+EClQiL8wl1fzWbuKs
         6FFQ==
X-Gm-Message-State: AOAM530R4293Enlz3ZTSx3d/hi2AiWWGh3OGdjlXABkNBMsE30cBGdAX
        7781rWS/kZgKI8HfObpc59f1Iw==
X-Google-Smtp-Source: ABdhPJwE6QdUbZZLIj2D0ypCZJjgmNnyWaeloehONU3loV9Pj3lRSYUZ4JCz8uXH/TIzE7+ZND82VQ==
X-Received: by 2002:aa7:9488:0:b029:1ee:16f0:5246 with SMTP id z8-20020aa794880000b02901ee16f05246mr15672113pfk.14.1614620875518;
        Mon, 01 Mar 2021 09:47:55 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3c20:df33:e36:93df])
        by smtp.gmail.com with ESMTPSA id y202sm19071325pfb.153.2021.03.01.09.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:47:55 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH 3/7] buildid: Add API to parse build ID out of buffer
Date:   Mon,  1 Mar 2021 09:47:45 -0800
Message-Id: <20210301174749.1269154-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301174749.1269154-1-swboyd@chromium.org>
References: <20210301174749.1269154-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an API that can parse the build ID in hex string form out of a
buffer to support printing a kernel module's build ID.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/buildid.h |  1 +
 lib/buildid.c           | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index dd134a96a87c..f5a5b920d18c 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -10,6 +10,7 @@
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 
+int build_id_parse_buf(const void *buf, char *build_id, u32 buf_size);
 const char *vmlinux_build_id(void);
 
 #endif
diff --git a/lib/buildid.c b/lib/buildid.c
index 57daf928b133..4e1d7c51dc5f 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -165,6 +165,26 @@ static void build_id2hex(char *dst, const unsigned char *src, __u32 size)
 	dst[2 * size] = '\0';
 }
 
+/**
+ * build_id_parse_buf - Get build ID in hex string format from elf section note
+ * @buf: Elf note section(s) to parse
+ * @build_id: Build ID in hex string format parsed from @buf
+ * @buf_size: Size of @buf in bytes
+ *
+ * Return: 0 on success, -EINVAL otherwise
+ */
+int build_id_parse_buf(const void *buf, char *build_id, u32 buf_size)
+{
+	unsigned char build_id_buf[BUILD_ID_SIZE_MAX];
+	__u32 size;
+	int ret;
+
+	ret = parse_build_id_buf(build_id_buf, &size, buf, buf_size);
+	if (!ret)
+		build_id2hex(build_id, build_id_buf, size);
+
+	return ret;
+}
 /**
  * vmlinux_build_id - Get the running kernel's build-id in hex string format
  *
-- 
https://chromeos.dev

