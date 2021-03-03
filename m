Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C30032BFC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580164AbhCCSd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376274AbhCCRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YzYqShpHo6c5w25CI9lpA3dmAurPMURmMoKrMzpauQQ=;
        b=SJQfO2bsyjAKzA30I/6lI8vCpmAN4keELgU/osqETG1/jY3u4K6C9Gc7EFx6YcoKVezMnP
        0lnuhG2a2A0hNac1XBH94c7GGXJRKBx0WcoHNVhQi38JgzqpVrWMaEuLA3IctqtCQaqQXR
        9ISMFUYYRGjzxGBjuAzSOEIQ6wGWG2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-_IcM3jNRNZeXVfup3UZCNg-1; Wed, 03 Mar 2021 12:06:05 -0500
X-MC-Unique: _IcM3jNRNZeXVfup3UZCNg-1
Received: by mail-wm1-f70.google.com with SMTP id q24so3277152wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YzYqShpHo6c5w25CI9lpA3dmAurPMURmMoKrMzpauQQ=;
        b=I7PfWZ96dukVuyz7/nt3VK3LGEZgdyRzIY2KxkIeDxKuySEN28qDJ5/1qQS+PhSsz7
         9vKjG8pbwHepKAkfjtDn2DZz3jKUF0oRpaG2jdOXVZy2NEH2l0QqMogNcgHrVJT0elyD
         MbE8bdTOTdtWk9vN6jc2VRM0nwmmV56a5jmfCBqjlkKC3UzIuNmDnEcK2b6Y2GHrvjr+
         Fiho+tuvL096HF3jnxA1t7xHwAdyYAURmf90XiWreNQBGPj8ojS9Fw6EqawmBKl6/lzX
         SL7gPBgiTTcVYdEvzpb9YAps0miZ1PqjaNojZF86UzSnDmGlTuJnquzofjUMPtXqnaoj
         0D9Q==
X-Gm-Message-State: AOAM530jNRXrAolHRBPqVQfXRgHA3+k9ff+XnzwVZkffSWL6sFMswd5X
        8a4U4fqbQbA9Ru76PZSqQyRdfV8X4uMS4KTTlOlX2VSuQHQ80fLCycODmTn/kPt+UWkjM0B9Gha
        DJzirP+SmC2ZlZFXQWvoRE/NrDNAsoUomWoO1m+X4F0X1Nvdl04fSc/lYYEGTqrUYQnUQN3EcwC
        ek
X-Received: by 2002:a1c:1d82:: with SMTP id d124mr13795wmd.1.1614791158765;
        Wed, 03 Mar 2021 09:05:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/w4VEMRsiBT75nmEd1w/T3n9ICG9GjGPK8ANFaXpMFx0mRKUTD31eTCQcfxUG5OuVGBVtuA==
X-Received: by 2002:a1c:1d82:: with SMTP id d124mr13175wmd.1.1614791147050;
        Wed, 03 Mar 2021 09:05:47 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id d29sm32957827wra.51.2021.03.03.09.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:05:46 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 3/8] arm64: insn: Reduce header dependencies of instruction decoder
Date:   Wed,  3 Mar 2021 18:05:31 +0100
Message-Id: <20210303170536.1838032-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170536.1838032-1-jthierry@redhat.com>
References: <20210303170536.1838032-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The instruction encoder/decoder depends on alternative headers only
for single macro definitions that could be part of the instruction
decoder.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/alternative-macros.h | 3 ---
 arch/arm64/include/asm/insn.h               | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/alternative-macros.h b/arch/arm64/include/asm/alternative-macros.h
index 5df500dcc627..c01edf4d988d 100644
--- a/arch/arm64/include/asm/alternative-macros.h
+++ b/arch/arm64/include/asm/alternative-macros.h
@@ -6,9 +6,6 @@
 
 #define ARM64_CB_PATCH ARM64_NCAPS
 
-/* A64 instructions are always 32 bits. */
-#define	AARCH64_INSN_SIZE		4
-
 #ifndef __ASSEMBLY__
 
 #include <linux/stringify.h>
diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 14aa2f3aebfe..ffcdeac80026 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -10,7 +10,8 @@
 #include <linux/build_bug.h>
 #include <linux/types.h>
 
-#include <asm/alternative.h>
+/* A64 instructions are always 32 bits. */
+#define AARCH64_INSN_SIZE	4
 
 #ifndef __ASSEMBLY__
 /*
-- 
2.25.4

