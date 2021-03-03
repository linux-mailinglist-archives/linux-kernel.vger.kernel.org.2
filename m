Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CCF32B72E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383119AbhCCKuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbhCCAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:24:01 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25914C0617AB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:35 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id q85so22341709qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2ZHo6bqqoFQHDt1XsnxWzUIHllyauSrjIJToDTBiZLY=;
        b=HFHYvchu6CpdqexxuDSsNYf6zc2J6VEKWIBzKSjPVt7Oj5tn2/oRKB1PtdVtAhgBcu
         8QtnWiz/7P8/LqX5wFb1aqUQju3puj7mBA1eY2moIHPzNRpZr6tHqSrfP6M19tFtCndA
         Dw7uvs/8X/wLRsL+Y2oTYcwh4VUTm1gb0QoWI27HLxniuFGEj0KhR+xLWCeoEvbTnu+7
         iDZO6hGQaznymI4Z7Kti3JjhODZC9KYEwl0lPssNr6T7Q8YrqF4+AmY67n+7+DzGelJs
         WYrCxrVf4ENesVrOPXLzb1mOiHh9nKU3H9yCHxRR06iUcT7IO02sj3oVqitQee/e+0NO
         HyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZHo6bqqoFQHDt1XsnxWzUIHllyauSrjIJToDTBiZLY=;
        b=FRhYCD4xoqPfZSax+vNHBZOgHh/wwXjyaK1GpovHEduXRB2C6Zc9WDw1H/tVuNZ3m/
         6jxAXY5AztG4PGaqY5St+TOgJa/6Cns2vj0IEzsHh4EuGDAPmuIPGaeD4LH8o/0yV0mD
         S5b1cFqWdCqU/NSer9TefH2waHzx3gjjtQvjz16pJJaSfu4ol4xbEzPhsR8EuB0FBcNf
         1cvUryuo/A5WeS+ZpysV3AWHJpyaHBPkIxrbypaES1wUClNno6G2PdIaUcGDyCz+4fYK
         DmegCzRzvUUKpJSJpB758jSBkMh0M0zvSmhCRzO6uv/HD3cMQ26bTVsoCr+QRqRQUfsz
         M3Jg==
X-Gm-Message-State: AOAM533qha2fHmqTYuA+4ekiYL6TkWPP16st03tfgVT4JmWz5D3PMPoh
        8vaImtL56IkQw//B8O2tbTL2Dw==
X-Google-Smtp-Source: ABdhPJwsTtNwrwyfksF0JxhDL724PEtC95EO+MO9/7fXbkyN8TnG2jdsy9RcmwXwPeG1L2V0hRnmfQ==
X-Received: by 2002:a37:4743:: with SMTP id u64mr16003296qka.350.1614730954363;
        Tue, 02 Mar 2021 16:22:34 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:34 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v12 01/17] arm64: hyp-stub: Check the size of the HYP stub's vectors
Date:   Tue,  2 Mar 2021 19:22:14 -0500
Message-Id: <20210303002230.1083176-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
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

