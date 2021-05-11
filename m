Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B405F379BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhEKAkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhEKAkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:40:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08050C06138E
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:39:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h127so14803231pfe.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8xF92PparIxztbt4SChu73xFaTVW2RGRWa+Ds/uypI=;
        b=BOwtpvbwDPuv3fKhGWLdChHX9yqlnD5sQABCARi2uggmarwZ4kpmIiteRLcNXNwCw1
         W/C3n8A02ZSv8GmySfJ04YXsf57shR/gEbZqjshqQI6Q/tMtZfe8NZcvGeUysz7yIyrE
         Xl/u5hAYrCbObQHVj6xVm96X5A9Icrr5E26hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8xF92PparIxztbt4SChu73xFaTVW2RGRWa+Ds/uypI=;
        b=gZ82LWg79XBvPA+rEdz3azrbo1/32/c8jKXyawiY4Mgrw8dCQmzjEVtg+lXL+XepnB
         GK8yNO2dYLckW1rNYYoLoYeFjzVRsisuPZXTZtJgpG3yutqjqbndvWwE8t+S9hZrtwzO
         xeeh+S2b67luzchErdtFc+ggsxg3a+DP1nktzHxbmkMXcmA5YRYHlT5RFpC64/oPxq4E
         zCnIOCktvusbKHoFodeLEVbakGG/F+/e+sMm5M/LyS6yXfjEEIjyZCXtRkby96aOolhV
         5cpG+r4Q3RNHcyC6ScLvuCiJZ7p3A63ymOgDltXDGIrtTCF+80FpVunzKc/ro1QHjMOU
         JEeg==
X-Gm-Message-State: AOAM532pSGTqATL4ma2soeX5WVCylt/P800Js9/AvM7XeVH/kJPJ39h9
        Ie7OGzsayY1SPNxwoARpj96Hag==
X-Google-Smtp-Source: ABdhPJwbzz3K0Vj2A5bxLHH6Gg7UHqtma3oeoCN1QMcOKFxigoeFEQ+utE7Y5e/tcKKS7XjiYteqWg==
X-Received: by 2002:a62:7c45:0:b029:27f:f30e:f0df with SMTP id x66-20020a627c450000b029027ff30ef0dfmr28250043pfc.49.1620693541502;
        Mon, 10 May 2021 17:39:01 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6765:417e:19fc:9756])
        by smtp.gmail.com with ESMTPSA id d26sm12142539pfq.215.2021.05.10.17.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:39:01 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v6 11/13] buildid: Mark some arguments const
Date:   Mon, 10 May 2021 17:38:43 -0700
Message-Id: <20210511003845.2429846-12-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
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
index 6f1e2903740b..8fe24d6c0925 100644
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

