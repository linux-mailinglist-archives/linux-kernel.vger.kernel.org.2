Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9803D3DA42D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbhG2N2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbhG2N2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:47 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA88C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:42 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id q188-20020a1ca7c50000b0290241f054d92aso818795wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sBorrifANrV+vpyuatLE9LgyQ9DNiLt3tvLMqd3Pt6A=;
        b=Ut7XM1RBkTI6hICybPUi8KmJxYV9LDmJ+BO6n904mN06Lz6fMB/V/BtKm6hhsuLfZP
         ivNztgGio4ESMLW5q3gVJgBLVveqCae0u3Cf+OKFjx6mnhwTYrhUTBdFbeTTJYOH2Oro
         egeF+yk4HTHuh6YDWWxQ/DlmPg6CLxqWIwkzudNjJzvZNRClSc0OkY+jbq0xqXUU/AJb
         ej+MxueBK07NIyaNgEDhpAQ0F2nwLtPwY0F0IGWM8mD7iwJf9+lNClSNk/EMPe/lAOyx
         FXnhesCTlFKoKTNCnkpafZ7MinyOF/hCThP8HikLHozvU5iFs+Dhw8yEZKqnOzO+cPPS
         ViCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sBorrifANrV+vpyuatLE9LgyQ9DNiLt3tvLMqd3Pt6A=;
        b=VF9cR2vX5XSPlq+/OkRUjVyiCpQFh9tbxmletmgOz2TC7RCzKEJ/FKDPAXdtLf4Tjj
         aaoxwXpqTj1cS6GkeS3frp7xYFIqePD4DkEAj0vYCbrwUMokSbgeQI1AGH49cphsOpQc
         NMvmScg/tN1EAuQnjA4l4cOuJ80WDTT8Ttlj3QoHgoEShADSUtdcQMqEnz773t9lXQJU
         7PuDhZqlFbyjcFMFjBbNc3+xdG4v+LUTShsZWfJLebuyPzwYxh8WqVK7korW/Ny+Tw7j
         7aS0InIsVub4/AzHaN4Q6zPS3ViYlgjwf1/eg8Jh2By/6i9hLYnGBjnYWFj/Aa4t5QLS
         EQ7A==
X-Gm-Message-State: AOAM531lJFkYU74WQ6o/FJA39qYcIUjxgHjDMz02t1JpnVNbO5zaC7wI
        ozZT04tnmrHMmMrIShQdP17E4YdK7TY5
X-Google-Smtp-Source: ABdhPJwtD68LvsEqvJLyJ+xAUhNDPqjLqDqVmLSO3BaeBLQNVsxniunIN5iAoYlgcySpAt9xikvTGJBkyHkY
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a1c:980e:: with SMTP id
 a14mr4764799wme.123.1627565321434; Thu, 29 Jul 2021 06:28:41 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:05 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-9-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 08/21] KVM: arm64: Don't overwrite software bits with owner id
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon start annotating page-tables with new flags to track shared
pages and such, and we will do so in valid mappings using software bits
in the PTEs, as provided by the architecture. However, it is possible
that we will need to use those flags to annotate invalid mappings as
well in the future, similar to what we do to track page ownership in the
host stage-2.

In order to facilitate the annotation of invalid mappings with such
flags, it would be preferable to re-use the same bits as for valid
mappings (bits [58-55]), but these are currently used for ownership
encoding. Since we have plenty of bits left to use in invalid
mappings, move the ownership bits further down the PTE to avoid the
conflict.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 59a394d82de3..1ee1168ac32d 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -46,7 +46,7 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
-#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 56)
+#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(9, 2)
 #define KVM_MAX_OWNER_ID		1
 
 struct kvm_pgtable_walk_data {
-- 
2.32.0.432.gabb21c7263-goog

