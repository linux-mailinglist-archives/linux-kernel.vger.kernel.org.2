Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEFF459874
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 00:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhKVXga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhKVXg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:36:29 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7DAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 15:33:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n26so17537774pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 15:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+v7bjTJ4Q3k72mUckY/vna9r5hdbnIr+w4bsRguwuxg=;
        b=HYZJN5nQT5ffIfe4A5FmRotB0sauY++n1cHO1UWu/y/I6EgV9v9t0g5tDt3sXKFa1O
         IdZOgNSjoa78yQSAPvApsxGyVdU+MP7D5bZmEeFDV8KZ3griZwooVbhktLDm/dbW4vic
         sFo5ou51c0mo2djjuUCL3kJ3PgeJ0eFVviLY5r/fnF6FYAqbRVfIWnxar1V7bo4IuPTt
         mLKCBYxHXhnTUxEQ75HArkHZGDO8g0DAgr3gQTcwBFwDFDtEoRUbf9u8Bo8ZrsTinbjh
         ybli+C0RObHoMq970WvrpMssXjymU4qAiiAsKD18096jc4je5SIpG/HwnRMOccgYLsSm
         MpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+v7bjTJ4Q3k72mUckY/vna9r5hdbnIr+w4bsRguwuxg=;
        b=0SSCciMHSdUwBoN76fFRxJJ/smULfkGAA/RCPO+SwiDRnWhHheJjq9l8aBkuyeU9JB
         mHFFsLYbKVYTZY/SfakeatQJtCoS82UrWXrpAxY61FE6I7d1/ykxOzffFCNCE6y7K2ew
         XdzFnSUyV8GQ/MtVDaGkrzshx9ioxzMg1i99tym1HWGUVX9vq/pbkpPk4xNoBpJi2KYS
         Gq+g5KpWZuTTl9bx8iwRQKIfFMBvjeAU+VrwQ7D1eE6Vi7DMDZk/QIxp0zFLtHngRTe1
         UXQv8XiQ4Oae/35No2vwuD+A4YuuysvRmLsCXKEJiX4m7btxbOr2bBggwg2NzCcSYYVX
         faLg==
X-Gm-Message-State: AOAM531XhrY6QER4FE2cKRdZeU6DDEdxzyrxxfnEZRsBWze9krpVg+4X
        X1q3Dr2YGQrnLKQzfe3+H7Q=
X-Google-Smtp-Source: ABdhPJyjCR2z/DOgUPPL2gLYko8fi4Npi78xIiH9uIvCRxByEuftaLaFvhyTa+DUl6ZoBP5eyFNNQg==
X-Received: by 2002:a63:9d8b:: with SMTP id i133mr571386pgd.125.1637624001644;
        Mon, 22 Nov 2021 15:33:21 -0800 (PST)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yct-z7s--tg8y8t-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:50fd:36ff:fe05:e039])
        by smtp.gmail.com with ESMTPSA id y6sm10195837pfi.154.2021.11.22.15.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:33:21 -0800 (PST)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Subject: [RFC PATCH 1/2] pgo: Update .profraw file format to version 7
Date:   Tue, 23 Nov 2021 01:33:04 +0200
Message-Id: <20211122233306.155968-2-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122233306.155968-1-jarmo.tiitto@gmail.com>
References: <20211122233306.155968-1-jarmo.tiitto@gmail.com>
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

