Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D899830D966
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhBCMAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbhBCMAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:00:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A5AC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:00:04 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id s24so4236599pjp.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zyIIbH1s6hkgFOvACSv5XJQgDv/VgHDX59KWA+Xvn8M=;
        b=HdaU2YkxBUv1ZQR72BHZhNkDi9aMeisLhesX6nItVNhnXwXnpSlW8tjDBNGyV9f3OE
         sH6r/X/3vzUef/ZF5pej/AWK61WfBFSyZULpvCKysllaA4ZSobhfIFeKiW10Lma8b5k+
         rnIrhYQM+0aORW7YgvIpqsBbEDSLMKyOkXMuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zyIIbH1s6hkgFOvACSv5XJQgDv/VgHDX59KWA+Xvn8M=;
        b=ATOuODDM6Yg0DCicIXhwnewEoqgtGUS5m/qlpMN7NauwZlEMIoQOyDYABbR12dRgW2
         nqmZIMMpb7q+yu2X58Gm9gNZ9PrY5lfETjcDL3771fmrzBAeXSVaViDDV/6LUtUlOQhg
         8GgbAFTeHIuVsK+5f1TupHVxbxV4mPnoGMef3yPrlds3u2gHATxT3pht7UtA/Aeor7TM
         3FrZm68yJgYucHx1DUHT58txxkIe2cCRr5IhT/WOI32ZNBkN90eETDvICY6/Yc7rIOhR
         G5CYM8JzdAl1wiHSUSMdzgu/NtQdzzFKujWlut99KkJ4YwIbGfn651C138vP2lrq9siC
         8wgw==
X-Gm-Message-State: AOAM530i3d1Ccd85kz9xQhQ3UlrYeWi+p5fbKYIMGElz+9ItUUbuJ84j
        IsjqBSp8YK2Tk8btFFC9dwOyOt7s+qfZmw==
X-Google-Smtp-Source: ABdhPJyjM8vsAjheEdTSAR8cEAxQiCmcXh8BHUMRbBe0TFX01V8qpKG9NVluj//d9mOMzxXjK3QhpA==
X-Received: by 2002:a17:90b:198d:: with SMTP id mv13mr2893257pjb.68.1612353602855;
        Wed, 03 Feb 2021 04:00:02 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-1c59-4eca-f876-fd51.static.ipv6.internode.on.net. [2001:44b8:1113:6700:1c59:4eca:f876:fd51])
        by smtp.gmail.com with ESMTPSA id b65sm2750037pga.54.2021.02.03.04.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:00:02 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v10 2/6] kasan: allow architectures to provide an outline readiness check
Date:   Wed,  3 Feb 2021 22:59:42 +1100
Message-Id: <20210203115946.663273-3-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210203115946.663273-1-dja@axtens.net>
References: <20210203115946.663273-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow architectures to define a kasan_arch_is_ready() hook that bails
out of any function that's about to touch the shadow unless the arch
says that it is ready for the memory to be accessed. This is fairly
uninvasive and should have a negligible performance penalty.

This will only work in outline mode, so an arch must specify
ARCH_DISABLE_KASAN_INLINE if it requires this.

Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Daniel Axtens <dja@axtens.net>

--

I discuss the justfication for this later in the series. Also,
both previous RFCs for ppc64 - by 2 different people - have
needed this trick! See:
 - https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
 - https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
---
 include/linux/kasan.h | 4 ++++
 mm/kasan/common.c     | 4 ++++
 mm/kasan/generic.c    | 3 +++
 mm/kasan/shadow.c     | 4 ++++
 4 files changed, 15 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index bb862d1f0e15..d314c0fa5804 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -23,6 +23,10 @@ struct kunit_kasan_expectation {
 
 #endif
 
+#ifndef kasan_arch_is_ready
+static inline bool kasan_arch_is_ready(void)	{ return true; }
+#endif
+
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 #include <linux/pgtable.h>
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a390fae9d64b..871ceefd723d 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -348,6 +348,10 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
 		return false;
 
+	/* We can't read the shadow byte if the arch isn't ready */
+	if (!kasan_arch_is_ready())
+		return false;
+
 	if (!kasan_byte_accessible(tagged_object)) {
 		kasan_report_invalid_free(tagged_object, ip);
 		return true;
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 2e55e0f82f39..718c171584e3 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -163,6 +163,9 @@ static __always_inline bool check_region_inline(unsigned long addr,
 						size_t size, bool write,
 						unsigned long ret_ip)
 {
+	if (!kasan_arch_is_ready())
+		return true;
+
 	if (unlikely(size == 0))
 		return true;
 
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index de6b3f074742..0aafc2d5138f 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -85,6 +85,10 @@ void kasan_poison(const void *address, size_t size, u8 value)
 	address = kasan_reset_tag(address);
 	size = round_up(size, KASAN_GRANULE_SIZE);
 
+	/* Don't touch the shadow memory if arch isn't ready */
+	if (!kasan_arch_is_ready())
+		return;
+
 	/* Skip KFENCE memory if called explicitly outside of sl*b. */
 	if (is_kfence_address(address))
 		return;
-- 
2.27.0

