Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C52329AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 11:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378181AbhCBBEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 20:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbhCAS5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:57:49 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3EDC061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 10:57:08 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id lr13so30198306ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 10:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBUmk+i9RZF3Nn9zKNKIfJ8eYQzXTK2RP3YEZ6TddRQ=;
        b=ow/f3NXkmHEnlN+4Z8bt+nml4yTmSwkbryiQ0NfTRrAgxIzghIy7YYvSqQh9O340wF
         8jPZmHA5raqoALA6nGoCXwcmRe4S9wQVqLlOSbbZ3PKgCtgBxwNSs+R4LB1bwFb5EnyO
         7g+4PzfDJ092qQnngV+6hsV5SpKW9BH3R+iAItz8wFOuKKRxHHcF8+/bxpYgtNwYWM3G
         UNMeAeRWXn7pgVvzYR9UchvfI3dvCXMJVAZ1gNCsgGTy/oqBIaS9rXJ59MxRoDwDd9Ut
         A+CatJzZ20jYrfFxZp5h3oWXx6DK3bjDvYOXuGCkBVRwxSdEnHvroIVuWGOqQe5MF1Pl
         O9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBUmk+i9RZF3Nn9zKNKIfJ8eYQzXTK2RP3YEZ6TddRQ=;
        b=IQDM39M7HmZTduxi5VS0ky0tJy43AdMNLEeEOrMMPWBMwxSWloLVqn4+qgsnKcvkt6
         EUxzjX4AFAObLpwF1N9dy/GaaiFE6wCAcZi1i0wVb9PRjCioB+pcA+WMtnobqyyu9NYL
         XZeH5hOLvmDD7hO30ZX0Rclj3+O6N1uclGiKe3qcJEwug7Yael4Q0OWG5bl6qIg+QG6S
         YeL0hZOUIFblbK5Y5SFApeftRO7hE7DxYu6cFJRWbiOcPOUg0BudxHSjjqS3Dsprt5L8
         N7/PkuFRosAUqYFKZ+gHhKlrLPJTrUu0HsHb4JB5z89t+BfPSdCXtRGGWw++eBX5D1Sg
         +e8g==
X-Gm-Message-State: AOAM533ep5/Cjv+P9cFx/yuapSFcxKcV53fXNA9vcL/SgSe4Knl2zDUs
        AFdr7HZpySqAypPGvlws0mM=
X-Google-Smtp-Source: ABdhPJw03B3ZhrHUyXXC6zq2cWZuS4J9LpoEQoH0x7bO5YYNdZbJZI4KABg7zWTrPC85HrVU3T3vkw==
X-Received: by 2002:a17:906:15cc:: with SMTP id l12mr17472248ejd.280.1614625027158;
        Mon, 01 Mar 2021 10:57:07 -0800 (PST)
Received: from localhost.localdomain (dynamic-046-114-039-064.46.114.pool.telefonica.de. [46.114.39.64])
        by smtp.googlemail.com with ESMTPSA id z17sm8998745eju.27.2021.03.01.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 10:57:06 -0800 (PST)
From:   Gon Solo <gonsolo@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Andreas Wendleder <andreas.wendleder@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Perf: Clean generated directory.
Date:   Mon,  1 Mar 2021 19:56:42 +0100
Message-Id: <20210301185642.163396-1-gonsolo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Wendleder <andreas.wendleder@gmail.com>

Remove generated directory tools/perf/arch/x86/include/generated.

Signed-off-by: Andreas Wendleder <andreas.wendleder@gmail.com>
---
 tools/perf/arch/x86/Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 8cc6642fce7a..5a9f9a7bf07d 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -10,10 +10,11 @@ PERF_HAVE_JITDUMP := 1
 # Syscall table generation
 #
 
-out    := $(OUTPUT)arch/x86/include/generated/asm
-header := $(out)/syscalls_64.c
-sys    := $(srctree)/tools/perf/arch/x86/entry/syscalls
-systbl := $(sys)/syscalltbl.sh
+generated := $(OUTPUT)arch/x86/include/generated
+out       := $(generated)/asm
+header    := $(out)/syscalls_64.c
+sys       := $(srctree)/tools/perf/arch/x86/entry/syscalls
+systbl    := $(sys)/syscalltbl.sh
 
 # Create output directory if not already present
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
@@ -22,6 +23,6 @@ $(header): $(sys)/syscall_64.tbl $(systbl)
 	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
 
 clean::
-	$(call QUIET_CLEAN, x86) $(RM) $(header)
+	$(call QUIET_CLEAN, x86) $(RM) -r $(header) $(generated)
 
 archheaders: $(header)
-- 
2.27.0

