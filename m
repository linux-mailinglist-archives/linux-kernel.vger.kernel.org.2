Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27B139856D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhFBJpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFBJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:45:37 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A78C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 02:43:53 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so1081863edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PXs9u6dzCmMe63YEsmhUrb93h0mWmoLs1gTxAQd7MEA=;
        b=oPgorK2YXYRV0NwbupNNErxxwaXHhcqOGNqd8VNe+P/7Nj5Uz7T7moZyrqR/KdQp5E
         iUOHFTmYLgjY+7moRvw+AKjjV2DBSZUDC7d+1Zn2fjOJu8WVLJq6Eq0T+m9uNQZE4Qdv
         68oufbungBm2FDwfThF94Fvb51/PTNHpNr0PqVJDP9Fai7qCvEORLB+XK0FZ+6MpTuKx
         w42/J0YFONYdkPPmysoMeWv9wfLLp7FgmZskg3IHlybRnVZD3yizxXzCveGebPdlVIaf
         kDua8A5CGclwlqWaUqvjFXuwm+AlAFlwyuDMET2h9JWGKzOlnh2KLZl9vpYdpX0KKae+
         G4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PXs9u6dzCmMe63YEsmhUrb93h0mWmoLs1gTxAQd7MEA=;
        b=lCfXotehjeo26S5Kyao3/tgMQPRb9mSDIEulyDpR9RChaHDJL6T0ABesHznbp5TII+
         7wlcDLi+bH1hPyBVy4yVG2PKiLhdjlIrz31W8AD07ba4oFYGN1UKE3AKZgFzz45L/eeC
         b/JxdEryTobpOlskL+ThnQ9i5HfVUgqSUQH6WubPgWIHL35ZCmc8ynhxUMPv7ffokirU
         f3tG7JrUYiTccKeLnoStqX4Ogg7uQgk6+n/AffZzMEHm+PX4kJtSeovG1OrxRt/oT4NL
         Wmw7ImFZnMF+DLznIF5Crq2+v3eQOXFGar0abnJuQNS993GL0aVKSLjysxWkHxiCXMXt
         RvdA==
X-Gm-Message-State: AOAM531SnNNBa8xO8sROikw8LieHo7lsj9Vi/OcnCauYfH3zPyoWLHhC
        DDe3w/AMvV9USJ5aZW7DWqct9Nt5qAhw
X-Google-Smtp-Source: ABdhPJwI732qm8er6IebqhgRNDcxCaKLRuDj57CyEYHgzxVlmlFpf/MCKV1O0VnL1RhgrhvYbef7nwiw583Q
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:aa7:d893:: with SMTP id
 u19mr38230483edq.258.1622627031729; Wed, 02 Jun 2021 02:43:51 -0700 (PDT)
Date:   Wed,  2 Jun 2021 09:43:40 +0000
Message-Id: <20210602094347.3730846-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 0/7] KVM: arm64: Reduce hyp_vmemmap overhead
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

This is a v2 of the patch series previously posted here:

  https://lore.kernel.org/r/20210527125134.2116404-1-qperret@google.com/

Please refer to the cover letter of v1 for the context and motivation
behind the series.

Changes since v1:
 - Added comment/doc in page_alloc.c explaining the locking expectations;
 - Removed unnecessary casts in the 'page-to-list-node' helpers;
 - A few other cosmetic changes in the allocator.

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
2.32.0.rc0.204.g9fa02ecfa5-goog

