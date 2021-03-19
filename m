Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061FB341FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhCSOlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhCSOlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:41:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E858C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:41:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id g10so3052926plt.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCC3AVfnj1w2eD4KT8qv23tgUysFvODW8V6tvYzpnj0=;
        b=Kcj5V4JO6UXzdOoeJYTdGv3hGZ0yiAZ4YA1dMGC+BWrEwefW0Qhg42b9QG27UfIZz+
         uf8r2JJzyEWmiIGbkR+DyB3Cyv7gPflBIA9aFiPnFfODIyrgnN84967czC0raJWhAown
         P0aP8rySNsA8usPv4NxILaGKNQmu0E7Ap02sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCC3AVfnj1w2eD4KT8qv23tgUysFvODW8V6tvYzpnj0=;
        b=nAUaBTRDrHV/lE4pRBJM5zHNXpdwGuYJ/igwzaAQaNFTcX5gcF6uoelZns9siNumyf
         kESjaEDCnSuc+bBcm6B0A81Zec827vCnVa/+nyL4BGKvXDknuZuY50LCYsGDR8tKGugV
         iL8paSkrwcV6tg8lH9wcv7SoCjQCEI1k/dqMSeHoFbC5GJfR+fr8ea+iQ3YyODNQDbyc
         OPzViXqTjL8x2UXhAVxbvhVk1cQunWQ3bLHkX3sSsnsv59WeoSHrZctPaRCYk7oTuJq8
         GttOXJ5Dt1Ngzy8rW7/X15Ty0saXcnrRImpEKKneiyVSmCK8Vjl2mfTR89fW7U1vfMn7
         iwjw==
X-Gm-Message-State: AOAM532YCuS630ylVnDZjoBjOTCkUCxgdHG4THTTveMjmJ3WCw0V3UU9
        pfWanXCxI/ldCwy/OQBlZ9RO73+yNxPooQ==
X-Google-Smtp-Source: ABdhPJy9qheq4CMOyD57S1I8GxJvr41ZOEKYLEQSvW8ZHFsQj8D1wGZJuqJfJaHplnp4QE646Q++8A==
X-Received: by 2002:a17:902:ac93:b029:e6:548b:d61 with SMTP id h19-20020a170902ac93b02900e6548b0d61mr14570825plr.80.1616164880480;
        Fri, 19 Mar 2021 07:41:20 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-674e-5c6f-efc9-136d.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:674e:5c6f:efc9:136d])
        by smtp.gmail.com with ESMTPSA id o197sm5984619pfd.42.2021.03.19.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 07:41:20 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v11 4/6] kasan: Document support on 32-bit powerpc
Date:   Sat, 20 Mar 2021 01:40:56 +1100
Message-Id: <20210319144058.772525-5-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319144058.772525-1-dja@axtens.net>
References: <20210319144058.772525-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN is supported on 32-bit powerpc and the docs should reflect this.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/dev-tools/kasan.rst |  8 ++++++--
 Documentation/powerpc/kasan.txt   | 12 ++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index a8c3e0cff88d..2cfd5d9068c0 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -36,7 +36,8 @@ Both software KASAN modes work with SLUB and SLAB memory allocators,
 while the hardware tag-based KASAN currently only supports SLUB.
 
 Currently, generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390,
-and riscv architectures, and tag-based KASAN modes are supported only for arm64.
+and riscv architectures. It is also supported on 32-bit powerpc kernels.
+Tag-based KASAN modes are supported only for arm64.
 
 Usage
 -----
@@ -334,7 +335,10 @@ CONFIG_KASAN_VMALLOC
 
 With ``CONFIG_KASAN_VMALLOC``, KASAN can cover vmalloc space at the
 cost of greater memory usage. Currently, this is supported on x86,
-riscv, s390, and powerpc.
+riscv, s390, and 32-bit powerpc.
+
+It is optional, except on 32-bit powerpc kernels with module support,
+where it is required.
 
 This works by hooking into vmalloc and vmap and dynamically
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

