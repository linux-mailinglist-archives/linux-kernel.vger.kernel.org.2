Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36E932BFC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580187AbhCCSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376297AbhCCRHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6Xn+u33CPNxO4HFinhCXFka/RB/0sOFe6x8iRrvQEw=;
        b=PQLzXSJPG6R+RTqGFoQnV8m1aY8JmVqg8ukL6EAggiJz8xj0QVldny3bg15PHmRt1sZu+L
        lswbTg4tekLQTcYZWQK/y1FQAHRmaXMdHfiQC0h0iXt5fW8jPY/6sjZMFZh5nHbGTJI6zO
        ZRWtkybvzqOuzMfkJ1yqznCgjpfVsJM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-UzIkIx-DMAeepIXBLLeaOg-1; Wed, 03 Mar 2021 12:06:07 -0500
X-MC-Unique: UzIkIx-DMAeepIXBLLeaOg-1
Received: by mail-wm1-f70.google.com with SMTP id w20so2035385wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6Xn+u33CPNxO4HFinhCXFka/RB/0sOFe6x8iRrvQEw=;
        b=TZh5If5vLvE8Cqsjui57FqpJca218VP3qiIj+05Nz88jDk72bsGBAvZhG34e/DMgoH
         zwzFD8Loq9Nz+WoBAv9t4qar6KfOE5eQwprq0be/aZmUlwzab5zdVGFSFZGAaq0iLmuT
         O7ACHv3yu3f5xVQwglMvvF5IEO/65KqCceJEATsyuktFn4i/aBU6h9YofqfT/3D4ThvB
         KT131afjju0y6vxPWEugkckqiAh9qoKBxuzkZbkkOZQaHM1NPxU7IxNutLowa1/PqEl5
         nRk41uUaqx4bkcjLB7yM7dN/eNUYoBw0P51IiQ9H+LHt+PifLJXwrGRqKEDoqtDOJBgX
         w1/g==
X-Gm-Message-State: AOAM532DPT8j+5xS+N9J0F9bxOY89vCITdztKncmldgXTunLTHtgT6t/
        AcnnwqpZHF9UBmXd1QjF0Sugv+xArLYi7ZMApiv7NsUVulybniNpIoGEL0b9YJa90/Gz91XmCFn
        Db0bgQyIOtIYMKNc23SH8XO/QH1mfikaLGGWGktwV6eo6OTbW2SCsNKxvukF5PjUiHqYikNHqsv
        pa
X-Received: by 2002:adf:ebc9:: with SMTP id v9mr28671238wrn.387.1614791166248;
        Wed, 03 Mar 2021 09:06:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpZBXzvFoGUuSttyR1nFY9YigBcVkN3UpeHTBedmmsMa9WDXR2BdsJ4M3u3ibeINwYxZYl7Q==
X-Received: by 2002:adf:ebc9:: with SMTP id v9mr28671202wrn.387.1614791165608;
        Wed, 03 Mar 2021 09:06:05 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id d29sm32957827wra.51.2021.03.03.09.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:06:05 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 6/8] arm64: insn: Add barrier encodings
Date:   Wed,  3 Mar 2021 18:05:34 +0100
Message-Id: <20210303170536.1838032-7-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170536.1838032-1-jthierry@redhat.com>
References: <20210303170536.1838032-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create necessary functions to encode/decode aarch64 barrier
instructions.

DSB needs special case handling as it has multiple encodings.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/insn.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index b55b629c5eab..185f52ef0228 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -370,6 +370,14 @@ __AARCH64_INSN_FUNCS(eret_auth,	0xFFFFFBFF, 0xD69F0BFF)
 __AARCH64_INSN_FUNCS(mrs,	0xFFF00000, 0xD5300000)
 __AARCH64_INSN_FUNCS(msr_imm,	0xFFF8F01F, 0xD500401F)
 __AARCH64_INSN_FUNCS(msr_reg,	0xFFF00000, 0xD5100000)
+__AARCH64_INSN_FUNCS(dmb,	0xFFFFF0FF, 0xD50330BF)
+__AARCH64_INSN_FUNCS(dsb_base,	0xFFFFF0FF, 0xD503309F)
+__AARCH64_INSN_FUNCS(dsb_nxs,	0xFFFFF3FF, 0xD503323F)
+__AARCH64_INSN_FUNCS(isb,	0xFFFFF0FF, 0xD50330DF)
+__AARCH64_INSN_FUNCS(sb,	0xFFFFFFFF, 0xD50330FF)
+__AARCH64_INSN_FUNCS(clrex,	0xFFFFF0FF, 0xD503305F)
+__AARCH64_INSN_FUNCS(ssbb,	0xFFFFFFFF, 0xD503309F)
+__AARCH64_INSN_FUNCS(pssbb,	0xFFFFFFFF, 0xD503349F)
 
 #undef	__AARCH64_INSN_FUNCS
 
@@ -381,6 +389,20 @@ static inline bool aarch64_insn_is_adr_adrp(u32 insn)
 	return aarch64_insn_is_adr(insn) || aarch64_insn_is_adrp(insn);
 }
 
+static inline bool aarch64_insn_is_dsb(u32 insn)
+{
+	return (aarch64_insn_is_dsb_base(insn) && (insn & 0xb00)) ||
+		aarch64_insn_is_dsb_nxs(insn);
+}
+
+static inline bool aarch64_insn_is_barrier(u32 insn)
+{
+	return aarch64_insn_is_dmb(insn) || aarch64_insn_is_dsb(insn) ||
+	       aarch64_insn_is_isb(insn) || aarch64_insn_is_sb(insn) ||
+	       aarch64_insn_is_clrex(insn) || aarch64_insn_is_ssbb(insn) ||
+	       aarch64_insn_is_pssbb(insn);
+}
+
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 bool aarch64_insn_uses_literal(u32 insn);
 bool aarch64_insn_is_branch(u32 insn);
-- 
2.25.4

