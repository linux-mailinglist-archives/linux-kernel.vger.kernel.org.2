Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9532BFC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580140AbhCCSdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352452AbhCCRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PNFPZrFga1zLopoBvYwVrfUOQSaR7zQE1lJT2SHv4Qk=;
        b=flCqHCsQuhDvx1J2aac0hZbsrLOrP39teVu1vNCVOic1KHQZyp6UBJJYqmZaR2jMellyZB
        jSI6buvwxM1NXT50wlsyS6bWxIINUBILeQMOVwKRBvVliw6SMpO0laj7DM9C/jjYojGpQZ
        vglnnAmvdZC1rqgfnZCHd3EBHgGwW4Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-ktDCNPZWPFWsyciDpQrmXw-1; Wed, 03 Mar 2021 12:06:05 -0500
X-MC-Unique: ktDCNPZWPFWsyciDpQrmXw-1
Received: by mail-wm1-f72.google.com with SMTP id 73so3234197wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNFPZrFga1zLopoBvYwVrfUOQSaR7zQE1lJT2SHv4Qk=;
        b=see2WReBursGXptb0iptIN3eaOVRvvolVqLD9P4JkHUUdBeQTp7sVAkj8ThvJpdqFA
         cyPv7dx/WXWVEJkdtEGI1AxS5EDr20GJQrjJorSJCuNMMJm5nvJZ3RhHJ3tsBProwp2r
         x0eegAbzIs5zGKTfG5Y7cqkapjxJCaPO4bie0UQJTq2OA7YQFA7jF3zvbINKPAxQr+xs
         UVmXbMH7PSqwjW9L+nvnNsZoY9FoQrzan3NA8T5qrN+z8Fe2ltnfWfOejP18ZNc5peg8
         XWRDjvMWKycCUgMQYm9Mkkc/Rh31/rdR6HOIqirWtG+Tlk/JPvdl7Ye2rDu3/5wy8WdW
         VtoA==
X-Gm-Message-State: AOAM530D8w7+Rhc8Jk61FfybwEx+J/6mcuGfanUD/3cofIRzOU5YwKVi
        ZG/tOjCQdZW6CPHY7C1NzxD7AA1M7dfzjZRiV2hPvxl1sWZpsmK8E4wlmSK2Vx8ruh+ItVKM4Az
        X8GtaGioTlOOfjXJszFpAZ21ZWKVF8Kvk6Ect7GCGLttvTOmQIOmsz552NGlExMe8u2qR7ABpsG
        0d
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr27859277wra.47.1614791163821;
        Wed, 03 Mar 2021 09:06:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxD0v/fzNgqSwNk35vvYY+wNzFbFYn93XkQS+sDe+djtqgvt9cBoTJiWb04+lSf82I9ql7osQ==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr27859256wra.47.1614791163583;
        Wed, 03 Mar 2021 09:06:03 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id d29sm32957827wra.51.2021.03.03.09.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:06:03 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 5/8] arm64: insn: Add SVE instruction class
Date:   Wed,  3 Mar 2021 18:05:33 +0100
Message-Id: <20210303170536.1838032-6-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170536.1838032-1-jthierry@redhat.com>
References: <20210303170536.1838032-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SVE has been public for some time now. Let the decoder acknowledge
its existence.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/insn.h | 1 +
 arch/arm64/lib/insn.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index ffcdeac80026..b55b629c5eab 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -31,6 +31,7 @@
  */
 enum aarch64_insn_encoding_class {
 	AARCH64_INSN_CLS_UNKNOWN,	/* UNALLOCATED */
+	AARCH64_INSN_CLS_SVE,		/* SVE instructions */
 	AARCH64_INSN_CLS_DP_IMM,	/* Data processing - immediate */
 	AARCH64_INSN_CLS_DP_REG,	/* Data processing - register */
 	AARCH64_INSN_CLS_DP_FPSIMD,	/* Data processing - SIMD and FP */
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 6ff8826ae7ea..b506a4b1e38c 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -23,7 +23,7 @@
 static const int aarch64_insn_encoding_class[] = {
 	AARCH64_INSN_CLS_UNKNOWN,
 	AARCH64_INSN_CLS_UNKNOWN,
-	AARCH64_INSN_CLS_UNKNOWN,
+	AARCH64_INSN_CLS_SVE,
 	AARCH64_INSN_CLS_UNKNOWN,
 	AARCH64_INSN_CLS_LDST,
 	AARCH64_INSN_CLS_DP_REG,
-- 
2.25.4

