Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE69343D098
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbhJ0SXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbhJ0SXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:23:38 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF6DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:21:12 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w10so3909495ilc.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNt5WP+KLlCz27tkIeCv/ilMnRF9ldGBWmcU2dkmMZU=;
        b=JzvSfbM/K7q0ZrKY3oW2DsWle0xLudyGmkxFHp/MTya8I9K5l55Jlky7CgrhDah2Vq
         VAZ142rlIQX85Xx+eUxPt0SDjdniaSAf13+a+hNyD8wAwNIt4No0/SRYDrOX5WhLTAVi
         6NvxuJbVTZcflJeM6nWXJnP6Uty7osthu3/+Ftf7+seRjiJCjsaKEc47s6WK/koHU01T
         fFZ2sQGHQ0qurjz4dT1yRqr5JCsvMn3QSr6E8wWB/hUyV/Om9w/fiwgsXp3Lpmns/FAf
         1OowdW8M2ybdVpo9GPpKEMqZtJYoxvRL9M37+OXbuTgh+OQB9ovG6JCcTvOfHgxu6DDl
         3/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNt5WP+KLlCz27tkIeCv/ilMnRF9ldGBWmcU2dkmMZU=;
        b=UK8IztuTvChagmGlfPJM1tcEgQ+xKYRjEN4ochKgIaAUIdo3WULilbckHZoivp5QZi
         FrrQzIU6AtgeorGylhrWz7xKfGNU/nrStluJrLFmzzjXhh+Ow+D/w6fzynzJCiuuIoIV
         He52XV4OFqC/efaNRSUQXTl6NcWxaoETlU5mP94Csz/8213fAM3aYhQbMdWXF2O9e/OQ
         dlD0p1lygUtFW/S6rjikqFe2vYXh+rUzILs2kElT849oC4EM2QpqK6C0chHJhIdmFvfz
         i3GsxMQKYICVMI4jZsyBVF3D3USkeLH9iT/05bsu+vryMt8lelXdsAu4HEXsrOUob4DI
         KIUA==
X-Gm-Message-State: AOAM531FLosVqndag8OM0hKLBeioYepk5jo3eKda+qQMf1kJaQZKePxy
        xAp22Cs37Ag0tdazHpZjnIc=
X-Google-Smtp-Source: ABdhPJybEzvgk9mFFq5J8AwV9xJpNGWtsziPt7WnEUD08s0X63sA74ODVcrn3y0vGY3SfjIyWIA3kw==
X-Received: by 2002:a05:6e02:1e0a:: with SMTP id g10mr129021ila.50.1635358872137;
        Wed, 27 Oct 2021 11:21:12 -0700 (PDT)
Received: from localhost.localdomain ([2600:1008:b008:ef4c:8cf4:62d8:2368:a681])
        by smtp.googlemail.com with ESMTPSA id l13sm362050ilh.14.2021.10.27.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:21:11 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] x86/xstate: Make AVX512 status tracking more accurate
Date:   Wed, 27 Oct 2021 13:21:03 -0500
Message-Id: <20211027182103.2569136-2-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027182103.2569136-1-goldstein.w.n@gmail.com>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211027182103.2569136-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the mask for tracking AVX512 usage to not include the opmask
xfeature set.

The purpose of tracking the AVX512 status is to convey information
about possible frequency throttling. Opmask usage does not cause
frequency throttling so it is a completely unnecessary false positive.

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
 arch/x86/include/asm/fpu/types.h | 4 ++++
 arch/x86/kernel/fpu/xstate.c     | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index f5a38a5f3ae1..e9a48f75159e 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -142,6 +142,10 @@ enum xfeature {
 					 | XFEATURE_MASK_ZMM_Hi256 \
 					 | XFEATURE_MASK_Hi16_ZMM)
 
+#define XFEATURE_MASK_AVX512_THROTTLE		(XFEATURE_MASK_ZMM_Hi256 \
+					 | XFEATURE_MASK_Hi16_ZMM)
+
+
 #define FIRST_EXTENDED_XFEATURE	XFEATURE_YMM
 
 struct reg_128_bit {
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 00b495914be2..e129fae48792 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1254,7 +1254,7 @@ void fpu_update_avx_timestamp(struct fpu *fpu)
 	 * AVX512 state is tracked here because its use is known to slow
 	 * the max clock speed of the core.
 	 */
-	if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+	if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512_THROTTLE)
 		fpu->avx512_timestamp = jiffies;
 }
 
-- 
2.25.1

