Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969E334F72D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhCaDFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbhCaDFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:05:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A21C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v8so7181825plz.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWzx7a4yEEmhkNqim1nF5/sbXLCId4RBCZFnVJCglEI=;
        b=P2OhPPciQb6hE6N+KG/SrmQe8072khFFaPOMQKgmkRY1TmJCIRrvC2Hw8hh4EzpqKw
         QG5W3Vqx4SezW2u1O3WoP49okxD/VFfG3UuVkXO6rqLmbHjdWosjqA7Tli1Do99o0e7P
         XHijkCp3AXyHvcuQlUV5prvltQ6jBs7u3c6as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWzx7a4yEEmhkNqim1nF5/sbXLCId4RBCZFnVJCglEI=;
        b=Ou9vPPam9u6RU0GZJsjQ6JLUXlwzMbNw5GOZsDSI1YIGx08tlDQys7ynbczLyoMYra
         T9+Sfl6LPGdNHev7MFicjwGiKkZLZdxwLzJ6E2a9NvOmW0cuytZsoJOdxeYO3xduelCc
         4+aODt3k8hMhdxgDEgwHGCfsf52qiTgNTmakDVdxtn+dCEBtZ5fYVRTCBEqLp9CIOnJl
         ROVlrCStH8W9P+f/jCeb7I8wxIAI4FevzPCH9nqvTKYoSsw5fA5zZ02FAMiDBr+3MbdQ
         ueYiTSbdAf7TGRVMCHA3CoPg+ElF7Gnilhzh9rJ/DiRTrWsa+TUHtRpAq3yuemezhnt5
         V4Qw==
X-Gm-Message-State: AOAM532mGvhRPpcSGCeTjSNgbe2i+UoYMhoAEzCXA0tzhapeVfvzq4b1
        rq/YenfzCvMeDH2CFysEsFlc5Q==
X-Google-Smtp-Source: ABdhPJyZNhYRR0BM3+t1x9tead4q6NIUZXizAS0Z5S5tPAJSoq68kiKBi/aAokO51XTAjg7uA7F6/A==
X-Received: by 2002:a17:902:8498:b029:e6:f010:a6fa with SMTP id c24-20020a1709028498b02900e6f010a6famr1292084plo.30.1617159935730;
        Tue, 30 Mar 2021 20:05:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id c6sm389024pfj.99.2021.03.30.20.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:05:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v3 10/12] buildid: Mark some arguments const
Date:   Tue, 30 Mar 2021 20:05:18 -0700
Message-Id: <20210331030520.3816265-11-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210331030520.3816265-1-swboyd@chromium.org>
References: <20210331030520.3816265-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These arguments are never modified so they can be marked const to
indicate as such.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 lib/buildid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index b939bbc59233..e8a473f2b023 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -47,10 +47,10 @@ static int parse_build_id_buf(unsigned char *build_id,
 	return -EINVAL;
 }
 
-static inline int parse_build_id(void *page_addr,
+static inline int parse_build_id(const void *page_addr,
 				 unsigned char *build_id,
 				 __u32 *size,
-				 void *note_start,
+				 const void *note_start,
 				 Elf32_Word note_size)
 {
 	/* check for overflow */
@@ -65,7 +65,7 @@ static inline int parse_build_id(void *page_addr,
 }
 
 /* Parse build ID from 32-bit ELF */
-static int get_build_id_32(void *page_addr, unsigned char *build_id,
+static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 			   __u32 *size)
 {
 	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
@@ -90,7 +90,7 @@ static int get_build_id_32(void *page_addr, unsigned char *build_id,
 }
 
 /* Parse build ID from 64-bit ELF */
-static int get_build_id_64(void *page_addr, unsigned char *build_id,
+static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 			   __u32 *size)
 {
 	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
-- 
https://chromeos.dev

