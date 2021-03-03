Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC89A32BFCF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580238AbhCCSdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376369AbhCCRHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZOme96OqfHDGW4Rd2dxm5kzYLLlb1jU0OpF+Zj1BLY=;
        b=OmdW33hwe/Byjx/p/7euvQD0jeLBhL8+7IpAgXgZfMz6vUX9cFYKiEnXy6g8lssY2ZcNUQ
        GWBb+m3PTEl7VywIm+xPhMPlD7P0ze7jtDDBj02mJOEjelGICZQmORT6JtIjp0tRH4lauv
        mdEEeukXyzCJgCU4KnYnfzbyELt2UbY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-md42UjxlNIKVAdyWJ6C5lw-1; Wed, 03 Mar 2021 12:06:11 -0500
X-MC-Unique: md42UjxlNIKVAdyWJ6C5lw-1
Received: by mail-wr1-f70.google.com with SMTP id p15so12875169wre.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ZOme96OqfHDGW4Rd2dxm5kzYLLlb1jU0OpF+Zj1BLY=;
        b=CychiT1nvwbQD4gM44qKfKFd0+hkoe9GADDQIiqnPSzy3X1C08qGNhivukL5fmJ1FA
         vv02r4tYceKS4aMakRMbePHPgYromlJOd3UUU6U/NvOF7XrEzJZGTy35D3JbJBgcDt4e
         PbmhBT2MZslA+V3ADhgRfKHNyKWaAbQv0JdVy9JatINLPDs/HHv3aC5l5JE4ZKFOt2GS
         KHAoJ+Fj7gshauxYAxuuofr07GsH+Cr/FF9E+WeOS3ma+4eGkDUfyM1/eBGPhG5Tj4tg
         tjvmR5CAdusXI8dg1V+/Vn1Hnf5tYyHJkQXBI3eyOmiTqpwZB0XAxTZDKvlZ7X3NmtQ4
         pwMA==
X-Gm-Message-State: AOAM533Q9sNA8Qan86Mo7GNkeQbSHVg81t/xv9gsjDYUKg+c1vaWH+8v
        SReeNueHOYAuuZtl4eiEpbO53ESqBeiTpct8Y/esjpIjMEto2b+S8QaJoYbc823KuqARXJqu4TS
        ohup9ATc3/7ovIN73oWifomK1surQjr9BPctvAax32Gnc+fqA264BePNpLvXY0mTqvS10oiHp+N
        /5
X-Received: by 2002:a5d:4d09:: with SMTP id z9mr27544905wrt.426.1614791170024;
        Wed, 03 Mar 2021 09:06:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxskyOrQHsycuKN7L4vDRKVmFDW3FGA9b5LTWtx2cz/oHzRiG9JoZ1yHI1kcOZ3L1fAYVISgw==
X-Received: by 2002:a5d:4d09:: with SMTP id z9mr27544882wrt.426.1614791169682;
        Wed, 03 Mar 2021 09:06:09 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id d29sm32957827wra.51.2021.03.03.09.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:06:09 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 8/8] arm64: insn: Add load/store decoding helpers
Date:   Wed,  3 Mar 2021 18:05:36 +0100
Message-Id: <20210303170536.1838032-9-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170536.1838032-1-jthierry@redhat.com>
References: <20210303170536.1838032-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide some function to group different load/store instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/insn.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 388aa22eacb1..71de52d1532f 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -412,6 +412,34 @@ static inline bool aarch64_insn_is_barrier(u32 insn)
 	       aarch64_insn_is_pssbb(insn);
 }
 
+static inline bool aarch64_insn_is_store_single(u32 insn)
+{
+	return aarch64_insn_is_store_imm(insn) ||
+	       aarch64_insn_is_store_pre(insn) ||
+	       aarch64_insn_is_store_post(insn);
+}
+
+static inline bool aarch64_insn_is_store_pair(u32 insn)
+{
+	return aarch64_insn_is_stp(insn) ||
+	       aarch64_insn_is_stp_pre(insn) ||
+	       aarch64_insn_is_stp_post(insn);
+}
+
+static inline bool aarch64_insn_is_load_single(u32 insn)
+{
+	return aarch64_insn_is_load_imm(insn) ||
+	       aarch64_insn_is_load_pre(insn) ||
+	       aarch64_insn_is_load_post(insn);
+}
+
+static inline bool aarch64_insn_is_load_pair(u32 insn)
+{
+	return aarch64_insn_is_ldp(insn) ||
+	       aarch64_insn_is_ldp_pre(insn) ||
+	       aarch64_insn_is_ldp_post(insn);
+}
+
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 bool aarch64_insn_uses_literal(u32 insn);
 bool aarch64_insn_is_branch(u32 insn);
-- 
2.25.4

