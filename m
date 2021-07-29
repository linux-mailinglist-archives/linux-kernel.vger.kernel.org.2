Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBA93DA42B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbhG2N2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbhG2N2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:43 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D59AC06179B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:40 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id y19-20020a0564021713b02903bbfec89ebcso2917217edu.16
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rFkRNcfpvB1Ju4IVqteFXhSiHej5m8ER5DA8p5t0LAM=;
        b=adgE5oH5ZzQyJ5my+MCD24NaPHWhLe66wtzcPFxdI/5uGtUKivh3E2sLcxhhUi1oUH
         kO7wflN08UcEigT8OK5o3G9pnCptziZAF+CPeYXNsUPhGWRx9thRs8VvjUsj0wnVgVd9
         FsDGXrEqaK5mNzuNKveKDQw9yNnZPbE3IwF3Nyp5jGLc24vZ6pC16gO1goRrmc6p4QeG
         1pl2RVMEOAGPak5/N4DWB4EdeaFsM/1BqnR1Y+4My1F0edR0G+W0cHFgkk/nQylpkCT7
         wfl1k5OCIXaC4iXp8zFS7ADwIDEW7L7ZdpJPW5wBQMrYF0zfhDiqkNWELGt0tzVlNpX3
         W7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rFkRNcfpvB1Ju4IVqteFXhSiHej5m8ER5DA8p5t0LAM=;
        b=EHGgjoeME66CFxVdvEwrDGF6BQYfWzLHM5vTT0kmihr0YgR1LFX3dBi2Uf8/BikHnv
         YSmfOobHzRyoub0B8hYV4MBW85T6znkUle98BZFAlWSIVvXACZ9tWhJzHBVKLrcyyckD
         SfiMuAl24AMo7G+p2Ms26aG/abQftzPDZcDCpn03kfF3rDBXiJcaOI25HjgvEJjh0AEm
         6Z2pZA89OfmZnJAoaleJcnAmtjVq+rsUZRTri4yJQWINrHgCnTGmKtWeVQizGHWpDvQp
         shQSX4LJ/W3/36Br5znXVco6zBgng1JxFHxsBB1WZ5ptyzCEayfALT7H/7E23ErDIW1T
         F+Mw==
X-Gm-Message-State: AOAM5305Zsl4k4qtI4VwpIXOGuwVP1q9V1bW3w9XMkc4NAjEw2FwJu3k
        PjZiNq+hsbkEAu4mptXOiZTSkjC7PC2Q
X-Google-Smtp-Source: ABdhPJycW7HuuY9Gim/mXG1ILhZq0/6nWfqymTtbWe0EQGgl+pPQmTGRPV48lVOvv5Y7iUj6rD/h42ZYLODf
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:aa7:dbc3:: with SMTP id
 v3mr6100538edt.63.1627565318816; Thu, 29 Jul 2021 06:28:38 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:04 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-8-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 07/21] KVM: arm64: Rename KVM_PTE_LEAF_ATTR_S2_IGNORED
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

The ignored bits for both stage-1 and stage-2 page and block
descriptors are in [55:58], so rename KVM_PTE_LEAF_ATTR_S2_IGNORED to
make it applicable to both. And while at it, since these bits are more
commonly known as 'software' bits, rename accordingly.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 4dff2ad39ee4..59a394d82de3 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -36,6 +36,8 @@
 
 #define KVM_PTE_LEAF_ATTR_HI		GENMASK(63, 51)
 
+#define KVM_PTE_LEAF_ATTR_HI_SW		GENMASK(58, 55)
+
 #define KVM_PTE_LEAF_ATTR_HI_S1_XN	BIT(54)
 
 #define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
@@ -44,8 +46,6 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
-#define KVM_PTE_LEAF_ATTR_S2_IGNORED	GENMASK(58, 55)
-
 #define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 56)
 #define KVM_MAX_OWNER_ID		1
 
-- 
2.32.0.432.gabb21c7263-goog

