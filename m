Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B197346F38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhCXCFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbhCXCE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:04:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E16C0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h8so94448plt.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwet6OVWdeJMtdtTDJ36Ir82gofgDUZMcP8EwdCLbzA=;
        b=CBY4+1eTXG6b7SRBiL7mXDnhZjxI0dYROO8YMAPMKav9aJEDjlGSZRjzTQYDoZFNi0
         ehYCAdypk7cfQePKHAsAIFehPCm6vnLgsbWLkI4mtQ+ZlZSbcqWfIQJf3ULj9Kl8oBYp
         XqaEuR6ryNJdaVXgbI7HQgNlRMv3NeaOkAoSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwet6OVWdeJMtdtTDJ36Ir82gofgDUZMcP8EwdCLbzA=;
        b=ORZqGd79lfo48ilzTU0Sm+RZHvB6daWUqFQZb20Bt3U+0SnOn7t2Wi8aTJAzRLhy/c
         CihcnUA8qe9NgXmuO2x5X5OZ1vmfyEDvCiEuGrPZunMyy5uZ0POlanzm/zoC2lj5HI6y
         W/6nbYQcbY2whb6J0PR8wlL7uDWHSOiFdP/oHuRfOzKZ604t6XFwzvB6QPpidFmjldXI
         j1BddOCOz1V72ApnMQu3SwnHpZCZC7E1AVQcwUMisNiVTXsNgTegazI+un/JXbBjPfDE
         ApAMyTImpy49J6eQTrKNgG0pjLiuz3BxOV0H9MdgZJPWRFcHxDP5s6k+HTaSMEZo/yG2
         NR8w==
X-Gm-Message-State: AOAM530+zXLK4DnXnMyRhTFXQmugIuDPk4lHrtngPk58EW9FHJcEbfER
        hFuxEMS/j5RFVGWgOUCgS6YhXA==
X-Google-Smtp-Source: ABdhPJxJmF4+5+BIvq7P3L++zXhbn/JuzaYx8RyduPHA6tHQHvR4dEy7ixHqQxbXe0st5NAiThoS9g==
X-Received: by 2002:a17:90a:be07:: with SMTP id a7mr965844pjs.75.1616551498860;
        Tue, 23 Mar 2021 19:04:58 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:04:58 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v2 10/12] buildid: Mark some arguments const
Date:   Tue, 23 Mar 2021 19:04:41 -0700
Message-Id: <20210324020443.1815557-11-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
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
index fa1b6466b4b8..1a35b28a85d8 100644
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

