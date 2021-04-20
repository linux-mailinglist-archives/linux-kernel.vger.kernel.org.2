Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF893661C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhDTVvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbhDTVuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:50:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20101C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:14 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u7so18620158plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SFxY7ZINiVkfJBwgddI5IfRF8IJdmESMPQk7SWg6uGA=;
        b=M9pIfIFluB5GPh2oNFPYn+52ZMZjIoFjjRK+nRByHKY5GxBWxzU5uI2OthKleL/DDd
         +Kc5xfRQg+h8rVFE2W61MM+D9MfTBIMvgOysWXuSMm+2aklFE5yIUyubQjG16emalSvM
         8f3bsA6HJLJyiN8znbIlQ9DvFuG1Yh2HXSAgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SFxY7ZINiVkfJBwgddI5IfRF8IJdmESMPQk7SWg6uGA=;
        b=L8d+RWa0TE3rOixyqXy/FpFKIquuI3S8/9oo3cjsl3pFYZeyDfwVODfUvnrHt0vrzu
         TdfKaDECH7DQTuWU2bRga16WKVi2caTx2uL1+usJmzkEmfWavy1ITYZYIEznSfXm7i5S
         kcTlxSwLUyHsuB39rQC8EirnuWcBDMh9RUn6kAhkQ/sK77LFRrUyshrL0La2bmEq9XXX
         2s4bVhSD5GoLp9kPVJqItTQPkSu77ywxiIvujRSRCAajiBN6tXcBB/bG7/iyVO6ViJhj
         l1vnOdFLO7czuSe/s0kYJnpJa378/NdHHJD4MCWXa7pq6JgKf2ufDcE/mZ7cYUQoFYvY
         4OIQ==
X-Gm-Message-State: AOAM533jPc7/dPLeRP+G89Cg7CbYw/crR6YnJ6JImJtMhYfz0y/dbILb
        r+mXat2efcQz9fUy8oxmWKjrEKmo+hMBew==
X-Google-Smtp-Source: ABdhPJx9In58E5J8Vpu625IbmqgXx31vHpgeWWQmZOeYJVUnjSV2CcyNbXL8rHw8H2pX57h/Ts8zJw==
X-Received: by 2002:a17:902:7043:b029:ec:939f:c9e5 with SMTP id h3-20020a1709027043b02900ec939fc9e5mr17924699plt.64.1618955413739;
        Tue, 20 Apr 2021 14:50:13 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:bf8b:4b8b:2315:3719])
        by smtp.gmail.com with ESMTPSA id c21sm31481pfo.91.2021.04.20.14.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:50:13 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v5 11/13] buildid: Mark some arguments const
Date:   Tue, 20 Apr 2021 14:50:01 -0700
Message-Id: <20210420215003.3510247-12-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210420215003.3510247-1-swboyd@chromium.org>
References: <20210420215003.3510247-1-swboyd@chromium.org>
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
index 530dbd1f6bbe..a7edab4914e6 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -48,10 +48,10 @@ static int parse_build_id_buf(unsigned char *build_id,
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
@@ -66,7 +66,7 @@ static inline int parse_build_id(void *page_addr,
 }
 
 /* Parse build ID from 32-bit ELF */
-static int get_build_id_32(void *page_addr, unsigned char *build_id,
+static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 			   __u32 *size)
 {
 	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
@@ -91,7 +91,7 @@ static int get_build_id_32(void *page_addr, unsigned char *build_id,
 }
 
 /* Parse build ID from 64-bit ELF */
-static int get_build_id_64(void *page_addr, unsigned char *build_id,
+static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 			   __u32 *size)
 {
 	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
-- 
https://chromeos.dev

