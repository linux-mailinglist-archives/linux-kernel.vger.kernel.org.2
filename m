Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B721A418B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 00:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhIZWfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 18:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhIZWfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 18:35:19 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BDEC061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 15:33:42 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id a9so10089756qvf.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzBIb9Rrkx8NbszjPdEpu16O5Mah570+vhSFzL6iVU4=;
        b=Y/0/o41Pe70qQK42UBfSUxuIpnjC4YEfaSZ/UYMWHES/flFLEToveab17WLhcNVcKB
         GR2F9mdNeqemVHENgXeRLl98XUkl4rtguI3a5jtFz3zCCuYuY9pJ9Gvy0wt1GAhUP+q0
         rdaiVhkJFcw01gjL4qcsMlb61PTmjKusbosQlMh5lxIuiyOa64qAt0XspObUdCBxeeqX
         gLR1jOiUqRw5ZQzl22QVvN0CsihS65sr8SXn0PzPs3OkPuX0/oknbIyASrG3LH2Mujj7
         paWWhUeJl8It37sOsLi16y03iYg1NANggXlqw17e9G/rcHcGaN/eL9CkV7Br7hkU9ar8
         AJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzBIb9Rrkx8NbszjPdEpu16O5Mah570+vhSFzL6iVU4=;
        b=gAAGAMCON7pjnJzWNHRyLub7+unfNvtfKcGLhT9TrVbs2nkllZaT3xglfCWFBZfLay
         UxQPxcx37kpT3EzDQCncMuYPT/BGkajvzbhCnf/7dqOfUpO4T32aIMs2ykyOh0axSXRo
         d627igLWZIZSQNP4aGlMM3x/KWhl4pZqUf1wf26IdCTWbm7UEG1l1ju/WElhO7it0eVR
         ce4FHurM49TV5gSOALUwURS+LRvswuMVjzaAFUZauzhrwld4QjjUnYEQyRq00e7C9LBL
         zO9CDM1fAE/ieWlF3V2JKT17FUPEBzcQlPH/P0BAA9I+z/GMDuoAOzPxgBnV6nfDqEax
         DrWg==
X-Gm-Message-State: AOAM532GECZmwuduAVM8XZ+JtxBIAJgmWBe254NCelC43w2fCt7WYXKw
        i3j02iISxdyXvHQRcYi4gnVdpQ==
X-Google-Smtp-Source: ABdhPJx5HD00AzRcLzny2/Y+fepBxWgk/Zkm/8XqmoemEyc0fYvS0c3N0NbzjA/cfFbwcDISkLWSvA==
X-Received: by 2002:ad4:4531:: with SMTP id l17mr2839310qvu.18.1632695621723;
        Sun, 26 Sep 2021 15:33:41 -0700 (PDT)
Received: from aehse.localdomain ([2804:d41:bd1c:9100:f2e1:f671:7a83:1eb8])
        by smtp.gmail.com with ESMTPSA id x6sm7244151qts.79.2021.09.26.15.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:33:41 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH v2 4/5] lib/Kconfig.debug: properly split hash test kernel entries
Date:   Sun, 26 Sep 2021 19:33:21 -0300
Message-Id: <20210926223322.848641-5-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210926223322.848641-1-isabellabdoamaral@usp.br>
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split TEST_HASH so that each entry only has one file.

Note that there's no stringhash test file, but actually
<linux/stringhash.h> tests are performed in lib/test_hash.c.

Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
---
 lib/Kconfig.debug | 14 +++++++++++---
 lib/Makefile      |  3 ++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2a9b6dcdac4f..eb6c4daf5fcb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2207,9 +2207,17 @@ config TEST_RHASHTABLE
 config TEST_HASH
 	tristate "Perform selftest on hash functions"
 	help
-	  Enable this option to test the kernel's integer (<linux/hash.h>),
-	  string (<linux/stringhash.h>), and siphash (<linux/siphash.h>)
-	  hash functions on boot (or module load).
+	  Enable this option to test the kernel's integer (<linux/hash.h>), and
+	  string (<linux/stringhash.h>) hash functions on boot (or module load).
+
+	  This is intended to help people writing architecture-specific
+	  optimized versions.  If unsure, say N.
+
+config TEST_SIPHASH
+	tristate "Perform selftest on siphash functions"
+	help
+	  Enable this option to test the kernel's siphash (<linux/siphash.h>) hash
+	  functions on boot (or module load).
 
 	  This is intended to help people writing architecture-specific
 	  optimized versions.  If unsure, say N.
diff --git a/lib/Makefile b/lib/Makefile
index 5efd1b435a37..c2e81d0eb31c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -61,7 +61,8 @@ obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
 obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
 CFLAGS_test_bitops.o += -Werror
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
-obj-$(CONFIG_TEST_HASH) += test_hash.o test_siphash.o
+obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
+obj-$(CONFIG_TEST_HASH) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
 CFLAGS_test_kasan.o += -fno-builtin
-- 
2.33.0

