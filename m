Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA76357B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhDHEFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhDHEFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:05:52 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B1C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o5so997472qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2ZHo6bqqoFQHDt1XsnxWzUIHllyauSrjIJToDTBiZLY=;
        b=X9eAU/eM3040QGUYmUbw7fYBZz3JtF3avBuvT24i1+XpVGvbIi9BNTH2rSlvhxMZ6p
         vB7bmo+61os1iTwbbNQRR69s0xibH9y2Zh+JxqbT2cEzOMZyXY4XleOC3VU2OQbelf4e
         qUx64StBUbF+O1txg2vRkmFpmHWn5MioQBG/fANNQ2YzUxTJC8uDaJ4j6/ABFGO80TmL
         lT7jf5YqjgaPI2Fa4vi35ToQnOb1K/7GhDLWSoB81CHHWcprY9EhPAQcUKCUF69eeTrQ
         5rcxFBkWQYTv7dEA+PHoUkVJSA2Bu07e+E9jh6dpYWIsqXcT3kY8zV4f1HpZcTG33b+V
         3i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZHo6bqqoFQHDt1XsnxWzUIHllyauSrjIJToDTBiZLY=;
        b=ejZc7oSXqAT0tI8nd2jXVxdnlncCee2flcx7FjMIMKJBkpqbx59A5jCBzBswTLYZQW
         3IRe7D6OKX4tXvR3MJhjNu7DJhHW0M8j7tA6zCvr0DA9ZQvewX5oyFN20Bp7qsh41mel
         tLHbXB/HdEiFtBlf8J53v8mD0hAVbmInbmwCPAqs1sbkHyBdKWBfKWloRwoXkF+1B2Ww
         zQuRRay58XJrdcTq3Qw/sZoTTheVnUd0jEEBgNUUyysBcWW7YfZE1P5ZY+sXOJ0fhvYE
         wuz4zvib5W5swSvs1RWgbIwiEEw7fJ7PHjSUW6+7c0H4M9a0sX/rPVK/cNGPHqHI+12X
         QPgA==
X-Gm-Message-State: AOAM530y6d+l+lwoAxgh+k/ElKPuat4TCY9ReDFHUhHXF7rOMp9/cU4a
        H2L3URxlFMNam6MpS1gSEosoaw==
X-Google-Smtp-Source: ABdhPJxYXvk2FxZ0FX2jOzjDLvti4P2RgEhIeGGR2Vwo3ThVtxJOO1wAhCh/APii2j5zwyiwpg/lrg==
X-Received: by 2002:a37:78b:: with SMTP id 133mr6607278qkh.109.1617854740543;
        Wed, 07 Apr 2021 21:05:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:39 -0700 (PDT)
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
        kernelfans@gmail.com
Subject: [PATCH v13 01/18] arm64: hyp-stub: Check the size of the HYP stub's vectors
Date:   Thu,  8 Apr 2021 00:05:20 -0400
Message-Id: <20210408040537.2703241-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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
index 5eccbd62fec8..572b28646005 100644
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
 
 SYM_CODE_START_LOCAL(el1_sync)
 	cmp	x0, #HVC_SET_VECTORS
-- 
2.25.1

