Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1339F56C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhFHLrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFHLrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:47:17 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC147C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 04:45:24 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id h10-20020a5d688a0000b0290119c2ce2499so4393372wru.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vVP6MnE5jtfCRNBSFEk8Tts1aw1n4jW8xd82TUR2TLU=;
        b=bsninEwjms+mWvprSOPlfQ4X/AFVMRBlxagtmZ/Wb9PNB3vao021HDHSnPOnN1bbG8
         c/k1nJyU8KGyKg1CHj50UHzW9860yE4GUoBteLsOMatA76Lnku3N9/7yQFSdd+cu5tux
         1SOqFVEshQtQlXFDUf63YvlroPYZPvMZ1fAiSZhJwcR+rtqz4AEfZ7lL6lcqyYN9SeZk
         o4cGRh/9uY15ziLA+Tvu3lz2eJUlm4PJC9zpyFs1VslISm3QD3Xsj0cgmyVUt8FAIg89
         GoKfasGi/ePTYi1DRf5IbMaWAjvN7QRM4W2XfRJnlvP/FrdhyMmyOUrGuUXgV8WSVN8J
         0AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vVP6MnE5jtfCRNBSFEk8Tts1aw1n4jW8xd82TUR2TLU=;
        b=fi3wwczpEpiTce6KPDG5Bjqs3oISWT2bbsTa6O3yR+N4/QaQ8kQB3mTRHsi74yl1V5
         1d4fGD95bmPlRYrfttwI/d/dEsSpoI/sjJPEhek2dIYyr84p90HZHuoCs6o0eOGeUbUM
         CX+8gXVELrNhmPpXhJsxT8iBbE3cBaWpAeETMTfnYwbojEyDk0xEwVvzDHcLVNL9C99C
         GNZ9VeslMSU32Sx4NAIfx7IOQFz8mbIdbS+IyTwq60BpzMmVAghBb3KU3+nsXSJDuJ1y
         lAVTQNhC7cYjeL7xLz+alNH5CCdwBhwR1IqJDx8R2rVES+ZNGoIsTeJ2ER96DNedtHFt
         /GvA==
X-Gm-Message-State: AOAM531FWu3ib1a5Y2hzp9sx+bHVIJVh/GdJfI1enkdDLA12IFf/+SCi
        nbs/RVEWGxYOV76RpGjDW5KebGqQib8E
X-Google-Smtp-Source: ABdhPJxnQTZBsAgtPXFz17t2riToek8ZifdE5myRG5kTzUVYdJXzhpzMu8D3AEklq9Tq4ufpuZnb/AOKJ/Uu
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c013:: with SMTP id
 c19mr3738933wmb.158.1623152723285; Tue, 08 Jun 2021 04:45:23 -0700 (PDT)
Date:   Tue,  8 Jun 2021 11:45:11 +0000
Message-Id: <20210608114518.748712-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 0/7] KVM: arm64: Reduce hyp_vmemmap overhead
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, will@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a v3 of the patch series previously posted here:

  https://lore.kernel.org/r/20210602094347.3730846-1-qperret@google.com

Please refer to the cover letter of v1 for the context and motivation
behind the series.

Changes since v2:
 - Rebased on kvmarm/next

Thanks,
Quentin

Quentin Perret (7):
  KVM: arm64: Move hyp_pool locking out of refcount helpers
  KVM: arm64: Use refcount at hyp to check page availability
  KVM: arm64: Remove list_head from hyp_page
  KVM: arm64: Unify MMIO and mem host stage-2 pools
  KVM: arm64: Remove hyp_pool pointer from struct hyp_page
  KVM: arm64: Use less bits for hyp_page order
  KVM: arm64: Use less bits for hyp_page refcount

 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  45 +------
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   2 +-
 arch/arm64/kvm/hyp/include/nvhe/memory.h      |   7 +-
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |  13 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  60 +++++-----
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          | 112 +++++++++++++-----
 arch/arm64/kvm/hyp/nvhe/setup.c               |  30 +++--
 arch/arm64/kvm/hyp/reserved_mem.c             |   3 +-
 8 files changed, 145 insertions(+), 127 deletions(-)

-- 
2.32.0.rc1.229.g3e70b5a671-goog

