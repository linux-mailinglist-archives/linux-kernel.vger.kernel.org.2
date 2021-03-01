Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4F3297DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbhCAW7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbhCARtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:49:51 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678DDC061221
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:47:59 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i10so2842263pfk.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFaVem5STDsBxH8OwspBfDEJiYdo4zC3KZA1kyPV7m8=;
        b=h2PSOuMvmPdp6evEuNi+nr2iBVa2b7Me3bCxbPJr/b+IWmn7XYRwafV1mldKNsfv/h
         oRi7Xt3sockVAb1LlttNqwE+RSMYRf4I0Oi7LFs9tzMdfnmnhy6XYlbiiHwHwLIwjowN
         5PUFuMRqc+s6Tfn148Qwxsut3AqlLpZfdVNVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFaVem5STDsBxH8OwspBfDEJiYdo4zC3KZA1kyPV7m8=;
        b=opFxBcPsVuEqHTjh8sb32MSoDYKcKKa/CLbwyAicCndO5Vaq7+q9+wGY1gqou+woYV
         BAfvKqP4JI++Wq9ddaF5bgr9/4bOMDeYjbNqvDyaEpWkM//3+vUPphBYBh63oWzFCqPW
         luGOg7K08hy8CohpU8x17iWEaCfcvpaRNTfpFwHtnv+qMJzRmEoIBfoJqZEJLPA3WmfJ
         qWNucxWdloihuVEe3HCcLc1sJUayIeBelvg87IslyChmye6EZ2Z1IOPfLWnx39hbJtM5
         SQs/vst7lL3b12Q9TTTltSDLXawAqP8zxzT9PVwDO8z/nDTVkJM9/eXzBuNgXKOfynVG
         ngsA==
X-Gm-Message-State: AOAM530ECFdinnTkc3Nt+QOd4tM6Cbii6/d2+GLMSqb/FpFo8/K0GCfI
        OH4VH/AJwvPMkt1I/csjy3DcVQ==
X-Google-Smtp-Source: ABdhPJwO5Cgp7nTWNpzYPhBUjHPqnkRe1QSvVnVQMc8RyVKOv5GK127EzCYXaOwFkkpnDuiZK+pISg==
X-Received: by 2002:a63:5557:: with SMTP id f23mr14767509pgm.242.1614620879052;
        Mon, 01 Mar 2021 09:47:59 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3c20:df33:e36:93df])
        by smtp.gmail.com with ESMTPSA id y202sm19071325pfb.153.2021.03.01.09.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:47:58 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH 6/7] buildid: Mark some arguments const
Date:   Mon,  1 Mar 2021 09:47:48 -0800
Message-Id: <20210301174749.1269154-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301174749.1269154-1-swboyd@chromium.org>
References: <20210301174749.1269154-1-swboyd@chromium.org>
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
index 4e1d7c51dc5f..71c087a6afda 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -46,10 +46,10 @@ static int parse_build_id_buf(unsigned char *build_id,
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
@@ -64,7 +64,7 @@ static inline int parse_build_id(void *page_addr,
 }
 
 /* Parse build ID from 32-bit ELF */
-static int get_build_id_32(void *page_addr, unsigned char *build_id,
+static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 			   __u32 *size)
 {
 	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
@@ -89,7 +89,7 @@ static int get_build_id_32(void *page_addr, unsigned char *build_id,
 }
 
 /* Parse build ID from 64-bit ELF */
-static int get_build_id_64(void *page_addr, unsigned char *build_id,
+static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 			   __u32 *size)
 {
 	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
-- 
https://chromeos.dev

