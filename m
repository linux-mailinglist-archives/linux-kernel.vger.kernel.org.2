Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B9B321B35
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhBVPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhBVPOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:14:08 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71002C0617AA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:12:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p3so3715549wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvdst0ke5NfAjFDKzfIGeJQUVrU5WqaPoSE7N9OL8Lk=;
        b=ByUTfEFTtBWT1+a0ndUHz1KXLJgEtcEoht2zWrZ92q9qenV/FW/QItrNFBA9yTMyEu
         nAxoZ+5AXu3tbOCmNa03Q8qLomQDKJiPxv7eM+CBxbCITTfPr61VnFrxqNLmeXxlwO3D
         NSpdRj4Lfc+il7l9Z296wz7zGGhZmRTTRRQtCoJTKm2wn4y36LdYZ9EjyeLCQJ4lYebI
         mYOlnGVeZdOkqV6tdEV2vpkWfpAsY7t3TGFQ6/SyIT186qvj7qU7fcfJQq7KTLm3B5ig
         A/gh1JqPwarb2PAOkQI97K0mXH1teQXM1pBWa2rExNw6siyEglWGb/yNUH+O8aiFhMYI
         3MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvdst0ke5NfAjFDKzfIGeJQUVrU5WqaPoSE7N9OL8Lk=;
        b=ax8M0AxGHyoXZ10BteaSyYclFBKeSBf9e30eGOZ9B/udGP43JWBuHXaIneVcElQxUr
         T0kvTezQ/G1bHfmazv0QPZ/ikM+spcCRIdr8FlZW8nz1zgexKWPYUrX5l1uGPqhjFSU+
         s266SwW0+mEUayTbEtNmcFVCxv3KIZrBDyi4/P3BnqDb8b+LCmhJLim+AN10jxU4ixzZ
         pW34bpnifryfozwDQUTWdVhIBfATEvqomMzpw/M7y5xZmmrc8DTgPmq7HliP+NvFsKfl
         QJEle04AWA34Kwe9aY0GeZ73xcQXojcsH8FJd9cEUIGw9gP9e3F0cFqgQYxQDGVFXpF1
         idfw==
X-Gm-Message-State: AOAM53299dtfd1OzqFO1CIuDe7enGcf2eRv8YRes1xjdOkhdgSmStw8n
        Dh/oV4Od+qS/4h23EIiUQAVTKQTkVR3GvUdGbxw=
X-Google-Smtp-Source: ABdhPJx3HdU5Aax1CbhYORFA+t6gTkfB7mL2V+O6OWbY4u994qmgJk/1EWCkqEb3ImN5wm0C+wO/uA==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr20165149wmb.128.1614006771938;
        Mon, 22 Feb 2021 07:12:51 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id k15sm27612424wrn.0.2021.02.22.07.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:12:51 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Romain Perier <romain.perier@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/20] kernfs: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:19 +0100
Message-Id: <20210222151231.22572-9-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 fs/kernfs/dir.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 7a53eed69fef..9e65b595d880 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -42,9 +42,9 @@ static bool kernfs_lockdep(struct kernfs_node *kn)
 static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
 {
 	if (!kn)
-		return strlcpy(buf, "(null)", buflen);
+		return strscpy(buf, "(null)", buflen);
 
-	return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
+	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
 }
 
 /* kernfs_node_depth - compute depth from @from to @to */
@@ -125,17 +125,18 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 {
 	struct kernfs_node *kn, *common;
 	const char parent_str[] = "/..";
-	size_t depth_from, depth_to, len = 0;
+	size_t depth_from, depth_to;
+	ssize_t len = 0;
 	int i, j;
 
 	if (!kn_to)
-		return strlcpy(buf, "(null)", buflen);
+		return strscpy(buf, "(null)", buflen);
 
 	if (!kn_from)
 		kn_from = kernfs_root(kn_to)->kn;
 
 	if (kn_from == kn_to)
-		return strlcpy(buf, "/", buflen);
+		return strscpy(buf, "/", buflen);
 
 	if (!buf)
 		return -EINVAL;
@@ -150,16 +151,16 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	buf[0] = '\0';
 
 	for (i = 0; i < depth_from; i++)
-		len += strlcpy(buf + len, parent_str,
+		len += strscpy(buf + len, parent_str,
 			       len < buflen ? buflen - len : 0);
 
 	/* Calculate how many bytes we need for the rest */
 	for (i = depth_to - 1; i >= 0; i--) {
 		for (kn = kn_to, j = 0; j < i; j++)
 			kn = kn->parent;
-		len += strlcpy(buf + len, "/",
+		len += strscpy(buf + len, "/",
 			       len < buflen ? buflen - len : 0);
-		len += strlcpy(buf + len, kn->name,
+		len += strscpy(buf + len, kn->name,
 			       len < buflen ? buflen - len : 0);
 	}
 
@@ -173,8 +174,8 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
  * @buflen: size of @buf
  *
  * Copies the name of @kn into @buf of @buflen bytes.  The behavior is
- * similar to strlcpy().  It returns the length of @kn's name and if @buf
- * isn't long enough, it's filled upto @buflen-1 and nul terminated.
+ * similar to strscpy().  It returns the length of @kn's name and if @buf
+ * isn't long enough or @buflen is 0, it returns -E2BIG.
  *
  * Fills buffer with "(null)" if @kn is NULL.
  *
@@ -858,7 +859,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 					  const unsigned char *path,
 					  const void *ns)
 {
-	size_t len;
+	ssize_t len;
 	char *p, *name;
 
 	lockdep_assert_held(&kernfs_mutex);
@@ -866,9 +867,9 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
 	spin_lock_irq(&kernfs_rename_lock);
 
-	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
+	len = strscpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
 
-	if (len >= sizeof(kernfs_pr_cont_buf)) {
+	if (len == -E2BIG) {
 		spin_unlock_irq(&kernfs_rename_lock);
 		return NULL;
 	}

