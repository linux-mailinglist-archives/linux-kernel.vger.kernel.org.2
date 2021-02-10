Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2AB316526
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhBJLZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhBJLP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:15:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46449C061225
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:14:38 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o24so1482778wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBGa/8m8HwiLIY68SqSzIvGj7Bjc1hXzjJPQSh8wpuc=;
        b=GkOqP2X+NrnL0YudSRAwXl+fT3XHjV2FJ8U9hgOvKVdxngYXKyI1Yp+yWdxEI6hTNF
         w/yxNghy4ertSeSRBy2OBCZ7QEHWNhUmAD8QmcjzuVA3xBGDvc4lOTryqwetrIaaI3EZ
         wdzr6tvjXXk/OiF4OvPwUANYGtK1XGq4+GidY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBGa/8m8HwiLIY68SqSzIvGj7Bjc1hXzjJPQSh8wpuc=;
        b=e8Rw0+VUR/lvfNpwqQDHV22ycUiE1nv8qkvqOC/kx0qUJs4sYyKDCrGoxomDVEgH/D
         kypeetpLiT02ReK0RvHIqfNDmjeSzHkJIuFerJy8UTitTX2VihFf6kJx7cWtpFzKMjm0
         W/CVrtFp8sTQ+VqJ0VyYZf6UxVXimagHx3UuKWroMSw78v6wJc5PR20YAYlAB94f6qNd
         bP9i9Ch6l69fUcbz5NcEFL0jDDt1TI2qxogbVE/evGOqu80dEb1lqVaq19EGyRpKU9VH
         QwIq4Ywf0hs3+sdl+PQM0gt56FDYjXGUo+iPhMhYexk5w97OavF/jXXqsefnOpAaVSxa
         VUCQ==
X-Gm-Message-State: AOAM533R7yxVChGbuCGixoecHBYzAcAXzEA0CWyAZSXGfqm5FMl2adWJ
        0zvtAU6JrvNuXfEeH9kUisBr7Q==
X-Google-Smtp-Source: ABdhPJzCQHN38hZX4BtGfkt9pFVlma1cQmupy1DlTQ3DM66Ksjm3tSyx7wu82r7qLuXQcp50EsRqUg==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr2501822wmk.116.1612955677081;
        Wed, 10 Feb 2021 03:14:37 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:31ae:b3c8:8fe:5f4d])
        by smtp.gmail.com with ESMTPSA id u10sm1907633wmj.40.2021.02.10.03.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:14:36 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v7 4/5] selftests/bpf: Use vmlinux.h in socket_cookie_prog.c
Date:   Wed, 10 Feb 2021 12:14:05 +0100
Message-Id: <20210210111406.785541-4-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210210111406.785541-1-revest@chromium.org>
References: <20210210111406.785541-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When migrating from the bpf.h's to the vmlinux.h's definition of struct
bps_sock, an interesting LLVM behavior happened. LLVM started producing
two fetches of ctx->sk in the sockops program this means that the
verifier could not keep track of the NULL-check on ctx->sk. Therefore,
we need to extract ctx->sk in a variable before checking and
dereferencing it.

Acked-by: KP Singh <kpsingh@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 .../testing/selftests/bpf/progs/socket_cookie_prog.c  | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
index 81e84be6f86d..fbd5eaf39720 100644
--- a/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
+++ b/tools/testing/selftests/bpf/progs/socket_cookie_prog.c
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018 Facebook
 
-#include <linux/bpf.h>
-#include <sys/socket.h>
+#include "vmlinux.h"
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#define AF_INET6 10
+
 struct socket_cookie {
 	__u64 cookie_key;
 	__u32 cookie_value;
@@ -41,7 +42,7 @@ int set_cookie(struct bpf_sock_addr *ctx)
 SEC("sockops")
 int update_cookie(struct bpf_sock_ops *ctx)
 {
-	struct bpf_sock *sk;
+	struct bpf_sock *sk = ctx->sk;
 	struct socket_cookie *p;
 
 	if (ctx->family != AF_INET6)
@@ -50,10 +51,10 @@ int update_cookie(struct bpf_sock_ops *ctx)
 	if (ctx->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
 		return 1;
 
-	if (!ctx->sk)
+	if (!sk)
 		return 1;
 
-	p = bpf_sk_storage_get(&socket_cookies, ctx->sk, 0, 0);
+	p = bpf_sk_storage_get(&socket_cookies, sk, 0, 0);
 	if (!p)
 		return 1;
 
-- 
2.30.0.478.g8a0d178c01-goog

