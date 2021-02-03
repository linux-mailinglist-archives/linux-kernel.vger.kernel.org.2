Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89A730D96C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhBCMBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhBCMBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:01:18 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1042CC06178A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:00:11 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g15so17204774pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qiaBVEZpA8Xo3CJyOAtaUaP2kzBvWdhYRuLo/mSWVKU=;
        b=HGv0pMdLzfcs9yqvkpK455qLVU8no2RvlmsDHwHuIvCfo5lqmg0y+tjFQR1wreuHHz
         BH+ZoqGxgZ3jJ82CX0cgyLetkWii90iNoED1V5dLaXxaQgTOLKqdeQjUNUC0q8T5DlWx
         lP6Do60cMbZ+X7p/O4Zbeh5ABfjzvqaNzH8z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qiaBVEZpA8Xo3CJyOAtaUaP2kzBvWdhYRuLo/mSWVKU=;
        b=liwbmSPnjPll5rWfVIYTl/fhNNEb4edBnSbTIUXXTnAkj7SvR9jf0BD6wadmIDneHR
         LZe/V5avx4gytMOzQmSKMiwXdyqsBO5eDXTczS3gjJDVP9H0z/NAety9OETmjskuEV6c
         +efh6WrKJ6E54aIt0cenit7Ipjx0P3rLwb6qFIf/Q1KrklgSwhoiIhZqTF6xxGZcVHER
         kVIvgCD4e9vybilQw/UIfDqgQbxu6kqESUAZQCC/uhIwbOXAhaWFpvmk0BqIu4dy3OkP
         D9Nv7t3LZG6Dl7WkJxa7UKxuHVEPzFXlOuHdqqY5lzwT7HYtFPTBenRwLd+nKbiI4LRM
         V8RA==
X-Gm-Message-State: AOAM5323oghmTrKK5Ezxlgs6pVVT7UmuJONSh/3tLrFyz46RBVmzXLQj
        /GjTRMY3qjKXjiT1ca/r49/Gnk7LCWUDhw==
X-Google-Smtp-Source: ABdhPJxFJ1tYSDB+nz4ocsXdc7DktJwVnAnbesODItHndkApfUngNGp46fA2hgEkXUBdkDxJapmh6w==
X-Received: by 2002:a65:408c:: with SMTP id t12mr3287866pgp.157.1612353610461;
        Wed, 03 Feb 2021 04:00:10 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-1c59-4eca-f876-fd51.static.ipv6.internode.on.net. [2001:44b8:1113:6700:1c59:4eca:f876:fd51])
        by smtp.gmail.com with ESMTPSA id a19sm2226291pfg.75.2021.02.03.04.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:00:10 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v10 4/6] kasan: Document support on 32-bit powerpc
Date:   Wed,  3 Feb 2021 22:59:44 +1100
Message-Id: <20210203115946.663273-5-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210203115946.663273-1-dja@axtens.net>
References: <20210203115946.663273-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN is supported on 32-bit powerpc and the docs should reflect this.

Document s390 support while we're at it.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/dev-tools/kasan.rst |  7 +++++--
 Documentation/powerpc/kasan.txt   | 12 ++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index e022b7506e37..9cfc116cc6bf 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -22,7 +22,8 @@ out-of-bounds accesses for global variables is only supported since Clang 11.
 Tag-based KASAN is only supported in Clang.
 
 Currently generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390
-and riscv architectures, and tag-based KASAN modes are supported only for arm64.
+and riscv architectures. It is also supported on 32-bit powerpc kernels.
+Tag-based KASAN modes are supported only for arm64.
 
 Usage
 -----
@@ -332,7 +333,9 @@ CONFIG_KASAN_VMALLOC
 ~~~~~~~~~~~~~~~~~~~~
 
 With ``CONFIG_KASAN_VMALLOC``, KASAN can cover vmalloc space at the
-cost of greater memory usage. Currently this is only supported on x86.
+cost of greater memory usage. Currently this supported on x86, s390
+and 32-bit powerpc. It is optional, except on 32-bit powerpc kernels
+with module support, where it is required.
 
 This works by hooking into vmalloc and vmap, and dynamically
 allocating real shadow memory to back the mappings.
diff --git a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
new file mode 100644
index 000000000000..26bb0e8bb18c
--- /dev/null
+++ b/Documentation/powerpc/kasan.txt
@@ -0,0 +1,12 @@
+KASAN is supported on powerpc on 32-bit only.
+
+32 bit support
+==============
+
+KASAN is supported on both hash and nohash MMUs on 32-bit.
+
+The shadow area sits at the top of the kernel virtual memory space above the
+fixmap area and occupies one eighth of the total kernel virtual memory space.
+
+Instrumentation of the vmalloc area is optional, unless built with modules,
+in which case it is required.
-- 
2.27.0

