Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2641433EA40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhCQGzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhCQGy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:29 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B0EC061762
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:29 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f20so39833117ioo.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ue7qb6UKVXaBOoNqVYxg8dDCH0ql0uLI78PzAQH/VF4=;
        b=DYRyHiUgndXMF7EAwhbxlaRGhlQmFqXkBFER9HMqCp0QlBNNhDPh/xafmeosEWNs+G
         wYOoiDEN7vT4t0osVpJMErrIEs19XtdKnPKiKJ2t0lWFpyAEtivXCKMLn+XkW98bkp23
         Wc1lBw/D98BUUeue+wWPJ06VeUK8ElDhKSK/mVO0Kj/AUC10/mj9qPl/RrQJU/i+ak3T
         ec4R3cF8onowgv1zvgzsTzhuADM/ee321dXk14NKyg1AUnarM4wDVy8wVewGINlliN23
         lXcqL1o+ShUxbIfFsODv/b0FtoK2ekoGAM7rZ7vTNtDOwrgOp2bAyJVBfAeLBHuIp8Fi
         iQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ue7qb6UKVXaBOoNqVYxg8dDCH0ql0uLI78PzAQH/VF4=;
        b=LzsHQ9I6bf9nv1K8Y7iZWh+9vBQrI6BwxbxTBh59tt4jBQLJY5Gwb0ceOMrQ7cB+Y+
         RIG0lu3kiyHqY+QwtPmgN0wcs1jJ3eOEnWdF1kzPsQuVQ4H/MNH62fw8eTeehqkI7GCE
         4aR3c3c8FxhRydmQNI5xvVNfrDK/o2IsXIefNPrgsjT6r64keW400oLC7adc1cPhQvdD
         MKa+IzMy1aC7R/m/000upW6pG7KDJIEAEOYbVQSc5j6KhfiCKVqK3DbsXcGwqWVlTRGM
         zhu/BFe1Jl4sqNonRGjkSYJ92uCi+F/fCTpx5B7lot3SLNYOu7WsuNjIRTPetIckvtZx
         cnbQ==
X-Gm-Message-State: AOAM532fcWRVWmlCtvFI7f6Vh3FTT07y1F3f/E+b2yCYlCTeQZS+Rbjq
        Y67T5f+uiasnwDt2k6JZ5Ts=
X-Google-Smtp-Source: ABdhPJw2V7LgSvgOY3/u6anrhiXldRV7KGt57AtH+MEbU+CbtDffA6mbfZjwN9XTc/cvnCvwQsEW0A==
X-Received: by 2002:a02:9986:: with SMTP id a6mr1799982jal.46.1615964069063;
        Tue, 16 Mar 2021 23:54:29 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:28 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 09/19] dyndbg: optimize ddebug_emit_prefix
Date:   Wed, 17 Mar 2021 00:54:02 -0600
Message-Id: <20210317065412.2890414-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add early return if no callsite info is specified in site-flags.
This avoids fetching site info that isn't going to be printed.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 9 +++++++++
 lib/dynamic_debug.c           | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index bc8027292c02..aa4a3f5d8d35 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -40,6 +40,15 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+
+#define _DPRINTK_FLAGS_INCL_ANYSITE		\
+	(_DPRINTK_FLAGS_INCL_MODNAME		\
+	 | _DPRINTK_FLAGS_INCL_FUNCNAME		\
+	 | _DPRINTK_FLAGS_INCL_LINENO)
+#define _DPRINTK_FLAGS_INCL_ANY			\
+	(_DPRINTK_FLAGS_INCL_ANYSITE		\
+	 | _DPRINTK_FLAGS_INCL_TID)
+
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1f0cac4a66af..af9cf97f869b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -632,6 +632,9 @@ static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	}
 	pos_after_tid = pos;
 
+	if (!(dp->flags & _DPRINTK_FLAGS_INCL_ANYSITE))
+		return buf;
+
 	if (desc) {
 		if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 			pos += snprintf(buf + pos, remaining(pos), "%s:",
-- 
2.29.2

