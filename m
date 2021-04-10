Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A97B35AA12
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhDJBxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhDJBxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:53:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644D2C061763
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:53:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u11so96548pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btJUrbbuYxga+0ZuR5wOi6KE/KhHQdS4LGHw92YDHEc=;
        b=gXBtyccVtYSbkzONyIlOADmjtti3f4Z76r5pfebGvbVSbvBpb1HlG1HefOSlAQdLDS
         P00iak7WZ7ijVAfxu8TX5yQIoHoVlS7dqWxQaibcFByHrB09qXut2E4Q80/fAeMYfbZ5
         mYNGfdbZOUaYP/SLWv6qooF/jwGdErmZAOaBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btJUrbbuYxga+0ZuR5wOi6KE/KhHQdS4LGHw92YDHEc=;
        b=XX/aBC+AyKe0KRg3FDJhZhLhrI74o897VzTbp77/XeP2pOIBIMNuvw62kaSWM8Gf1I
         nsjiKqui1q6A7Y59uJ5GjKtTbjc02JjPcE6/fS+Bk9dcp1YVp27ZpPTkWdyycBrwywd3
         ZVFhNbCOIRBy/n0G34n6zA+V+9Gu6DnV+hUEyL3wc5jR+OccYazzxXHI1gO7rRUGzrbK
         +furJoMpkSPSb8sOT++h5yOPiGCFEqwTA5pkDjIQS2CEdAcgKoQMnD81YX3Y/bstjoWE
         WCBjXtWNosl2mwuV1y5oNzsrt9EFMcEIP0TMf2pKEkRtK+avC+vISFXoa34BdbYpBN94
         4erA==
X-Gm-Message-State: AOAM530xZDbDsG5L4Y0BN9pYPfGV824gQCa1J8t0f1RnGxCzzHgHkRTs
        X8L7o7iFeQ9WU1ajnwypvffpmg==
X-Google-Smtp-Source: ABdhPJzgePqZi9BAEQAu0WHvKfEiXXgYpWqf63a2eO+NK8U6Vj3Fx83MFQjaeG76tDsBnnH/qoFz7Q==
X-Received: by 2002:a17:90b:94f:: with SMTP id dw15mr16991752pjb.3.1618019591072;
        Fri, 09 Apr 2021 18:53:11 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id n23sm3837962pgl.49.2021.04.09.18.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:53:10 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v4 11/13] buildid: Mark some arguments const
Date:   Fri,  9 Apr 2021 18:52:58 -0700
Message-Id: <20210410015300.3764485-12-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210410015300.3764485-1-swboyd@chromium.org>
References: <20210410015300.3764485-1-swboyd@chromium.org>
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
index 1103ed46214f..df42282b36ff 100644
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

