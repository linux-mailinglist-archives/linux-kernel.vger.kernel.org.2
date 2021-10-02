Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8460941FF01
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 02:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhJCA5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 20:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhJCA5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 20:57:06 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3553FC0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 17:55:20 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id u11so9536909uaw.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 17:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=tVXeAmNHJn7089TI6x6JdBRSQO8KRp9mK26zxcPg+jo=;
        b=Jmle6jfRQt0MzXm7lx4EQlj8BmB3reqS0IscBgRpVyuHwNbS3tcbHT440AW1EwZ8Qa
         l8qaJDI5w9T5+ykkcbdY+NXaTKqjht7oSdsQY8XBZuE6mzHTsmY4ZtGFK9/gbmMto65V
         AdV9wJcNnY6XKcQcbm9rpLy2+VU8PwhvbNI7yvqKmHxywTP86Ui9wpUZU93lveQjobaW
         HvPqXDOtLQx3s+MUr460GSaeA/kog6SlM9pLvO/4sIryk7Bo55zptkuU0O2WVNlnVnPq
         3oH1tMKJrub8HDePTw66dkY3ME5wYoagC+B2GgKpOGU5txZ7K6nnLuwCBiS2f7Ce87Sy
         ac/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=tVXeAmNHJn7089TI6x6JdBRSQO8KRp9mK26zxcPg+jo=;
        b=kLKiEBmnQKtjPkgFy0PDRJhwZzwsSpKYQrIPsTwFueGjvxbQst1KPCLtWhOBEFSUeC
         9i0eRJ27rk9Mr7O1SipHpao/eB4e1mo2fGxL9sJhn/kMJtnYpVzIk3FopwXEjILpFGsl
         9UyYUaMOUbmHAEJeav4S7uWYcoMwK6jPsdjq9iCmOSqT9kSiEFjSbzxjcIDB+fhX9NH9
         vIkdqNa49umNMR7mRZLOkX9wbyTt75rT59RZ/vuuwlMgGyACICZtzkpqGNv/wYbv8B9a
         xmhrk2nCkZ01QqtsNuLRHfADfbREBWJsmBM8ZBJKVYvqpI8Qj3L7R3DUuUd25t8aSkoR
         HuUQ==
X-Gm-Message-State: AOAM5319IfBRsvKBPyIMJygt0wHmaLvZtaM7rn+gjlG1wJO50nNdBQQe
        avdUURdO1dmMZFv7a+UWfJVcXg==
X-Google-Smtp-Source: ABdhPJxURd5VbcY4ybyhS3JjskY1pkkPDj/0I19ACm5f595gaw99JEsTXcyPMCtYQIF4hs9IRHZneQ==
X-Received: by 2002:ab0:4a19:: with SMTP id q25mr2855117uae.143.1633222519103;
        Sat, 02 Oct 2021 17:55:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f23sm5159759vkl.47.2021.10.02.17.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 17:55:18 -0700 (PDT)
Subject: [PATCH] checksyscalls: Unconditionally ignore fstat{,at}64
Date:   Sat,  2 Oct 2021 16:57:13 -0700
Message-Id: <20211002235712.189536-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, david@redhat.com,
        catalin.marinas@arm.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        rppt@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

These can be replaced by statx().  Since rv32 has a 64-bit time_t we
just never ended up with them in the first place.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
Happy to take this through the RISC-V tree, as it's fixing a build warning
(that's being promoted to an error for me, not sure why).  I'm just not all
that familiar with how this one works.

Arnd suggested putting these here, but not exactly doing it this way.
---
 scripts/checksyscalls.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index fd9777f63f14..9dbab13329fa 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -82,10 +82,8 @@ cat << EOF
 #define __IGNORE_truncate64
 #define __IGNORE_stat64
 #define __IGNORE_lstat64
-#define __IGNORE_fstat64
 #define __IGNORE_fcntl64
 #define __IGNORE_fadvise64_64
-#define __IGNORE_fstatat64
 #define __IGNORE_fstatfs64
 #define __IGNORE_statfs64
 #define __IGNORE_llseek
@@ -253,6 +251,10 @@ cat << EOF
 #define __IGNORE_getpmsg
 #define __IGNORE_putpmsg
 #define __IGNORE_vserver
+
+/* 64-bit ports never needed these, and new 32-bit ports can use statx */
+#define __IGNORE_fstat64
+#define __IGNORE_fstatat64
 EOF
 }
 
-- 
2.33.0.800.g4c38ced690-goog

