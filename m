Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DBD4599A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 02:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhKWBZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 20:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 20:25:39 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8FBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:22:31 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z8so7645599ljz.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+v7bjTJ4Q3k72mUckY/vna9r5hdbnIr+w4bsRguwuxg=;
        b=KHUf30VQn1ZVyxatiZMwksbGW4yx/73ZdX6kceDOUX09dkeDc+hltITGm3HGEX/kYH
         QDFLQv7Zgazk2dWzsLqEfQZj/Y6elr+3GEvOHvn/CqzP67vX0rllsvVisrSyGRFejLK7
         S9WxVJzYNwA5xteDU0VXhm+DBy7sVL5clj57kgXHPxTBhByxJIdEP52qZLkTLHkEawoj
         QqNpZCGQjqD8hzelkja43WsHQl121Wu9+y7fucVktrsSgo4X7R5KVQTPuGIquS2qSSeW
         xk/57o/GncRVbJdAas22IJhU+TcnhviOAtn6SfPywwSeDZG7lvWAzULdAO3cHuxbyuct
         LA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+v7bjTJ4Q3k72mUckY/vna9r5hdbnIr+w4bsRguwuxg=;
        b=wP8LEPoyDMNrIT/g8MpUInbfn1kh3Qiz+i82NFST0qYzhmLDS4ZEOla2UQzh6MHZ5K
         XJOBg4vIk19MaA46q4nMmphd5dwhknCSlFszn1iFFrM1nicGYtTvYa6PSx7kMy8CKrtM
         aZe6upcut9AUeLjFsuiX4jPBWex4fT+F0IKGuhUMlppu88Hri1Jkzd/xAEruDjJQJDas
         aNrK4s2qbllhebgnDri8ON7b/HopcBWLCH61OQIBkAzfjDDxS3xpI3LugV0j5FcCJ2Ku
         XUfxFk2iPvbDFJTyfVm6II98JD6yUC3QXIsfoCsUKref3lNE1ieOgrX23W7vcSE/MuNQ
         jj7g==
X-Gm-Message-State: AOAM531kg5P+SxY8kq9XJM0PWdrfWlZF1T5h9FmIaKhGh5uu4/vMUul9
        hJk/8psV8sdPaag536WcK1Y=
X-Google-Smtp-Source: ABdhPJy6B/wNtgkmxeAVu3rYxbA96TanTzMNVgCaXBb1m4CM6hjj5DSswiuGk4kwjP9hbhRFMuYwug==
X-Received: by 2002:a2e:9217:: with SMTP id k23mr800807ljg.267.1637630550152;
        Mon, 22 Nov 2021 17:22:30 -0800 (PST)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yct-z7s--tg8y8t-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:50fd:36ff:fe05:e039])
        by smtp.gmail.com with ESMTPSA id c15sm1304038lfb.40.2021.11.22.17.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 17:22:29 -0800 (PST)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [RFC PATCH 1/2] pgo: Update .profraw file format to version 7
Date:   Tue, 23 Nov 2021 03:21:36 +0200
Message-Id: <20211123012138.160532-2-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123012138.160532-1-jarmo.tiitto@gmail.com>
References: <20211123012138.160532-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent LLVM-13 can't read the version 5 profile file any more
so update the format to .profraw file version 7.

This version adds binary_ids_size entry to struct llvm_prf_header
and it is output as zero.

This is enough to fix processing the profile data on LLVM-13 tools.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
 kernel/pgo/fs.c  | 1 +
 kernel/pgo/pgo.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
index 3c5aa7c2a4ce..77d23f869503 100644
--- a/kernel/pgo/fs.c
+++ b/kernel/pgo/fs.c
@@ -62,6 +62,7 @@ static void prf_fill_header(void **buffer)
 #endif
 	header->version = LLVM_VARIANT_MASK_IR_PROF | LLVM_INSTR_PROF_RAW_VERSION;
 	header->data_size = prf_data_count();
+	header->binary_ids_size = 0;
 	header->padding_bytes_before_counters = 0;
 	header->counters_size = prf_cnts_count();
 	header->padding_bytes_after_counters = 0;
diff --git a/kernel/pgo/pgo.h b/kernel/pgo/pgo.h
index 04fbf3bcde1e..45eeff9ab6c4 100644
--- a/kernel/pgo/pgo.h
+++ b/kernel/pgo/pgo.h
@@ -43,7 +43,7 @@
 		 (u64)'R' << 8  |	\
 		 (u64)129)
 
-#define LLVM_INSTR_PROF_RAW_VERSION		5
+#define LLVM_INSTR_PROF_RAW_VERSION 7
 #define LLVM_INSTR_PROF_DATA_ALIGNMENT		8
 #define LLVM_INSTR_PROF_IPVK_FIRST		0
 #define LLVM_INSTR_PROF_IPVK_LAST		1
@@ -56,6 +56,7 @@
  * struct llvm_prf_header - represents the raw profile header data structure.
  * @magic: the magic token for the file format.
  * @version: the version of the file format.
+ * @binary_ids_size: the number of binary ids. (since LLVM_INSTR_PROF_RAW_VERSION >= 7)
  * @data_size: the number of entries in the profile data section.
  * @padding_bytes_before_counters: the number of padding bytes before the
  *   counters.
@@ -72,6 +73,7 @@
 struct llvm_prf_header {
 	u64 magic;
 	u64 version;
+	u64 binary_ids_size;
 	u64 data_size;
 	u64 padding_bytes_before_counters;
 	u64 counters_size;
-- 
2.34.0

