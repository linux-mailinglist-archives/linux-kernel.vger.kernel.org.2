Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE133D5693
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhGZItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhGZIs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:48:56 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D92C061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:25 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 7-20020a0562140d47b02902d89f797d08so7761332qvr.17
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xhqFHmC/x7AnH8ZRcl4l1dWbyNuPeqmFIi1qz6ztr7w=;
        b=ky9L1rdM2E3/pnvC1byWpnnDrketwgcUM2bCx8+9oPsj/Yt617M9WBkhR3Ympi/l4L
         VTeD1nruEtGe4LWOp3GLcU+7LstB63zkiS4nWY8QanDvEdLTpsDsMTSnXOla07D8Y4LE
         CKd5U8AUGdUjttxk0FKMZofS9v9BiNVjLm3R2YTEuFvxA2hECbp42flWzlsfaVnzYCaW
         ff1fKfwwzoN8osSFvI3OV/+2ArYR9Z0WC5vtT3Q8fMLNmb0YI3GsjsikhLyr2K4YGhdV
         OtFyNK5p9iKQ8eOXfzV9kQ58g82+/f5r/bb15bcMbUTlfDrVHghBIyXO41eZuDmkB84i
         dKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xhqFHmC/x7AnH8ZRcl4l1dWbyNuPeqmFIi1qz6ztr7w=;
        b=ccn1yi8DQE6LSdsMmQ473c8wGkiGTbkK0dQwhjzHTguuXBqvBfrJg2q1XAWMQZ6DWU
         ru6lwaZK6s1x5AADt5RTQ8epIRhNtCKp/7/cSOhUI2sY91N3x8sQm4n142d9Xzr5RqO6
         4hjrSAmZT/7o3xNMUVXqwTy4IojEwg7qPlVTSIjQ/YDDOd0mntISJGanFX9XcWTeHmam
         ofwH91WqQsufphnDWbJwehibQKQoYUqM9KvSzfBzVlC1D9ajDe/ISpxbAdMxHVvDV3UP
         viReE6xzZkP0cShYLtgLcsS6HDbWdaU7snQjB5MHZTTqw9wUtiik6CrQzsOL31YgOKhq
         oXwA==
X-Gm-Message-State: AOAM5323CKt6RIxti8lh5sBXcThdhocjzI/kxoVqnDej4CeNyQ23o9Zq
        2ezqi7d+AaB1XH5VLhK0SlOLzUUVmO1W
X-Google-Smtp-Source: ABdhPJw4miv6yKMoP660KkuAQKoQs6QJrbWUOze6sSCFx/jyqDsnRSbtfSCLwuMOdKieMRJBqFuxCCiKdHzU
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a0c:fbd1:: with SMTP id
 n17mr17016888qvp.19.1627291764500; Mon, 26 Jul 2021 02:29:24 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:28:55 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-7-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 06/16] KVM: arm64: Don't overwrite software bits with owner id
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
index 516c1b8ce6b8..b5ca21b44b6a 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -49,7 +49,7 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
-#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 56)
+#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(9, 2)
 #define KVM_MAX_OWNER_ID		1
 
 struct kvm_pgtable_walk_data {
-- 
2.32.0.432.gabb21c7263-goog

