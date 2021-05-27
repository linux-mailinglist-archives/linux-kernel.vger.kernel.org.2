Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A111A3931BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhE0PH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbhE0PHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:08 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD14AC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:31 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j184so929883qkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ghqRky3xeZiHl8S3DiRVTP9pM6BiSKFavllixIkkvd0=;
        b=caUhVx3J/tqp+Gal3Xi+7VBVenbj1bAKADWn8txk9KZ20D6QNDbgDjYASPogchOfyj
         MnR9GvDeTVlU/w7h0MDxRGxJcSxJKoV0mjkK+QdLIg1QR5LED8krF6MVh4Dw7m3PScI9
         DH5d0pWUvzXOFaty1vK3wY3s2CaSoIxaYfFpwPApeJBhcfwIAViezHl4cLnrFbUJWTEz
         CxttZKvFn/yQ47HYBvaRhH+Top3dM3Aos+zj8m2STtvk8DprhmBAFJxZS0AcEiFO3Kb7
         DrdN7vRSm71g5/nEb3VcE95apeL0RMCTNaPwasAdOu10HhJ2vq1M/c/C1Yn8L1NpF7Rq
         MkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghqRky3xeZiHl8S3DiRVTP9pM6BiSKFavllixIkkvd0=;
        b=PIz79x1p7scVBrAN+ncd3SCEo7A86I9iCei2v/yrfv+gMziDD767L0eXbkwjgV4rIe
         fL+6zMTU0zrBa0byFwltHTbt8XC12s7v5vEMqROcJAXMJl3ZbT/Cxu5NQKxNX0PQtWXl
         gmPKIWxE574zi3ZT8iAHl+RmXYVMJKBAfLMkSlnVM1uiF8f5DxCIMuOmgRjEHfkw0Zua
         RNYl0QCAZv11hPwKfJ6StuAkS81VCYAsrxRRMTVML0bwHRW8O63FkepV0uqiYt8/W07r
         wLiEJhi/ORhHpGqAM7vCFvBkCcUUUezEbXMliYA5zRzpKLqWeioop/n8rBSnQNQq6Z7r
         mzhg==
X-Gm-Message-State: AOAM530PT49NxFHSD9lHOnHHnwy8+lmuQylbQ6FTcb8XI1IYTNvyiSGD
        7ZCdWSBwwPxgWOH44e/Ht5uBUg==
X-Google-Smtp-Source: ABdhPJzkqRktvQM1YvTQKwrzQq+gZ576cPkKRhONnmbg0z/uIwTpNvyWkip4RNp35WexktltcbHpqw==
X-Received: by 2002:a37:c15:: with SMTP id 21mr3945299qkm.180.1622127930853;
        Thu, 27 May 2021 08:05:30 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:30 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: [PATCH 01/18] arm64: hyp-stub: Check the size of the HYP stub's vectors
Date:   Thu, 27 May 2021 11:05:09 -0400
Message-Id: <20210527150526.271941-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

Hibernate contains a set of temporary EL2 vectors used to 'park'
EL2 somewhere safe while all the memory is thrown in the air.
Making kexec do its relocations with the MMU on means they have to
be done at EL1, so EL2 has to be parked. This means yet another
set of vectors.

All these things do is HVC_SET_VECTORS and HVC_SOFT_RESTART, both
of which are implemented by the hyp-stub. Lets copy it instead
of re-inventing it.

To do this the hyp-stub's entrails need to be packed neatly inside
its 2K vectors.

Start by moving the final 2K alignment inside the end marker, and
add a build check that we didn't overflow 2K.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hyp-stub.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 43d212618834..91aab4121463 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -41,9 +41,13 @@ SYM_CODE_START(__hyp_stub_vectors)
 	ventry	el1_irq_invalid			// IRQ 32-bit EL1
 	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
 	ventry	el1_error_invalid		// Error 32-bit EL1
+	.align 11
+SYM_INNER_LABEL(__hyp_stub_vectors_end, SYM_L_LOCAL)
 SYM_CODE_END(__hyp_stub_vectors)
 
-	.align 11
+# Check the __hyp_stub_vectors didn't overflow
+.org . - (__hyp_stub_vectors_end - __hyp_stub_vectors) + SZ_2K
+
 
 SYM_CODE_START_LOCAL(elx_sync)
 	cmp	x0, #HVC_SET_VECTORS
-- 
2.25.1

